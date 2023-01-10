Feature: Articles

  Background:
    Given url "https://conduit.productionready.io/api/"
    Given path "users/login"
    And request {"user": {"email": "debi@gmail.com", "password": "debi"}}
    When method post
    Then status 200
    * def token = response.user.token

  Scenario: Create a new article
    Given header Authorization = "Token " + token
    And path "articles"
    And request {"article":{"tagList":[],"title":"Test4","description":"test","body":"test"}}
    When method post
    Then status 200
    And match $.article.title == "Test4"