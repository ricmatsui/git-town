Feature: git sync: syncing the current non-feature branch (without open changes)

  (see ./with_open_changes.feature)


  Background:
    Given I have branches named "qa" and "production"
    And my non-feature branches are configured as "qa" and "production"
    And I am on the "qa" branch
    And the following commits exist in my repository
      | BRANCH | LOCATION         | MESSAGE       | FILE NAME   |
      | qa     | local            | local commit  | local_file  |
      |        | remote           | remote commit | remote_file |
      | main   | local and remote | main commit   | main_file   |
    When I run `git sync`


  Scenario: no conflict
    Then it runs the Git commands
      | BRANCH | COMMAND              |
      | qa     | git fetch --prune    |
      |        | git rebase origin/qa |
      |        | git push             |
      |        | git push --tags      |
    And I am still on the "qa" branch
    And all branches are now synchronized
    And I have the following commits
      | BRANCH | LOCATION         | MESSAGE       | FILE NAME   |
      | main   | local and remote | main commit   | main_file   |
      | qa     | local and remote | remote commit | remote_file |
      |        |                  | local commit  | local_file  |
