public with sharing class ControllerAccountView {
    public String AccountId{get;set;}
    private final Account Acct;
    private string ReportPath;
    public List<RecordType> recTypeList;
    public String AccumulationTypeId;
    public String TrustTypeId;
    public String EstateTypeId;
    public String BusinessTypeId;
    public List<Account_Relationship__c> AccountRelationships;
    
    public ControllerAccountView(ApexPages.StandardController controller){
        Acct = [SELECT Id,
                Owner.Name,
                RecordType.Name,
                RecordTypeId,
                Account_Number__c,
                Customer_PIN__c,
                Salutation,
                Primary_Phone__c,
                FirstName,
                Name,
                Business_Phone__c,
                MiddleName,
                Mobile_Phone__c,
                PersonContact.LastName ,
                Primary_Email__pc,
                Secondary_Approver__c,
                Third_Approver__c ,
                Secondary_Email__pc,
                Account_Status__c,
                CreatedDate,
                Last_Conversation_Date__c,
                Total_Purchases__c,
                Last_Activity_Date__c,
                Account_Agreement_Sent_Date__c,
                Last_Activity_Related__c,
                Account_Agreement_Executed_Date__c,
                Trust_Pilot_Survey_Sent_Date__c,
                Trust_Pilot_Survey_Completed_Date__c,
                Current_Balance__c,
                Storage_Balance__c,
                BillingStreet,
                BillingCity,
                BillingStateCode,
				BillingPostalCode,
				BillingCountryCode,
                Next_Trade_Date__c,
                Next_Trade_Expected_Date__c,
                Next_Trade_Amount__c,
                Trade_Probability__c,
				Gender__c,
                Birthdate__c,
                Marital_Status__c,
                Anniversary__c,
                Spouse_Name__c,
                Is_Loan__c,         
				Last_Lead_Source__c,
                Email_subscription__c,
                IsPersonAccount,
                CRM_Account_GUID__c
                FROM Account WHERE Id = :ApexPages.currentPage().getParameters().get('id')];
        AccountId =ApexPages.currentPage().getParameters().get('id');
         recTypeList = [SELECT Id, Name, IsActive FROM RecordType Where IsActive = true];
    }

    public Account getAcct() {
        return Acct;
    }
    
    public PageReference saveAccount(){
        update Acct;
        return null;
        
    }
    public List<Account_Relationship__c> getAccountRelationships(){        
    	List<Account_Relationship__c> arList = new List<Account_Relationship__c>();            
        arList = [Select Id, Name, From_Account__c, To_Account__c, From_Role__c, To_Role__c From Account_Relationship__c where From_Account__c =: Acct.Id]; 
        return arList;        
    }
    
    public PageReference newAccountRelationship(){
         PageReference page = new  PageReference('/a02/e');
    	 page.setRedirect(true);
    	 return page;
    }
    

    public string GetReportPath(){
      return  GoldlineUtility.GetReportServerLink();
    }
    
    public string setParams(){
        return null;
    }
       
    /* 
     * For use with Accumulation Clients : 012W00000009NALIA2
     * For use with Trust Accounts: 012W000000096KiIAI
     * For use with Estate Accounts: 012W000000096KfIAI
     * For use with Business Accounts: 012W000000096KdIAI
*/
    public string getAccumulationTypeId(){
        for(RecordType rt : recTypeList){
            if(rt.Name == 'Accumulation Client')
                return (string)rt.Id;
        }
        return '';
    }
    public string getTrustTypeId(){
         for(RecordType rt : recTypeList){
            if(rt.Name == 'Trust Account')
                return (string)rt.Id;
        }
        return '';
    }
    public string getEstateTypeId(){
         for(RecordType rt : recTypeList){
            if(rt.Name == 'Estate Account')
                return (string)rt.Id;
        }
        return '';
    }
    public string getBusinessTypeId(){        
         for(RecordType rt : recTypeList){
            if(rt.Name == 'Business Account')
                return (string)rt.Id;
        }
        return '';
    }
}