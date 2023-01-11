Feature: Create Token

  Scenario: Create Token
    Given url apiUrl
    And path "users/login"
    And request {"user": {"email": "#(userEmail)", "password": "#(userPass)"}}
    When method post
    Then status 200
    * def authToken = response.user.token