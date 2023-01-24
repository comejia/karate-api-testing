Feature: Sign up new user

  Background: Preconditions
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * def randomEmail = dataGenerator.getRandomEmail()
    * def randomUsername = dataGenerator.getRandomUsername()
    Given url apiUrl

  Scenario: New user sign up
      #* def userData = {"email":"auto4@gmail.com","username":"auto4"}
#    * def randomEmail = dataGenerator.getRandomEmail()
#    * def randomUsername = dataGenerator.getRandomUsername()

    * def jsFunction =
      """
        function() {
          var DataGenerator = Java.type('helpers.DataGenerator')
          var generator = new DataGenerator()
          return generator.getRandomUsername2()
        }
      """
    * def randomUsername2 = call jsFunction

    Given path 'users'
      #And request {"user":{"email": #(userData.email),"password":"auto2","username": #(userData.username)}}
    And request
      """
        {
          "user":
            {
              "email": #(randomEmail),
              "password":"auto2",
              "username": #(randomUsername)
            }
        }
      """
    When method post
    Then status 200

  Scenario Outline: Validate Sign up error messages


    Given path 'users'
    And request
      """
        {
          "user":
            {
              "email": "<email>",
              "password":"<password>",
              "username": "<username>"
            }
        }
      """
    When method post
    Then status 422
    And match response == <errorResponse>

    Examples:
      | email          | password  | username          | errorResponse                                        |
      | #(randomEmail) | karate123 | karate            | {"errors": {"username": ["has already been taken"]}} |
      | debi@gmail.com | karate123 | #(randomUsername) | {"errors": {"email": ["has already been taken"]}}    |
      |                | karate123 | #(randomUsername) | {"errors": {"email": ["can't be blank"]}}                |