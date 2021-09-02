Feature: Work with redis

Background: Connected to redis
* def redisHandler = Java.type("helpers.RedisHandler")
* def routeValidate = Java.type("helpers.validateRoute")
* url apiUrl
* def tokenResponse = callonce read('classpath:helpers/createToken.feature')
* def token = tokenResponse.accessToken

Scenario: Validate Route, Network and country through Redis
    * def route = redisHandler.getRedisData("edge.core.sms.routes-data")

    Given path 'destinations/countries'
    Given header Authorization = 'Bearer ' + token
    When method get
    Then status 200
    * def countyId = get[0] response.countries[?(@.country_name=='Malta')].country_id
    
    Given path "destinations/countries/"+countyId+"/networks"
    Given header Authorization = 'Bearer ' + token
    When method get
    Then status 200
    * def networkId = get[0] response.networks[?(@.network_name=='Vodafone')].network_id
    
    Given path 'routes'
    Given header Authorization = 'Bearer ' + token
    When method get
    Then status 200
    * def routeId = get[0] response.routes[?(@.name=='Route1')].id

    * match routeValidate.getRouteId(route) contains routeId
    * match routeValidate.getCountryId(route,routeId) contains countyId
    * match routeValidate.getNetworkId(route,routeId,countyId) contains networkId