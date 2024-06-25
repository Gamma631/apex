({
    sendMessage: function(component, event, helper) {
        var message = component.get("v.message");
        var sendEvent = component.getEvent("sendToParent");
        sendEvent.setParams({ "message": message });
        sendEvent.fire();
    },
    
    clearInput: function(component, event, helper) {
        component.set("v.message", "");
    }
})