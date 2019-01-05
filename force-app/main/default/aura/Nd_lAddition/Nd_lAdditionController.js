({
    /** Called when button is pressed to add numbers **/
    add : function(component) {
        var sum = parseInt(component.get("v.num1"))
                + parseInt(component.get("v.num2"));
        component.set("v.sum", sum+'');
    }
})