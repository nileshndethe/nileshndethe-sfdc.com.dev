trigger ClosedOpportunityTrigger on Opportunity (after insert, after update )  
{
Set<ID> setOfClosedOpp = new Set<ID>();
List<Task> tasks = new List<Task>(); 
List<Opportunity> Opps = Trigger.new; 
for (Opportunity Opp : Opps) 
{ 
    if(Opp.StageName== 'Closed Won')
     
    tasks.add(new Task(subject='Follow Up Test Task',whatID = Opp.ID, Ownerid = Opp.OwnerId)); 
} 
    insert tasks; 
}