Feature: Karate Java Integration

  Background:
* def spartanUrl = 'http://3.91.214.5:8000/'

  Scenario: Get a spartan with request header
      Given url spartanUrl
      And path "api/spartans"
      And header Accept = 'application/json'
      When method Get
      Then status 200


  Scenario: Create a new spartan
    Given url spartanUrl
    And path "api/spartans"
    And header Accept = 'application/json'
    And header Content-Type = 'application/json'
    And request
    """
    {
    "gender":"Female",
    "name":"Clair",
    "phone": 2727277878
    }

    """
    When method Post
    Then status 201
    And print response


  Scenario: reading java method
#    point the class that we want to run
     #Java.type --> used to connect to java class
     * def SDG = Java.type ('utilities.SpartanDataGenerator')
    * def newSpartan = SDG.createSpartan()
      #run the static method in that class and capture the result
     #the return map object is represented as a json
    * print newSpartan

  Scenario: create a spartan with Random Data (Java)

    * def SDG = Java.type ('utilities.SpartanDataGenerator')
    * def newSpartan = SDG.createSpartan()
    Given url spartanUrl
    And path "api/spartans"
    And header Accept = 'application/json'
    And header Content-Type = 'application/json'
    And request newSpartan
    When method post
    Then status 201
    And print response
    And match response.success == 'A Spartan is Born!'
#    verify names
    And match response.data.name ==  newSpartan.name

  @wip
  Scenario: create a spartan with Random Data (Java)
    * def SDG = Java.type ('utilities.SpartanDataGenerator')
    * def newSpartan = SDG.createSpartan()
    Given url spartanUrl
    And path "api/spartans"
    And header Accept = 'application/json'
    And header Content-Type = 'application/json'
    And request newSpartan
    When method post
    Then status 201
    And print response
    And match response.success == 'A Spartan is Born!'
#    verify names
    And match response.data.name ==  newSpartan.name
    And def idToDelete = response.data.id
    Given url spartanUrl
    And path 'api/spartans', idToDelete
#    And path idToDelete
    When method DELETE
    Then status 204