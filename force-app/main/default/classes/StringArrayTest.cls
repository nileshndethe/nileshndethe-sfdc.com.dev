public class StringArrayTest 
{	
	public static list<string> generateStringArray(integer lengthofarray)
	{
		list<string> lstArray = new list<string>();
		for(integer index=0;index <lengthofarray; index++)
		{
			lstArray.add('Test ' + index);
		}
		
		return lstArray;
	} 

}