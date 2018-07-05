trigger AvoidEditorDelete on Compensation__c (before update, before delete, after update, before insert) {
    
    if (trigger.isUpdate){
        Compensation__c c;

        

        for( Id compId : Trigger.newMap.keySet() ) {

            if( Trigger.oldMap.get( compId ).status__c == Trigger.newMap.get( compId ).status__c){

                if( Trigger.oldMap.get( compId ).submitted__c == Trigger.newMap.get( compId ).submitted__c ){
                    c = Trigger.newMap.get( compId );
                    if(c.submitted__c==true){
                    c.addError('The status of the Compensation does not allow delete or modify');
                    }
                }
                if(Trigger.newMap.get( compId ).submitted__c==false && Trigger.oldMap.get( compId ).submitted__c==true){
                     c = Trigger.newMap.get( compId );
                    
                    c.addError('The status of the Compensation does not allow delete or modify');

                }
                if(Trigger.newMap.get( compId ).submitted__c==true && Trigger.oldMap.get( compId ).submitted__c==false){
                     c = Trigger.newMap.get( compId );
                    
                    c.status__c='SUBMITTED';

                }
            }
        }
    }

   

    if (trigger.isdelete){
            for(Compensation__c c : Trigger.Old) {
                if(c.submitted__c==true){
                    c.addError('The status of the Compensation does not allow delete or modify');
                }
            }



    }



    
    
}