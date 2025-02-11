*** Settings ***
Documentation    Resource for recipe suggestion test suite
Library    SeleniumLibrary
Resource    ../variables/base.robot
Resource    ./helpers.robot

*** Keywords ***
Open Recipe Suggestions Page
    Open Browser And Maximize    ${GLOBAL_CLIENT_BASE_URL}/    chrome
    Maximize Browser Window