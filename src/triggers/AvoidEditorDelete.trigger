trigger AvoidEditorDelete on Compensation__c (before update, before delete) {
    
   	if(Trigger.isDelete)
    for(Compensation__c c : Trigger.Old) {
        if(c.Submitted__c==true){
            c.addError('The status of the Compensation does not allow delete or modify');
        }
    }else{
        
     
    for(Compensation__c c : Trigger.New) {
        if(c.Submitted__c==true){
            c.addError('The status of the Compensation does not allow delete or modify');
        
    }
    }
    }
    
}