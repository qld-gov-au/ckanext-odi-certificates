@smoke
Feature: ODI Certificates

    Scenario: DQL-67 Add Salsa organisation
        Given "Admin" as the persona
        When I log in
        Then I go to add new organisation
        When I fill in "title" with "Salsa Digital"
        When I press "save"

    Scenario: DQL-67 Add datset with ODI certificate
        Given "Admin" as the persona
        When I log in
        Then I create a dataset with title "Youth Justice - Young offenders in youth detention" and notes "A description"

    Scenario: DQL-67 Add datset with ODI certificate
        Given "Admin" as the persona
        When I log in
        Then I create a dataset with title "Test dataset without ODI certificate" and notes "A description"

    Scenario: DQL-67 BDD-1 Check ODI certificate exists
        When I go to dataset "youth-justice-young-offenders-in-youth-detention"
        Then the element with the css selector "#odi_certificates" should be visible within 10 seconds
        Then I should see "Open Data Certificate Awarded" within 10 seconds
        Then I take a screenshot

    Scenario: DQL-67 BDD-2 Check ODI certificate does NOT exist
        When I go to dataset "test-dataset-without-odi-certificate"
        Then the element with the css selector "#odi_certificates" should not be visible within 10 seconds
        Then I should not see "Open Data Certificate Awarded" within 10 seconds
