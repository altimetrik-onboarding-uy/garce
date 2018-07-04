@isTest
public class TestCompesantionController {

@isTest 
   static void TestReturnedCompAll(){
        
         List<Compensation__c> comps = TestDataFactory.testData(false);

        

        Test.startTest();
        
        List<Compensation__c> returnedList = CompensationsController.getCompensations(null, 'All','All');
        
		Test.stopTest();

        System.assert(returnedList.size() == 1);
        System.assertEquals(returnedList.get(0).id,comps.get(0).id);
        
        
    }
@isTest
    static void TestReturnedCompForContact(){
        
         List<Compensation__c> comps = TestDataFactory.testData(false);

         Contact c = new Contact(FirstName='Prueba',LastName='Test');
        insert c;

        Test.startTest();
        List<Compensation__c> returnedListfilled = CompensationsController.getCompensations(comps.get(0).Contact__c, 'All','All');
        List<Compensation__c> returnedListempty = CompensationsController.getCompensations(c.Id, 'All','All');
        
		Test.stopTest();

        
        System.assertEquals(comps.get(0).Contact__c,returnedListfilled.get(0).Contact__c);
        
        System.assert(returnedListempty.isEmpty());  
        
        
    }

    @isTest
    static void TestReturnedCompRecordTypeFilterWithContact(){
        
         List<Compensation__c> comps = TestDataFactory.testData(false);

        string recordtypename = Schema.SObjectType.Compensation__c.getRecordTypeInfosById().get(comps.get(0).recordtypeid).getname();
        System.debug('El id del contacto es: ' + comps.get(0).Contact__c);
        System.debug('El contacto es: ' + comps.get(0));
        Test.startTest();
        
        List<Compensation__c> returnedListfilled = CompensationsController.getCompensations(comps.get(0).Contact__c, recordtypename,'All');
        List<Compensation__c> returnedListempty = CompensationsController.getCompensations(comps.get(0).Contact__c, 'Test','All');
        
		Test.stopTest();
        
        System.assert(returnedListfilled.size()>0);
        System.assertEquals(comps.get(0).Contact__c,returnedListfilled.get(0).Contact__c);
        System.assert(returnedListempty.isEmpty());  
        
        
    }

    @isTest
    static void TestReturnedCompRecordTypeFilterWithoutContact(){
        
        List<Compensation__c> comps = TestDataFactory.testData(false);
        string recordtypename = Schema.SObjectType.Compensation__c.getRecordTypeInfosById().get(comps.get(0).recordtypeid).getname();
        
       

        Test.startTest();
        List<Compensation__c> returnedListfilled = CompensationsController.getCompensations(null, recordtypename,'All');
        List<Compensation__c> returnedListempty = CompensationsController.getCompensations(null, 'Test','All');
        
		Test.stopTest();
        
        
        System.assertEquals(comps.get(0).Contact__c,returnedListfilled.get(0).Contact__c);
        System.assert(returnedListempty.size()==0); 
        
        
    }

     @isTest
    static void TestReturnedCompSubmitFilterWithoutTypeFilter(){
        
        List<Compensation__c> comps = TestDataFactory.testData(false);
        

        

        Test.startTest();
        List<Compensation__c> returnedListfilled = CompensationsController.getCompensations(null, 'All','false');
        List<Compensation__c> returnedListempty = CompensationsController.getCompensations(null, 'All','true');
        
		Test.stopTest();
        
        
        System.assertEquals(comps.get(0).Contact__c,returnedListfilled.get(0).Contact__c);
        System.assert(returnedListempty.size()==0); 
        
        
    }

     @isTest
    static void TestReturnedCompSubmitFilterWithTypeFilter(){
        
        List<Compensation__c> comps = TestDataFactory.testData(false);
        string recordtypename = Schema.SObjectType.Compensation__c.getRecordTypeInfosById().get(comps.get(0).recordtypeid).getname();
       
        

        Test.startTest();
        List<Compensation__c> returnedListfilled = CompensationsController.getCompensations(null, recordtypename,'false');
        List<Compensation__c> returnedListempty = CompensationsController.getCompensations(null, 'Test','false');
        
		Test.stopTest();
        
        
        System.assertEquals(comps.get(0).Contact__c,returnedListfilled.get(0).Contact__c);
        System.assert(returnedListempty.size()==0); 
        
        
    }

    @isTest
    static void TestReturRecordTypes(){
        
        List<RecordType> recordTypesCompensation = [select id, DeveloperName from RecordType where SobjectType ='Compensation__c'];
        List<String> listRt = new List<String>();
        listRt.add('All');
        for(RecordType rt : recordTypesCompensation){
            listRt.add(rt.DeveloperName);

        }
        

        Test.startTest();
        List<String> listreturned = CompensationsController.getRecordTypes();
       
		Test.stopTest();
        
        
        System.assertEquals(listRt,listreturned);
        
        
        
    }


     @isTest
    static void TestCompSubmit(){
        
         List<Compensation__c> comps = TestDataFactory.testData(false);
        

        Test.startTest();
        String strreturned = CompensationsController.compensationToSubmit(comps);
       
		Test.stopTest();
        
        
        System.assertEquals(comps.size()+' compesantion(s) updated.',strreturned);
        
        
        
    }
}