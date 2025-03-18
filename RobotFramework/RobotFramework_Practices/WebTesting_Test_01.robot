*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${EDGEDRIVER}    C:/Users/antony.vinith/Downloads/msedgedriver.exe
${URL}          https://www.saucedemo.com/
${USERNAME}     standard_user
${PASSWORD}     secret_sauce
${LGN_BTN}      xpath=//input[@Id="login-button"]


*** Test Cases ***
Open Website in Edge
    Open Browser    ${URL}   Edge    executable_path=${EDGEDRIVER}
    Title Should Be    Swag Labs
    Input text         id=user-name   ${USERNAME}
    Input text         id=password   ${PASSWORD}
    Click button       ${LGN_BTN}


