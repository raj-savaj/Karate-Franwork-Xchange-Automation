Feature: Category Test
Background:
    * url 'http://192.168.20.23:8065/'

Scenario: Send HttpIn Message
    Given path '/v2/sms'
    * def requestPayload = read('http_sms_payload.json') 
    And request  requestPayload
    And header Authorization = 'Bearer QbpWt9jzxN560LCJxVthV15dRzWq5FanEDzC'
    When method post
    Then status 200
    