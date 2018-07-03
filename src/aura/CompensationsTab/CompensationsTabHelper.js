({
	loadTable : function(component, recorType) {
        var action = component.get("c.getCompensations");
        var contactRecordId = component.get("v.recordId");
		// Add callback behavior for when response is received
		console.log(contactRecordId);
		action.setParams({
            "contactRecordId" : contactRecordId,
            "recordType": recorType
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
              
                component.set("v.compensations", response.getReturnValue());
            
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
	},
	loadfilter : function(component) {
		var action = component.get("c.getRecordTypes");
		// Add callback behavior for when response is received
		
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
              
                component.set("v.options", response.getReturnValue());
            
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
	}
})