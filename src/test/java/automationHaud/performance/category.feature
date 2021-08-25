Feature: Category Test
    Background:
        * url apiUrl
        * def tokenResponse = callonce read('classpath:helpers/createToken.feature')
        * def token = tokenResponse.accessToken
        * def requestBody = {}
        * set requestBody.name = __gatling.categoryName
    
    Scenario: Create Category Feature
        Given path 'categories'
        And header Authorization = 'Bearer ' + token
        And request requestBody
        When method post
        Then status 200
        * def countyId = get[0] response.id
        