/*({
	// Your renderer method overrides go here
})*/

({
    render : function(cmp, helper) {
        var ret = this.superRender();
        // do custom rendering here
        return ret;
    },
    
    rerender : function(cmp, helper) {
        this.superRerender();
        // do custom rerendering here
	},
    
    afterRender: function (component, helper) {
        this.superAfterRender();
        // interact with the DOM here
	},
    
    unrender: function () {
        this.superUnrender();
        // do custom unrendering here
	}
})