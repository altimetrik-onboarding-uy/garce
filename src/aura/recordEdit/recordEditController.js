({
	save : function(component, event, helper) {
        component.find("edit").get("e.recordSave").fire();
    },
    handleSaveSuccess : function(component, event) {
        component.set("v.saveState", "SAVED");
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Success!",
            "message": "The record has been updated successfully."
        });
        toastEvent.fire();
    }
})