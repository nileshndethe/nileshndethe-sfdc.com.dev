@isTest
public class DailyLeadProcessorTest {
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    static testmethod void testScheduledJob()
    {
        List<Lead> lstNewLeads = new List<Lead>();
        for(integer i=0; i<200;i++)
        {
            lstNewLeads.add(new Lead(
                LastName='Lead '+ string.valueOf(i),
                company ='ND Tech '+ string.valueOf(i)
            ));
        }
        insert lstNewLeads;
        Test.startTest();
        string jobid = System.schedule('DailyleadProcessorJob', CRON_EXP, new DailyLeadProcessor());
        system.assert(string.isNotBlank(jobid));              
        Test.stopTest();
        
        List<Lead> lstLeads = [SELECT Id, LeadSource 
                               FROM Lead 
                               WHERE LeadSource = null 
                               LIMIT 200];
        if(!lstLeads.isEmpty()){
            for(lead ld : lstLeads)
            {
                system.assert(string.isNotBlank(ld.LeadSource));
            }
        }        
    }
    
}