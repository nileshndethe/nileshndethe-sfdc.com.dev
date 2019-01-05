({
	createItem : function(component) {
        var newcmpItem = component.get("v.newItem");
		var addItemEvnt = component.getEvent("addItem");
    	addItemEvnt.setParams({"item": newcmpItem });
    	addItemEvnt.fire();        
        component.set("v.newItem", 
                      {'sobjectType':'Camping_Item__c',
                       'Quantity__c':'0',
                       'Price__c':'0'});
	}
})