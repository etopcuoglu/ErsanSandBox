public class ControllerViewAccount {

    private string ServerName{get;set;}
	private string ReportPath;
    private string CrmGuid;
    private string ReportParams{get;set;}
    public string MovementReportLink{get;set;}
    
    public boolean isProd;
    public string GetReportPath(){
      return  GoldlineUtility.GetReportServerLink();
    }
        
    public ControllerViewAccount(ApexPages.StandardController controller){
        
    }
    public Account acct {get;set;}
    public string GetCrmGuid(){
        return '{282E0A2B-CC0D-4CE4-A723-000683787BF0}';    
    }
    public void setParams(){
        CrmGuid = '{282E0A2B-CC0D-4CE4-A723-000683787BF0}';
        //return null;
    }

    public pageReference MovementReport() {
        //'http://' + sServer + '/ReportServer/Pages/ReportViewer.aspx?' + sPath+ '&rs:Command=Render&' + sIdVarName + '=' + sId
        //'http://sna-gl-rpt-01/ReportServer/Pages/ReportViewer.aspx?/AE/Customer Financial Movement&rs:Command=Render&oId={282E0A2B-CC0D-4CE4-A723-000683787BF0}
        ReportPath ='/AE/Customer+Financial+Movement';
        //  '/AE/Customer+Financial+Movement'
        ReportParams='oId';
        CrmGuid ='{282E0A2B-CC0D-4CE4-A723-000683787BF0}';
        ServerName = GetServerName();   
        string link = 'http://'+ ServerName +'/ReportServer/Pages/ReportViewer.aspx?'; 
        pageReference pageRef = new pageReference(link);
        pageRef.getParameters().put('/AE/Customer Financial Movement&oId','{282E0A2B-CC0D-4CE4-A723-000683787BF0}');
        system.debug('The LINK '+ link);
        system.debug('The LINK '+ pageRef.getUrl());
        return pageRef;
        
        
      //  HYPERLINK("http://www.fedex.com/Tracking?ascend_header=1&clienttype=dotcom&cntry_code=us&language=english&tracknumbers= "& tracking_id__c,"Track")
      //  HYPERLINK ("https://www.myintegration.com?sId=" & GETSESSIONID() & "?&rowID=" & Name & "action=CreateTask","Create a Meeting Request");
     
    }

    public string GetMovementReportLink()
    {
        ReportPath ='/AE/Customer+Financial+Movement';
        ReportParams='oId';
        string link = CreateStringHyperLink(ReportPath,ReportParams);
        return link;
    }
    
    public pageReference ComissionReport(){
        ReportPath ='/AE/OrderHistory';
        ReportParams='oId';
        return CreateHyperLink(ReportPath,ReportParams);
    } 

    public pageReference BaseReport(){
        ReportPath ='%2fAE%2fOrderHistory';
        ReportParams='oId';
        return CreateHyperLink(ReportPath,ReportParams);
    } 

    public pageReference DeliveryReport(){
        ReportPath ='%2fAE%2fCustomer+Delivery+Report';
        ReportParams='Contactid';
        return CreateHyperLink(ReportPath,ReportParams);
    }
    
    private pageReference CreateHyperLink(string ReportPath, string ReportParams){        
        ServerName=GetServerName();   
        CrmGuid ='{282E0A2B-CC0D-4CE4-A723-000683787BF0}';
       // ReportParams='PassParams="1" WinParams="resizable=yes, scrollbars=yes, menubar=no, directories=no, location=no, status=no, toolbar=no" WinMode="0" AvailableOffline="false"';
        string hyperLink = 'http://'+ ServerName +'/ReportServer/Pages/ReportViewer.aspx?'; //+ ReportPath +'&rs:Command=Render&'+ ReportParams +'='+ CrmGuid;          
    	pageReference pageRef = new pageReference(hyperLink);
    	pageRef.getParameters().put(ReportParams,CrmGuid);
        return pageRef;
    }
    
    private String CreateStringHyperLink(string ReportPath, string ReportParams){        
        ServerName=GetServerName();   
        CrmGuid ='{282E0A2B-CC0D-4CE4-A723-000683787BF0}';
        system.debug('reportPath '+ReportPath +' ReportParams '+ReportParams+' CrmGuid '+CrmGuid);
       // ReportParams='PassParams="1" WinParams="resizable=yes, scrollbars=yes, menubar=no, directories=no, location=no, status=no, toolbar=no" WinMode="0" AvailableOffline="false"';
        string hyperLink = 'http://'+ ServerName +'/ReportServer/Pages/ReportViewer.aspx?'; //+ ReportPath +'&rs:Command=Render&'+ ReportParams +'='+ CrmGuid;    
    	
        
        //pageReference pageRef = new pageReference(hyperLink);
        system.debug('Hyperlink in function'+ hyperLink);
    	return hyperLink;
    }
    
    private String GetServerName(){
        //ersanbox 00DW0000008xjN7 
        //devQA 00D2F0000008jxi 
        //prod 00D41000002Hug8        
        if(UserInfo.getOrganizationId() =='00D41000002Hug8'){
            //prod
            system.debug('it is PROD');
            return 'sna-gl-rpt-01';            
        }else{
            //test-dev-sandbox
            system.debug('it is TEST');
            return 'sna-gl-rpt-01';
            
        }    
        
    }
    
    // path=%2fAE%2fCustomer+Financial+Movement"
	//path=%2fAE%2fCustomerMetalMovement" 
	//path=%2fAE%2fOrderHistory" 
	//path=%2fAE%2fCustomer+Delivery+Report"
}