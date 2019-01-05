/***************************************************************
    Class : SalesforceRegHandler
    Developer : Nilesh Dethe
    Created Date : 27-Feb-2018
    Summary : This is a custom global authorizaion registraton handler class that handles linking customer/partner org Salesforce users to existing Cirrico Community Users.
    Test Coverage Classes : SaleforceRegHandler_Test
    Change Log: 
v1.0 - 27-Feb-2018 - Nilesh Dethe - Created this new handler(100% Code Coverage)
*****************************************************************/

global class SalesforceRegHandler implements Auth.RegistrationHandler{

 class RegHandlerException extends Exception {}


    // Creates a Standard salesforce or a community user
    global User createUser(Id portalId, Auth.UserData data){
        User u = null;
        Boolean noUserFound = true;
        
        // This is for a community.
        if(data.attributeMap.containsKey('sfdc_networkid')) {
            // Check for email, whether the user is a portal user and is active.
            List<User> uLst = [SELECT Id, username, email, lastName, firstName, alias, languagelocalekey, localesidkey, emailEncodingKey, timeZoneSidKey from User where email=:data.email and IsPortalEnabled=true and isactive=true LIMIT 1];
            // Check to see if the user is a valid one.
            noUserFound = uLst.isEmpty();
            // Log the login attempt.
            createCirricoSSOLog(data, noUserFound);
            
            if (noUserFound) {
                system.debug('User does not exist, do not allow access to community');
                // throw new RegHandlerException('We can\'t find an active user, please contact the Cirrico team for support, or login using a username and password.');
            }
            else {
                system.debug('User exists, no need to create one');
                u = uLst[0];                    
            }
                
            return u;
            
        } else {
            //Nothing to do for the org login.
            return u;
        }
    }
    
    // Updates the user's first and last name
    global void updateUser(Id userId, Id portalId, Auth.UserData data){
        createCirricoSSOLog(data,false);
        //Nothing to do here.
    }
    
    //To log details about the user who attempted to login to Cirrico Community
    private void createCirricoSSOLog(Auth.UserData data, Boolean noUserFound){
        System.debug('data=>'+data);
        SSO_Log__c loginAttempt=new SSO_Log__c();
        String userData='';
        
        if(data!=null){
            userData=userData+'Full Name : '+data.fullName+', ';
            userData=userData+'Email : '+data.email+', ';
            userData=userData+'Username : '+data.username;
        }
        
        userData.removeEnd(', ');
        System.debug('userData=>'+userData);
        loginAttempt.User_Data__c=userData;
        loginAttempt.Valid_Login__c=!noUserFound;
        insert loginAttempt;
    }
}