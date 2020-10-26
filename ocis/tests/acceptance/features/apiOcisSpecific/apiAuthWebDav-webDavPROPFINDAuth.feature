@api
Feature: get file info using PROPFIND

  Background:
    Given user "Alice" has been created with default attributes and without skeleton files
    And user "Alice" has uploaded file with content "some data" to "/textfile0.txt"
    And user "Alice" has created folder "/PARENT"
    And user "Alice" has created folder "/FOLDER"
    And user "Alice" has uploaded file with content "some data" to "/PARENT/parent.txt"
    And user "Brian" has been created with default attributes and without skeleton files

  @issue-ocis-reva-9 @skipOnOcis-EOS-Storage @issue-ocis-reva-303
  # after fixing all issues delete this Scenario and use the one from oC10 core
  Scenario: send PROPFIND requests to another user's webDav endpoints as normal user
    When user "Brian" requests these endpoints with "PROPFIND" to get property "d:getetag" about user "Alice"
      | endpoint                                           |
      | /remote.php/dav/files/%username%/textfile0.txt     |
      | /remote.php/dav/files/%username%/PARENT            |
      | /remote.php/dav/files/%username%/PARENT/parent.txt |
    Then the HTTP status code of responses on all endpoints should be "404"
