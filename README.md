# corda-agreement-dashboard
Salesforce Lightning Agreement Dashboard for Corda Smart Contracts

Install the Dappsync managed package (Dappsync 1.3 (Beta 7)):

https://login.salesforce.com/packaging/installPackage.apexp?p0=04t1U0000058VV1


```
sfdx force:package:install --package 04t1U0000058VV1AAA
```

Once the managed package is installed, you will need to setup your Custom Metadata Types, sync with you Corda Node and add the Agreement Dashboard Tab to your navigation.

1. Go to Custom Metadata Settings and manage the Node Settings.

Enter in your Node Name and Node URL in the Properties.

2. Add your Node URL to the Remote Site Settings

3. Go to External Data Sources and click on Corda Node

Validate and Sync with the Corda Node which will create your DSOA_Agreements External Object.

4. Go to Dappsync in the App Launcher

Edit Dappsync App Navigation Items and Click Add More Items to add the Agreement Dashboard.

You now should be able to see the Agreements coming from the Camila Networks.
