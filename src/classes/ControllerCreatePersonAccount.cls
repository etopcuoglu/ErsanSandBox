public class ControllerCreatePersonAccount {
    //This controller checks duplicate rules on PersonAccount Creation
    //Gives end users to save the duplicate or update current record
    public Account acct {get;set;}
    public Account_Phone_Relationship__c acctRel = new Account_Phone_Relationship__c();
    public PhoneNumber__c phoneNumber = new PhoneNumber__c();
    public ApexPages.StandardController Con {get; set;}
    public String errorDuplicateText{get;set;}
    public List<sObject> duplicateRecords{get;set;}    
    public boolean hasDuplicateResult{get;set;}    
        
    public ControllerCreatePersonAccount(ApexPages.StandardController controller){        
        acct = (Account)controller.getRecord();
        Con = controller;
        hasDuplicateResult = false;
        
    }
        
    public PageReference save() {
        // check for person account record type
        RecordType recType = [select id,name,sobjectType,ispersontype from recordType where ispersontype=true and sobjectType='account' limit 1];
        acct = (Account)Con.getRecord();
        acct.RecordTypeId = recType.id;
        acct.CRM_Account_GUID__c = GuidUtil.NewGUID();
        acct.isSynchronizedAX__C = false;
        Database.SaveResult saveResult = Database.insert(acct, false);
        system.debug('Account>>> '+acct);
        if (!saveResult.isSuccess()) {
            for (Database.Error error : saveResult.getErrors()) {
                // If there are duplicates, an error occurs
                // Process only duplicates and not other errors 
                //   (e.g., validation errors)
                if (error instanceof Database.DuplicateError) {
                    // Handle the duplicate error by first casting it as a 
                    //   DuplicateError class
                    // This lets you use methods of that class 
                    //  (e.g., getDuplicateResult())
                    Database.DuplicateError duplicateError = (Database.DuplicateError)error;
                    Datacloud.DuplicateResult duplicateResult = duplicateError.getDuplicateResult();
                    
                    // Get duplicate records
                    this.duplicateRecords = new List<sObject>();
                    
                    // Return only match results of matching rules that 
                    //  find duplicate records
                    Datacloud.MatchResult[] matchResults = 
                        duplicateResult.getMatchResults();                        
                    // Just grab first match result (which contains the 
                    //   duplicate record found and other match info)
                    Datacloud.MatchResult matchResult = matchResults[0];                        
                    Datacloud.MatchRecord[] matchRecords = matchResult.getMatchRecords();
                    // Add matched record to the duplicate records variable
                    for (Datacloud.MatchRecord matchRecord : matchRecords) {
                        this.duplicateRecords.add(matchRecord.getRecord()); 
                    }
                    // Display duplicate error message as defined in the duplicate rule                    
                    errorDuplicateText = this.duplicateRecords.size() +' Possible Duplicate Records Found.<br/>' + duplicateResult.getErrorMessage();
                    this.hasDuplicateResult = !this.duplicateRecords.isEmpty();                        
                }
            }            
            return null;            
        }         
        try{            
            phoneNumber.Name = acct.Phone; // This will trigger a save into the PhoneNumber__c.Phone_Number__c field
            insert phoneNumber;
            
            acctRel.Account__c = acct.Id;
            acctRel.Phone_Number__c = phoneNumber.Id;
            insert acctRel;
            
            PageReference pageOfNewAccount = New PageReference('/'+acct.id);
            pageOfNewAccount.setRedirect(true);
            return pageOfNewAccount;             
        } catch (Exception e){            
            ApexPages.addMessages(e);
            System.debug('Error in ControllerCreatePersonAccount.save(): ' + e.getMessage());            
        }        
        return null;        
    }
    
    public PageReference saveandignore(){        
        try{            
            Database.DMLOptions dml = new Database.DMLOptions();
            dml.DuplicateRuleHeader.AllowSave = true; 
            RecordType recType = [select id,name,sobjectType,ispersontype from recordType where ispersontype=true and sobjectType='account' limit 1];
            acct = (Account)Con.getRecord();
            acct.CRM_Account_GUID__c = GuidUtil.NewGUID();
            acct.isSynchronizedAX__C = false;
            acct.RecordTypeId = recType.id;
            Database.SaveResult saveResult = Database.insert(acct, DML);

            phoneNumber.Name = acct.Phone; // This will trigger a save into the PhoneNumber__c.Phone_Number__c field
            insert phoneNumber;
            
            acctRel.Account__c = acct.Id;
            acctRel.Phone_Number__c = phoneNumber.Id;
            insert acctRel;
            
            PageReference pageOfNewAccount = New PageReference('/'+acct.id);
            pageOfNewAccount.setRedirect(true);
            return pageOfNewAccount;                 
        } catch (Exception e){            
            ApexPages.addMessages(e);
            System.debug('Error in ControllerCreatePersonAccount.saveandignore(): ' + e.getMessage());            
        }        
        return null;        
    }
    
    public PageReference SaveAndNew(){        
        try{            
            Database.DMLOptions dml = new Database.DMLOptions();
            dml.DuplicateRuleHeader.AllowSave = true; 
            RecordType recType = [select id,name,sobjectType,ispersontype from recordType where ispersontype=true and sobjectType='account' limit 1];
            acct = (Account)Con.getRecord();
            acct.RecordTypeId = recType.id;
            acct.CRM_Account_GUID__c = GuidUtil.NewGUID();
            acct.isSynchronizedAX__C = false;
            Database.SaveResult saveResult = Database.insert(acct, dml);
            
            //phoneNumber.Name = String.valueOf(acct.Phone).replaceAll('[^0-9]', '');
            insert phoneNumber;
            
            acctRel.Account__c = acct.Id;
            acctRel.Phone_Number__c = phoneNumber.Id;
            insert acctRel;

            phoneNumber.Name = acct.Phone; // This will trigger a save into the PhoneNumber__c.Phone_Number__c field
            insert phoneNumber;
            
            acctRel.Account__c = acct.Id;
            acctRel.Phone_Number__c = phoneNumber.Id;
            insert acctRel;
                                  
            string s ='/apex/CreatePersonAccount';   
            PageReference pg =  new PageReference(s);
            return pg.setRedirect(true) ;
        
        } catch (Exception e){
            
            ApexPages.addMessages(e);
            System.debug('Error in ControllerCreatePersonAccount.SaveAndNew(): ' + e.getMessage());
            
        }
        
        return null;
        
    }

}