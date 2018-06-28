@isTest
public class TestDataFactory {

    public static List<Compensation__c> testData(boolean sumbitted){
        Contact c = new Contact(FirstName='Name', LastName = 'Test');
        insert c;

        Compensation__c comp = new Compensation__c (Submitted__c=sumbitted,Name='Tesc Comp',Contact__c = c.id, Location__c='Uruguay',  Office__c='MVD WTC 2', Job_Category__c='Senior');
        insert comp;
        List<Compensation__c> listComp = new List<Compensation__c>();
        listComp.add(comp);
        return  listComp;
    }

}