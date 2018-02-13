public class ControllerTaskList {
    // Custom extension for both "UserTasksPage" and "CallListPage" visualforce Pages.
    
    public ControllerTaskList(ApexPages.StandardController stdController) {

    }
 
    public List<Task> getTodaysCallTasks() {
        List<Task> taskList = new List<Task>([SELECT Id, Owner.Id, What.Name, Status, Disposition__c, ActivityDate, Subject, Description FROM Task WHERE Owner.Id = :UserInfo.getUserID() and Type='Call' and Status = 'Open' and ActivityDate = :System.TODAY()]);
        return taskList;
    }

    public List<Task> getAllUsersTasks() {
        List<Task> taskList = new List<Task>([SELECT Id, Owner.Id, What.Name, Status, Disposition__c, ActivityDate, Subject, Description FROM Task WHERE Owner.Id = :UserInfo.getUserID()]);
        return taskList;
    }
    
}