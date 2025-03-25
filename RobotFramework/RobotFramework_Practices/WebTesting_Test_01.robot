*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn
*** Variables ***
${EDGEDRIVER}    C:/Users/antony.vinith/Downloads/msedgedriver.exe
${URL}          https://www.saucedemo.com/
${USERNAME}     standard_user
${PASSWORD}     secret_sauce
${LGN_BTN}      xpath=//input[@Id="login-button"]
${INVALID_USER}  invalid_user
${PASSWORD}      wrong_password
${ERROR_MSG}            xpath=//h3[contains(text(), "Epic sadface")]
${SORT_DROPDOWN}        xpath=//select[@class="product_sort_container"]
${PRODUCT_PRICES}          xpath=//div[@class="inventory_item_price"]
${price_list}               Create List



*** Test Cases ***
Open Website in Edge
    Open Browser    ${URL}   Edge    executable_path=${EDGEDRIVER}
    Title Should Be    Swag Labs
    Input text         id=user-name   ${USERNAME}
    Input text         id=password   ${PASSWORD}
    Click button       ${LGN_BTN}


Verify Invalid Login Attempt
    Open Browser    ${URL}   Edge    executable_path=${EDGEDRIVER}
    Input Text      id=user-name    ${INVALID_USER}
    Input Text      id=password     ${PASSWORD}
    Click Button    ${LGN_BTN}
    Wait Until Element Is Visible   ${ERROR_MSG}    timeout=10s
    Wait Until Element Contains  ${ERROR_MSG}    Epic sadface: Username and password do not match any user in this service
    Log To Console    "Invalid login test passed - Error message displayed correctly."
    Close Browser


