({
    doInit : function(component, event, helper){
        var action = component.get("c.getItems");
        action.setCallback(this, function(response){
            var state = response.getState();
            if(component.isValid() && state == "SUCCESS"){
                component.set("v.items", response.getReturnValue());
            }
            else
            {
                console.log("Failed with state: " + state);
            }
        });
        $A.enqueueAction(action);
    },
    handleAddItem : function(component, event, helper)
    {               
        var newItem = event.getParam("item");
        var action = component.get("c.saveItem");
            action.setParams({
                "newItem" : newItem
            });
            action.setCallback(this, function(response){
            var state = response.getState();
            if(component.isValid() && state == "SUCCESS"){
               	var cmpList = component.get("v.items");           
                cmpList.push(response.getReturnValue());
                component.set("v.items",cmpList);                              
            }            
        });
         $A.enqueueAction(action);
    }
})