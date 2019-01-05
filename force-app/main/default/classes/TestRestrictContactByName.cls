@isTest
public class TestRestrictContactByName 
{ 
	@isTest static void TestCoverageForRestrictContactByName()
	{
		Contact newInvalidContact = new Contact(LastName = 'INVALIDNAME');		
		//Test.startTest();
		Database.SaveResult result1 =  Database.Insert(newInvalidContact);
		//Test.stopTest();
		System.assert(!result1.isSuccess());
		System.assert(result1.getErrors().size() > 0);
        System.assertEquals('The Last Name "INVALIDNAME" is not allowed for DML',result1.getErrors()[0].getMessage());

		//Contact newValidContanct = new Contact(LastName = 'Dethe');
		
		//Database.SaveResult result2 =  Database.Insert(newValidContanct);
		
		//System.assert(result2.isSuccess());
		//System.assertNOTEquals(Null,result2.Id);

		//newValidContanct.LastName = 'INVALIDNAME';
		
		//Database.SaveResult result3 =  Database.Update(newValidContanct);
		
		//System.assert(!result3.isSuccess());
		//System.debug('result3.getErrors()[0].getMessage() >>' + result3.getErrors()[0].getMessage());
		//System.assertEquals('The Last Name "INVALIDNAME" is not allowed for DML', result3.getErrors()[0].getMessage());
		//Test.stopTest();
	}

}