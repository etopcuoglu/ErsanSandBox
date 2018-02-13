public class ControllerPhoneCallPage {
    // Custom Extension for PhoneCallPage Visualforce Page.
    public Id selectedPhoneNumbersAccountId;
    public Id selectedPhoneNumbersId;
    public String selectedPhoneNumber;
    public Id callTaskId;
    public Task callTask;
    private String callTaskSubject;
    public String callDisposition;
    public String taskComments {get; set;}
    private String userExtension;
    
    public ControllerPhoneCallPage(ApexPages.StandardController Account){
        
            selectedPhoneNumbersAccountId = ApexPages.currentPage().getParameters().get('accountID');
            selectedPhoneNumbersId = ApexPages.currentPage().getParameters().get('phoneId');
            selectedPhoneNumber = ApexPages.currentPage().getParameters().get('phoneNumber');
            // callDisposition = ApexPages.currentPage().getParameters().get('callDisposition');
        
            if (ApexPages.currentPage().getParameters().get('taskId') != '' && ApexPages.currentPage().getParameters().get('taskId') != null){
                
                callTaskId = ApexPages.currentPage().getParameters().get('taskId');
                callTask = [SELECT Id, Subject, Disposition__c, Description, Status, Extension_Used__c, Phone_Number__c, HTTP_Response__c, Call_GUID__c FROM Task WHERE Id = :callTaskId][0];
                callTaskSubject = callTask.Subject;
                
            } else {
                
                callTaskId = NULL;
                callTaskSubject = ApexPages.currentPage().getParameters().get('originalTasksSubject');
                
            }
        
    }
    
    public void MakeCall(){
        try{
            
            if (callTaskId == null || callTaskId == ''){
                
                // Create new Task to store the next call with.
                // We don't need to set owner id because it will be automatically created with the context user, which will be the AE who is logged in.
                callTask = new Task();
                callTask.Subject = callTaskSubject;
                callTask.WhatId = selectedPhoneNumbersAccountId;
                Account accountForWhoId = [SELECT Id, Name, PersonContactId FROM Account WHERE Id = :selectedPhoneNumbersAccountId][0];
                callTask.WhoId = accountForWhoId.PersonContactId;
                callTask.Type = 'Call';
                callTask.Status = 'Open';
                insert callTask;
    
                callTaskId = callTask.Id;
                
            }
            
            User u = [Select id, Extension from User where id =: UserInfo.getUserId() LIMIT 1][0];
            userExtension = u.Extension;
            
            if (Environment_Test_Settings__c.getInstance(UserInfo.getUserId()).Active__c == true){ 
                
                String testPhoneNumber = Environment_Test_Settings__c.getInstance(UserInfo.getUserId()).Test_Phone_Number__c;
                String testExtension = Environment_Test_Settings__c.getInstance(UserInfo.getUserId()).Test_Phone_Extension__c;
                
                If (!String.isBlank(testPhoneNumber)){
                    selectedPhoneNumber = testPhoneNumber;
                }
                If (!String.isBlank(testExtension)){
                    userExtension = testExtension;
                }
                
            } 
            
            WebserviceCallouts.callOutboundCall(callTaskId, userExtension, '51' + selectedPhoneNumber);         // WebserviceCallouts.callOutboundCall(callTaskId,'6681','517144041763');
            
        } catch (Exception e) {
            
            System.debug('Exception in PhoneCallPageCustomController.MakeCall(): ' + e);
            
        }
    }
    
    public PageReference CompleteCallTask(){
        
        try{

            callDisposition = ApexPages.currentPage().getParameters().get('callDisposition');       
            callTask.Disposition__c = callDisposition;
            callTask.Description = taskComments;
            callTask.Status = 'Completed';
            callTask.Phone_Number__c = selectedPhoneNumber;

            update callTask;
            
            PageReference thePhoneListPage = Page.PhoneListPage;
            thePhoneListPage.setRedirect(true);
            thePhoneListPage.getParameters().put('Id', selectedPhoneNumbersAccountId);
            thePhoneListPage.getParameters().put('taskId', ''); 
            thePhoneListPage.getParameters().put('accountId', selectedPhoneNumbersAccountId); 
            thePhoneListPage.getParameters().put('oldTaskSubject', callTaskSubject); 
            return thePhoneListPage;
            
            // return Page.CallListPage;        We might need to do this eventually. JM
            
        }
        
        catch (Exception e){
            
            System.debug('Exception in PhoneCallPageCustomController.CompleteCallTask(): ' + e);
            return Page.PhoneListPage;
    
        }

    }

}