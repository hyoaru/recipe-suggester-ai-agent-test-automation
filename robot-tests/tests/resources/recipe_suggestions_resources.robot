*** Settings ***
Documentation    Resource for recipe suggestion test suite
Library    SeleniumLibrary
Resource    ../variables/base.robot


*** Keywords ***
OpenRecipeSuggestionsPage
    Open Browser    ${GLOBAL_CLIENT_BASE_URL}/    chrome
    Maximize Browser Window