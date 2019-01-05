({
	getCaseDetails : function(component, event, helper) {
        debugger;
		var caseid = component.find("caseID").get("v.value");
        var action = component.get("c.getCaseFromId");
        action.setParams({
            "caseID": null
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state == "SUCCESS")
            {
                component.set("v.record", response.getReturnValue());
            }
        });
		$A.enqueueAction(action);

	}
})