({
    loadTable: function (component, recorType, submitted) {
        var action = component.get("c.getCompensations");
        var contactRecordId = component.get("v.recordId");
        // Add callback behavior for when response is received

        action.setParams({
            "contactRecordId": contactRecordId,
            "recordType": recorType,
            "submitted": submitted
        });
        action.setCallback(this, function (response) {
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
    loadfilter: function (component) {
        var action = component.get("c.getRecordTypes");
        // Add callback behavior for when response is received
        var options = [];

        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {

                response.getReturnValue().forEach(element => {
                    options.push({ value: element, label: element });

                });

                component.set("v.options", options);


            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
    },

    removeComp: function (component, compensation) {
        var selectedComps = component.get("v.selectedCompensations");
        var foundit = false;
        for (var i = 0; selectedComps.length && !foundit; i++) {
            var c = selectedComps[i];
            if (c.id == compensation.id) {
                foundit = true;
                selectedComps.splice(i, 1);
            }
        }



    },

    sendSubmit: function (component) {
        var action = component.get("c.compensationToSubmit");

        var comps = component.get("v.selectedCompensations");


        action.setParams({
            "comps": comps

        });

        action.setCallback(this, function (response) {
            var state = response.getState();
            if (state === "SUCCESS") {

                alert(response.getReturnValue());

                component.set("v.selectedCompensations", []);


            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
    },

    convertArrayOfObjectsToCSV: function (component, objectRecords) {
        // declare variables
        var csvStringResult, columns;

        // check if "objectRecords" parameter is null, then return from function
        if (objectRecords == null || !objectRecords.length) {
            return null;
        }


        columns = ['Name', 'Employee\'s Name', 'Employee\'s Birthdate', 'Job Category', 'Compensation Type', 'Amount', 'Location', 'Office', 'Submitted', 'Status'];

        csvStringResult = '';
        csvStringResult += columns.join(',');
        csvStringResult += '\n';

        for (var i = 0; i < objectRecords.length; i++) {

            var compensation = objectRecords[i];

            csvStringResult += '"' + compensation.Name + '",' + '"' + compensation.Contact__r.Name + '",' + '"' + compensation.Contact__r.Birthdate + '",' + '"' + compensation.Job_Category__c + '",' + '"' + compensation.RecordType.DeveloperName + '",' + '"' + compensation.Amount__c + '",' + '"' + compensation.Location__c + '",' + '"' + compensation.Office__c + '",' + '"' + compensation.Submitted__c + '",' + '"' + compensation.Status__c + '"\n';

        }

        return csvStringResult;
    }
})