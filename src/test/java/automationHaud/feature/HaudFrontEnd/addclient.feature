Feature: Validate Add Client

Background: Connected to URL
    Given configure driver = { httpConfig: { readTimeout: 120000 } }
    Given  driver 'http://192.168.20.76/'
    When input('#root > div.AuthLayout > div.k-card.AuthLayoutContent.AuthLayoutContent--Desktop.k-card-vertical > div > div > div:nth-child(2) > span > label','admin.xchange')
    When input('#root > div.AuthLayout > div.k-card.AuthLayoutContent.AuthLayoutContent--Desktop.k-card-vertical > div > div > div:nth-child(3) > span > label','Haudsysops123!')
    And click('#root > div.AuthLayout > div.k-card.AuthLayoutContent.AuthLayoutContent--Desktop.k-card-vertical > div > div > div:nth-child(4) > button')
    And def sleep = function(millis){ java.lang.Thread.sleep(millis) }
    And eval sleep(15000)

Scenario: Validate Add Client
    Given click('#root > div.Sidebar > nav > ul > li:nth-child(2) > a > span > span.SidebarMenuItemTitle')
    And click('#root > div.MainLayout.MainLayout--MenuBar > div.MainLayoutContent > main > div > div > div > div.k-card-body > div > div:nth-child(1) > button')
    And eval sleep(10000)
    And input('#root > div.MainLayout.MainLayout--MenuBar > div.MainLayoutContent > main > div > div:nth-child(2) > div > div.k-card-body > div > div:nth-child(2) > span > label','Client 1')
    And eval sleep(2000)
    And script('#root > div.MainLayout.MainLayout--MenuBar > div.MainLayoutContent > main > div > div:nth-child(2) > div > div.k-card-body > div > div:nth-child(14) > span > span > span > span.k-searchbar', '_.scrollIntoView()')
    And input('#root > div.MainLayout.MainLayout--MenuBar > div.MainLayoutContent > main > div > div:nth-child(2) > div > div.k-card-body > div > div:nth-child(14) > span > span > span > span.k-searchbar','EUR')
    When click('#root > div.MainLayout.MainLayout--MenuBar > div.MainLayoutContent > main > div > div:nth-child(2) > div > div.k-card-actions.k-card-actions-stretched.k-card-actions-horizontal > button.k-button.k-flat.k-primary')
    And eval sleep(1000)
    Then match driver.url == 'http://192.168.20.76/clients'