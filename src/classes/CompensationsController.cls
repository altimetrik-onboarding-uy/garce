public with sharing class  CompensationsController {

    
     @AuraEnabled
    public static List<Compensation__c> getCompensations(String contactRecordId, String recordType, String submitted) {
        // Perform isAccessible() checking first, then
        System.debug('Viene: '+contactRecordId +' '+recordType+' '+ submitted);
        String squery = 'SELECT Id, Name, Contact__r.Name,Contact__r.Birthdate,Job_Category__c,RecordType.DeveloperName,Amount__c,Location__c,Office__c,Submitted__c,Status__c FROM Compensation__c ';
        Boolean wherewaswritten = false;
        String contactFilter = ' contact__r.id=\'' + contactRecordId + '\' ';
        String recordTypeFilter = ' RecordType.DeveloperName=\'' + recordType + '\' ';
        String submittedFilter = ' Submitted__c=' + submitted;
        
        
        if(contactRecordId!=null){
             squery += 'where'+ contactFilter;
             wherewaswritten = true;
        }
        
        if (recordType!='All'){
                if(wherewaswritten){
                squery += 'and'+recordTypeFilter;
                } else{
                    squery += 'where'+recordTypeFilter; 
                    wherewaswritten = true;
                }
        }

        if (submitted!='All'){
                if(wherewaswritten){
                squery += 'and'+submittedFilter;
                } else{
                    squery += 'where'+submittedFilter;
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

    @AuraEnabled
    public static String compensationToSubmit(List<Compensation__c> comps){
        
        for (Compensation__c c : comps){

            c.Submitted__c=true;
        }

        update comps;
        return comps.size() + ' compesantion(s) updated.';


    }

}