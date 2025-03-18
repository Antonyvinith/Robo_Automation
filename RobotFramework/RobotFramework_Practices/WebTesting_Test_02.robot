*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${EDGEDRIVER}                   C:/Users/antony.vinith/Downloads/msedgedriver.exe
${URL}                          https://www.saucedemo.com/
${USERNAME}                     standard_user
${PASSWORD}                     secret_sauce
${LGN_BTN}                      xpath=//input[@Id="login-button"]
${Products}                     xpath=//div[@class="inventory_item"]
${Actual_Product_Count}         6
${Cart_BTN}                     .//*[contains(text(), "Add to cart")]


*** Test Cases ***

#Open Website in Edge and Login Sucessfully
#    Open Browser    ${URL}   Edge    executable_path=${EDGEDRIVER}
#    Input text         id=user-name   ${USERNAME}
#    Input text         id=password   ${PASSWORD}
#    Click button       ${LGN_BTN}
#    Title Should Be    Swag Labs
#    Close Browser


Navigate to Products Section after navigation Verify the Count of the Products
    Open Browser    ${URL}   Edge    executable_path=${EDGEDRIVER}
    Input text         id=user-name   ${USERNAME}
    Input text         id=password   ${PASSWORD}
    Click button       ${LGN_BTN}
    Wait Until Page Contains Element  ${Products}    timeout=5s
    ${Product_Count}=  Get Element Count  ${Products}
    Should be Equal As Numbers  ${Product_Count}  ${Actual_Product_Count}
    Log To Console   "The Count of Products are: ${Product_Count}"
    Close Browser


Verify the Add to Cart Button is Present for all the Products
    Open Browser    ${URL}   Edge    executable_path=${EDGEDRIVER}
    Input text         id=user-name   ${USERNAME}
    Input text         id=password   ${PASSWORD}
    Click button       ${LGN_BTN}
    Wait Until Page Contains Element   ${Products}   timeout=5s

    ${Product_Elements}=  Get WebElements   ${Products}

    ${product_count}=  Get Length   ${Product_Elements}
    Log To Console    "Total Products Found: ${product_count}"

    FOR  ${Product}  IN  @{Product_Elements}
        ${button_present}=   Run Keyword And Return Status   Element Should Be Visible   xpath=.//button[contains(text(), "Add to cart")]   parent=${Product}
        Should Be True   ${button_present}    msg=Each product must have an 'Add to Cart' button
    END

    Log To Console    "Verified all ${product_count} products contain an 'Add to Cart' button."
    Close Browser


