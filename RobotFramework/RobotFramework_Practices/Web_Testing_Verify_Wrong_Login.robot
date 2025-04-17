*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String

*** Variables ***
${URL}                https://www.saucedemo.com/
${EDGEDRIVER}         C:/Users/antony.vinith/Downloads/msedgedriver.exe
${USERNAME}           standard_user
${PASSWORD}           secret_sauce
${LGN_BTN}            xpath=//input[@id='login-button']




*** Test Cases ***
Verify Invalid Login Shows Error
    Open Browser    ${URL}    Edge    executable_path=${EDGEDRIVER}
    Maximize Browser Window

    Input Text    xpath=//input[@id="user-name"]    invalid_user
    Input Text    xpath=//input[@id="password"]     invalid_pass
    Click Button  ${LGN_BTN}
    Sleep    2s

    Page Should Contain Element    xpath=//h3[@data-test="error"]
    Log To Console    Invalid login error displayed as expected.

    Close Browser
