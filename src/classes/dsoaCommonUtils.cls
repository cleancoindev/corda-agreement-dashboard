// Dapps Incorporated 2020. All Rights Reserved.

global with sharing class dsoaCommonUtils {
    
    public static  String NODE_URL = '';
    public static  String NODE_NAME = '';
    public static  String MASTER_KEY = '';
    public static  Boolean ENCRYPT_RESPONSE = false; 
  
    public static Boolean isSandbox() {
        SecurityUtils.checkSecurity('Organization',  new List<String>{'IsSandbox'});
        return [SELECT IsSandbox FROM Organization LIMIT 1].IsSandbox;
    }
    
    public static string getEnvironment() {
        if(isSandbox()){
            return 'sandbox';
        }
        return 'production';
    }
    
    public static string getMasterKey() {
        String masterKey = '';
        List<dsoa__System_Property__mdt> properties = [SELECT dsoa__Master_Key__c FROM dsoa__System_Property__mdt WHERE MasterLabel='Properties'];
        if(!properties.isEmpty()){
            masterKey = properties.get(0).dsoa__Master_Key__c;
        } 
        
        return masterKey;  
    }
    
    public static string getNodeName() {
        String nodeName = '';
    	List<dsoa__Network_Settings__mdt> nodesettings = [SELECT dsoa__nodeName__c FROM dsoa__Network_Settings__mdt WHERE MasterLabel='Properties'];
        if(!nodesettings.isEmpty()){
            nodeName = nodesettings.get(0).dsoa__nodeName__c;
        }
        
        return nodeName;
    }
        
  		@RemoteAction
 		global static String verifyUser(){
        return HttpUtils.submitRequestWithMethod('{}', 'verifyUser');
 	    }


    public class CustomMetadataCallback implements Metadata.DeployCallback {
        public void handleResult(Metadata.DeployResult result,
                                 Metadata.DeployCallbackContext context) {
            if (result.status == Metadata.DeployStatus.Succeeded) {
                System.debug('success: '+ result);
            } else {
                // Deployment was not successful
                System.debug('fail: '+ result);
            }
        }
    }
    
    public static void deployMetadata(String objectName,String recordId,String label, Map<String,Object> fieldMap){
        Metadata.CustomMetadata customMetadata =  new Metadata.CustomMetadata();
        customMetadata.fullName = objectName+'.'+recordId;
        customMetadata.label = label;
        
        for(String fieldName : fieldMap.keySet()){
            Object fieldValue = fieldMap.get(fieldName);
            
            Metadata.CustomMetadataValue customField = new Metadata.CustomMetadataValue();
            customField.field = fieldName;
            customField.value = fieldValue;
        
            customMetadata.values.add(customField);
        }
        
        Metadata.DeployContainer mdContainer = new Metadata.DeployContainer();
        mdContainer.addMetadata(customMetadata);
        Id jobId = Metadata.Operations.enqueueDeployment(mdContainer, new CustomMetadataCallback());
        system.debug('Job ID:'+jobId);
        
    }
    
    public static void sendErrroMail(String errorMessage,String subject){              
        try{
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
             String[] toAddresses = new String[] {'devops@dapps-inc.com'};
             mail.setToAddresses(toAddresses);
             mail.setReplyTo('support@id.com');  
             mail.setSenderDisplayName('Apex error message : '+subject);
             mail.setSubject('Error from Org : ' + UserInfo.getOrganizationName());
             mail.setPlainTextBody(errorMessage);

        }catch(Exception e){
            system.debug('Error in Email');
            system.debug(e);
        }
        }
    
    public static void sendErrroMail(String errorMessage,String subject,Exception e){
        String exceptionStr = '';
        if(e!=null){
          exceptionStr = exceptionStr +'Line Number :' +e.getLineNumber() + '<br/>';
            exceptionStr = exceptionStr +'Message :' +e.getMessage() + '<br/>';
            exceptionStr = exceptionStr +'Type :' +e.getMessage()+ '<br/>';
            exceptionStr = exceptionStr +'Stack Trace :' +e.getStackTraceString() + '<br/>';    
        }
        
        sendErrroMail(errorMessage + '  <br/>  Error Details :'+exceptionStr,subject);
    }
    public static void sendMail(String text){
        sendErrroMail(text,'Logs');
    }
    


}