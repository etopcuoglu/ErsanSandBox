global class Webcallouts{
    //this class makes webApi call to AX 
    
    @future (callout=true)
    webservice static void UpdateContact(List<ID> accountIdList){
        String envelopeBody;
        List<Account> accList = [Select  Id, CRM_Account_GUID__c, AccountNumber, OwnerId,
                                Owner.CRM_User_GUID__c, Email__c, FirstName, 
                                LastName,MiddleName, isSynchronizedAX__C, BillingStreet,
                                Suffix
                                From Account Where  id IN :accountIdList];
                                system.debug('AccList in webcall'+accList);
        Date d = system.today();
        string ContactUpdateDate = DateTime.newInstance(d.year(),d.month(),d.day()).format('yyyy-MM-dd');
        ContactUpdateDate = ContactUpdateDate +'T00:00:00.000';
        
        //Create webCaLL
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        req.setMethod('POST');
        req.setEndpoint('https://'+GoldlineUtility.Get_Ax_Web_Service_Link_In_Network()+'/mcaGoldLineCRMtoAXWebService.asmx?op=UpdateContact'); // sfax.goldline.com:4777
        req.setHeader('Content-Type', 'text/xml; charset=utf-8');
        
        //Create WebCall Body
        envelopeBody = '<?xml version="1.0" encoding="utf-8"?>'
                +'<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">'
                +'  <soap:Body>'
                +'    <UpdateContact xmlns="http://mcaConnect.Goldline/">';
        for(Account acc: accList)
        {
            envelopeBody = envelopeBody +'<oContact>'
                +'<gContactId>'+acc.CRM_Account_GUID__c+'</gContactId>'
                +'<sSalutation>'+GoldlineUtility.GetAccountSalutaionEnumValue(acc.Salutation)+'</sSalutation>'
                +'<sFirstName>'+acc.FirstName+'</sFirstName>'
                +'<sMiddleName>'+acc.MiddleName+'</sMiddleName>'
                +'<sLastName>'+acc.LastName+'</sLastName>'
                +'<sSuffix>'+acc.Suffix+'</sSuffix>'
                +'<sSpouseName></sSpouseName>'
                +'<sSecondaryApprover></sSecondaryApprover>'
                +'<sTertiaryApprover></sTertiaryApprover>'
                +'<sEmailAddress>'+acc.Email__c+'</sEmailAddress>'
                +'<sGender></sGender>'
                +'<sContactNumber>'+acc.AccountNumber+'</sContactNumber>'
                +'<sAddressLine1>'+acc.BillingStreet+'</sAddressLine1>'
                +'<sAddressLine2></sAddressLine2>'
                +'<sAddressLine3></sAddressLine3>'
                +'<sAddressCity></sAddressCity>'
                +'<sAddressStateOrProvince></sAddressStateOrProvince>'
                +'<sAddressPostalCode></sAddressPostalCode>'
                +'<sAddressCountry></sAddressCountry>'
                +'<gOwner>'+acc.Owner.CRM_User_GUID__c+'</gOwner>'
                +'<dtContractExecuted>'+ContactUpdateDate+'</dtContractExecuted>'
                +'</oContact>';

        }
        envelopeBody = envelopeBody +'</UpdateContact>'
                +'</soap:Body>'
                +'</soap:Envelope>';

        req.setHeader('Content-Length',String.valueOf(envelopeBody.length()));      
        req.setBody(envelopeBody);
        res = h.send(req);
        System.debug('response ' +res.getBody());

    }

    @future (callout=true)
    webservice static void CreateContact(List<ID> accountIdList){
        System.debug('Create Contact WEB CALL OUT');
        String envelopeBody;
        List<Account> accList = [Select  Id, CRM_Account_GUID__c, AccountNumber, OwnerId,
                                Owner.CRM_User_GUID__c, Email__c, FirstName, 
                                LastName,MiddleName,Suffix, isSynchronizedAX__C, BillingStreet, BillingCity,
                                BillingPostalCode
                                From Account Where  id IN :accountIdList];
                                system.debug('AccList in webcall'+accList);
        //Create webCaLL
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        HttpResponse res = new HttpResponse();
        req.setMethod('POST');
        req.setEndpoint('https://'+GoldlineUtility.Get_Ax_Web_Service_Link_In_Network()+'/mcaGoldLineCRMtoAXWebService.asmx?op=CreateContact');
        req.setHeader('Content-Type', 'text/xml; charset=utf-8');
        Date d = system.today();
        string ContactCreateDate = DateTime.newInstance(d.year(),d.month(),d.day()).format('yyyy-MM-dd');
        ContactCreateDate = ContactCreateDate +'T00:00:00.000';
         
        //Create WebCall Body
        envelopeBody = '<?xml version="1.0" encoding="utf-8"?>'
                +'<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">'
                +'  <soap:Body>'
                +'    <CreateContact  xmlns="http://mcaConnect.Goldline/">';
        for(Account acc: accList)
        {
            envelopeBody = envelopeBody +'<oContact>'
                        +'<gContactId>'+acc.CRM_Account_GUID__c+'</gContactId>'
                        +'<sSalutation>'+GoldlineUtility.GetAccountSalutaionEnumValue(acc.Salutation)+'</sSalutation>' //salutation needs to be converted
                        +'<sFirstName>'+acc.FirstName+'</sFirstName>'
                        +'<sMiddleName>'+acc.MiddleName+'</sMiddleName>'
                        +'<sLastName>'+acc.LastName+'</sLastName>'
                        +'<sSuffix>'+acc.Suffix+'</sSuffix>'
                        +'<sSpouseName></sSpouseName>'
                        +'<sSecondaryApprover></sSecondaryApprover>'
                        +'<sTertiaryApprover></sTertiaryApprover>'
                        +'<sEmailAddress>'+acc.Email__c+'</sEmailAddress>'
                        +'<sGender></sGender>'
                        +'<sContactNumber>'+acc.AccountNumber+'</sContactNumber>'
                        +'<sAddressLine1>+'+acc.BillingStreet+'+</sAddressLine1>'
                        +'<sAddressLine2></sAddressLine2>'
                        +'<sAddressLine3></sAddressLine3>'
                        +'<sAddressCity>'+acc.BillingCity+'</sAddressCity>'
                        +'<sAddressStateOrProvince></sAddressStateOrProvince>'
                        +'<sAddressPostalCode>'+acc.BillingPostalCode+'</sAddressPostalCode>'
                        +'<sAddressCountry></sAddressCountry>'
                        +'<gOwner>'+acc.Owner.CRM_User_GUID__c+'</gOwner>'
                        +'<dtContractExecuted>'+ContactCreateDate+'</dtContractExecuted>'
                    +'</oContact>';
        }

        envelopeBody = envelopeBody +'</CreateContact>'
                +'</soap:Body>'
                +'</soap:Envelope>';

        req.setHeader('Content-Length',String.valueOf(envelopeBody.length()));      
        req.setBody(envelopeBody);
        //system.debug('envelopeBody>> '+envelopeBody);
        res = h.send(req);
       // System.debug('>>>Create Contact Response>>>>   ' +res.getBody());
    }

    /*  @future (callout=true)
   webservice static void UpdateContact2(){
        system.debug('WebCall Function');
        try{
            system.debug('WebCall');
            Http h = new Http();
            HttpRequest req = new HttpRequest();
            HttpResponse res = new HttpResponse();
            req.setMethod('POST');
            req.setEndpoint('https://sfax.goldline.com:4777/mcaGoldLineCRMtoAXWebService.asmx?op=UpdateContact');
            req.setHeader('Content-Type', 'text/xml; charset=utf-8');
           
            String ReqBody = '<?xml version="1.0" encoding="utf-8"?>'
                +'<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">'
                +'  <soap:Body>'
                +'    <UpdateContact xmlns="http://mcaConnect.Goldline/">'
                +'      <oContact>'
                +'        <gContactId>{F389E8C9-8065-49CD-80CC-579F4C91ED8D}</gContactId>'
                +'        <sSalutation>2</sSalutation>'
                +'        <sFirstName>Ersan</sFirstName>'
                +'        <sMiddleName></sMiddleName>'
                +'        <sLastName>JimpBob</sLastName>'
                +'        <sSuffix></sSuffix>'
                +'        <sSpouseName></sSpouseName>'
                +'        <sSecondaryApprover></sSecondaryApprover>'
                +'        <sTertiaryApprover></sTertiaryApprover>'
                +'        <sEmailAddress></sEmailAddress>'
                +'        <sGender></sGender>'
                +'        <sContactNumber>82280852</sContactNumber>'
                +'        <sAddressLine1>1234 fake Avenue</sAddressLine1>'
                +'        <sAddressLine2></sAddressLine2>'
                +'        <sAddressLine3></sAddressLine3>'
                +'        <sAddressCity></sAddressCity>'
                +'        <sAddressStateOrProvince></sAddressStateOrProvince>'
                +'        <sAddressPostalCode></sAddressPostalCode>'
                +'        <sAddressCountry></sAddressCountry>'
                +'        <gOwner>{00C370B9-1FC8-DE11-AB9E-0017A477000C}</gOwner>'
                +'        <dtContractExecuted>1900-01-01T00:00:00.000</dtContractExecuted>'
                +'      </oContact>'
                +'    </UpdateContact>'
                +'  </soap:Body>'
                +'</soap:Envelope>';
            
            req.setHeader('Content-Length',String.valueOf(ReqBody.length()));
      
       		req.setBody(ReqBody);
            res = h.send(req);
            System.debug('response ' +res.getBody());
            
        }
        catch(Exception e){
            System.debug('Error: '+e);
        }
    }
    */
}