@debug
Feature: Sign up new user
  Background: Preconditions
    * def dataGenerator = Java.type('helpers.DataGenerator')
    Given url apiUrl

    Scenario: New user sign up
      #* def userData = {"email":"auto4@gmail.com","username":"auto4"}
      * def randomEmail = dataGenerator.getRandomEmail()
      * def randomUsername = dataGenerator.getRandomUsername()

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