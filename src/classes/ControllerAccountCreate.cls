public with sharing class ControllerAccountCreate {    
    private final Account Acct;
    private String PageTittle;
    private boolean isPersonAccount;
    public ControllerAccountCreate(ApexPages.StandardController controller){        
        Acct = (Account)controller.getRecord();
        List<RecordType> rtList = [Select ID,Name,IsPersonType from RecordType where id =: Acct.RecordTypeId];
        PageTittle =rtList.isEmpty()? '' : rtList[0].Name;            
        isPersonAccount = rtList.isEmpty()? true : rtList[0].IsPersonType;
    }
    
    public String getPageTittle(){
        return PageTittle;
    }
    public Account getAcct() {
        return Acct;
    }
    public boolean getisPersonAccount(){
        return isPersonAccount;
    }
    //sample text add for git hub
    public PageReference saveAccount(){
        List<PhoneNumber__c> numberList = new List<PhoneNumber__c>();
        if(Acct.Primary_Phone__c != null){
            PhoneNumber__c primaryPhone = new PhoneNumber__c();
            numberList.add(primaryPhone);
        }
        
        return null;
    }

}