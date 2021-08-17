Feature: Work with database

Background: Connected to database
    * def dbHandler = Java.type("helpers.DbHandler")
    * url apiUrl
    * def tokenResponse = callonce read('classpath:helpers/createToken.feature')
    * def token = tokenResponse.accessToken

Scenario: Check the country count
    Given path 'destinations/countries'
    Given header Authorization = 'Bearer ' + token
    When method get
    Then status 200
    * def apiCountryCount = response.countries.length 
    * def countyId = get[0] response.countries[?(@.country_name=='Malta')].country_id
    * def dbCount = dbHandler.getRowCount("country")
    * match dbCount.count == apiCountryCount


    Given path "destinations/countries/"+countyId+"/networks"
    Given header Authorization = 'Bearer ' + token
    When method get
    Then status 200
    * def apiNetworkCount = response.networks.length 
    * def dbCount = dbHandler.getRowCount("network where country_id='"+countyId+"'")
    * match dbCount.count == apiNetworkCount
