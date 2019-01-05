({
    createItem : function(component,event)
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
                component.set("v.newItem", { 'sobjectType': 'Camping_Item__c',
                        'Name': '',
                        'Quantity__c': 0,
                        'Price__c': 0,
                        'Packed__c': false });                 
            }
            else
            {
                component.set("v.newItem",response.getReturnValue());
                console.log("Failed with state: " + state);
            }
        });
         $A.enqueueAction(action);
    }
})