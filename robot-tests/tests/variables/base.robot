*** Settings ***
Documentation    Base variables for the entire project
Library    OperatingSystem
Library    ../../load_env.py

*** Variables ***
${GLOBAL_CLIENT_BASE_URL}    ${EMPTY}

*** Keywords ***
InitializeGlobalVariables
    Log    Setting up suite...
    ${client_base_url}=    Get Environment Variable    CLIENT_BASE_URL
    Set Suite Variable    ${GLOBAL_CLIENT_BASE_URL}    ${client_base_url}