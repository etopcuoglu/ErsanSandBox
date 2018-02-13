trigger AccountTrigger on Account (after insert,after update) {
    system.debug('isUpdate: '+trigger.isUpdate + ' isInsert '+ trigger.isInsert);
    if(trigger.isUpdate){
    	ControllerAccountTriggerHandler.UpdateContactinAX(trigger.new);    
    }
    
    if(trigger.isInsert){
        system.debug('isInsert '+trigger.new);
    	ControllerAccountTriggerHandler.CreateNewAccountinAX(trigger.new);    
    }
    
    
}