@isTest
public class UnitOfWorkTest {
    public static testmethod void challengeComplete()
    {       
        Test.startTest();
        fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(new Schema.SObjectType[]{Account.SObjectType,Contact.SObjectType,Note.SObjectType});
        
        for(integer i=0; i<100;i++)
        {
            Account acc = new Account();
            acc.Name = 'Test Account-' + i;
            uow.registerNew(acc);
            
            for(integer j=0; j<5; j++){
                Contact cnt = new Contact();
                cnt.LastName = 'Account-'+ i +' TestContact-' +j;                
                uow.registerNew(cnt, Contact.AccountId, acc);
                uow.registerRelationship(cnt, Contact.AccountId, acc);
                
                Note nts = new Note();
                nts.Title = 'Contact-'+i+' TestNote - '+j;
                nts.Body = 'Test Body for Test Contact-' + j;                
                uow.registerNew(nts, Note.ParentId, cnt);
                uow.registerRelationship(nts, Note.ParentId, cnt);
            }      
        }
        uow.commitWork();
        Test.stopTest();
        System.assertEquals(100, [Select Id from Account].size());
        System.assertEquals(500, [Select Id from Contact].size());
        System.assertEquals(500, [Select Id from Note].size());
    }
}