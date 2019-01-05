public with Sharing class CaseService {
    public static void closeCases(set<Id> setIds, string clsReason){
        //validate parameters
        if(setIds == null || setIds.isEmpty())
            throw new CaseServiceException('Cases are not defined');
        if(string.isBlank(clsReason))
            throw new CaseServiceException('Cases close reason not defined');
        // Fetch the Cases to close based on the the set of id passed in the parameters
        List<Case> lstCases = [SELECT status FROM case WHERE Id IN :setIds AND status != 'Closed'];
        List<Case> lstCaseToUpdate = new List<Case>();
        //validation that case exists to close with the reason
        if(!lstCases.isEmpty()){
            for(case cs : lstCases){
                cs.Status='Closed';
                cs.Reason= clsReason;
                lstCaseToUpdate.add(cs);
            }
        }    
        SavePoint sv = Database.setSavepoint();
        try{
            if(!lstCaseToUpdate.isEmpty())
                UPDATE lstCaseToUpdate;            
        }catch(Exception e){
           Database.rollback(sv);
           throw e;
        }
    }
    
    public class CaseServiceException extends Exception{}
}