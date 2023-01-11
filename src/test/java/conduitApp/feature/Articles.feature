#@debug
Feature: Articles

  Background:
    Given url apiUrl
    #Given path "users/login"
    #And request {"user": {"email": "debi@gmail.com", "password": "debi"}}
    #When method post
    #Then status 200
    #* def token = response.user.token
    #* def tokenResponse = call read("classpath:helpers/CreateToken.feature")
    #* def tokenResponse = callonce read("classpath:helpers/CreateToken.feature")
      #{"email": "debi@gmail.com", "password": "debi"}
    #* def token = tokenResponse.authToken

  #@ignore
  Scenario: Create a new article
    #Given header Authorization = "Token " + token
    Given path "articles"
    And request {"article":{"tagList":[],"title":"Test5","description":"test","body":"test"}}
    When method post
    Then status 200
    And match $.article.title == "Test5"

  @debug
  Scenario: Create and delete article
    #Given header Authorization = "Token " + token
    Given path "articles"
    And request {"article":{"tagList":[],"title":"Delete","description":"test","body":"test"}}
    When method post
    Then status 200
    * def articleId = $.article.slug

    Given path "articles"
    #Given header Authorization = "Token " + token
    And params { limit: 10, offset: 0 }
    When method GET
    Then status 200
    And match response.articles[0].title == "Delete"

    #Given header Authorization = "Token " + token
    And path "articles",articleId
    When method delete
    Then status 204

    Given path "articles"
    #Given header Authorization = "Token " + token
    And params { limit: 10, offset: 0 }
    When method GET
    Then status 200
    And match response.articles[0].title != "Delete"