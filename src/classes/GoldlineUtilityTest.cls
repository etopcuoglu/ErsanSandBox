@isTest
private class GoldlineUtilityTest {
	

	@isTest static void testGetEnviormentName() { 
		ID orgId  = Userinfo.getOrganizationId();
        if(orgId == '00D41000002Hug8')
		{
			System.assertEquals(GoldlineUtility.GetEnviormentName(),'prod');
		} 
        else if(orgId == '00D0t0000008bk6')
		{
			System.assertEquals(GoldlineUtility.GetEnviormentName(),'test');
		}
        else
		{ 
			System.assertEquals(GoldlineUtility.GetEnviormentName(),'dev');
		}


		
	}
	
	@isTest static void testisProd(){
		ID orgId  = Userinfo.getOrganizationId();
		if(orgId == '00D41000002Hug8')
		{
			System.assertEquals(GoldlineUtility.isProd(),true);
		}
        else
		{ 
			System.assertEquals(GoldlineUtility.isProd(),false);
		}
		
	}

	@isTest static void testisTest() {
		ID orgId  = Userinfo.getOrganizationId();
		if(orgId == '00D0t0000008bk6')
		{
			System.assertEquals(GoldlineUtility.isTest(),true);
		}
        else
		{ 
			System.assertEquals(GoldlineUtility.isTest(),false);
		}
		
	}
	@isTest static void testisDev(){
		ID orgId  = Userinfo.getOrganizationId();
		if(orgId != '00D0t0000008bk6' && orgId !='00D41000002Hug8')
		{
			System.assertEquals(GoldlineUtility.isDev(),true);
		}
        else
		{ 
			System.assertEquals(GoldlineUtility.isDev(),false);
		}
		
	}

	@isTest static void testGetReportServerLink(){
		ID orgId  = Userinfo.getOrganizationId();
        if(orgId == '00D41000002Hug8')
		{
			System.assertEquals(GoldlineUtility.GetReportServerLink(),'sna-gl-rpt-01');
		} 
        else{
			System.assertEquals(GoldlineUtility.GetReportServerLink(),'wla-tst-rpt-01');
		}

		
	}


	@isTest static void test_GetSSRSReportServerLink(){
		if(Userinfo.getOrganizationId()=='00D41000002Hug8') {
            System.assertEquals(GoldlineUtility.GetSSRSReportServerLink(),'wla-sf-rpt-01');
        } else if (Userinfo.getOrganizationId()=='00D0t0000008bk6'){
            System.assertEquals(GoldlineUtility.GetSSRSReportServerLink(),'wla-tst-rpt-01');
        } else {
            System.assertEquals(GoldlineUtility.GetSSRSReportServerLink(),'null'); //TBD
        }     
	}

	@isTest static void test_Web_Service_Link_Out(){
		ID orgId  = Userinfo.getOrganizationId();
 if(orgId == '00D41000002Hug8')
		{
			System.assertEquals(GoldlineUtility.Get_Ax_Web_Service_Link_Out_of_NetWork(),'wla-sf-dax-02:88');
		} 
        else if(orgId == '00D0t0000008bk6')
		{
			System.assertEquals(GoldlineUtility.Get_Ax_Web_Service_Link_Out_of_NetWork(),'wla-tst-dax-02:88');
		}
        else
		{ 
			System.assertEquals(GoldlineUtility.Get_Ax_Web_Service_Link_Out_of_NetWork(),'wla-tst-dax-01:88');
		}




	}
	
	@isTest static void test_Web_Service_Link_In_Network(){
		if(GoldlineUtility.isDev()){
			System.assertEquals(GoldlineUtility.Get_Ax_Web_Service_Link_In_Network(),'sfax.goldline.com:4777');
		}
		else if(GoldlineUtility.isTest()){
			System.assertEquals(GoldlineUtility.Get_Ax_Web_Service_Link_In_Network(),'null');
		}
		else if(GoldlineUtility.isProd()){
			System.assertEquals(GoldlineUtility.Get_Ax_Web_Service_Link_In_Network(),'null');
		}

	}

	@isTest static void test_Get_Ax_Sql_Server_Link(){
		if(GoldlineUtility.isDev()){
			System.assertEquals(GoldlineUtility.Get_Ax_Sql_Server_Link(),'smc-tst-sql-01');
		}
		else if(GoldlineUtility.isTest()){
			System.assertEquals(GoldlineUtility.Get_Ax_Sql_Server_Link(),'smc-tst-sql-02');
		}
		else if(GoldlineUtility.isProd()){
			System.assertEquals(GoldlineUtility.Get_Ax_Sql_Server_Link(),'wla-sf-sql-02');
		}

	}

	@isTest static void test_Pallito_WS_Server_Link_Out_of_Network(){
		if(GoldlineUtility.isDev()){
			System.assertEquals(GoldlineUtility.Get_Pallito_WS_Server_Link_Out_of_Network(),'null');
		}
		else if(GoldlineUtility.isTest()){
			System.assertEquals(GoldlineUtility.Get_Pallito_WS_Server_Link_Out_of_Network(),'wla-dev-ws-01');
		}
		else if(GoldlineUtility.isProd()){
			System.assertEquals(GoldlineUtility.Get_Pallito_WS_Server_Link_Out_of_Network(),'null');
		}

	}

	@isTest static void test_Pallito_WS_Server_Link_In_Network(){
		if(GoldlineUtility.isDev()){
			System.assertEquals(GoldlineUtility.Get_Pallito_WS_Server_Link_In_Network(),'wla-dev-ws-01');
		}
		else if(GoldlineUtility.isTest()){
			System.assertEquals(GoldlineUtility.Get_Pallito_WS_Server_Link_In_Network(),'wla-dev-ws-01');
		}
		else if(GoldlineUtility.isProd()){
			System.assertEquals(GoldlineUtility.Get_Pallito_WS_Server_Link_In_Network(),'sna-gl-ws-02');
		}

	}

	@isTest static void test_Cloudsync_Sql_Server_Link(){
		if(GoldlineUtility.isDev()){
			System.assertEquals(GoldlineUtility.Get_Cloudsync_Sql_Server_Link(),'null');
		}
		else if(GoldlineUtility.isTest()){
			System.assertEquals(GoldlineUtility.Get_Cloudsync_Sql_Server_Link(),'smc-tst-sql-01');
		}
		else if(GoldlineUtility.isProd()){
			System.assertEquals(GoldlineUtility.Get_Cloudsync_Sql_Server_Link(),'wla-sf-sql-01');
		}

	}
	@isTest static void test_ODS_Sql_Server_Link(){
		if(GoldlineUtility.isDev()){
			System.assertEquals(GoldlineUtility.Get_ODS_Sql_Server_Link(),'null');
		}
		else if(GoldlineUtility.isTest()){
			System.assertEquals(GoldlineUtility.Get_ODS_Sql_Server_Link(),'wla-tst-dss-01');
		}
		else if(GoldlineUtility.isProd()){
			System.assertEquals(GoldlineUtility.Get_ODS_Sql_Server_Link(),'wla-sf-dss-01');
		}

	}
	@isTest static void test_Get_AWS_mySQL_Server_Link(){
		if(GoldlineUtility.isDev()){
			System.assertEquals(GoldlineUtility.Get_AWS_mySQL_Server_Link(),'mysql-stage.aws.goldline.com');
		}
		else if(GoldlineUtility.isTest()){
			System.assertEquals(GoldlineUtility.Get_AWS_mySQL_Server_Link(),'mysql-stage.aws.goldline.com');
		}
		else if(GoldlineUtility.isProd()){
			System.assertEquals(GoldlineUtility.Get_AWS_mySQL_Server_Link(),'mysql.aws.goldline.com');
		}

	}

	@isTest(SeeAllData=true) static void test_GetAccountSalutaionEnumValue(){
		String param1 = 'Mr.';
		System.assertEquals(GoldlineUtility.GetAccountSalutaionEnumValue(param1),1);

	}

	@isTest(SeeAllData=true) static void GetAccountSalutaionEnumMap(){	
		Map<String,Decimal> SalutationMap = new Map<String,Decimal>();
		SalutationMap = GoldlineUtility.GetAccountSalutaionEnumMap();
		Decimal ResultMap = SalutationMap.get('Atty.');		
		System.assertEquals(ResultMap,15);

	}
	
}