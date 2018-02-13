public with sharing class GoldlineUtility {

    public static String GetEnviormentName(){
        //DevQA: 00D2F0000008jxi
        //QaUat: 00D0t0000008bk6
        //Prod: 00D41000002Hug8
        ID orgId  = Userinfo.getOrganizationId();
        if(orgId == '00D41000002Hug8') return 'prod';
        else if(orgId == '00D0t0000008bk6') return 'test';
        else return 'dev';

    }
    
    public static boolean isProd(){        
        return Userinfo.getOrganizationId() =='00D41000002Hug8' ? true : false;
       
    }

    public static boolean isTest(){        
        return Userinfo.getOrganizationId() =='00D0t0000008bk6' ? true : false;
       
    }

    public static boolean isDev(){   
        if(Userinfo.getOrganizationId() != '00D0t0000008bk6' && Userinfo.getOrganizationId() !='00D41000002Hug8'){ 
            return true;
        }else{
            return false;
        }     
        //return Userinfo.getOrganizationId() =='00D2F0000008jxi' ? true : false;
       
    }

    public static String GetReportServerLink(){
        return isProd()? 'sna-gl-rpt-01' : 'wla-tst-rpt-01'; 
       
    }
    
    public static String GetSSRSReportServerLink(){
        if(Userinfo.getOrganizationId()=='00D41000002Hug8') {
            return 'wla-sf-rpt-01';
        } else if (Userinfo.getOrganizationId()=='00D0t0000008bk6'){
            return 'wla-tst-rpt-01';
        } else {
            return 'null'; //TBD
        }      
    }
    
    public static String Get_Ax_Web_Service_Link_Out_of_NetWork(){
        if(isProd()) {
            return 'wla-sf-dax-02:88';
        } else if (isTest()){
            return 'wla-tst-dax-02:88';
        } else {
            return 'wla-tst-dax-01:88';
        }      
    }

    public static String Get_Ax_Web_Service_Link_In_Network(){
        if(isProd()) {
            return 'sfax.goldline.com:4777'; //tbd , needs to be updated in the future
        } else if (isTest()){
            return 'sfax.goldline.com:4777'; //tbd , needs to be updated in the future
        } else {
            return 'sfax.goldline.com:4777';
        }      
    }
    
    public static String Get_Ax_Sql_Server_Link(){
        if(isProd()) {
            return 'wla-sf-sql-02';
        } else if (isTest()){
            return 'smc-tst-sql-02';
        } else {
            return 'smc-tst-sql-01';
        }      
    }
    
    public static String Get_Pallito_WS_Server_Link_Out_of_Network(){
        if(isProd()) {
            return 'null';//TBD
        } else if (isTest()){
            return 'wla-dev-ws-01';
        } else {
            return 'null';
        }      
    }

    public static String Get_Pallito_WS_Server_Link_In_Network(){
        if(isProd()) {
            return 'sna-gl-ws-02';
        } else if (isTest()){
            return 'wla-dev-ws-01';
        } else {
            return 'wla-dev-ws-01';
        }      
    }
    
    public static String Get_Cloudsync_Sql_Server_Link(){
        if(isProd()) {
            return 'wla-sf-sql-01';
        } else if (isTest()){
            return 'smc-tst-sql-01';
        } else {
            return 'null'; //TBD
        }      
    }
    
    public static String Get_ODS_Sql_Server_Link(){
        if(isProd()) {
            return 'wla-sf-dss-01';
        } else if (isTest()){
            return 'wla-tst-dss-01';
        } else {
            return 'null'; //TBD
        }      
    }
    
    public static String Get_AWS_mySQL_Server_Link(){
        if(isProd()) {
            return 'mysql.aws.goldline.com';
        } else if (isTest()){
            return 'mysql-stage.aws.goldline.com';
        } else {
            return 'mysql-stage.aws.goldline.com';
        }      
    }
    
    public static Map<String,Decimal> GetAccountSalutaionEnumMap(){
        Map<String,Decimal> salutationMap = new Map<String,Decimal>();
        List<String_map__c> StrMapList = new List<String_map__c>();
        
        StrMapList= [Select Value__c,AttributeValue__c From String_map__c Where Name = 'gld_salutation' AND ObjectTypeCode__c = 2];
        for(String_map__c st: StrMapList){
            salutationMap.put(st.Value__c, st.AttributeValue__c);
        }
        return salutationMap;                  
    }
    
    public static Decimal GetAccountSalutaionEnumValue(String salutationValue){
        String_map__c StrMap = new String_map__c();
        
        StrMap= [Select Value__c,AttributeValue__c From String_map__c Where Name = 'gld_salutation' AND ObjectTypeCode__c = 2 AND Value__c =:salutationValue];
        
        return StrMap.AttributeValue__c;                  
    }
    
    
     public static String ConvertPhoneNumberTo10Digit(String phoneNumberText){     
        if(phoneNumberText == NULL) return null;
        String newPhoneNumberText = phoneNumberText.replaceAll('[^0-9]', '');    
        return newPhoneNumberText.right(10);
    }   

}