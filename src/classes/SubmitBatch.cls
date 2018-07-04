global class SubmitBatch implements 
    Database.Batchable<sObject>, Database.Stateful {
    
    // instance member to retain state across transactions
    global Integer recordsProcessed = 0;
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(
            'SELECT Id, submitted__c,status__c, createddate '+
            'FROM Compensation__c '+
            'WHERE submitted__c = false AND createddate < LAST_N_DAYS:2'
        );
    }
    global void execute(Database.BatchableContext bc, List<Compensation__c> scope){
        // process each batch of records
        System.debug('La cantidad en scope es: '+scope.size());
        for (Compensation__c compensation : scope) {
            compensation.submitted__c=true;
           
             recordsProcessed = recordsProcessed + 1;
        }
        update scope;
    }    
    global void finish(Database.BatchableContext bc){
        
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, 
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
        // call some utility to send email
       
    }    
}