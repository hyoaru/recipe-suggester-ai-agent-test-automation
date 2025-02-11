*** Settings ***
Documentation    Helper keywords for the project
Library    SeleniumLibrary


*** Keywords ***
Open Browser And Maximize
    [Arguments]    ${url}    ${browser}
    Open Browser    ${url}    ${browser}
    Maximize Browser Window