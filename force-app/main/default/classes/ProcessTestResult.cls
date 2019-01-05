global class ProcessTestResult implements Database.Batchable<sObject>,Database.AllowsCallouts
{    
    global string curntUsrsessionId;
    global ProcessTestResult(string sessionID){
        system.debug('sessionId >>> '+sessionId);
        this.curntUsrsessionId = sessionId;      
        system.debug('curntUsrsessionId >>> '+curntUsrsessionId);
    }
    
    global List<ApexTestQueueItem> start(Database.BatchableContext bc) 
    {
        TestJobId__c testjob= TestJobId__c.getInstance('Asynch_Id');
        return getQueuedItems(testjob.JobId__c);   
    }
    
    global void execute(Database.BatchableContext BC, List<ApexTestQueueItem> lstTestQueItms)
    {
        processResults(lstTestQueItms, curntUsrsessionId);
    }
    
    global void finish(Database.BatchableContext BC)
    {
        
    }
    
    global static void processResults(List<ApexTestQueueItem> queuedItems, string sessionId)
    {
        try
        {
            Map<Id, List<ApexTestQueueItem>> parentIdtoTestQueueListMap = new Map<Id, List<ApexTestQueueItem>>();
            //List<ApexTestQueueItem> queuedItems = new List<ApexTestQueueItem>();
            TestJobId__c testjob= TestJobId__c.getInstance('Asynch_Id');
            if(testjob !=null && testjob.ProcessResult__c == true && !String.isBlank(testjob.userIds__c))
            {        
                //queuedItems = getQueuedItems(testjob.JobId__c);
                system.debug('queuedItems:'+queuedItems);
                
                Boolean isCompleted = getTestExecutionStatus(queuedItems);
                system.debug('isCompleted:'+isCompleted);
                
                if(isCompleted)
                {
                    List<ApexTestResult> testResults = checkMethodStatus(testjob.JobId__c);
                    sendTestResultEmail(testResults,sessionId);
                    testjob.JobId__c = '';
                    Update testjob;
                    
                    //Abort scheduled job
                    LIST<CronJobDetail> lstDetail = [SELECT Id FROM CronJobDetail WHERE Name='ScheduleProcessTestResults' LIMIT 1];
                    if (lstDetail != null && lstDetail.size()>0) {
                        system.debug('lstDetail :'+lstDetail );
                        Id jobId = [SELECT Id from CronTrigger WHERE CronJobDetailId = :lstDetail[0].Id ][0].Id;
                        System.abortJob(jobId);
                    }
                }
                else
                {
                    LIST<CronJobDetail> lstDetail = [SELECT Id FROM CronJobDetail WHERE Name='ScheduleProcessTestResults' LIMIT 1];
                    if (lstDetail != null && lstDetail.size()>0) {
                        system.debug('lstDetail :'+lstDetail );
                        Id jobId = [SELECT Id from CronTrigger WHERE CronJobDetailId = :lstDetail[0].Id ][0].Id;
                        System.abortJob(jobId);
                    }
                    
                    ScheduleProcessTestResults  ptr = new ScheduleProcessTestResults(sessionId);  
                    String sch = system.now().addMinutes(Integer.valueOf(testjob.Interval__c)).format('ss mm HH dd MM ? yyyy');
                    system.schedule('ScheduleProcessTestResults',sch,ptr);
                }
            }
        }catch(exception ex)
        {
            System.debug('Exception : '+ex.getMessage() +' StackTrace : '+ ex.getStackTraceString());
        }
    }
    
    //Returns queued items
    public static List<ApexTestQueueItem> getQueuedItems(String jobId) 
    {
        try
        {
            List<ApexTestQueueItem> testQItems = new List<ApexTestQueueItem>();
            testQItems = [SELECT ApexClass.Name,Status,ExtendedStatus,ParentJobId FROM ApexTestQueueItem WHERE ParentJobId =:jobId];
            
            return testQItems;
        }catch(exception ex)
        {
            System.debug('Exception : '+ex.getMessage() +' StackTrace : '+ ex.getStackTraceString());
            return null;
        }
    }
    
    //Return execution status
    public static Boolean getTestExecutionStatus(List<ApexTestQueueItem> queuedItems)
    {
        try
        {
            Boolean allCompleted = true;
            
            for (ApexTestQueueItem queuedTest : queuedItems){
                if (queuedTest.Status != 'Completed' && queuedTest.Status != 'Failed' && queuedTest.Status != 'Aborted')
                {
                    allCompleted = false;
                    break;
                }
            }
            
            return allCompleted;
        }catch(exception ex)
        {
            System.debug('Exception : '+ex.getMessage() +' StackTrace : '+ ex.getStackTraceString());
            return false;
        }
    }
    
    //Returns Test result of all test
    public static List<ApexTestResult> checkMethodStatus(String jobId) {
        try
        {
            List<ApexTestResult> results = [SELECT Outcome,MethodName,Message,StackTrace,AsyncApexJobId,ApexClass.Name,ApexClass.Body,ApexClass.LengthWithoutComments,ApexClass.NamespacePrefix,ApexClass.Status,ApexLogId,ApexLog.DurationMilliseconds,ApexLog.Operation,ApexLog.Request,ApexLog.Status,ApexLog.Location,ApexLog.Application FROM ApexTestResult WHERE AsyncApexJobId =:jobId];
            
            for (ApexTestResult atr : results) {
                System.debug(atr.ApexClass.Name + '.' + atr.MethodName + ': ' + atr.Outcome);
                if (atr.message != null) {
                    System.debug(atr.Message + '\n at ' + atr.StackTrace);
                }
            }
            
            return results;
        }catch(exception ex)
        {
            System.debug('Exception : '+ex.getMessage() +' StackTrace : '+ ex.getStackTraceString());
            return null;
        }
    }
    
    //Send result email
    private static void sendTestResultEmail(List<ApexTestResult> jobTestResults, string usrsessionId){
        try
        {
            system.debug(' In sendTestResultEmail');    
            TestJobId__c testjob= TestJobId__c.getInstance('Asynch_Id');
            LIST<String> lstUserIds = testjob.userIds__c.split('\\$');
            system.debug('lstUserIds:'+lstUserIds);
            String testResultEmailbody = getTestResultHtmlEmailBody(jobTestResults,usrsessionId);
            for(String str : lstUserIds){
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setSaveAsActivity(false);
                mail.setTargetObjectId(str);
                String emailSubject = 'Test Results ' + String.valueOf(Date.today()); 
                mail.setSubject(emailSubject);
                system.debug('testResultEmailbody::::'+testResultEmailbody);
                mail.setHtmlBody(testResultEmailbody);
                Messaging.sendEmail(new Messaging.Email[] { mail });
            }
            system.debug('sent test results email');
        }catch(exception ex)
        {
            System.debug('Exception : '+ex.getMessage() +' StackTrace : '+ ex.getStackTraceString());
        }
    }
    
    //Prepare email body
    private static String getTestResultHtmlEmailBody(List<ApexTestResult> jobTestResults, string usrsessionId){
        try
        {
            system.debug(' In getTestResultHtmlEmailBody');
            List<ApexTestResult> successTests = new List<ApexTestResult>();
            List<ApexTestResult> failedTests = new List<ApexTestResult>();
            
            for (ApexTestResult jobTestResult : jobTestResults){
                if (jobTestResult.Outcome == 'Pass'){
                    successTests.add(jobTestResult);
                }
                else{
                    failedTests.add(jobTestResult);
                }
            }
            
            system.debug('successTests:'+successTests.size());
            Integer numTestsRun = successTests.size() + failedTests.size();
            Integer numFailures = failedTests.size();
            Integer successNum = numTestsRun - numFailures;
            
            if (successNum < 0){
                successNum = 0;
            }
            
            String testResultBody = '';
            
            testResultBody += '<table border="1"><tbody><tr class="firstTr"><th>Tests Run</th><th>Failure Count</th><th>Success Count</th></tr>';
            testResultBody += '<tr class="firstTr"><td>'+numTestsRun+'</td><td>'+numFailures+'</td><td>'+successNum+'</td></tr></tbody></table><br/><br/>';
            
            if (numFailures > 0){
                
                testResultBody += '<b>Test Failures:</b><br/><br/>';
                
                testResultBody += '<table border="1"><tbody><tr class="firstTr"><th>Test Class</th><th>Unit Test</th><th>Message</th><th>Stack Trace</th><th>Time (Ms)</th></tr>';
                
                for (ApexTestResult testFailure : failedTests)
                {
                    
                    testResultBody +='<tr><td>'+testFailure.ApexClass.Name+'</td><td>'+testFailure.MethodName+'</td><td>'+testFailure.message+'</td><td>'+testFailure.stackTrace+'</td><td>'+testFailure.ApexLog.DurationMilliseconds+'</td></tr>';
                    
                }
                testResultBody += '</tbody></table>';
            }      
            system.debug('testResultBody:'+testResultBody);
            
            CalculateTestCoverage testcoverage = new CalculateTestCoverage();
            LIST<CoverageWrapper> belowCoverageList = (string.isNotBlank(usrsessionId))?testcoverage.getCoverage(usrsessionId):Null;
            system.debug('belowCoverageList size:'+belowCoverageList.size());
            if(belowCoverageList!= null && belowCoverageList.size()>0)
            {
                testResultBody += '<br/><b>Classes having below 75% coverage:</b><br/><br/>';
                testResultBody += '<table border="1"><tbody><tr class="firstTr"><th>Class or Trigger Name</th><th>Class or Trigger Id</th><th>Coverage Percent</th></tr>';
                for(CoverageWrapper cw :belowCoverageList){
                    testResultBody += '<tr class="firstTr"><td>'+cw.ClassName+'</td><td>'+cw.ClassOrTriggerId+'</td><td>'+cw.Coverage+'</td></tr>';
                }
                testResultBody += '</tbody></table>';
            }
            
            return testResultBody;
        }catch(exception ex)
        {
            System.debug('Exception : '+ex.getMessage() +' StackTrace : '+ ex.getStackTraceString());
            return '';
        }
    }
}