public class GetTelemarketValidation {       
    //This Method will return phone number and phone number area code in map <PhoneNumber,AreaCode>
    private static Map<String,String> parseAreaCode(List<String> PhoneNumberList){
        List<String> AreaCode = new List<String>();
        Map<String,String> phoneAreaCodeMap = new Map<String,String>();
        String PhoneNumber;
        Pattern p = Pattern.compile('[-() +]');
        for(String num : PhoneNumberList){
            PhoneNumber = p.matcher(num).replaceAll('');            
            if(PhoneNumber.length() == 10){            	
                phoneAreaCodeMap.put(PhoneNumber, PhoneNumber.substring(0, 3));
            }else if(PhoneNumber.length()>10){
                phoneAreaCodeMap.put(PhoneNumber, PhoneNumber.substring(1, 4));             
            }
        }     
        return phoneAreaCodeMap;        
    }
    
    //Return list of state based on the areacodes passed in Map<PhoneNumber,StateName>
    private static Map<String,Area_Code__c> returnPhoneStateMap(Map<String,String> phoneAreaCodeMap){
        Map<String,Area_Code__c> returnPhoneAreaCodeMap = new Map<String,Area_Code__c>();
        List<Integer> codes = new List<Integer>();
        Integer x=0;
        for(String ac:phoneAreaCodeMap.values()){           
            codes.add(integer.valueof(ac));
        }       
        List<Area_Code__c> areaCodeList = new List<Area_Code__c>();
        areaCodeList = [
            Select Name
            ,Area_Code__c
            ,State__c
            ,State_Abbreviation__c
            ,Area_State_Code__r.Id
            ,Area_State_Code__r.Time_Zone_Offset__c
            ,Area_State_Code__r.Call_Start_Time__c
            ,Area_State_Code__r.Call_End_Time__c
            FROM Area_Code__c
            Where Area_Code__c IN : codes       
        ];
        State__c currentState = new State__c();
        for(String keyValue:phoneAreaCodeMap.keySet()){            
            for(Area_Code__c state: areaCodeList){
                if(phoneAreaCodeMap.get(keyValue) == state.Name){                  
                    returnPhoneAreaCodeMap.put(keyValue,state); 
                }
            }
        }
        return returnPhoneAreaCodeMap;
    }
    
    
    public Static Map<String,Boolean> getPhoneDialablity(Id acctId){
        //  Map<String,Boolean> phoneDialbilty = new Map<String,Boolean>();
        List<Account_Phone_Relationship__c> acctPhoneRelList;
        List<String> phoneList = new List<String>();
        Map<String,String> phoneAreaCodeMap = new Map<String,String>();
        Map<String,Area_Code__c> PhoneStateMap = new Map<String,Area_Code__c>();
        Map<String,Boolean> PhoneTelemarketingMap = new Map<String,Boolean>();        
        acctPhoneRelList = [SELECT Phone_Number__r.Name, Account__r.Name FROM Account_Phone_Relationship__c WHERE Account__c = :acctId];
        for(Account_Phone_Relationship__c pNum: acctPhoneRelList){
            phoneList.add(pNum.Phone_Number__r.Name);
        }        
        phoneAreaCodeMap = parseAreaCode(phoneList);
        PhoneStateMap = returnPhoneStateMap(phoneAreaCodeMap);      
        return getTelemarketingSchedule(PhoneStateMap);
        
    }
    //Return a map of Phone number and dialable status
    public Static Map<String,Boolean> getTelemarketingSchedule(Map<String,Area_Code__c> phoneStateMap){
        Datetime currentDate = System.now();
		//currentDate= currentDate.addHours(2);
		Time currentTime = currentDate.time();
        Map<String,boolean> PhoneTelemarketingMap = new Map<String,boolean>();
        Map<String,Boolean> PhoneList = new Map<String,Boolean>();       
        Area_Code__c aCode = new Area_Code__c();
        List<String> stateList = new List<String>();
        for(Area_Code__c stateName : PhoneStateMap.values()){
            stateList.add(stateName.Area_State_Code__r.Id);
        }
       
        List<Telemarketing_time__c> teleMarketingList = [SELECT Id, 
                                                         Name, 
                                                         State__c,
                                                         State__r.Name, 
                                                         Start_Date__c, 
                                                         End_Date__c
                                                         FROM Telemarketing_time__c
                                                         Where State__c IN : stateList
                                                         AND Start_Date__c <= :currentDate.date() 
                                                         AND End_Date__c >= :currentDate.date()
                                                        ];
              
        for(string keyValue: phoneStateMap.keySet()){
            Boolean inhours = false;
            aCode = phoneStateMap.get(keyValue);
            if((aCode.Area_State_Code__r.Call_Start_Time__c.addhours(-(Integer)aCode.Area_State_Code__r.Time_Zone_Offset__c) < currentTime 
                && aCode.Area_State_Code__r.Call_End_Time__c.addhours(-(Integer)aCode.Area_State_Code__r.Time_Zone_Offset__c) > currentTime)){
                    //local time is still in call hours of the state                   
                    inhours=true;
                }           
            for(Telemarketing_time__c telemarket : teleMarketingList){
                if((aCode.Area_State_Code__r.Id == telemarket.State__c) || !inHours){
                        PhoneList.put(keyValue, false);                
                }else{
                    PhoneList.put(keyValue, true);
                }
            }
        }     
        return PhoneList;
    } 
}