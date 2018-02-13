public class ControllerPhoneList {
    // Controller extension for the PhoneListPage Visualforce Page.
    private List<Account_Phone_Relationship__c> phoneNumberList;
    public Task theTask {get;set;}
    public Id accountID {get;set;}
    public String accountName {get;set;}
    public String subjectForNewTaskFromOldTaskIfNeeded {get;set;}
    
    public ControllerPhoneList(ApexPages.StandardController Account){
        
        if (ApexPages.currentPage().getParameters().get('taskId') != null && ApexPages.currentPage().getParameters().get('taskId') != ''){
            
            theTask = [SELECT Id, Owner.Id, WhatId, ActivityDate, Subject, Description FROM Task 
                       WHERE Id = :ApexPages.currentPage().getParameters().get('taskId')];
            
            accountID = theTask.WhatId;
            
        } else {
            
            accountID = ApexPages.currentPage().getParameters().get('accountId');    
            subjectForNewTaskFromOldTaskIfNeeded = ApexPages.currentPage().getParameters().get('oldTaskSubject');
            
        }

    }    
    
    public List<Account_Phone_Relationship__c> getPhoneNumberList(){
        
        phoneNumberList = [SELECT Id, Phone_Number__r.Phone_Number__c, Phone_Number_Type__c, Is_Primary_Phone_del__c, Account__r.Name FROM Account_Phone_Relationship__c WHERE Account__c = :accountID];
        
        if (!phoneNumberList.isEmpty()){
            accountName = phoneNumberList[0].Account__r.Name;  
        } else {
            System.debug('No phone numbers returned for this account.');
        }
        
        return phoneNumberList;
        
    }

}