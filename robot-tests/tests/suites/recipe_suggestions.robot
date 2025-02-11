*** Settings ***
Documentation    Test suite for recipe suggestion functionality
Library    SeleniumLibrary
Resource    ../resources/recipe_suggestions_resources.robot
Suite Setup    Initialize


*** Variables ***
${SUITE_LOCATOR_INGREDIENTS_INPUT}    xpath://input[@placeholder='Type and press space to add ingredients']
${SUITE_LOCATOR_SUGGEST_RECIPE_BUTTON}    xpath://*[local-name()='svg' and @class='lucide lucide-sparkles']/parent::button
${SUITE_LOCATOR_SUGGESTED_RECIPES_CONTAINER}    xpath://div[@id='header']/following-sibling::div
${SUITE_LOCATOR_INPUTTED_INGREDIENTS_CONTAINER}    xpath://input[@placeholder='Type and press space to add ingredients']/preceding-sibling::div

*** Keywords ***
Initialize
    Initialize Global Variables


*** Test Cases ***
Add Ingredients and Generate Suggestions
    [Tags]    Smoke    Positive
    Open Recipe Suggestions Page

    Log    Waiting for page to load...
    Set Selenium Implicit Wait    5s
    Log    Page loaded.
    
    Log    Inputing ingredients...
    @{ingredients}    Create List    egg    buttter
    FOR    ${ingredient}    IN    @{ingredients}
        Input Text    ${SUITE_LOCATOR_INGREDIENTS_INPUT}    ${ingredient}
        Press Keys    ${SUITE_LOCATOR_INGREDIENTS_INPUT}    SPACE
    END
    Log    Ingredients entered.
    
    Log    Generating recipe suggestions...
    Click Element    ${SUITE_LOCATOR_SUGGEST_RECIPE_BUTTON}
    Wait Until Page Contains Element    ${SUITE_LOCATOR_SUGGESTED_RECIPES_CONTAINER}/child::*    timeout=30s
    Log    Generated recipe suggestions.

    ${recipe_suggestions}=    Get WebElements    ${SUITE_LOCATOR_SUGGESTED_RECIPES_CONTAINER}/child::*
    Should Not Be Empty    ${recipe_suggestions}
    Log    Capturing screenshots of generated suggestions...
    FOR    ${index}    ${recipe_suggestion}    IN ENUMERATE    @{recipe_suggestions}
        Capture Element Screenshot    ${recipe_suggestion}    ./screenshots/generated_recipe_suggestion_${index}.png
    END
    Log    Generated suggestions screenshots captured.

    Close Browser

Empty Input Validation
    [Tags]    Negative    InputValidation
    Open Recipe Suggestions Page
    
    Log    Verifying input validation...
    Clear Element Text    ${SUITE_LOCATOR_INGREDIENTS_INPUT}
    Log    Cleared ingredients input value
    
    Log    Entering space character using spacebar to the input...
    Set Focus To Element    ${SUITE_LOCATOR_INGREDIENTS_INPUT}
    Press Keys    ${SUITE_LOCATOR_INGREDIENTS_INPUT}    SPACE
    Log    Space character entered.
    
    Log    Validating that no ingredient was added...
    ${inputted_ingredients}=    Get WebElements    ${SUITE_LOCATOR_INPUTTED_INGREDIENTS_CONTAINER}/child::*
    Should Be Empty    ${inputted_ingredients}
    Log    Validated no ingredient was added.
    
    Close Browser
