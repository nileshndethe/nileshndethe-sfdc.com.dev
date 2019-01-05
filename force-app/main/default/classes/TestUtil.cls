global class TestUtil implements schedulable{
	
    global string curntUsrsessionId;
    global TestUtil(string sessionID){
        system.debug('TestUtil > sessionId >>> '+sessionId);
        this.curntUsrsessionId = sessionId;      
        system.debug('TestUtil > curntUsrsessionId >>> '+curntUsrsessionId);
    }
    global void execute(SchedulableContext SC) {
        enqueueTests(curntUsrsessionId);
    }
    // Enqueue all classes ending in "Test". 
    public void enqueueTests(string sessionId) {
        try
        {
            LIST<LIST<ApexClass>> testClasses = [FIND '@isTest' IN ALL FIELDS RETURNING ApexClass(Id, Name WHERE (Name != 'TestUtil'))];
            system.debug('testClasses:'+testClasses);
            TestJobId__c testjob= TestJobId__c.getInstance('Asynch_Id');
            SET<String> excludedClassesSet = new SET<String>();
            if(testjob !=null)
            {
                String excludedClasses = testjob.Excluded_Classes__c;
                LIST<String> excludedList = excludedClasses.split(',');
                excludedClassesSet.addAll(excludedList);
                system.debug('excludedClassesSet:'+excludedClassesSet);
            }
            if (testClasses.size() > 0) {
                ApexTestQueueItem[] queueItems = new List<ApexTestQueueItem>();
                for (ApexClass cls : testClasses[0]) {
                    if(!excludedClassesSet.contains(cls.Name)){
                        queueItems.add(new ApexTestQueueItem(ApexClassId=cls.Id));
                    }
                }
                insert queueItems;

                // Get the job ID of the first queue item returned.
                ApexTestQueueItem item = [SELECT ParentJobId FROM ApexTestQueueItem WHERE Id=:queueItems[0].Id LIMIT 1];
                    
                system.debug('item.parentjobid:'+item.parentjobid);
                
                if(testjob !=null)
                {
                    testjob.JobId__c = item.parentjobid;
                }
                else
                {
                    testjob= new TestJobId__c();
                    testjob.name = 'Asynch_Id';
                    testjob.JobId__c = item.parentjobid;
                }
                
                upsert testjob;
                scheduleProcessJob(sessionId);
            }
        }catch(exception ex)
        {
            System.debug('Exception : '+ex.getMessage() +' StackTrace : '+ ex.getStackTraceString());
        }

    }
    
    //Schedule ProcessTestResult for execution
    public static void scheduleProcessJob(string usrSessionId)
    {
        try
        {
            LIST<CronJobDetail> lstDetail = [SELECT Id FROM CronJobDetail WHERE Name='ScheduleProcessTestResults' LIMIT 1];
            if (lstDetail != null && lstDetail.size()>0) {
                system.debug('lstDetail :'+lstDetail);
                Id jobId = [SELECT Id from CronTrigger WHERE CronJobDetailId = :lstDetail[0].Id ][0].Id;
                System.abortJob(jobId);
            }
            
            TestJobId__c testjob= TestJobId__c.getInstance('Asynch_Id');
            if(testjob!=null)
            {
                ScheduleProcessTestResults ptr = new ScheduleProcessTestResults(usrSessionId);  
                String sch = system.now().addMinutes(Integer.valueOf(testjob.First_Execution__c)).format('ss mm HH dd MM ? yyyy');
                system.schedule('ScheduleProcessTestResults',sch,ptr);
            }
        }catch(exception ex)
        {
            System.debug('Exception : '+ex.getMessage() +' StackTrace : '+ ex.getStackTraceString());
        }
    }
    
}