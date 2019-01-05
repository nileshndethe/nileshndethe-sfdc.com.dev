@RestResource(urlMapping='/case/*/close')
global class CaseCloseResource {
    
    @HTTPPOST
    global static void closeCase(String clsReason){
        RestRequest req = RestContext.request;
        String[] uriParts = req.requestURI.split('/');       
        CaseService.closeCases(new set<Id>{uriParts[2]},clsReason);
	}

}