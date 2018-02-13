public class ControllerClientOverviewPage {
    public String contactIDValue;
    public Account account {get;set;}
    
    public void setcontactIDValue (String conID) {     
        account = [SELECT Id,                     
                   Name,
                   //secondary approver?
                   //lead group
                   BillingState,
                   Account_Status__c ,
                   Has_Account_Agreement__c ,                                        
                   Gross_Sales__c ,
                   Current_Balance__c ,
                   PersonLeadSource,
                   CreatedDate,                  
                   PersonEmail
                   FROM Account 
                   where ID =: conID 
                   LIMIT 1]; 
        contactIDValue = account.Name;
    }
    
    public String getcontactIDValue() {
        return contactIDValue;
    } 
}