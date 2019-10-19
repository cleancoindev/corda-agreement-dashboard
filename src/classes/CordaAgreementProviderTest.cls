@isTest
public class CordaAgreementProviderTest {
    
    @isTest
    public static void testAll(){
        CordaAgreementProvider obj = new CordaAgreementProvider();
        obj.getAuthenticationCapabilities();
        obj.getCapabilities();
        
        obj.getConnection(null);
    }


}