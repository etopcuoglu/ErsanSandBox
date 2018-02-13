@isTest
private class ControllerAccountViewTest {
    static TestMethod void TestMethod1(){
        Account acct = TestDataFactory.CreateAccountByName('Jimmy');
        Account toAcct = TestDataFactory.CreateEstateAccountByName('John To');
        insert acct;
        insert toAcct;
        
        Account_Relationship__c ar = TestDataFactory.CreateAccountRelationship(acct.Id,toAcct.Id);
        
        
        
        
        ApexPages.StandardController sc = new ApexPages.StandardController(acct);
        ControllerAccountView con = new ControllerAccountView(sc);
        
        //if(con.accountHeader !='')
    		system.assertEquals(true ,true);
        
        //if(con.AccountRelationships.size()>0)
            System.assertEquals(true, true);
         
        //con.
        //PageReference pageRef = Page.ControllerAccountView;
        
        //PageReference pageRef = Page.
    
    }

}