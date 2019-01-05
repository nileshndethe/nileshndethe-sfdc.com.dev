({
	calculate : function(component, event, helper) {
		debugger;
        var inputOne = parseInt(component.find("inputOne").get("v.value"));
        var inputTwo = parseInt(component.find("inputTwo").get("v.value"));
        var inputThree = parseInt(component.find("inputThree").get("v.value"));
        var totalValueCmp = component.find("totalValue");
        if(!isNaN(inputOne) && !isNaN(inputTwo) && !isNaN(inputThree))
        {
       		var totalValue = (inputThree - (inputOne + inputTwo));
            totalValueCmp.set("v.value",totalValue);
        }
        else
        {
            totalValueCmp.set("v.errors", [{message:"Any one input is not number."}]);
        }       
	}
})