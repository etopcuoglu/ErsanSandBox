public class ControllerAccountTriggerHandler {
    public static void UpdateContactinAX(Account[] accList){
        system.debug('New Account Update'+ accList);
        List<ID>  accIdList = new List<ID>();
        for(Account a: accList){
            if(a.isSynchronizedAX__C){
                accIdList.add(a.id);
            }                
        }
        if(!accIdList.isEmpty())
        Webcallouts.UpdateContact(accIdList);
    }
    public static void CreateNewAccountinAX(Account[] accList){
    system.debug('CreateNewAccountinAX>>>'+ accList);
        List<ID>  accIdList = new List<ID>();
        for(Account a: accList){
            system.debug('a.isSynchronizedAX__C: '+a.isSynchronizedAX__C);
            if(a.isSynchronizedAX__C){              
                accIdList.add(a.id);
            }
                
        }

        system.debug('New Accounts'+ accIdList);
        if(!accIdList.isEmpty())
        Webcallouts.CreateContact(accIdList);
    }
}