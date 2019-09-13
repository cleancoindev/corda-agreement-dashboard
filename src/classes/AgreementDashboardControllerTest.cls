// Dapps Incorporated 2020. All Rights Reserved.
@isTest
public with sharing class AgreementDashboardControllerTest {
    static testMethod void init() {
        
        dsoa__NodeSettings__c orgWiseProperty = new dsoa__NodeSettings__c();
        orgWiseProperty.Name = 'Properties';
        orgWiseProperty.dsoa__username__c = '1210982091809820980980980';
        orgWiseProperty.dsoa__nodeAddressURL__c = 'callout:DSOA_Network';
        orgWiseProperty.dsoa__Organization_Id__c = UserInfo.getOrganizationId();
        orgWiseProperty.dsoa__Private_Key__c = '1210982091809820980123456';
        orgWiseProperty.dsoa__compatabilityZoneURL__c = 'https://dsoa.network:8080';
        orgWiseProperty.dsoa__webserverURL__c = 'https://dsoa.network:';
        orgWiseProperty.dsoa__webserverPort__c = '10050';
        orgWiseProperty.dsoa__Port__c = '10002';
        orgWiseProperty.dsoa__p2pAddress__c = 'localhost' + orgWiseProperty.dsoa__Port__c;
        orgWiseProperty.dsoa__truststorePassword__c = 'truststore';
        insert orgWiseProperty;
        
        }
    
      static testMethod void testAll() {
        init();
        run();
       
      }
        
        @future(callout=true)
      static void run(){


    Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());        
        AgreementDashboardController.getMe();
        AgreementDashboardController.getAgreementRecords();
        AgreementDashboardController.createAgreement('{"data":""}');
        AgreementDashboardController.activateAgreement('{"data":""}');
        AgreementDashboardController.renewAgreement('{"data":""}');
        AgreementDashboardController.amendAgreement('{"data":""}');
        AgreementDashboardController.terminateAgreement('{"data":""}');
        AgreementDashboardController.expireAgreement('{"data":""}');
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator('{"statusCode":200,"status":"SUCCESS","responseStr":{"keyObj" : {"address":"ADD123"}}}'));
        
        
        AgreementDashboardController adcObj = new AgreementDashboardController(); 
        adcObj.init();
            
  }
    
}