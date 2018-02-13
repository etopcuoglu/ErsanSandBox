public class Test
{
    public List<Integer> counterId{get;set;}
    List<SelectOption> options{get;set;}
    List<Account_Convert__c> acList {get;set;}
    Account_Convert__c AccConvert {get;set;}
    
    public Test(ApexPages.StandardController controller)
    {}
    
    public Test()
    {
        system.debug('Test');
        options = new List<SelectOption>();
        options.add(new SelectOption('Audi','Audi'));
        
        acList = new List<Account_Convert__c>();
        AccConvert = new Account_Convert__c();
        
        counterId = new List<Integer>();
        counterId.add(1);
    }
    public PageReference addFilter()
    {
        system.debug('addFilter');
        counterId.add(2);
        return null;
    }
    public List<SelectOption> getCars()
    {
        system.debug('getCars');
        return options;
    }
}