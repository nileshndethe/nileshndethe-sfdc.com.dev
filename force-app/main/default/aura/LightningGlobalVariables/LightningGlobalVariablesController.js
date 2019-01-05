({
	getBrowserStatus: function(component, event, helper) {
		var device = $A.get("$Browser.formFactor");
		component.set('v.bStatus',device);
	},
	getLocaleStatus: function(component, event,helper){
		var locale = $A.get("$Locale.timezone");
		component.set('v.lStatus', locale);
	}
})