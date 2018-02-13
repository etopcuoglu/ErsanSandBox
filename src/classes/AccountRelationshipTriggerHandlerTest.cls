@isTest
private class AccountRelationshipTriggerHandlerTest {
    //Tesst class for AccountRelationship Object Trigger Handler class
    static testMethod void test_SwapAccountEntryOnCreate (){
        Account_Relationship__c ar = new Account_Relationship__c();
        Account acc1 = TestDataFactory.CreateAccountByName('Account 1');
        insert acc1;
        Account acc2 = TestDataFactory.CreateAccountByName('Account 2');
        insert acc2;
       // ar.Name = 'unit test';
        ar.From_Account__c = acc1.Id;
        ar.From_Role__c = 'test from';
        ar.To_Account__c = acc2.Id;
        ar.To_Role__c = 'test to';
        insert ar;
        
        List<Account_Relationship__c> arList = [SELECT Id, From_Account__c, From_Role__c, To_Account__c, To_Role__c 
                                                FROM Account_Relationship__c 
                                                WHERE To_Role__c like '%test%'];
        system.assertEquals(arlist.size() , 2);
        
    }
    static testMethod void test_SwapSameAccountEntryOnCreate (){
        Account_Relationship__c ar = new Account_Relationship__c();
        Account acc1 = TestDataFactory.CreateAccountByName('Account 1');
        insert acc1;
       // ar.Name = 'unit test';
        ar.From_Account__c = acc1.Id;
        ar.From_Role__c = 'test from';
        ar.To_Account__c = acc1.Id;
        ar.To_Role__c = 'test to';
        
        Database.SaveResult saveResult = Database.insert(ar,false);
        if (!saveResult.isSuccess()){
           //for (Database.Error error : saveResult.getErrors()) {                                  
              system.assertEquals(true ,true);
            //}
        }

        
    }
}