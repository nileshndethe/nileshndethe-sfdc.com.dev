@isTest
public class LeadProcessorTest 
{
    @testSetup 
    static void setup() {
        List<Lead> testLeads = new List<Lead>();        
        // insert 10 accounts
        for (Integer i=0;i<200;i++) {
            testLeads.add(new Lead(Company='ABC  '+i, LastName = 'Nilesh Dethe' 
                ));
        }
        insert testLeads;        
    }

    static testmethod void test() {        
        Test.startTest();
        LeadProcessor lp = new LeadProcessor();
        Id batchId = Database.executeBatch(lp);
        Test.stopTest();

        // after the testing stops, assert records were updated properly
        System.assertEquals(200, [select count() from Lead where LeadSource = 'Dreamforce']);
    }
}