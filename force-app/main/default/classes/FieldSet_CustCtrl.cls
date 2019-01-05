public class FieldSet_CustCtrl 
{
	public List<Contact> LstContact {get;Set;}

	public FieldSet_CustCtrl()
	{
		this.LstContact = getContactDetails();
	}

	public List<Schema.FieldSetMember> getContactFields()
	{
		return sObjectType.Contact.FieldSets.DemoSet1.getFields();
	}

	private List<Contact> getContactDetails()
	{
		String soqlQuery = 'SELECT ';
		For(Schema.FieldSetMember fmember:getContactFields())
		{
			soqlQuery += fmember.getFieldPath()+ ', ';
		}
		soqlQuery = soqlQuery.substring(0,soqlQuery.length()-2);
		soqlQuery += ' From Contact Limit 2';
		return Database.query(soqlQuery);
	}

}