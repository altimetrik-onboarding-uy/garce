@isTest

public class TestTriggerCompensation {

    

    @isTest static void TestModifySubmittedCompensation(){
        
        List<Compensation__c> compensations = TestDataFactory.testData(true);
        System.debug(compensations.size());
        compensations.get(0).Name='Prueba';

        Test.startTest();
        
        Database.SaveResult  sr = Database.update(compensations.get(0), false);
        
		Test.stopTest();
        
        System.assert(!sr.isSuccess());
        System.assert(sr.getErrors().size() > 0);
        System.assertEquals('The status of the Compensation does not allow delete or modify',
                             sr.getErrors()[0].getMessage());
            
        
        
    }

    @isTest static void TestModifyunSubmittedCompensation(){
        
        List<Compensation__c> compensations = TestDataFactory.testData(false);
        compensations.get(0).Name='Prueba';

        Test.startTest();
        
        Database.SaveResult  sr = Database.update(compensations.get(0), false);
        
		Test.stopTest();
        
        System.assert(sr.isSuccess());
        
            
        
        
    }

    @isTest static void TestDeleteSubmittedCompensation(){
        
        List<Compensation__c> compensations = TestDataFactory.testData(true);

        Test.startTest();
        
        Database.DeleteResult  dr = Database.delete(compensations.get(0), false);
        
		Test.stopTest();
        
        System.assert(!dr.isSuccess());
        System.assert(dr.getErrors().size() > 0);
        System.assertEquals('The status of the Compensation does not allow delete or modify',
                             dr.getErrors()[0].getMessage());
            
        
        
    }

    @isTest static void TestDeleteunSubmittedCompensation(){
        
        List<Compensation__c> compensations = TestDataFactory.testData(false);
        Test.startTest();
        
        Database.DeleteResult  dr = Database.delete(compensations.get(0), false);
        
		Test.stopTest();
        
        System.assert(dr.isSuccess());
      
            
        
        
    }
    
    

}