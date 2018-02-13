@isTest(SeeAllData=true)
private class ControllerTelemarketTest {
    
    private static testMethod void GetTelemarketValidation_Test(){
        Map<String,Boolean> Results = new Map<String,Boolean>();
        
        Account acct1 = new Account();
        Account_Phone_Relationship__c ar = new Account_Phone_Relationship__c();
        Account_Phone_Relationship__c ar2 = new Account_Phone_Relationship__c();
        Account_Phone_Relationship__c ar3 = new Account_Phone_Relationship__c();
        List<PhoneNumber__c> pNumList = new List<PhoneNumber__c>();
        
        Account_Phone_Relationship__c accRel = new Account_Phone_Relationship__c();
        Account_Phone_Relationship__c accRel2 = new Account_Phone_Relationship__c();
        Account_Phone_Relationship__c accRel3 = new Account_Phone_Relationship__c();
        List<Account_Phone_Relationship__c> ArList = new List<Account_Phone_Relationship__c>();
        //create the test account
        acct1.name = 'teleMarket test';
        insert acct1;
        ID acctId = acct1.id;
        
        //create the phone numbers
        PhoneNumber__c pNum1 = new PhoneNumber__c();
        pNum1.Name = '(504)-111-2233';
        insert pNum1;
        
        PhoneNumber__c pNum2 = new PhoneNumber__c();
        pNum2.Name ='1(310) 587-1423';
        insert pNum2;
        
        PhoneNumber__c pNum3 = new PhoneNumber__c();
        pNum3.Name ='(310) 2221423';
        Insert pNum3;
        
        ar.Account__c  = acct1.id;
        ar.Phone_Number__c  = pNum1.Id;
        Insert ar;
        
        ar2.Account__c  = acct1.id;
        ar2.Phone_Number__c  = pNum2.Id;
        Insert ar2;
      
        ar3.Account__c  = acct1.id;
        ar3.Phone_Number__c  = pNum3.Id;
        Insert ar3;
        
        pNumList = [Select Id,Name from PhoneNumber__c Limit 10];
        ArList = [Select Id, Name, Phone_Number__c  from Account_Phone_Relationship__c Limit 10];
        system.debug('pNumList '+pNumlist);
        system.debug('ArList '+ArList);
        Results = GetTelemarketValidation.getPhoneDialablity(acctId);
        system.debug('Resul'+ Results);
        integer counter=0;
        for(Boolean ac:Results.values()){           
            if(ac){
              counter++;                 
            }
        }   
        system.assertEquals(counter, 2);
    }

}