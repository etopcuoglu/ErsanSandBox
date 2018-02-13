public class CTITestDataFactory {
    
    public static User CreateCTIData(){
        // Returns a User who owns Accounts that are associated with 3 phone numbers each and that own Tasks of type "Call.""
             User testUser = new User(
             ProfileId = [SELECT Id FROM Profile WHERE Name = 'System Administrator'][0].Id,
             LastName = 'Testlastname',
             Email = 'testuser@nowhere.com',
             Username = 'testuser@nowhere.com.test' + System.currentTimeMillis(),
             CompanyName = 'TEST',
             Title = 'test title',
             Alias = 'tsta',
             TimeZoneSidKey = 'America/Los_Angeles',
             EmailEncodingKey = 'UTF-8',
             LanguageLocaleKey = 'en_US',
             LocaleSidKey = 'en_US'
             // UserRoleId = r.Id		// We might need this to test AE and other functionality later. JM
        );
        insert testUser;
        
        String personRecordTypeId  = Schema.getGlobalDescribe().get('Account').getDescribe().getRecordTypeInfosByName().get('Person Account').getRecordTypeId();
        Account acc= new Account(RecordTypeID=personRecordTypeId);
        
        List<Account> accountList = new List<Account>();
        Account account1 = new Account(RecordTypeID=personRecordTypeId,LastName='Seinfeld',FirstName='Jerry',OwnerId=testUser.Id);
        accountList.add(account1);
        Account account2 = new Account(RecordTypeID=personRecordTypeId,LastName='Benes',FirstName='Elaine',OwnerId=testUser.Id);
        accountList.add(account2);
        // Account account3 = new Account(RecordTypeID=personRecordTypeId,LastName='Costanza',FirstName='George');
        // accountList.add(account3);
        insert accountList;
        
        List<PhoneNumber__c> phoneNumbers = new List<PhoneNumber__c>();
        PhoneNumber__c phoneNumber1 = new PhoneNumber__c();
        phoneNumber1.Phone_Number__c = '1111111111';
        phoneNumbers.add(phoneNumber1);
        PhoneNumber__c phoneNumber2 = new PhoneNumber__c();
        phoneNumber2.Phone_Number__c = '2222222222';
        phoneNumbers.add(phoneNumber2);
        PhoneNumber__c phoneNumber3 = new PhoneNumber__c();
        phoneNumber3.Phone_Number__c = '3333333333';
        phoneNumbers.add(phoneNumber3);
        PhoneNumber__c phoneNumber4 = new PhoneNumber__c();
        phoneNumber4.Phone_Number__c = '4444444444';
        phoneNumbers.add(phoneNumber4);
        PhoneNumber__c phoneNumber5 = new PhoneNumber__c();
        phoneNumber5.Phone_Number__c = '5555555555';
        phoneNumbers.add(phoneNumber5);
        PhoneNumber__c phoneNumber6 = new PhoneNumber__c();
        phoneNumber6.Phone_Number__c = '6666666666';
        phoneNumbers.add(phoneNumber6);
        insert phoneNumbers;
        
        List<Account_Phone_Relationship__c> accountPhoneRelationshipList = new List<Account_Phone_Relationship__c>();
        Account_Phone_Relationship__c accountPhoneRelationship1 = new Account_Phone_Relationship__c(Phone_Number__c=phoneNumber1.Id, Phone_Number_Type__c='Home', Is_Primary_Phone_del__c=false, Account__c=account1.Id);
        accountPhoneRelationshipList.add(accountPhoneRelationship1);
        Account_Phone_Relationship__c accountPhoneRelationship2 = new Account_Phone_Relationship__c(Phone_Number__c=phoneNumber2.Id, Phone_Number_Type__c='Business', Is_Primary_Phone_del__c=true, Account__c=account1.Id);
        accountPhoneRelationshipList.add(accountPhoneRelationship2);
        Account_Phone_Relationship__c accountPhoneRelationship3 = new Account_Phone_Relationship__c(Phone_Number__c=phoneNumber3.Id, Phone_Number_Type__c='Mobile', Is_Primary_Phone_del__c=false, Account__c=account1.Id);
        accountPhoneRelationshipList.add(accountPhoneRelationship3);
        Account_Phone_Relationship__c accountPhoneRelationship4 = new Account_Phone_Relationship__c(Phone_Number__c=phoneNumber4.Id, Phone_Number_Type__c='Home', Is_Primary_Phone_del__c=false, Account__c=account2.Id);
        accountPhoneRelationshipList.add(accountPhoneRelationship4);
        Account_Phone_Relationship__c accountPhoneRelationship5 = new Account_Phone_Relationship__c(Phone_Number__c=phoneNumber5.Id, Phone_Number_Type__c='Business', Is_Primary_Phone_del__c=false, Account__c=account2.Id);
        accountPhoneRelationshipList.add(accountPhoneRelationship5);
        Account_Phone_Relationship__c accountPhoneRelationship6 = new Account_Phone_Relationship__c(Phone_Number__c=phoneNumber6.Id, Phone_Number_Type__c='Mobile', Is_Primary_Phone_del__c=true, Account__c=account2.Id);
        accountPhoneRelationshipList.add(accountPhoneRelationship6);
        insert accountPhoneRelationshipList;
        
        List<Task> taskList = new List<Task>();
        Account accountForWhoId1 = [SELECT Id, Name, PersonContactId FROM Account WHERE Id = :account1.Id][0];
        Account accountForWhoId2 = [SELECT Id, Name, PersonContactId FROM Account WHERE Id = :account2.Id][0];
        Task task1 = new Task(OwnerId=testUser.Id,Status='Open',ActivityDate=System.today(),WhatId=account1.Id,WhoId=accountForWhoId1.PersonContactId,
                             Type='Call', Disposition__c='', Subject='American Eagle Purchase', Description='');
        taskList.add(task1);
        Task task2 = new Task(OwnerId=testUser.Id,Status='Open',ActivityDate=System.today(),WhatId=account1.Id,WhoId=accountForWhoId1.PersonContactId,
                             Type='Call', Disposition__c='', Subject='Canadian Maple Leaf Purchase', Description='');
        taskList.add(task2);
        Task task3 = new Task(OwnerId=testUser.Id,Status='Open',ActivityDate=System.today(),WhatId=account1.Id,WhoId=accountForWhoId1.PersonContactId,
                             Type='Call', Disposition__c='', Subject='Australian Kangaroo Purchase', Description='');
        taskList.add(task3);
        Task task4 = new Task(OwnerId=testUser.Id,Status='Open',ActivityDate=System.today(),WhatId=account2.Id,WhoId=accountForWhoId2.PersonContactId,
                             Type='Call', Disposition__c='', Subject='American Buffalo Purchase', Description='');
        taskList.add(task4);
        Task task5 = new Task(OwnerId=testUser.Id,Status='Open',ActivityDate=System.today(),WhatId=account2.Id,WhoId=accountForWhoId2.PersonContactId,
                             Type='Call', Disposition__c='', Subject='South African Krugerrand', Description='');
        taskList.add(task5);
        Task task6 = new Task(OwnerId=testUser.Id,Status='Open',ActivityDate=System.today(),WhatId=account2.Id,WhoId=accountForWhoId2.PersonContactId,
                             Type='Call', Disposition__c='', Subject='Chinese Panda', Description='');
        taskList.add(task6);        
        insert taskList;
        
        return testUser;
    }

}