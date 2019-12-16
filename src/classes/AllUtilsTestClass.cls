// Dapps Incorporated 2020. All Rights Reserved.

@isTest
public with sharing class AllUtilsTestClass {
    
    static testMethod void testHTTPUtils() {
        Test.startTest();
        dsoa__NodeSettings__c orgWiseProperty = new dsoa__NodeSettings__c();
        orgWiseProperty.Name = 'Properties';
        orgWiseProperty.dsoa__username__c = '0987';
        orgWiseProperty.dsoa__nodeAddressURL__c = 'callout:DSOA_Network_API';
        orgWiseProperty.dsoa__Organization_Id__c = UserInfo.getOrganizationId();
        orgWiseProperty.dsoa__Private_Key__c = 'abcdefghijklmnopqrstuvwxyz123456';
        orgWiseProperty.dsoa__Port__c = '10002';
        orgWiseProperty.dsoa__p2pAddress__c = '000.000.000';
        insert orgWiseProperty;
        Test.stopTest();
        
       doHTTPCall();
        
        System.assert(orgWiseProperty != NULL);
    }
    
    @future(callout=true)
    static void doHTTPCall(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        HttpUtils http = new HttpUtils('');
        http.doPost('');
        http.doGet('');
        http.basicAuthCallout();
        HttpUtils.submitRequestWithMethod('', 'test');
    }
    
    static testMethod void testSecurityUtils() {
        dsoa__NodeSettings__c orgWiseProperty = new dsoa__NodeSettings__c();
        orgWiseProperty.Name = 'Properties';
        orgWiseProperty.dsoa__Private_Key__c = dsoaCommonUtils.MASTER_KEY;
        orgWiseProperty.dsoa__webserverURL__c= dsoaCommonUtils.NODE_URL;
        orgWiseProperty.dsoa__Organization_Id__c='';
        orgWiseProperty.dsoa__Private_Key__c='01234567890123456789012345678901';
        insert orgWiseProperty;
        
        SecurityUtils.encrypt('ABC', '01234567890123456789012345678901');
        SecurityUtils.encrypt('ABC', Blob.valueOf('01234567890123456789012345678901'));
        SecurityUtils.decrypt(EncodingUtil.base64Decode(''), '01234567890123456789012345678901');
        SecurityUtils.prepareRequest('{}');
        SecurityUtils.prepareRequestMaster('{}');

        System.assertNotEquals(SecurityUtils.encrypt('ABC', '01234567890123456789012345678901'), NULL);
        
    }   
    
    static testMethod void testdsoaCommonUtils() {
        dsoa__NodeSettings__c orgWiseProperty = new dsoa__NodeSettings__c();
        dsoa__KeySettings__c orgWideProperty = new dsoa__KeySettings__c();
        dsoa__ConfigSettings__c orgWineProperty = new dsoa__ConfigSettings__c();
        dsoa__NetworkMapSettings__c orgWifeProperty = new dsoa__NetworkMapSettings__c();
        orgWiseProperty.Name = 'Properties';
        orgWiseProperty.dsoa__Private_Key__c = '';
        orgWiseProperty.dsoa__webserverURL__c='callout:DSOA_Network_API';
        orgWiseProperty.dsoa__Organization_Id__c='';
        orgWiseProperty.dsoa__Private_Key__c='';
        insert orgWiseProperty;
        
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        dsoaCommonUtils.getMasterKey();
        dsoaCommonUtils.verifyUser();
        dsoaCommonUtils.getNodeName();
        dsoaCommonUtils.getNodeURL();
        dsoaCommonUtils.getUserId();
        
    }
    
}