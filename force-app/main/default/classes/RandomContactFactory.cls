public class RandomContactFactory 
{
	public static List<Contact> generateRandomContacts(Integer numOfContacts, String contactLastName)
	{
		List<Contact> lstContact = new List<Contact>();
		for(Integer contCount=0;contCount<numOfContacts;contCount++)
		{
			Contact c = new Contact();
			c.FirstName = 'Test'+contCount;
			c.LastName = contactLastName;
			lstContact.add(c);
		}
		return lstContact;
	}

}