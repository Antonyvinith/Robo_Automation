*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}           https://www.demoblaze.com/
${BROWSER}       Chrome
${USERNAME}      Antony
${PASSWORD}      password123
${EMAIL}         testuser@example.com

*** Test Cases ***
Register And Login
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

    # Register
    Click Element    xpath=//a[text()='Sign up']
    Sleep     5s
    Input Text       id=sign-username    ${USERNAME}
    Input Text       id=sign-password    ${PASSWORD}
    Sleep      5s
    Click Button     xpath=//button[text()='Sign up']
    Sleep            5s

    Page Should Contain    Welcome

    # Login
    Click Element    xpath=//a[text()='Log in']
    Input Text       id=username    ${USERNAME}
    Input Text       id=password    ${PASSWORD}
    Click Button     xpath=//button[text()='Log in']
    Sleep            2s

    Page Should Contain    Welcome

    Close Browser
