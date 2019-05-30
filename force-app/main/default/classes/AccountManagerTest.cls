@isTest
private class AccountManagerTest {
    @isTest static void testGetAccount(){
        Account acc = new Account(name='Test Account');
        insert acc;
        System.assert(acc.id != null);

        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://ndcloud-dev-ed.lightning.force.com/services/apexrest/Accounts/'+ acc.id +'/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Account thisAcc= AccountManager.getAccount();
        // Verify results
        System.assert(thisAcc != null);
        System.assertEquals('Test Account', thisAcc.name);
    }
}