Feature: Validate Login Functionality

Background: Connected to URL
    Given configure driver = { httpConfig: { readTimeout: 120000 } }
    Given  driver 'http://192.168.20.76/'

Scenario: Validate Login module
    When input('#root > div.AuthLayout > div.k-card.AuthLayoutContent.AuthLayoutContent--Desktop.k-card-vertical > div > div > div:nth-child(2) > span > label','admin.xchange')
    When input('#root > div.AuthLayout > div.k-card.AuthLayoutContent.AuthLayoutContent--Desktop.k-card-vertical > div > div > div:nth-child(3) > span > label','Haudsysops123!')
    And click('#root > div.AuthLayout > div.k-card.AuthLayoutContent.AuthLayoutContent--Desktop.k-card-vertical > div > div > div:nth-child(4) > button')
    Then match driver.url == 'http://192.168.20.76/'
    * waitForText('#root > div.MainLayout.MainLayout--MenuBar > div.MainLayoutContent > main > header > h1', 'Dashboard')