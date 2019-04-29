({
    upload: function(component, event, helper) {      
        //component.set('v.loaded', !component.get('v.loaded'));
        var file = component.get("v.FileList")[0];
        var reader = new FileReader();       
        reader.onload = function (e) {          
            var binary = "";
            var bytes = new Uint8Array(e.target.result);
            var length = bytes.byteLength;
            for (var i = 0; i < length; i++) {
                binary += String.fromCharCode(bytes[i]);
            }           
            var workbook = XLSX.read(binary, { type: 'binary' }); 
            var sheet_name_list = workbook.SheetNames;
            if(workbook.SheetNames.length > 1){
                if(confirm("The uploaded excel contains more than one worksheet out of which by defalut first worksheet \"" +workbook.SheetNames[0]+ "\" will be processed. Do you want to procceed?")){
                    var fileContentAsCSV = XLSX.utils.sheet_to_csv(workbook.Sheets[sheet_name_list[0]]);
                    component.find("myLtngFileuploadTextArea").set("v.value", fileContentAsCSV);
                }
            }
            else{
                var fileContentAsCSV = XLSX.utils.sheet_to_csv(workbook.Sheets[sheet_name_list[0]]);
                component.find("myLtngFileuploadTextArea").set("v.value", fileContentAsCSV);
            }
        };
        reader.readAsArrayBuffer(file);
        //component.set('v.loaded', !component.get('v.loaded'));
    },
    saveFileAsCSV : function(component, event, helper){
        //component.set('v.loaded', !component.get('v.loaded'));
        var file = component.get("v.FileList")[0];
        helper.processExcelData(component, event, file, component.find("myLtngFileuploadTextArea").get("v.value") ,"text/csv");  
        //component.set('v.loaded', !component.get('v.loaded'));
    },
})