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
    public List<Account_Phone_Relationship__c> AccountPhoneRelationships;
    
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
    
    public List<Account_Phone_Relationship__c> getAccountPhoneRelationships(){        
    	List<Account_Phone_Relationship__c> arList = new List<Account_Phone_Relationship__c>();            
        arList = [SELECT Name,Phone_Number_Type__c,Phone_Number__r.Name,Phone_Number__r.Phone_Number_10_Numbers__c,Status__c FROM Account_Phone_Relationship__c where Account__c =: Acct.Id]; 
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
    
    
        public String ConversationType {get;set;}
//will hold the account records to be saved
	public List<Account_Convert__c>lstAcct  = new List<Account_Convert__c>();
	
	//list of the inner class
	public List<innerClass> lstInner  {	get;set;	}
	
	//will indicate the row to be deleted
	public String selectedRowIndex{get;set;}	
	
	//no. of rows added/records in the inner class list
	public Integer count = 1;    		
	//add one more row
	public void Add()
	{	
		count = count+1;
		addMore();		
	}
	
	/*Begin addMore*/
	public void addMore()
	{
		//call to the iner class constructor
		innerClass objInnerClass = new innerClass(count,AccountId,ConversationType);
		
		//add the record to the inner class list
        lstInner.add(objInnerClass);    
       // system.debug('lstInner---->'+lstInner);            
    }/* end addMore*/
	
	/* begin delete */
	public void Del()
	{
		//system.debug('selected row index---->'+selectedRowIndex);
		lstInner.remove(Integer.valueOf(selectedRowIndex)-1);
		count = count - 1;
		
	}/*End del*/
/*Inner Class*/
	public class innerClass
	{		
		/*recCount acts as a index for a row. This will be helpful to identify the row to be deleted */
		public String recCount {get;set;}		
		public Account_Convert__c AccountConvert {get;set;}
        
		/*Inner Class Constructor*/
		public innerClass(Integer intCount, String AccountId,String ConversationType)
		{
			recCount = String.valueOf(intCount);					
			/*create a new account*/
			AccountConvert = new Account_Convert__c();
			AccountConvert.Converted_Account__c = AccountId;
            AccountConvert.Name = 'Conversion to '+ ConversationType;
            
		}/*End Inner class Constructor*/	
	}/*End inner Class*/
       
    
}