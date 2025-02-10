*** Settings ***
Documentation    Test suite for recipe suggestion functionality
Library    SeleniumLibrary
Resource    ../resources/recipe_suggestions_resources.robot
Suite Setup    Initialize

*** Variables ***
@{INGREDIENTS}    egg    butter

*** Test Cases ***
ValidIngredientsInput
    [Tags]    Smoke    Positive
    Open Recipe Suggestions Page


*** Keywords ***
Initialize
    Initialize Global Variables

    
