({
	ShowPhone: function(component, event, helper) {        
		var phNumber = component.find("phone").get("v.value");
        $A.get("e.c:PhoneNumberEvent").setParams({
            phone:phNumber
        }).fire();
	}
})