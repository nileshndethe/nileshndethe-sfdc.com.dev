public class Excel2CsvCtrl {
	
    @AuraEnabled
    public static string saveTheFile(Id parentId, String fileName, String base64Data, String contentType) { 
        try {
           
        
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        
        Attachment a = new Attachment();
        a.parentId = parentId;

        a.Body = Blob.valueof(base64Data);
        a.Name = fileName;
        a.ContentType = contentType;
        
        insert a;
        
        return a.Id;

        } catch (Exception ex) {
           throw new AuraHandledException('Something went wrong: '
            + ex.getMessage());
        }
    }
}