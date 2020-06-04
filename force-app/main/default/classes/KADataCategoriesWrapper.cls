/**
 * @File Name          : KADataCategoriesWrapper.cls
 * @description        : 
 * @Author             : Nilesh Dethe
 * @Group              : 
 * @Last Modified By   : Nilesh Dethe
 * @Last Modified On   : 6/3/2020, 9:21:13 PM
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    6/3/2020   Nilesh Dethe     Initial Version
**/
public with sharing class KADataCategoriesWrapper {
    public class TopCategories {
		public String label;
		public String name;
		public Boolean expanded;
		public List<Items> items;
	}

	public class SubCategories {
		public String label;
		public String name;
		public Boolean expanded;
		public List<TopCategories> items;
	}

	public String label;
	public String name;
	public Boolean expanded;
	public List<SubCategories> items;

	public class Items {
	}
	
	/**
	* @description 
	* @author Nilesh Dethe | 6/3/2020 
	* @param String json 
	* @return List<KADataCategoriesWrapper> 
	**/
	public static List<KADataCategoriesWrapper> parse(String json) {
		return (List<KADataCategoriesWrapper>) System.JSON.deserialize(json, List<KADataCategoriesWrapper>.class);
	}
}
