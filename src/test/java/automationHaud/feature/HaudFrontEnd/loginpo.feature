Feature: Validate Login Functionality

Background: Connected to URL
    Given call read 'loginpo.json'
    Given configure driver = { httpConfig: { readTimeout: 120000 } }
    Given  driver 'http://192.168.20.76/'

Scenario: Validate Login module
    When input(login.username,'admin.xchange')
    When input(login.password,'Haudsysops123!')
    And click(login.submit)
    Then match driver.url == 'http://192.168.20.76/'
    * waitForText('#root > div.MainLayout.MainLayout--MenuBar > div.MainLayoutContent > main > header > h1', 'Dashboard')
