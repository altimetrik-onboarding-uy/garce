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
    @isTest static void TestModifySubmittedCompensationToUnSubmmitted(){
        
        List<Compensation__c> compensations = TestDataFactory.testData(true);
        System.debug(compensations.size());
        compensations.get(0).submitted__c=false;

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
        System.debug('Objeto a borrar: '+compensations.get(0));
        Database.DeleteResult  dr = Database.delete(compensations.get(0), false);
        for(Database.Error err : dr.getErrors()) {
            System.debug('The following error has occurred.');             
            System.debug(err.getStatusCode() + ': ' + err.getMessage());
            System.debug('Account fields that affected this error: ' + err.getFields());

        }



		Test.stopTest();
        
        System.assert(dr.isSuccess());
      
            
        
        
    }
    
    

}