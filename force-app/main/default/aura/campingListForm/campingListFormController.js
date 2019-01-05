({
    submitForm : function(component, event, helper) {
		// Simplistic error checking
        var validCamping = true;

        // Name must not be blank
        var nameField = component.find("cmpname");
        var cmpname = nameField.get("v.value");
        if ($A.util.isEmpty(cmpname)){
            validCamping = false;
            nameField.set("v.errors", [{message:"Camping name can't be blank."}]);
        }
        else {
            nameField.set("v.errors", null);
        }

        // Quantity must not be blank
        var quantityField = component.find("quantity");
        var quantity = nameField.get("v.value");
        if ($A.util.isEmpty(quantity)){
            validCamping = false;
            quantityField.set("v.errors", [{message:"Camping Quantity can't be blank."}]);
        }
        else {
            quantityField.set("v.errors", null);
        }
		
        // Price must not be blank
        var priceField = component.find("price");
        var price = nameField.get("v.value");
        if ($A.util.isEmpty(price)){
            validCamping = false;
            priceField.set("v.errors", [{message:"Camping Price can't be blank."}]);
        }
        else {
            priceField.set("v.errors", null);
        }
        
        // If we pass error checking, do some real work
        if(validCamping){
            // Create the new expense          
            helper.createItem(component);                       
        }        
	}
})