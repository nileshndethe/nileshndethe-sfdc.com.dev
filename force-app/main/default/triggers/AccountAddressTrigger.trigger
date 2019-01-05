trigger AccountAddressTrigger on Account (before insert)  
{
	//List<Account> lstAcc = new List<Account>();
	For(Account acc : Trigger.new)
	{
		if(acc.Match_Billing_Address__c && acc.BillingPostalCode != null)
		{	
			acc.ShippingPostalCode = acc.BillingPostalCode;		
		}
	}	
}