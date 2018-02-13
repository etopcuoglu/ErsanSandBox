trigger PhoneNumberTrigger on PhoneNumber__c (before insert, before update) {    
    for(PhoneNumber__c phoneRecord : trigger.new){        
        phoneRecord.Phone_Number_10_Numbers__c = GoldLineUtility.ConvertPhoneNumberTo10Digit(phoneRecord.Name);
    }    
}