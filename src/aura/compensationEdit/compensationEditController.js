({
	
		edit : function(component, event, helper) {
			var editRecordEvent = $A.get("e.force:editRecord");
			editRecordEvent.setParams({
				"recordId": component.get("v.compensation.Id") 
			});
			editRecordEvent.fire();
			
			
		},

	
		save : function(component, event, helper) {

			console.log('estoy ecuchando');
		},

		selectCompensation: function(component, event, helper) {
			
			var compensation = component.get("v.compensation");
			var updateEvent = component.getEvent("selectcompensation");
			var add= component.find("selectionCheck").get("v.value");
			
			updateEvent.setParams({ "compensation": compensation, "add":add });
			updateEvent.fire();
		}


	
})