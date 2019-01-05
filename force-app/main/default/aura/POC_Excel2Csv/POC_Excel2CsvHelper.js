({
    processExcelData: function (component, event, file, fileContents, fileType) {
        var action = component.get("c.saveTheFile");

        action.setParams({
            parentId: component.get("v.recordId"),
            fileName: file.name.substr(0, file.name.lastIndexOf('.')) + Math.floor(Math.random() * 101) + ".csv",
            base64Data: fileContents,
            contentType: fileType
        });

        action.setCallback(this, function (response) {
            // Checking the server response state
            let state = response.getState();
            let returnValue = response.getReturnValue();
            if (state === "SUCCESS") {
                // Process server success response
                let message = "Excel file Successfully converted and attaced as CSV to this record.";
                this.showToast(component, event, message, "success");
            }
            else if (state === "ERROR") {
                // Process error returned by server
                this.showToast(component, event, returnValue, "error");
            }
            else {
                // Handle other reponse states
            }
        });

        $A.enqueueAction(action);
        $A.get('e.force:refreshView').fire();
    },
    showToast: function (component, event, message, messageType) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Excel to CSV Converter",
            "type": messageType,
            "message": message
        });
        toastEvent.fire();
    },
})