@isTest(SeeAllData=true)
public class AccountProcessorTest 
{    
    public static testmethod void Test_TestCoverage_AccountProcessor()
    {
        List<Account> lstAccPre = [select id from Account where id = '0012800000MCB98' limit 1];
        List<Id> lstId = new List<Id>();
        lstId.add(lstAccPre[0].id);
        Test.startTest();
        AccountProcessor.countContacts(lstId);
        Test.stopTest();
        
        List<Account> lstAccPost = [select Number_of_Contacts__c from Account where id = '0012800000MCB98' limit 1];
        system.assertNotEquals(0, lstAccPost[0].Number_of_Contacts__c);
    }

}