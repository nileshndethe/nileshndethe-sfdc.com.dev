({
    upload: function(component, file, fileContents) {
        var action = component.get("c.saveTheFile"); 
        
        action.setParams({
            parentId: component.get("v.parentId"),
            fileName: file.name,
            base64Data: encodeURIComponent(fileContents), 
            contentType: file.type
        });
        
        action.setCallback(this, function(a) {
            attachId = a.getReturnValue();
            console.log(attachId);
        });

        $A.enqueueAction(action);    
    },
})