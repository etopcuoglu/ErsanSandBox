public with sharing class dynamicController {
private integer Counter =0;
    public PageReference AddRecord() {
        
       //Assign your own data to do this. for testing I just placed the dummy data.
       
       //Test Data
       //
       counter++;
       String count = String.ValueOf(Counter);
        MyWrapper oWrapp = new MyWrapper();
        oWrapp.sName='Test1'+ ' '+String.ValueOf(Counter); 
        oWrapp.isFlag= false; 
        lstWrapper.add(oWrapp);
    
        return null;
    }


     public list<MyWrapper> lstWrapper {get;set;} 
      
     public dynamicController(ApexPages.StandardController ctlr){
        this.lstWrapper = new list<MyWrapper>();  
        MyWrapper oWrapp = new MyWrapper();
        oWrapp.sName='Test'; 
        oWrapp.isFlag= true; 
        lstWrapper.add(oWrapp);
              
     } 
      public class MyWrapper{
          public string sName{ get;set;}
          public boolean isFlag{get;set;}
      }
      
}