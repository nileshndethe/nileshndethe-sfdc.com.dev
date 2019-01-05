({
	handleFilesChange : function(component, event, helper) {
		var file = event.getSource().get("v.files")[0];

        var fr = new FileReader();
        
       	fr.onload = function() {
            var fileContents = fr.result;
    	    var base64Mark = 'base64,';
            var dataStart = fileContents.indexOf(base64Mark) + base64Mark.length;
 
            fileContents = fileContents.substring(dataStart);
        	component.find("myLtngInputTextArea").set("v.value",fileContents);
    	    //helper.processExcelData(component, file, fileContents);
        };
 
        fr.readAsDataURL(file);
	}
})