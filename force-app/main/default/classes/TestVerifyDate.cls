@IsTest
private class TestVerifyDate 
{
 
	@isTest static void Test_CheckDates()
	{
		
		Date myDate = Date.newInstance(2015, 6, 11);
		Date newDate = mydate.addDays(5);
		Date newDate1 = mydate.addDays(50);
		Test.startTest();		
		Date returnDate = VerifyDate.CheckDates(myDate, newDate);
		System.assertEquals(newDate, returnDate);

		Date returnDate1 = VerifyDate.CheckDates(myDate, newDate1);
		Integer totalDays = Date.daysInMonth(myDate.year(), myDate.month());
		Date lastDay = Date.newInstance(myDate.year(), myDate.month(), totalDays);
		System.assertEquals(lastDay,returnDate1);
		Test.stopTest();

	}

}