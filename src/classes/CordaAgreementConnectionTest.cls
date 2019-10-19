// Dapps Incorporated 2020. All Rights Reserved.

@isTest
public class CordaAgreementConnectionTest {
    
    @TestSetup
    static void setup(){
        dsoa__NodeSettings__c orgWiseProperty = new dsoa__NodeSettings__c();
        orgWiseProperty.Name='Properties';
        orgWiseProperty.dsoa__Private_Key__c = dsoaCommonUtils.MASTER_KEY;
        orgWiseProperty.dsoa__webserverURL__c = dsoaCommonUtils.NODE_URL;
        orgWiseProperty.dsoa__Organization_Id__c = '';
        orgWiseProperty.dsoa__Private_Key__c = '01234567890123456789012345678901';
        insert orgWiseProperty;
    }
   @isTest
   public static void test(){
       testCallout();
   }
   @future(callout=true)
    public static void testCallout() {
        
    
        
    CordaAgreementConnection conn = new CordaAgreementConnection();
    conn.sync();
        
        conn.mapColumnName('agreementName');
        conn.mapColumnName('agreementNumber');
        conn.mapColumnName('agreementStatus');
        conn.mapColumnName('agreementType');
        conn.mapColumnName('totalAgreementValue');
        conn.mapColumnName('party');
        conn.mapColumnName('counterparty');
        conn.mapColumnName('agreementStartDate');
        conn.mapColumnName('agreementEndDate');
        conn.mapColumnName('active');
        conn.mapColumnName('createdAt');
        conn.mapColumnName('lastUpdated');
        conn.mapColumnName('linearId');
        conn.mapColumnName('ExternalId');
        conn.mapColumnName('DisplayUrl');
        conn.mapColumnName('');
        

        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator('{"items":[]}'));
        conn.getData('URL');

        Map<String, Object> item = new Map<String, Object>();
        item.put('ExternalId','ExternalId');
        
        conn.createRow(item);
        


  }
   
}