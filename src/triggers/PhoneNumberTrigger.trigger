trigger PhoneNumberTrigger on PhoneNumber__c (before insert, before update) {    
    for(PhoneNumber__c phoneRecord : trigger.new){        
        phoneRecord.Name = GoldLineUtility.ConvertPhoneNumberTo10Digit(phoneRecord.Name);
        phoneRecord.Phone_Number_10_Numbers__c = phoneRecord.name;//GoldLineUtility.ConvertPhoneNumberTo10Digit(phoneRecord.Name);
        phoneRecord.Phone_Number__c =  phoneRecord.name;//GoldLineUtility.ConvertPhoneNumberTo10Digit(phoneRecord.Name);
        
    }    
}