global class DailyLeadProcessor implements schedulable
{
	global void execute(SchedulableContext ctx)
    {
        List<Lead> lstLeads = [SELECT Id, LeadSource 
                               FROM Lead 
                               WHERE LeadSource = null 
                               LIMIT 200];
        Map<id,Lead> mapLeadToUpdate = new Map<id,lead>();
        If(lstLeads != null && !lstLeads.isEmpty())
        {
            for (Lead ld : lstLeads)
            {
                ld.LeadSource = 'Dreamforce';
                mapLeadToUpdate.put(ld.Id, ld);
            } 
            if(!mapLeadToUpdate.isEmpty())
            {
                update mapLeadToUpdate.values();
            }
        }
    }
}