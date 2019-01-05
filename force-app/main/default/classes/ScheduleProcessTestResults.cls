global class ScheduleProcessTestResults implements Schedulable 
{	
    global string curntUsrsessionId;
    global ScheduleProcessTestResults(string sessionID){
        system.debug('ScheduleProcessTestResults > sessionId >>> '+sessionID);
        this.curntUsrsessionId = sessionId;      
        system.debug('ScheduleProcessTestResults > curntUsrsessionId >>> '+curntUsrsessionId);
    }
    global void execute(SchedulableContext sc) {
        system.debug('UserInfo.getSessionId() >> ' + curntUsrsessionId);
        Database.executeBatch(new ProcessTestResult(curntUsrsessionId));        
    }
}