Feature: Create
         Simple test of creating and storing
         an new app object

         Scenario: Add new Object
                   Given I visit the create page
                   And I fill in 'John' for 'name'
                   And I fill in 'Doe' for 'value'
                   And I fill in '5' for 'numeral'
                   When I press 'submit'
                   Then I should see 'John'
