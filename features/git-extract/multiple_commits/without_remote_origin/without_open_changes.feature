Feature: git extract: extracting multiple commits (without open changes or remote repo)

  (see ../with_remote_origin/with_open_changes.feature)


  Background:
    Given I have a feature branch named "feature"
    And my repo does not have a remote origin
    And the following commits exist in my repository
      | BRANCH  | LOCATION | MESSAGE          | FILE NAME      |
      | main    | local    | main commit      | main_file      |
      | feature | local    | feature commit   | feature_file   |
      |         |          | refactor1 commit | refactor1_file |
      |         |          | refactor2 commit | refactor2_file |
    And I am on the "feature" branch
    When I run `git extract refactor` with the last two commit shas


  Scenario: result
    Then it runs the Git commands
      | BRANCH   | COMMAND                                                                     |
      | feature  | git checkout main                                                           |
      | main     | git checkout -b refactor main                                               |
      | refactor | git cherry-pick <%= sha 'refactor1 commit' %> <%= sha 'refactor2 commit' %> |
    And  I end up on the "refactor" branch
    And I have the following commits
      | BRANCH   | LOCATION | MESSAGE          | FILE NAME      |
      | main     | local    | main commit      | main_file      |
      | feature  | local    | feature commit   | feature_file   |
      |          |          | refactor1 commit | refactor1_file |
      |          |          | refactor2 commit | refactor2_file |
      | refactor | local    | main commit      | main_file      |
      |          |          | refactor1 commit | refactor1_file |
      |          |          | refactor2 commit | refactor2_file |
