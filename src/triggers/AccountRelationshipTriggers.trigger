trigger AccountRelationshipTriggers on Account_Relationship__c (before insert) {
if(checkRecursive.runOnce()){
        if(trigger.isInsert){
        AccountRelationshipTriggerHandler.SwapAccountEntryOnCreate(trigger.new);
    	}
    } 
}