public class ControllerTelemarket {
    public ID acctId {get;set;} 
    public Map<String,Boolean> teleMarketSchedule{get;set;}
    public ControllerTelemarket(){
        acctId = '001W000000bnRua';
        teleMarketSchedule = GetTelemarketValidation.getPhoneDialablity(acctId);
        
    }

}