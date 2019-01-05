public class CalculateTestCoverage{

    public LIST<CoverageWrapper> getCoverage(string usrsessionId)
    {
    	system.debug('usrsessionId >>> ' + usrsessionId);
        String objectIdQuery = 'SELECT ApexClassorTriggerId, NumLinesCovered, NumLinesUncovered FROM ApexCodeCoverageAggregate';

        String environmentURL = URL.getSalesforceBaseUrl().toExternalForm() + '/services/data/v37.0/tooling/query/?q=' + EncodingUtil.urlEncode(objectIdQuery, 'UTF-8');
       
        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', 'Bearer ' + usrsessionId);
        req.setHeader('Content-Type', 'application/json');
        req.setEndpoint(environmentURL);
        req.setMethod('GET');
       
        Http h = new Http();
        system.debug('result:'+h.send(req).getBody());
        String JsonString ='';
        if(Test.isRunningTest() == false){
         JsonString = h.send(req).getBody();
        }
        else
        {
            JsonString ='';
        }
        system.debug('JsonString :'+JsonString );
        JSON2Apex myClass = JSON2Apex.parse(jsonString);
        system.debug('myClass:'+myClass);
        LIST<ApexClass> lstApexClass = [Select Id, Name from ApexClass];
        LIST<ApexTrigger> lstApexTrigger = [Select Id, Name from ApexTrigger];
        MAP<Id,String> idtoNameMap = new MAP<Id,String>();
        for(ApexClass ac : lstApexClass)
            idtoNameMap.put(ac.Id,ac.Name);
        for(ApexTrigger at : lstApexTrigger)
            idtoNameMap.put(at.Id,at.Name);
                
        System.debug('idtoNameMap:'+idtoNameMap.size());

        LIST<JSON2Apex.Records> coverageList = myClass.records;
        LIST<CoverageWrapper> cwList = new LIST<CoverageWrapper>(); 
        for(JSON2Apex.Records rec : coverageList){
            
            
            Integer coverage =(rec.NumLinesCovered != 0 && rec.NumLinesUncovered != 0)?(rec.NumLinesCovered / (rec.NumLinesCovered + rec.NumLinesUncovered))*100:0;
            if(coverage<75){
                CoverageWrapper cw = new CoverageWrapper();
                cw.Coverage =coverage;
                cw.ClassOrTriggerId = rec.ApexClassOrTriggerId;
                cw.ClassName = idtoNameMap.get(rec.ApexClassOrTriggerId);
                cwList.add(cw);
            }
        
        }
 
    return cwList;
    }

}