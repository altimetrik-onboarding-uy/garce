@isTest
private class TestScheduleJob {
    // Dummy CRON expression: midnight on March 15.
    // Because this is a test, job executes
    // immediately after Test.stopTest().
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';

    static testmethod void testScheduledJob() {
        List<RecordType> recordTypesCompensation = [select id from RecordType where SobjectType ='Compensation__c'];
        
        Contact c = new Contact(FirstName='Name', LastName = 'Test');
        insert c;
        Compensation__c comp = new Compensation__c (RecordTypeId = recordTypesCompensation.get(0).id,Submitted__c=false,Name='Tesc Comp',Contact__c = c.id, Location__c='Uruguay',  Office__c='MVD WTC 2', Job_Category__c='Senior', status__c='NOT SUBMITTED');
        insert comp;
        
        Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('ScheduledApexTest',
            CRON_EXP, 
            new ScheduleSubmit());         
        Test.stopTest();
        
        System.assertEquals(1, [select count() from Compensation__c]);
        System.assertEquals(0, [select count() from Compensation__c where submitted__c = true]);
    }
}