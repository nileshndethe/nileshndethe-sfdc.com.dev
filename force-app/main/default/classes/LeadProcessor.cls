global class LeadProcessor implements Database.Batchable<sObject>
{
	global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT ID, LeadSource From Lead'
        );
    }

    global void execute(Database.BatchableContext bc, List<Lead> scope)
    {
        // process each batch of records
        List<Lead> leads = new List<Lead>();
        for (Lead ld : scope) 
        {
            ld.LeadSource = 'Dreamforce';
            leads.add(ld);
        }
      
        update leads;
    }    

    global void finish(Database.BatchableContext bc){
       
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, 
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
        system.debug('job.id : ' + job.id);
    }    
}