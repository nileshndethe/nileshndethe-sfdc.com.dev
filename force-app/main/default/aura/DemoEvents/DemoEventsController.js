({
    init : function(component, event, helper) {
        var empApi = component.find("empApi");
        empApi.setDebugFlag(true);
        /*
        // Error handler function that prints the error to the console.
        var errorHandler = function (message) {
            console.log("Received error ", message);
        }.bind(this);
        
        // Register error listener and pass in the error handler function.
        empApi.onError(errorHandler); */
        
        // Register error listener and pass in the error handler function
        empApi.onError($A.getCallback(error => {
            debugger;
            // Error can be any type of error (subscribe, unsubscribe...)
            console.error('EMP API error: ', error);
        }));
            
            var channel='/event/Demo_Event__e';
            var sub;
            
            // new events
            var replayId=-1;
            
            var callback = function (message) {
            /*component.find('notifLib').showToast({
            	"title": "Message Received!",
	            "message": message.data.payload.Message__c,
            "mode": "sticky"
        		});  */      
            
            component.find('notifLib').showNotice({
            "variant": "warning",
            "header": "Pricebook onwership Changed!",
            "message": message.data.payload.Message__c,
            closeCallback: function() {
                alert($A.get("$SObjectType.CurrentUser.Id"));
                $A.get('e.force:refreshView').fire();
            }
        });
                       }.bind(this);
        
        empApi.subscribe(channel, replayId, callback).then(function(value) {
            console.log("Subscribed to channel " + channel);
            sub = value;
            component.set("v.sub", sub);
        });
    }
})