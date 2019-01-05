public class ContactSearch 
{
	Public static List<Contact> searchForContacts (String lastName, String maillingPostalCode)
	{
		List<Contact> lstContact = new List<Contact>();
		lstContact = [SELECT Id, Name FROM Contact WHERE LastName = : lastName AND MailingPostalCode =:maillingPostalCode];
		return lstContact;
	}
}