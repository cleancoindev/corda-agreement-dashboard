// Dapps Incorporated 2020. All Rights Reserved.

global with sharing class AgreementDashboardController {
    
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
        
        List<dsoa__DSOA_Agreements__x> agreements = [select id, dsoa__agreementName__c, dsoa__agreementNumber__c, dsoa__agreementStartDate__c, 	dsoa__agreementStatus__c, 	dsoa__agreementType__c, dsoa__counterparty__c, dsoa__party__c, dsoa__totalAgreementValue__c from dsoa__DSOA_Agreements__x ];     
        return agreements;
    }    
    
    
        
        
    @RemoteAction
    public static String getMe() {
        string url;
        url = 'callout:DSOA_Network_API' + '/api/nodes/ ' + dsoaCommonUtils.NODE_NAME + '/me';
        Http httpProtocol = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndPoint(url);
        request.setMethod('GET');
        HttpResponse response = httpProtocol.send(request);
        return response.getBody();
    }
    
    
    @RemoteAction
    public static String getAgreements() {
        string url;
        string webserverPort;
        url = 'callout:DSOA_Network_API' + '/api/' + dsoaCommonUtils.NODE_NAME + '/getAgreements';
        Http httpProtocol = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndPoint(url);
        request.setMethod('GET');
        HttpResponse response = httpProtocol.send(request);
        return response.getBody();
    }
    
    
    @RemoteAction
    global static String createAgreement(String body) {
        Http httpProtocol = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndPoint('callout:DSOA_Network_API' + '/api' + dsoaCommonUtils.NODE_NAME + '/createAgreement');
        request.setMethod('POST');
        request.setBody(body);
        HttpResponse response = httpProtocol.send(request);
        return response.getBody();
    }
    
    @RemoteAction
    global static String activateAgreement(String agreementNumber) {
        Http httpProtocol = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndPoint('callout:DSOA_Network_API' + '/api/' + dsoaCommonUtils.NODE_NAME + '/activateAgreement?agreementNumber=' + agreementNumber);
        request.setMethod('POST');
        HttpResponse response = httpProtocol.send(request);
        return response.getBody();
    }
    
    @RemoteAction
    global static String renewAgreement(String agreementNumber) {
        Http httpProtocol = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndPoint('callout:DSOA_Network_API' + '/api/' + dsoaCommonUtils.NODE_NAME + 'partyC/renewAgreement?agreementNumber=' + agreementNumber);
        request.setMethod('POST');
        HttpResponse response = httpProtocol.send(request);
        return response.getBody();
    }
    
    @RemoteAction
    global static String amendAgreement(String agreementNumber) {
        Http httpProtocol = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndPoint('callout:DSOA_Network_API' + '/api/' + dsoaCommonUtils.NODE_NAME + '/amendAgreement?agreementNumber=' + agreementNumber);
        request.setMethod('POST');
        HttpResponse response = httpProtocol.send(request);
        return response.getBody();
    }
    
    @RemoteAction
    global static String terminateAgreement(String agreementNumber) {
        Http httpProtocol = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndPoint('callout:DSOA_Network_API' + '/api/' + dsoaCommonUtils.NODE_NAME + 'terminateAgreement?agreementNumber=' + agreementNumber);
        request.setMethod('POST');
        HttpResponse response = httpProtocol.send(request);
        return response.getBody();
    }
    
    
    @RemoteAction
    global static String expireAgreement(String agreementNumber) {
         Http httpProtocol = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndPoint('callout:DSOA_Network_API' + '/api/' + dsoaCommonUtils.NODE_NAME + '/expireAgreement?agreementNumber=' + agreementNumber);
        request.setMethod('POST');
        HttpResponse response = httpProtocol.send(request);
        return response.getBody();
    }
    
    
}