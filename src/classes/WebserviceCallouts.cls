global class WebserviceCallouts {
    
	@future (callout=true)
    public static void callOutboundCall(Id taskId, String ext, String targetNumber){
        
        Try{
            
            // Call__c theCall = [SELECT Id, Name, Extension_Used__c, Phone_Number__c, HTTP_Response__c, GUID__c FROM Call__c WHERE Name = :theCallName][0];
            
            Task callTask = [SELECT Id, Extension_Used__c, Phone_Number__c, HTTP_Response__c, Call_Start_Time__c, Call_GUID__c FROM Task WHERE Id = :taskId][0];
        
            // Update Task with the information we have now.
            callTask.Extension_Used__c = ext;
            callTask.Phone_Number__c = targetNumber;
            callTask.Call_Start_Time__c = System.now();
            
            // Instantiate a new http object
            Http h = new Http();
        
            // Instantiate a new HTTP request, specify the method as well as the endpoint
            HttpRequest req = new HttpRequest();
            // String endpointString = 'https://sfc2d.goldline.com:48989/DialNumber/?ext=' + ext + '&number=51' + targetNumber;
            // req.setEndpoint(endpointString);
            req.setEndpoint('https://sfc2d.goldline.com:48989/DialNumber/?ext=6681&number=517144041763');
            req.setMethod('GET');
        
            // Send the request, and return a response
            HttpResponse res = h.send(req);
            
            // Save response information
            String responseString = res.getBody();
            callTask.HTTP_Response__c = responseString;
            callTask.Call_Start_Time__c = System.now();
            system.debug('callTask.Call_Start_Time__c: ' + callTask.Call_Start_Time__c);
            callTask.Call_GUID__c = responseString.substringBetween('<pre>', '</pre>');
            Update callTask;
            system.debug('response: ' + responseString);
            
        } Catch (Exception e){
            
            System.debug('Exception in Callouts.callOutboundCall(): ' + e);
            
        }

    }

}