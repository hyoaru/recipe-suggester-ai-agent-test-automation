*** Settings ***
Documentation    Test suite for recipe suggestion functionality
Library    Browser
Resource    ../resources/recipe_suggestions_resources.robot
Suite Setup    Initialize


*** Variables ***
${SUITE_LOCATOR_INGREDIENTS_INPUT}    //input[@placeholder='Type and press space to add ingredients']
${SUITE_LOCATOR_SUGGEST_RECIPE_BUTTON}    //*[local-name()='svg' and @class='lucide lucide-sparkles']/parent::button
${SUITE_LOCATOR_SUGGESTED_RECIPES_CONTAINER}    //div[@id='header']/following-sibling::div
${SUITE_LOCATOR_INPUTTED_INGREDIENTS_CONTAINER}    //input[@placeholder='Type and press space to add ingredients']/preceding-sibling::div

*** Keywords ***
Initialize
    Initialize Global Variables


*** Test Cases ***
Add Ingredients and Generate Suggestions
    [Tags]    Smoke    Positive
    Open Recipe Suggestions Page

    Log    Inputing ingredients...
    @{ingredients}    Create List    egg    buttter
    FOR    ${ingredient}    IN    @{ingredients}
        Fill Text    ${SUITE_LOCATOR_INGREDIENTS_INPUT}    ${ingredient}
        Press Keys    ${SUITE_LOCATOR_INGREDIENTS_INPUT}    Space
    END
    Log    Ingredients entered.
    
    Log    Generating recipe suggestions...
    Click    ${SUITE_LOCATOR_SUGGEST_RECIPE_BUTTON}
    Log    Generated recipe suggestions.

    ${recipe_suggestions}=    Get Elements    ${SUITE_LOCATOR_SUGGESTED_RECIPES_CONTAINER}/child::*[1]
    Should Not Be Empty    ${recipe_suggestions}
    Log    Capturing screenshots of generated suggestions...
    FOR    ${index}    ${recipe_suggestion}    IN ENUMERATE    @{recipe_suggestions}
        Take Screenshot    generated_recipe_suggestion_${index}    ${recipe_suggestion}
    END
    Log    Generated suggestions screenshots captured.

    Close Browser

Empty Input Validation
    [Tags]    Negative    InputValidation
    Open Recipe Suggestions Page
    
    Log    Verifying input validation...
    Clear Text    ${SUITE_LOCATOR_INGREDIENTS_INPUT}
    Log    Cleared ingredients input value
    
    Log    Entering space character using spacebar to the input...
    Focus    ${SUITE_LOCATOR_INGREDIENTS_INPUT}
    Press Keys    ${SUITE_LOCATOR_INGREDIENTS_INPUT}    Space
    Log    Space character entered.
    
    Log    Validating that no ingredient was added...
    Take Screenshot    no_ingredient_added
    ${inputted_ingredients}=    Get Elements    ${SUITE_LOCATOR_INPUTTED_INGREDIENTS_CONTAINER}/child::*
    Should Be Empty    ${inputted_ingredients}
    Log    Validated no ingredient was added.
    
    Close Browser
    
# Numeric Input Validation
#     [Tags]    Negative    InputValidation
#     Open Recipe Suggestions Page
    
#     Log    Waiting for input to be present in the DOM...
#     Wait Until Page Contains Element    ${SUITE_LOCATOR_INGREDIENTS_INPUT}    timeout=5s
#     Log    Input is present.
    
#     Log    Verifying input validation for numeric values...
#     Clear Element Text    ${SUITE_LOCATOR_INGREDIENTS_INPUT}
#     Input Text    ${SUITE_LOCATOR_INGREDIENTS_INPUT}    12345
#     Press Keys    ${SUITE_LOCATOR_INGREDIENTS_INPUT}    SPACE
#     Capture Page Screenshot    numeric_input_validation.png
#     ${inputted_ingredients}=    Get WebElements    ${SUITE_LOCATOR_INPUTTED_INGREDIENTS_CONTAINER}/child::*
#     Should Be Empty    ${inputted_ingredients}
#     Log    Numeric values are correctly rejected

#     Close Browser

# Exceeding Character Limit Input Validation
#     [Tags]    Negative    InputValidation
#     Open Recipe Suggestions Page
    
#     Log    Waiting for input to be present in the DOM...
#     Wait Until Page Contains Element    ${SUITE_LOCATOR_INGREDIENTS_INPUT}    timeout=5s
#     Log    Input is present.

#     Log    Verifying input validation for exceeding character limit...
#     Clear Element Text    ${SUITE_LOCATOR_INGREDIENTS_INPUT}
#     ${long_ingredient}=    Evaluate    "a" * 256
#     Input Text    ${SUITE_LOCATOR_INGREDIENTS_INPUT}    ${long_ingredient}
#     Press Keys    ${SUITE_LOCATOR_INGREDIENTS_INPUT}    SPACE
#     Capture Page Screenshot    exceeding_character_limit_input_validation.png
#     ${inputted_ingredients}=    Get WebElements    ${SUITE_LOCATOR_INPUTTED_INGREDIENTS_CONTAINER}/child::*
#     Should Be Empty    ${inputted_ingredients}
#     Log    Exceeding character limit is correctly rejected
    
#     Close Browser

# Special Characters Input Validation
#     [Tags]    Negative    InputValidation
#     Open Recipe Suggestions Page
    
#     Log    Waiting for input to be present in the DOM...
#     Wait Until Page Contains Element    ${SUITE_LOCATOR_INGREDIENTS_INPUT}    timeout=5s
#     Log    Input is present.
    
#     Log    Verifying input validation for special characters...
#     Clear Element Text    ${SUITE_LOCATOR_INGREDIENTS_INPUT}
#     Input Text    ${SUITE_LOCATOR_INGREDIENTS_INPUT}    !@#$%^&*
#     Press Keys    ${SUITE_LOCATOR_INGREDIENTS_INPUT}    SPACE
#     Capture Page Screenshot    special_characters_input_validation.png
#     ${inputted_ingredients}=    Get WebElements    ${SUITE_LOCATOR_INPUTTED_INGREDIENTS_CONTAINER}/child::*
#     Should Be Empty    ${inputted_ingredients}
#     Log    Special characters are correctly rejected
    
#     Close Browser