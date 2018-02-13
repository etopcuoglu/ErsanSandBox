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
    
    public PageReference saveAccount(){
        
        
        return null;
    }

}