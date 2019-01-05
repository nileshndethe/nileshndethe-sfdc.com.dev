public class ContactAndLeadSearch 
{
	Public Static List<List<SObject>> searchContactsAndLeads(String searchQuery)
	{
		List<List<SObject>> searchResult = [FIND :searchQuery IN ALL FIELDS RETURNING	Contact(Name WHERE (FirstName = 'Smith' OR LastName = 'Smith')), Lead(Name WHERE (FirstName = 'Smith' OR LastName = 'Smith'))];
		System.debug('searchResult :>>>>' + searchResult);
		return searchResult;
	}
}