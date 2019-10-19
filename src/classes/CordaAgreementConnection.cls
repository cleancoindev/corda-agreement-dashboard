// Dapps Incorporated 2020. All Rights Reserved.

global class CordaAgreementConnection 
    extends DataSource.Connection {

    /**
     *   Constructors.
     **/
    global CordaAgreementConnection(
        DataSource.ConnectionParams connectionParams) {
    }
    global CordaAgreementConnection() {}
    
    
        // Search 
        // 
        // 
            override global List<DataSource.TableResult> search(
            DataSource.SearchContext context) {
        List<DataSource.TableResult> results =
                new List<DataSource.TableResult>();

        for (Integer i =0;i< context.tableSelections.size();i++) {
            String entity = context.tableSelections[i].tableSelected;

            // Search usernames
            String url = 'callout:dsoa__DSOA_Network_API' + '/api/' + dsoaCommonUtils.NODE_NAME + '/getAgreements'
                            + context.searchPhrase;
            results.add(DataSource.TableResult.get(
                    true, null, entity, getData(url)));
        }

        return results;
    }
        
        
/**
     *   Called to query and get results from the external 
     *   system for SOQL queries, list views, and detail pages 
     *   for an external object that’s associated with the 
     *   external data source.
     *   
     *   The queryContext argument represents the query to run 
     *   against a table in the external system.
     *   
     *   Returns a list of rows as the query results.
     **/
    override global DataSource.TableResult query(
            DataSource.QueryContext context) {
        DataSource.Filter filter = context.tableSelection.filter;
        String url;
        if (filter != null) {
            String thisColumnName = filter.columnName;
            if (thisColumnName != null &&
               (thisColumnName.equals('ExternalId') ||
                thisColumnName.equals('linearId')))
                url = 'callout:callout:dsoa__DSOA_Network_API' + '/api/' + dsoaCommonUtils.NODE_NAME + '/getAgreements'
                        + filter.columnValue;
            else
                    url = 'callout:dsoa__DSOA_Network_API' + '/api/' + dsoaCommonUtils.NODE_NAME + '/getAgreements';
        } else {
            url = 'callout:dsoa__DSOA_Network_API' + '/api/' + dsoaCommonUtils.NODE_NAME + '/getAgreements';
        }

        /**
         * Filters, sorts, and applies limit and offset clauses.
         **/
        List<Map<String, Object>> rows =
                DataSource.QueryUtils.process(context, getData(url));
        return DataSource.TableResult.get(true, null,
                context.tableSelection.tableSelected, rows);
    }
        
          /**
           * 
       

    /**
     *   Called when an external object needs to get a list of 
     *   schema from the external data source, for example when 
     *   the administrator clicks “Validate and Sync” in the 
     *   user interface for the external data source.   
     **/
      override global List<DataSource.Table> sync() {
        List<DataSource.Table> tables =
            new List<DataSource.Table>();
        List<DataSource.Column> columns;
        columns = new List<DataSource.Column>();
        columns.add(DataSource.Column.text('agreementNumber',255));
        columns.add(DataSource.Column.text('agreementName',255));
        columns.add(DataSource.Column.text('agreementStatus',255));
        columns.add(DataSource.Column.text('agreementType',255));
        columns.add(DataSource.Column.text('totalAgreementValue',255));
        columns.add(DataSource.Column.text('party',255));
        columns.add(DataSource.Column.text('counterparty',255));
        columns.add(DataSource.Column.text('agreementStartDate',255));
        columns.add(DataSource.Column.text('agreementEndDate',255));
        columns.add(DataSource.Column.text('active', 255));
        columns.add(DataSource.Column.text('createdDate',255));
        columns.add(DataSource.Column.text('lastUpdated',255));
        columns.add(DataSource.Column.text('linearId',255));
        columns.add(DataSource.Column.text('ExternalId',255));
        columns.add(DataSource.Column.url('DisplayUrl'));
        tables.add(DataSource.Table.get('DSOA_Agreements','title',
            columns));
        return tables;
    }



/**     *   Helper method to parse the data.
     *   The url argument is the URL of the external system.
     *   Returns a list of rows from the external system.
     **/
    public List<Map<String, Object>> getData(String url) {
        String response = getResponse(url);

        // Standardize response string
        if (!response.contains('"items":')) {
            if (response.substring(0,1).equals('{')) {
                response = '[' + response  + ']';
            }
            response = '{"items": ' + response + '}';
        }

        List<Map<String, Object>> rows =
                new List<Map<String, Object>>();

        Map<String, Object> responseBodyMap = (Map<String, Object>)
                JSON.deserializeUntyped(response);

        /**
         *   Checks errors.
         **/
        Map<String, Object> error =
                (Map<String, Object>)responseBodyMap.get('error');


        List<Object> fileItems = 
            (List<Object>)responseBodyMap.get('items');
        if (fileItems != null) {
            for (Integer i=0; i < fileItems.size(); i++) {
                Map<String, Object> item =
                        (Map<String, Object>)fileItems[i];
                rows.add(createRow(item));
            }
        } else {
            rows.add(createRow(responseBodyMap));
        }

        return rows;
    }
    
    /**
     *   Helper method to map column names.
     **/
    @TestVisible
    private String mapColumnName(String apexName) {
        if (apexName.equalsIgnoreCase('agreementNumber'))
            return 'agreementNumber';
        if (apexName.equalsIgnoreCase('agreementName'))
            return 'agreementName';
        if (apexName.equalsIgnoreCase('agreementStatus'))
            return 'agreementStatus';
        if (apexName.equalsIgnoreCase('agreementType'))
            return 'agreementType';
        if (apexName.equalsIgnoreCase('totalAgreementValue'))
            return 'totalAgreementValue';
        if (apexName.equalsIgnoreCase('party'))
            return 'party';
        if (apexName.equalsIgnoreCase('counterparty'))
            return 'counterparty';
        if (apexName.equalsIgnoreCase('agreementStartDate'))
            return 'agreementStartDate';
        if (apexName.equalsIgnoreCase('agreementEndDate'))
            return 'agreementEndDate';
        if (apexName.equalsIgnoreCase('active'))
            return 'active';
        if (apexName.equalsIgnoreCase('createdAt'))
            return 'createdAt';
        if (apexName.equalsIgnoreCase('lastUpdated'))
            return 'lastUpdated';
        if (apexName.equalsIgnoreCase('linearId'))
            return 'linearId';
        if (apexName.equalsIgnoreCase('ExternalId'))
            return 'externalId';
        if (apexName.equalsIgnoreCase('DisplayUrl'))
            return 'Id';
        return apexName;
    }

	public Map<String, Object> createRow(
            Map<String, Object> item){
        Map<String, Object> row = new Map<String, Object>();
        for ( String key : item.keySet() ) {
            if (key == 'linearId') {
                row.put('ExternalId', item.get(key));
            }

            row.put(key, item.get(key));
        }
        return row;
    }

    /**
     *   Helper method to make the HTTP GET call.
     *   The url argument is the URL of the external system.
     *   Returns the response from the external system.
     **/
    public String getResponse(String url) {
        // Perform callouts for production (non-test) results.
        url = 'callout:dsoa__DSOA_Network_API' + '/api/' + dsoaCommonUtils.NODE_NAME + '/getAgreements';
        Http httpProtocol = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndPoint(url);
        request.setMethod('GET');
        HttpResponse response = httpProtocol.send(request);
        return response.getBody();
        
    }
}