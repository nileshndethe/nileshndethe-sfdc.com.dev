({	
    SetPhoneNumber: function(component, event, helper) {
        debugger;
		var phnumber = event.getParam("phone");
        //Console.write("phnumber : " + phnumber);
        component.set("v.number",phnumber);
	}
})