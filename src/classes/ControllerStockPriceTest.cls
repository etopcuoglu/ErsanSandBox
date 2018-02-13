@isTest
private class ControllerStockPriceTest {
    private static TestMethod void createPricesTestMethod(){ 
        List<Metal_Price__c> StockPriceList = new List<Metal_Price__c>();
        StockPriceList = TestDataFactory.CreateStockPrices();
        insert StockPriceList;
        ControllerStockPrice cp = new ControllerStockPrice();
        List<Metal_Price__c> returnedList = new List<Metal_Price__c>();
        returnedList = cp.getMetalPrices();
        system.assertEquals(returnedList.size(),4);
        
    }
    
    
}