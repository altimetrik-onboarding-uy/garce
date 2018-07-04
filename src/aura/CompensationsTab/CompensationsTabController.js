({
    doInit: function (component, event, helper) {
        // Create the action

        helper.loadTable(component, 'All', 'All');
        helper.loadfilter(component);

    },
    filterTable: function (component, event, helper) {

        helper.loadTable(component, component.get('v.selectedValue'), component.get('v.submittedValue'));
    },

    handleSelectCompensation: function (component, event, helper) {
        console.log('Estoy escuchando este nuevo');
        var add = event.getParam("add");
        var compensation = event.getParam("compensation");
        var selectedComps = component.get("v.selectedCompensations");

        if (add) {
            selectedComps.push(compensation);

        }
        else {
            helper.removeComp(component, compensation);

        }
    },

    sendtoSubmitt: function (component, event, helper) {
        var list = component.get("v.selectedCompensations");
        if (list.length > 0) {
            helper.sendSubmit(component, list);
            helper.loadTable(component, 'All', 'All');
        } else {
            alert('No compensation(s) to submit');
        }

    },

    downloadCsv: function (component, event, helper) {


        var comps = component.get("v.compensations");

        // call the helper function which "return" the CSV data as a String   
        var csv = helper.convertArrayOfObjectsToCSV(component, comps);
        if (csv == null) { return; }

        // ####--code for create a temp. <a> html tag [link tag] for download the CSV file--####     
        var hiddenElement = document.createElement('a');
        hiddenElement.href = 'data:text/csv;charset=utf-8,' + encodeURI(csv);
        hiddenElement.target = '_self'; // 
        hiddenElement.download = 'Compensations.csv';  // CSV file Name* you can change it.[only name not .csv] 
        document.body.appendChild(hiddenElement); // Required for FireFox browser
        hiddenElement.click(); // using click() js function to download csv file
    }




})