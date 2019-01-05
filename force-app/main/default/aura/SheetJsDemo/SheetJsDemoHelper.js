({
    processExcelData: function(component, file, fileContents, fileType) {
        var action = component.get("c.saveTheFile"); 
        
        action.setParams({
            parentId: component.get("v.parentId"),
            fileName: file.name.substr(0,file.name.lastIndexOf('.'))+ Math.floor(Math.random() * 101) +".csv",
            base64Data: fileContents, 
            contentType: fileType
        });
        
        action.setCallback(this, function(a) {
            alert("Excel file attaced as csv to the record : " + a.getReturnValue());
        });

        $A.enqueueAction(action);    
    },
})