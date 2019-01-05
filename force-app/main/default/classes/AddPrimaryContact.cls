public class AddPrimaryContact implements Queueable
{
    public string state;
    Public contact cnt = new contact();
    public AddPrimaryContact(Contact c, string state)
    {
        this.state = state;
        this.cnt = c;
    }
    public void execute(QueueableContext context) 
    { 
        List<Contact> lstConToUpdate = new List<Contact>();
        List<Account> lstAcc = [select id, name from account where billingstate =:state limit 200];
        for(Account acc : lstAcc)
        {             
            cnt.AccountId = acc.id;
            lstConToUpdate.add(cnt);
        }
        if(!lstConToUpdate.isEmpty())
        	update lstConToUpdate;
    }

}