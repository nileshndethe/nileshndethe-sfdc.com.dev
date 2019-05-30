global with sharing class MySOAPWebService {
    webservice static Account getRecord(String id) {
          // Add some code here
          return new Account(name='Test SOAP Service');  
    }
}