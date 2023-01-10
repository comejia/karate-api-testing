Feature: Test for the home page

  Background:
    Given url "https://conduit.productionready.io/api/"

  Scenario: Get all tags
    #Given url "https://conduit.productionready.io/api/"
    Given path "tags"
    When method GET
    Then status 200
    And match response.tags contains ['introduction', "et"]
    And match response.tags !contains "car"
    And match response.tags == "#array"
    And match each response.tags == "#string"

  Scenario: Get 10 articles from the page
    #Given url "https://conduit.productionready.io/api/"
    Given path "articles"
    And params { limit: 10, offset: 0 }
    #And param limit = 10
    #And param offset = 0
    When method GET
    Then status 200
    And match response.articles == "#[10]"
    And match response.articlesCount == 197