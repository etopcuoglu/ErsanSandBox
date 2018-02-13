@isTest
public class TestDataFactory {
    
    public static string GetRecordTypeIdByName(String recTypeName){    
        List<RecordType> recTypeList = [select id,name,sobjectType,ispersontype from recordType where isActive = true and sObjectType ='Account'];
        //List<recordType> recTypeList ;
        for(RecordType rt : recTypeList){
            if(rt.name == recTypeName) return rt.Id;
        }
        return null;
    }
    
    public static Account CreateAccountByName(String accountName){        
        Account acc = new Account();
        acc.Salutation = 'Mr.';
        acc.FirstName ='TestName';
        acc.LastName = accountName;
        acc.RecordTypeId=  GetRecordTypeIdByName('Individual Account');
        acc.BillingStreet ='123 '+accountName+' street';
        acc.BillingCity='Los Angeles';
        acc.BillingPostalCode ='90046';
            acc.BillingState = 'California';
            acc.BillingCountry = 'United States';
        acc.Current_Holdings__c = 100.00;
        return acc;
    }
    
     public static Account CreateEstateAccountByName(String accountName){        
        Account acc = new Account();
        acc.Name =accountName;        
        acc.RecordTypeId=  GetRecordTypeIdByName('Estate Account');
        acc.BillingStreet ='333 '+accountName+' street';
        acc.BillingCity='Los Angeles';
        acc.BillingPostalCode ='90046';
            acc.BillingState = 'California';
            acc.BillingCountry = 'United States';
        acc.Current_Holdings__c = 500.00;
        return acc;
    }
    //Create given number amount of accounts
    public static List<Account> CreateAccountsforDuplicateRules(Integer numAccts){
        List<Account> paList = new list<Account>();
       ID recID = GetRecordTypeIdByName('Individual Account');
        
        for(integer i=0; i<numAccts; i++){
            Account pa = new Account();
            pa.Salutation = 'Mr.';
            pa.FirstName = 'test '+i;
            pa.LastName = 'test last name';
            pa.PersonEmail = 'test@gmail.com';
            pa.BillingStreet ='111 test street';
            pa.BillingCity='Los Angeles';
            pa.BillingPostalCode ='90046';
            pa.BillingState = 'California';
            pa.BillingCountry = 'United States';
            pa.Current_Holdings__c = 100;
            paList.add(pa);
            pa.RecordTypeId = recID;
          //  Database.SaveResult saveResult = Database.insert(pa, DML);
        }
        
        return paList;
    }
    
    //Create only single account
    public static Account CreateSingleAccountforDuplicateRules()
    {
        Account paNew = new Account();
        paNew.Salutation = 'Mr.';
        paNew.FirstName = 'test';
        paNew.LastName = 'test last name';
        paNew.PersonEmail = 'test@test.com';
        paNew.BillingStreet ='111 test street';
        paNew.BillingCity='Los Angeles';
        paNew.BillingPostalCode ='90046';
        paNew.BillingState = 'California';
        paNew.BillingCountry = 'United States';
        paNew.Current_Holdings__c = 100;
        paNew.RecordTypeId = GetRecordTypeIdByName('Individual Account');
        
        return paNew;
    }
	//Create a single account that will pass the duplicate rules
    public static Account CreateSingleAccountwithNoDuplicateError()
    {
        Account paNew = new Account();
        paNew.Salutation = 'Mr.';
        paNew.FirstName = 'gold';
        paNew.LastName = 'line';
        paNew.PersonEmail = 'goldline@goldline.com';
        paNew.BillingStreet ='123 Olympic street';
        paNew.BillingCity='Los Angeles';
        paNew.BillingPostalCode ='90001';
        paNew.BillingState = 'California';
        paNew.BillingCountry = 'United States';
        paNew.Current_Holdings__c = 100;
        paNew.RecordTypeId = GetRecordTypeIdByName('Individual Account');
        
        return paNew;
    }
    public static List<Metal_Price__c> CreateStockPrices(){
        List<Metal_Price__c> StockPriceList = new List<Metal_Price__c>();
        Metal_Price__c GoldPrice = new Metal_Price__c();
        GoldPrice.Name = 'Gold';
        GoldPrice.Price__c =123.98;
        GoldPrice.Price_Date__c = Date.today();
        StockPriceList.add(GoldPrice);
        
        Metal_Price__c SilverPrice = new Metal_Price__c();
        SilverPrice.Name = 'Silver';
        SilverPrice.Price__c =99.98;
        SilverPrice.Price_Date__c = Date.today();
        StockPriceList.add(SilverPrice);
        
        Metal_Price__c PlatinumPrice = new Metal_Price__c();
        PlatinumPrice.Name = 'Platinum';
        PlatinumPrice.Price__c =88.98;
        PlatinumPrice.Price_Date__c = Date.today();
        StockPriceList.add(PlatinumPrice);
        
        Metal_Price__c PalladiumPrice = new Metal_Price__c();
        PalladiumPrice.Name = 'Palladium';
        PalladiumPrice.Price__c =55.98;
        PalladiumPrice.Price_Date__c = Date.today();
        StockPriceList.add(PalladiumPrice);
        
        return StockPriceList;
    }
    
    public static Account_Relationship__c CreateAccountRelationship(String FromID, String ToID){
        Account_Relationship__c aRel  = new Account_Relationship__c();
        aRel.From_Account__c = FromID;
        aRel.From_Role__c='Primary Account Holder';
        aRel.To_Account__c = ToId;
        aRel.To_Role__c = 'Executor';
        
        return aRel;
    }
}