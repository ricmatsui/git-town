Feature: git extract: extracting a single commit (with open changes and without remote origin)

  (see ../../multiple_commits/with_remote_origin/with_open_changes.feature)


  Background:
    Given I have a feature branch named "feature"
    And my repo does not have a remote origin
    And the following commits exist in my repository
      | BRANCH  | LOCATION | MESSAGE         | FILE NAME     |
      | main    | local    | main commit     | main_file     |
      | feature | local    | feature commit  | feature_file  |
      |         |          | refactor commit | refactor_file |
    And I am on the "feature" branch
    And I have an uncommitted file with name: "uncommitted" and content: "stuff"
    When I run `git extract refactor` with the last commit sha


  Scenario: result
    Then it runs the Git commands
      | BRANCH   | COMMAND                                      |
      | feature  | git stash -u                                 |
      |          | git checkout main                            |
      | main     | git checkout -b refactor main                |
      | refactor | git cherry-pick <%= sha 'refactor commit' %> |
      |          | git stash pop                                |
    And I end up on the "refactor" branch
    And I still have an uncommitted file with name: "uncommitted" and content: "stuff"
    And I have the following commits
      | BRANCH   | LOCATION | MESSAGE         | FILE NAME     |
      | main     | local    | main commit     | main_file     |
      | feature  | local    | feature commit  | feature_file  |
      |          |          | refactor commit | refactor_file |
      | refactor | local    | main commit     | main_file     |
      |          |          | refactor commit | refactor_file |
