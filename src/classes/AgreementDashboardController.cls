// Dapps Incorporated 2020. All Rights Reserved.

public with sharing class AgreementDashboardController {
    
    public String webserverURL{get;set;}
    public String webserverPort{get;set;}
    

    public void init(){
        
        dsoa__NodeSettings__c nodeSettingsObj = null;
        try{
            nodeSettingsObj = DSOAServices.getNode('Properties',new List<String>{'Name', 'dsoa__webserverURL__c', 'dsoa__webserverPort__c', 'dsoa__Port__c','dsoa__password__c', 'dsoa__p2pAddress__c', 'dsoa__nodeAddressURL__c','dsoa__Organization_Id__c'});          
        }catch(Exception e){
            //No Read Access
        }    
        if(nodeSettingsObj!=null){
            webserverURL = nodeSettingsObj.dsoa__webserverURL__c;
            webserverPort = nodeSettingsObj.dsoa__webserverPort__c;
        }
        
    }
            

    @RemoteAction
    public static List<dsoa__DSOA_Agreements__x> getAgreementRecords(){
        
        List<dsoa__DSOA_Agreements__x> agreements = [select id, dsoa__agreementName__c, dsoa__agreementNumber__c, dsoa__agreementStartDate__c,   dsoa__agreementStatus__c,   dsoa__agreementType__c, dsoa__counterparty__c, dsoa__party__c, dsoa__totalAgreementValue__c from dsoa__DSOA_Agreements__x ];     
        return agreements;
    }    
    
    
        
    @RemoteAction
    public static String getMe() {
        string url;
        string webserverPort;
        url = 'callout:DSOA_Network_API' + webserverPort + '/api/me';
        Http httpProtocol = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndPoint(url);
        request.setMethod('GET');
        HttpResponse response = httpProtocol.send(request);
        return response.getBody();
    }
    
    
    @RemoteAction
    public static String createAgreement(String url){
        url = 'callout:DSOA_Network_API' + '/api/createAgreement';
        Http httpProtocol = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndPoint(url);
        request.setMethod('POST');
        HttpResponse response = httpProtocol.send(request);
        return response.getBody();
    }
    
    @RemoteAction
    public static String activateAgreement(String reqMapStr){
        HttpUtils hp2 = new HttpUtils( dsoaCommonUtils.NODE_URL + '/api/activateAgreement');
        hp2.doPost(reqMapStr);
        String responseBody  = hp2.body;
        
        return responseBody;
    }
    
    @RemoteAction
    public static String renewAgreement(String reqMapStr){
        HttpUtils hp2 = new HttpUtils( dsoaCommonUtils.NODE_URL + '/api/renewAgreement');
        hp2.doPost(reqMapStr);
        String responseBody  = hp2.body;
        
        return responseBody;
    }
    
    @RemoteAction
    public static String amendAgreement(String reqMapStr){
        HttpUtils hp2 = new HttpUtils( dsoaCommonUtils.NODE_URL + '/api/amendAgreement');
        hp2.doPost(reqMapStr);
        String responseBody  = hp2.body;
        
        return responseBody;
    }
    
    @RemoteAction
    public static String terminateAgreement(String reqMapStr){
        HttpUtils hp2 = new HttpUtils( dsoaCommonUtils.NODE_URL + '/api/terminateAgreement');
        hp2.doPost(reqMapStr);
        String responseBody  = hp2.body;
        
        return responseBody;
    }
    
    
    @RemoteAction
    public static String expireAgreement(String reqMapStr){
        HttpUtils hp2 = new HttpUtils( dsoaCommonUtils.NODE_URL + '/api/expireAgreement');
        hp2.doPost(reqMapStr);
        String responseBody  = hp2.body;
        
        return responseBody;
    }
    
    
}