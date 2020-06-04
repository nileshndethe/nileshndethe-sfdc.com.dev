/**
 * @File Name          : KADataCategoriesWrapper_Test.cls
 * @description        : 
 * @Author             : Nilesh Dethe
 * @Group              : 
 * @Last Modified By   : Nilesh Dethe
 * @Last Modified On   : 6/3/2020, 9:17:31 PM
 * @Modification Log   : 
 * Ver       Date            Author      		    Modification
 * 1.0    6/3/2020   Nilesh Dethe     Initial Version
**/
public with sharing class KADataCategoriesWrapper_Test {
    static testMethod void testParse() {
		String json = '[{'+
		'    \"label\": \"Western Sales Director\",'+
		'    \"name\": \"1\",'+
		'    \"expanded\": true,'+
		'    \"items\": [{'+
		'        \"label\": \"Western Sales Manager\",'+
		'        \"name\": \"2\",'+
		'        \"expanded\": true,'+
		'        \"items\" :[{'+
		'            \"label\": \"CA Sales Rep\",'+
		'            \"name\": \"3\",'+
		'            \"expanded\": true,'+
		'            \"items\" : []'+
		'        },{'+
		'            \"label\": \"OR Sales Rep\",'+
		'            \"name\": \"4\",'+
		'            \"expanded\": true,'+
		'            \"items\" : []'+
		'        }]'+
		'    }]'+
		'}, {'+
		'    \"label\": \"Eastern Sales Director\",'+
		'    \"name\": \"5\",'+
		'    \"expanded\": false,'+
		'    \"items\": [{'+
		'        \"label\": \"Eastern Sales Manager\",'+
		'        \"name\": \"6\",'+
		'        \"expanded\": true,'+
		'        \"items\" :[{'+
		'            \"label\": \"NY Sales Rep\",'+
		'            \"name\": \"7\",'+
		'            \"expanded\": true,'+
		'            \"items\" : []'+
		'        }, {'+
		'            \"label\": \"MA Sales Rep\",'+
		'            \"name\": \"8\",'+
		'            \"expanded\": true,'+
		'            \"items\" : []'+
		'        }]'+
		'    }]'+
		'}];';
		List<KADataCategoriesWrapper> obj = KADataCategoriesWrapper.parse(json);
		System.assert(obj != null);
	}
}
