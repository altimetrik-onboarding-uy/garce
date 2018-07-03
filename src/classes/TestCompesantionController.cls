
@isTest
public class TestCompesantionController {

@isTest 
   static void TestReturnedCompAll(){
        
         List<RecordType> recordTypesCompensation = [select id from RecordType where SobjectType ='Compensation__c'];
         List<Compensation__c> comps = TestDataFactory.testData(false);

        comps.get(0).RecordTypeId = recordTypesCompensation.get(0).id;
        update comps;

        Test.startTest();
        
        List<Compensation__c> returnedList = CompensationsController.getCompensations(null, 'All');
        
		Test.stopTest();

        System.assert(returnedList.size() == 1);
        System.assertEquals(returnedList.get(0).id,comps.get(0).id);
        
        
    }
@isTest
    static void TestReturnedCompForContact(){
        
         List<RecordType> recordTypesCompensation = [select id from RecordType where SobjectType ='Compensation__c'];
         List<Compensation__c> comps = TestDataFactory.testData(false);

        comps.get(0).RecordTypeId = recordTypesCompensation.get(0).id;
        
        update comps;
        Contact c = new Contact(FirstName='Prueba',LastName='Test');
        insert c;

        Test.startTest();
        List<Compensation__c> returnedListfilled = CompensationsController.getCompensations(comps.get(0).Contact__r.id, 'All');
        List<Compensation__c> returnedListempty = CompensationsController.getCompensations(c.Id, 'All');
        
		Test.stopTest();

        
        System.assertEquals(comps.get(0).Contact__c,returnedListfilled.get(0).Contact__c);
        System.debug('Escribiendo....' +returnedListempty+' fin');
        System.assert(returnedListempty.isEmpty());  
        
        
    }

    @isTest
    static void TestReturnedCompRecordTypeFilterWithContact(){
        
        List<RecordType> recordTypesCompensation = [select id from RecordType where SobjectType ='Compensation__c' and DeveloperName='Salary'];
        List<Compensation__c> comps = TestDataFactory.testData(false);

        comps.get(0).RecordTypeId = recordTypesCompensation.get(0).id;
        update comps;
        

        Test.startTest();
        List<Compensation__c> returnedListfilled = CompensationsController.getCompensations(comps.get(0).Contact__r.id, 'Salary');
        List<Compensation__c> returnedListempty = CompensationsController.getCompensations(comps.get(0).Contact__r.id, 'Study');
        
		Test.stopTest();

        
        System.assertEquals(comps.get(0).Contact__c,returnedListfilled.get(0).Contact__c);
        System.assert(returnedListempty.isEmpty());  
        
        
    }

    @isTest
    static void TestReturnedCompRecordTypeFilterWithoutContact(){
        
        List<RecordType> recordTypesCompensation = [select id from RecordType where SobjectType ='Compensation__c' and DeveloperName='Salary'];
        List<Compensation__c> comps = TestDataFactory.testData(false);

        comps.get(0).RecordTypeId = recordTypesCompensation.get(0).id;
        update comps;
        

        Test.startTest();
        List<Compensation__c> returnedListfilled = CompensationsController.getCompensations(null, 'Salary');
        List<Compensation__c> returnedListempty = CompensationsController.getCompensations(null, 'Study');
        
		Test.stopTest();
        
        
        System.assertEquals(comps.get(0).Contact__c,returnedListfilled.get(0).Contact__c);
        System.assert(returnedListempty.size()==0); 
        
        
    }
}


