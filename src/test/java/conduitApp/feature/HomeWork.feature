@debug
Feature: Home Work

  Background: Preconditions
    * url apiUrl


  Scenario: Favorite articles
        # Step 1: Get articles of the global feed
    Given path "articles"
    And params { limit: 10, offset: 0 }
    When method GET
    Then status 200
        # Step 2: Get the favorites count and slug ID for the first article, save it to variables
    * def favorites = $.articles[0].favoritesCount
    * def slugId = $.articles[0].slug
        # Step 3: Make POST request to increse favorites count for the first article
    Given path "articles",slugId,"favorite"
    When method POST
    Then status 200
        # Step 4: Verify response schema
        # Step 5: Verify that favorites article incremented by 1
    Given path "articles"
    And params { limit: 10, offset: 0 }
    When method GET
    Then match $.articles[0].favoritesCount == favorites + 1

        # Step 6: Get all favorite articles
        # Step 7: Verify response schema
        # Step 8: Verify that slug ID from Step 2 exist in one of the favorite articles
    Given path "articles"
    And params { limit: 10, offset: 0 }
    When method GET
    And match $.articles[*].slug contains slugId

  Scenario: Comment articles
        # Step 1: Get articles of the global feed
    Given path "articles"
    And params { limit: 10, offset: 0 }
    When method GET
    Then status 200
        # Step 2: Get the slug ID for the first articles, save it to variable
    * def slugId = $.articles[0].slug
        # Step 3: Make a GET call to 'comments' end-point to get all comments
    Given path "articles",slugId,"comments"
    When method GET
    Then status 200
        # Step 4: Verify response schema
        # Step 5: Get the count of the comments array length and save to variable
            #Example
    * def responseWithComments = $.comments
    * def commentsSize = responseWithComments.length
    * print commentsSize
        # Step 6: Make a POST request to publish a new comment
    Given path "articles",slugId,"comments"
    And request {"comment":{"body":"abc"}}
    When method POST
    Then status 200
        # Step 7: Verify response schema that should contain posted comment text
    And match $.comment.body == "abc"
    * def commentId = $.comment.id
        # Step 8: Get the list of all comments for this article one more time
    Given path "articles",slugId,"comments"
    When method GET
        # Step 9: Verify number of comments increased by 1 (similar like we did with favorite counts)
    Then match response.comments == "#[commentsSize + 1]"
        # Step 10: Make a DELETE request to delete comment
    Given path "articles",slugId,"comments",commentId
    When method DELETE
    Then status 200
        # Step 11: Get all comments again and verify number of comments decreased by 1
    Given path "articles",slugId,"comments"
    When method GET
    Then match response.comments == "#[commentsSize]"