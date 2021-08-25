Feature: Category Test
Background:
    * url 'http://192.168.20.22:5000/'

Scenario: Send HttpIn Message
    Given path 'sample_post'
    When method post
    Then status 200
    