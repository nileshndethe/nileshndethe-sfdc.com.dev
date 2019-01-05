@isTest
public class AddPrimaryContactTest {

    	@testSetup 
    static void setup() {
        List<Account> accounts = new List<Account>();
        // add a parent account
        accounts.add(new Account(name='Parent'));
        // add 100 child accounts
        for (Integer i = 0; i < 50; i++) {
            accounts.add(new Account(
                name='Test Account'+i,
                billingstate = 'NY'
            ));
        }
        for (Integer i = 0; i < 50; i++) {
            accounts.add(new Account(
                name='Test Account'+i,
                billingstate = 'CA'
            ));
        }
        insert accounts;                
    }
    
    static testmethod void testQueueable() {
        Contact cont = new Contact(LastName='abc');
       	AddPrimaryContact pcont = new AddPrimaryContact(cont,'CA');
        Test.startTest();        
        System.enqueueJob(pcont);
        Test.stopTest();        
        // Validate the job ran. Check if record have correct parentId now
        System.assertEquals(50, [select count() from account where billingstate = 'CA']);
    }
}