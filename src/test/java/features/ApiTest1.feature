Feature: exchange rate api tests


  Scenario: basic test with status code validation
    Given url 'https://api.exchangerate.host/latest'
    When method GET
    Then status 200


  Scenario: get rates
    Given url 'https://api.exchangerate.host/2010-01-12'
    When method get
    Then status 200


  Scenario: header verification
    Given url 'https://api.exchangerate.host/2010-01-12'
    When method get
    Then status 200
    And match header Connection == 'keep-alive'
    And match header Content-Type == 'application/json; charset=utf-8'
    And match header Date == '#present'


  Scenario:json body verification
    Given url 'https://api.exchangerate.host/2010-01-12'
    When method get
    Then status 200
    And match header Content-Type == 'application/json; charset=utf-8'
    And print response
    And print response.base
#    verify base is EUR

    And match response.base == 'EUR'
    And print response.rates
    And print response.rates.USD
    And match response.rates.USD == '#present'
    And match response.rates.USD == 1.4477
    And match response.rates.JPY == 131.84
    And print response.rates.JPY


