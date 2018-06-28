({
    doInit: function (component, event, helper) {
        // Create the action

        helper.loadTable(component, 'All');
        helper.loadfilter(component);

    },
    filterTable: function (component, event, helper) {

        helper.loadTable(component, component.get('v.selectedValue'));
    },

    handleSaveSuccess: function (component, event, helper) {

        console.log('el evento');

    }
})