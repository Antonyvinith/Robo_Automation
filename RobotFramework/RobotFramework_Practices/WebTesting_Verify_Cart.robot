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
${ADD_TO_CART_BTN}    xpath=//button[@id='add-to-cart-sauce-labs-backpack']
${CART_ICON}          xpath=//span[@class='shopping_cart_badge']
${CART_LINK}          xpath=//a[@class='shopping_cart_link']
${PRODUCT_IN_CART}    xpath=//div[@class='inventory_item_name' and text()='Sauce Labs Backpack']

*** Test Cases ***
Verify Product Added to Cart
    Open Browser    ${URL}    Edge    executable_path=${EDGEDRIVER}
    Maximize Browser Window

    Input Text      xpath=//input[@id="user-name"]    ${USERNAME}
    Input Text      xpath=//input[@id="password"]     ${PASSWORD}
    Click Button    ${LGN_BTN}
    Sleep    2s
    Log To Console    Login successful.

    ${cart_count_initial}=    Run Keyword And Return Status    Element Should Not Be Visible    ${CART_ICON}
    Log To Console    Initial cart state checked: No items expected.

    Click Button    ${ADD_TO_CART_BTN}
    Sleep    5s
    Log To Console    Product added to cart.

    Wait Until Element Is Visible    ${CART_ICON}    timeout=10s
    ${cart_count}=    Get Text    ${CART_ICON}
    Should Be Equal As Strings    ${cart_count}    1    msg=Cart count did not update to 1 after adding product
    Log To Console    Cart count updated: ${cart_count}

    Click Element    ${CART_LINK}
    Sleep    5s
    Wait Until Page Contains Element    ${PRODUCT_IN_CART}    timeout=10s
    Log To Console    Product 'Sauce Labs Backpack' found in cart.

    Close Browser