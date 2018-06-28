({
	loadrow : function(component, recordId) {
		var action = component.get("c.getOneCompensation");
		// Add callback behavior for when response is received
		
		action.setParams({
            "recordId": recordId
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
              
                component.set("v.compensation", response.getReturnValue());
            
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
	}
})