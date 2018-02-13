public class ControllerAccountConvert {
    public ApexPages.StandardController Con {get; set;}
    public String AccountId {get;set;}
    public String AccountRecordTypeId {get;set;}
    public String ConversationType {get;set;}
	//will hold the account records to be saved
	public List<Account_Convert__c>lstAcct  = new List<Account_Convert__c>();
	
	//list of the inner class
	public List<innerClass> lstInner  {	get;set;	}
	
	//will indicate the row to be deleted
	public String selectedRowIndex{get;set;}	
	
	//no. of rows added/records in the inner class list
	public Integer count = 1;
	
	
	////save the records by adding the elements in the inner class list to lstAcct,return to the same page
	public PageReference Save()
	{
        
        Account ConvertedAcct = [Select ID, RecordTypeId from Account Where ID =:AccountId];
        ConvertedAcct.RecordtypeId = AccountRecordTypeId;
        
        system.debug('ConvertedAcct '+ConvertedAcct);
		string pageLink = '/apex/AccountViewPage?id='+AccountId;
        PageReference page = new  PageReference(pageLink);
		
		for(Integer j = 0;j<lstInner.size();j++)
		{
            system.debug('AccountConvert '+lstInner[j].AccountConvert);
			lstAcct.add(lstInner[j].AccountConvert);
		} 
        system.debug('recordList '+lstAcct);
        
        if(lstAcct.size() >0)
        {            
            insert lstAcct;
            update ConvertedAcct;
        }
		page.setRedirect(True);
		return page;
	}
    public PageReference goBack(){
        string pageLink = '/apex/AccountViewPage?id='+AccountId;
        PageReference page = new  PageReference(pageLink);
        page.setRedirect(True);
		return page;
    }
		
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

	/*Constructor*/
	public ControllerAccountConvert(ApexPages.StandardController ctlr)
	{      
        Con = ctlr;
        AccountId = apexpages.currentpage().getparameters().get('AcctId');
        AccountRecordTypeId = apexpages.currentpage().getparameters().get('RecordType');
        ConversationType = apexpages.currentpage().getparameters().get('event');
	
        lstInner = new List<innerClass>();
        addMore();
        selectedRowIndex = '0';
        
	}/*End Constructor*/
		


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
       
    
    
}/*End Class*/