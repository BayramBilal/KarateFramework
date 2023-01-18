
Feature: Parameters example
 Background:

  * def baseUrl = "https://api.exchangerate.host"
   * def spartanUrl = 'http://3.91.214.5:8000/'
   * def hrUrl = 'http://3.91.214.5:1000/ords/hr'


  Scenario: path parameters
    Given url baseUrl
    And path "latest"
    When method get
    Then status 200


  Scenario: path parameters
    Given url baseUrl
    And path "2010-01-12"
    When method get
    Then status 200

  Scenario: get all spartans with path
    Given url spartanUrl
    And path "api/spartans"
    When method get
    Then status 200
    And print response


  Scenario: get only one spartan
     * def expectedSpartan =
    """
    { "id": 10,
  "name": "Lorenza",
  "gender": "Female",
  "phone": 3312820936
}
    """
    Given url spartanUrl
    And path "api/spartans"
    And path "10"
    When method get
    Then status 200
    And print response
    And match response == {"id": 10, "name": "Lorenza", "gender": "Female", "phone": 3312820936}
    And match response == expectedSpartan


    Scenario: query parameters
    Given url spartanUrl
    And path "api/spartans/search"
    And param nameContains = "j"
    And param gender = "Female"
    When method get
    Then status 200
    And match header Content-Type == 'application/json'
    And print response
#    And match response.pageable.pageNumber == 0
#    verify each content has gender = Female
    And match each response.content contains {"gender":"Female"}
    #    2nd way iteration
    And match each response.content[*].gender == "Female"
    And match response.content[0].name =='Jaimie'

    #    verify each content phone is number
    And match each response.content[*].phone == '#number'


  Scenario: hr regions regions example
    Given url hrUrl
    And path "regions"
    When method get
    Then status 200
    And print response
    And match response.limit == 25
    And match each response.items[*].region_id == '#number'