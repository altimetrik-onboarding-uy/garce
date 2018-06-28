public with sharing class  CompensationsController {

    
     @AuraEnabled
    public static List<Compensation__c> getCompensations(String contactRecordId, String recordType) {
        // Perform isAccessible() checking first, then
        System.debug(contactRecordId +' '+recordType);
        
        String squery = 'SELECT Id, Name, Contact__r.Name,Contact__r.Birthdate,Job_Category__c,RecordType.DeveloperName,Amount__c,Location__c,Office__c,Submitted__c,Status__C FROM Compensation__c ';
        if(contactRecordId!=null){
            squery += 'where contact__r.id=\'' + contactRecordId + '\'' ;
            if (recordType!='All'){
                squery += ' and RecordType.DeveloperName=\'' + recordType + '\'' ;
            }
        }else{
             if (recordType!='All'){
                squery += 'where RecordType.DeveloperName=\'' + recordType + '\'' ;
            }
        }
        System.debug(squery);
        List<Compensation__c> returnList = Database.query(squery);


        
        return returnList;
       
    }
     @AuraEnabled
     public static List<String> getRecordTypes(){
        List<RecordType> recordTypesCompensation = [select DeveloperName from RecordType where SobjectType ='Compensation__c'];
        
        List<String> nameList = new List<String>();
        nameList.add('All');

        for(RecordType r : recordTypesCompensation){

            nameList.add(r.DeveloperName);
        }
        return nameList; 
     }

    

}