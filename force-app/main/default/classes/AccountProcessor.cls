public class AccountProcessor {
    @future
    public static void countContacts(List<Id> lstAccountId)
    {        
        if(!lstAccountId.isEmpty())
        {
            List<Account> lstAccount = [SELECT id, name, (Select id from Contacts) FROM Account WHERE id IN :lstAccountId];
            if(!lstAccount.isEmpty())
            {
                for(Account acc :lstAccount)
                {
                    acc.Number_of_Contacts__c = acc.contacts.size();
                }
                Database.update(lstAccount);
            }
        }
        
    }
}