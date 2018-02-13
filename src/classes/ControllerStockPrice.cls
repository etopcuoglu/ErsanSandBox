public class ControllerStockPrice { 
    //this class pulls stock prices from Product table(or AX - based one the system design. TBD)
    public List<Metal_Price__c> ListMP {get;set;}
    
    public ControllerStockPrice(){        
        ListMP = [Select Name, Price__c , Price_Date__c  FROM Metal_Price__c];//add filter for price date, only pull today's numbers
    }
    public List<Metal_Price__c> getMetalPrices(){
        return ListMP;
    }

}