Feature: Sign up new user
  Background: Preconditions
    Given url apiUrl

    @debug
    Scenario: New user sign up
      * def userData = {"email":"auto4@gmail.com","username":"auto4"}
      Given path 'users'
      #And request {"user":{"email": #(userData.email),"password":"auto2","username": #(userData.username)}}
      And request
      """
        {
          "user":
            {
              "email": #(userData.email),
              "password":"auto2",
              "username": #(userData.username)
            }
        }
      """
      When method post
      Then status 200