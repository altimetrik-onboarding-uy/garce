@isTest
private class TestBatchSubmit {
    @testSetup 
    static void setup() {
        List<RecordType> recordTypesCompensation = [select id from RecordType where SobjectType ='Compensation__c'];
        
        Contact c = new Contact(FirstName='Name', LastName = 'Test');
        insert c;
        Compensation__c comp = new Compensation__c (RecordTypeId = recordTypesCompensation.get(0).id,Submitted__c=false,Name='Tesc Comp',Contact__c = c.id, Location__c='Uruguay',  Office__c='MVD WTC 2', Job_Category__c='Senior', status__c='NOT SUBMITTED');
        insert comp;
    }
    static testmethod void test() {        
        Test.startTest();
        SubmitBatch sb = new SubmitBatch();
       
        Id batchId = Database.executeBatch(sb);
        Test.stopTest();
        // after the testing stops, assert records were updated properly
        System.assertEquals(1, [select count() from Compensation__c]);
        System.assertEquals(0, [select count() from Compensation__c where submitted__c = true]);
    }
    
}