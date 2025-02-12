*** Settings ***
Documentation    Resource for recipe suggestion test suite
Library    Browser
Resource    ../variables/base.robot

*** Keywords ***
Open Recipe Suggestions Page
    New Browser    chromium
    New Page    ${GLOBAL_CLIENT_BASE_URL}/