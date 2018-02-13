@isTest
public class ControllerPhoneListTest {
    
    ControllerPhoneListTest(){
        
    }
    
    public static testMethod void testControllerPhoneListWithTask(){
        
		PageReference phoneListPageInstance = Page.PhoneListPage;
        
        User testUser = CTITestDataFactory.CreateCTIData();
        
        // Check functionality when a Task that is owned by the user is passed in to the page...
        // Get one of the Tasks that are owned by testUser that were just created...
        Task aUserTask = [SELECT Id, WhatId FROM Task WHERE OwnerId=:testUser.Id][0];
        Account anAccount = [SELECT Id FROM Account WHERE Id=:aUserTask.WhatId][0];
        
        phoneListPageInstance.getParameters().put('taskId',aUserTask.Id);
        
        Test.setCurrentPage(phoneListPageInstance);
        
        ApexPages.StandardController standardTaskControllerInstance = new ApexPages.StandardController(anAccount);
        ControllerPhoneList controllerPhoneListInstance = new ControllerPhoneList(standardTaskControllerInstance);
        
        System.assert(controllerPhoneListInstance.getPhoneNumberList().size()==3, 'The phone number list does not contain 3 items.');

    }
        
    public static testMethod void testControllerPhoneListWithAccountOnly(){     
        
        PageReference phoneListPageInstance = Page.PhoneListPage;
        
        User testUser = CTITestDataFactory.CreateCTIData();
        
        // Check functionality when a Task that is owned by the user is NOT passed in to the page...
        // Get one of the Tasks that are owned by testUser that were just created...
        Task aUserTask = [SELECT Id, WhatId FROM Task WHERE OwnerId=:testUser.Id][0];
        Account anAccount = [SELECT Id FROM Account WHERE Id=:aUserTask.WhatId][0];

        phoneListPageInstance.getParameters().put('accountId',anAccount.Id);
        
        Test.setCurrentPage(phoneListPageInstance);    
        
        ApexPages.StandardController standardTaskControllerInstance = new ApexPages.StandardController(anAccount);
        ControllerPhoneList controllerPhoneListInstance = new ControllerPhoneList(standardTaskControllerInstance);
        
        System.assert(controllerPhoneListInstance.getPhoneNumberList().size()==3, 'The phone number list does not contain 3 items.');        
        
    }

}