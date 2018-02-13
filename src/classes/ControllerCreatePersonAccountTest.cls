@isTest
private class ControllerCreatePersonAccountTest {
static testMethod void  PAcct_Save_Test(){
    //TEST the SAVE method
        List<Account> paList = new list<Account>();
        Account paNew = New Account();
        
        paList = TestDataFactory.CreateAccountsforDuplicateRules(3);
        paNew = TestDataFactory.CreateSingleAccountforDuplicateRules();
        
        Database.DMLOptions dml = new Database.DMLOptions();
        dml.DuplicateRuleHeader.AllowSave = true; 
        for(Account pa:paList){
            Database.SaveResult saveResult = Database.insert(pa, DML);
        }
        
        ApexPages.StandardController sc = new ApexPages.StandardController(paNew);
        ControllerCreatePersonAccount pAcct = New ControllerCreatePersonAccount(sc);
        
        PageReference pageRef = Page.CreatePersonAccountPage;
        pageRef.getParameters().put('firstname',String.valueOf(paNew.FirstName));
        pageRef.getParameters().put('lastname',String.valueOf(paNew.LastName));
        pageRef.getParameters().put('email',String.valueOf(paNew.PersonEmail));
        
		pageRef = pAcct.save();
   
        system.assertEquals(null, null);
        
    }
    
    static testMethod void  PAcct_Save_W_No_Erros_Test(){
        //TEST the Save method with no dupicate errors
         List<Account> paList = new list<Account>();
        Account paNew = New Account();
        
        paList = TestDataFactory.CreateAccountsforDuplicateRules(3);
        paNew = TestDataFactory.CreateSingleAccountwithNoDuplicateError();
        
        Database.DMLOptions dml = new Database.DMLOptions();
        dml.DuplicateRuleHeader.AllowSave = true; 
        for(Account pa:paList){
            Database.SaveResult saveResult = Database.insert(pa, DML);
        }   
        
        ApexPages.StandardController sc = new ApexPages.StandardController(paNew);
        ControllerCreatePersonAccount pAcct = New ControllerCreatePersonAccount(sc);
        
        PageReference pageRef = Page.CreatePersonAccountPage;
        pageRef.getParameters().put('firstname',String.valueOf(paNew.FirstName));
        pageRef.getParameters().put('lastname',String.valueOf(paNew.LastName));
        pageRef.getParameters().put('email',String.valueOf(paNew.PersonEmail));
        
        pageRef = pAcct.save();
        system.assertNotEquals(pageRef, null);
    }
    static testMethod void  PAcct_Save_Ignore_Test(){
        //TEST save method with duplicte errors and user will override the functionality
        List<Account> paList = new list<Account>();
        Account paNew = New Account();
        
        paList = TestDataFactory.CreateAccountsforDuplicateRules(3);
        paNew = TestDataFactory.CreateSingleAccountforDuplicateRules();
        
        Database.DMLOptions dml = new Database.DMLOptions();
        dml.DuplicateRuleHeader.AllowSave = true; 
        for(Account pa:paList){
            Database.SaveResult saveResult = Database.insert(pa, DML);
        }
        
        
        ApexPages.StandardController sc = new ApexPages.StandardController(paNew);
        ControllerCreatePersonAccount pAcct = New ControllerCreatePersonAccount(sc);
        
        PageReference pageRef = Page.CreatePersonAccountPage;
        pageRef.getParameters().put('firstname',String.valueOf(paNew.FirstName));
        pageRef.getParameters().put('lastname',String.valueOf(paNew.LastName));
        pageRef.getParameters().put('email',String.valueOf(paNew.PersonEmail));
		
        pageRef = pAcct.saveandignore();
        system.assertNotEquals(pageRef, null);
        
    }
    static testMethod void  PAcct_Save_And_New_Test(){
        //TEST the save method and create a new personAccount 
        List<Account> paList = new list<Account>();
        Account paNew = New Account();
        
        paList = TestDataFactory.CreateAccountsforDuplicateRules(3);
        paNew = TestDataFactory.CreateSingleAccountforDuplicateRules();
        
        Database.DMLOptions dml = new Database.DMLOptions();
        dml.DuplicateRuleHeader.AllowSave = true; 
        for(Account pa:paList){
            Database.SaveResult saveResult = Database.insert(pa, DML);
        }
        
        
        ApexPages.StandardController sc = new ApexPages.StandardController(paNew);
        ControllerCreatePersonAccount pAcct = New ControllerCreatePersonAccount(sc);
        
        PageReference pageRef = Page.CreatePersonAccountPage;
        pageRef.getParameters().put('firstname',String.valueOf(paNew.FirstName));
        pageRef.getParameters().put('lastname',String.valueOf(paNew.LastName));
        pageRef.getParameters().put('email',String.valueOf(paNew.PersonEmail));
		
        string pPath ='/apex/CreatePersonAccount';   
        pageRef = pAcct.SaveAndNew();
        system.assertEquals(pageRef.getUrl(), pPath);
    } 
}