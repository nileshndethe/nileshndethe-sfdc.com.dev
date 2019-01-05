public class AccountHandler 
{
	Public Static Account insertNewAccount(String accountName)
	{
		try
		{
			Account acc = new Account(Name=accountName);
			insert acc;
			return acc;
		}
		catch(DmlException ex)
		{
			return null;
		}

	} 
}