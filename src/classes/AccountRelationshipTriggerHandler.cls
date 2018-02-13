public class AccountRelationshipTriggerHandler {
    //this class Handles all trigger events for account relationship
    public static void SwapAccountEntryOnCreate(Account_Relationship__c[]  newAccounts){
        List<Account_Relationship__c> arList = new List<Account_Relationship__c>();
        Account_Relationship__c newAr = new Account_Relationship__c();
        Account_Relationship__c newAr2 = new Account_Relationship__c();
        
        for(Account_Relationship__c ar: newAccounts){
         //   system.debug('>>>>ar.From_Account__c.IsPersonAccount    '+ ar.From_Account__r.IsPersonAccount);
            if(ar.From_Account__c == ar.To_Account__c){
                ar.addError('You cannot create a Relationship from an Account to itself. ');
            }else if(!ar.From_Account__r.IsPersonAccount && !ar.To_Account__r.IsPersonAccount){
            newAr2 = ar;
//            newAr.Name = newAr2.Name;    
            newAr.To_Account__c = newAr2.From_Account__c;
            newAr.From_Account__c = newAr2.To_Account__c;
            newAr.From_Role__c = newAr2.To_Role__c;
            newAr.To_Role__c = newAr2.From_Role__c;
            arList.add(newAr);  
            }
            else{
                ar.addError('You cannot create an Account Relationship between two business-type Accounts');
            }
        }         
        insert arList;
    }
    
}