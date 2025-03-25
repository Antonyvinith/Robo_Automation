*** Settings ***
Library    SeleniumLibrary
Library    Collections

*** Variables ***
${EDGEDRIVER}                   C:/Users/antony.vinith/Downloads/msedgedriver.exe
${URL}                          https://www.saucedemo.com/
${USERNAME}                     standard_user
${PASSWORD}                     secret_sauce
${LGN_BTN}                      xpath=//input[@Id="login-button"]
${Products}                     xpath=//div[@class="inventory_item"]
${Actual_Product_Count}         6
${Cart_BTN}                     .//*[contains(text(), "Add to cart")]
${FILTER_DROPDOWN}              xpath=//select[@class="product_sort_container"]
${LOW_TO_HIGH_FILTER}           xpath=//option[@value="lohi"]
${PRODUCT_PRICES}               xpath=//div[@class="inventory_item_price"]
${PRODUCT_NAMES}                xpath=//div[@class="inventory_item_name "]



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



Verify Price -low to high Filter
    Open Browser    ${URL}   Edge    executable_path=${EDGEDRIVER}
    Input text         xpath=//input[@id="user-name"]   ${USERNAME}
    Input text         xpath=//input[@id="password"]   ${PASSWORD}
    Click button       ${LGN_BTN}
    Wait Until Page Contains Element  ${FILTER_DROPDOWN}    timeout=5s


    Select From List By Value    ${FILTER_DROPDOWN}    lohi
    Wait Until Page Contains Element  ${PRODUCT_PRICES}    timeout=5s


    ${prices}=    Get WebElements    ${PRODUCT_PRICES}
    ${price_list}=    Create List

    FOR    ${price}    IN    @{prices}
        ${price_text}=    Get Text    ${price}
        ${price_number}=    Evaluate    float('${price_text}'.replace('$', ''))
        Append To List    ${price_list}    ${price_number}
    END


    ${sorted_prices}=    Evaluate    sorted(${price_list})
    Should Be Equal    ${price_list}    ${sorted_prices}    msg=Prices are not sorted in ascending order

    Log To Console    "Prices are sorted in ascending order: ${price_list}"
    Close Browser


Verify Prices - High to Low Filter
    Open Browser    ${URL}   Edge    executable_path=${EDGEDRIVER}
    Input text         xpath=//input[@id="user-name"]   ${USERNAME}
    Input text         xpath=//input[@id="password"]   ${PASSWORD}
    Click button       ${LGN_BTN}
    Wait Until Page Contains Element  ${FILTER_DROPDOWN}    timeout=5s


    Select From List By Value    ${FILTER_DROPDOWN}    hilo
    Wait Until Page Contains Element  ${PRODUCT_PRICES}    timeout=5s


    ${prices}=    Get WebElements    ${PRODUCT_PRICES}
    ${price_list}=    Create List

    FOR    ${price}    IN    @{prices}
        ${price_text}=    Get Text    ${price}
        ${price_number}=    Evaluate    float('${price_text}'.replace('$', ''))
        Append To List    ${price_list}    ${price_number}
    END


    ${sorted_prices}=    Evaluate    sorted(${price_list} , reverse=True)
    Should Be Equal    ${price_list}    ${sorted_prices}    msg=Prices are not sorted in descending order

    Log To Console    "Prices are sorted in descending order: ${price_list}"
    Close Browser



Verify Product Names - A to Z Filter
    Open Browser    ${URL}    Edge    executable_path=${EDGEDRIVER}
    Maximize Browser Window
    Input Text      xpath=//input[@id="user-name"]    ${USERNAME}
    Input Text      xpath=//input[@id="password"]     ${PASSWORD}
    Click Button    ${LGN_BTN}
    Wait Until Page Contains Element    ${FILTER_DROPDOWN}    timeout=10s

    Log To Console    Login successful, applying A-Z filter...
    Select From List By Value    ${FILTER_DROPDOWN}    az
    Sleep    2s    # Small delay to ensure filter applies
    Wait Until Page Contains Element    ${PRODUCT_NAMES}    timeout=10s

    ${products}=    Get WebElements    ${PRODUCT_NAMES}
    ${products_list}=    Create List

    FOR    ${product}    IN    @{products}
        ${product_name_text}=    Get Text    ${product}
        Append To List    ${products_list}    ${product_name_text}
    END

    ${sorted_products}=    Evaluate    sorted(${products_list})
    Should Be Equal    ${products_list}    ${sorted_products}    msg=Product names are not sorted in ascending order (A-Z)

    Log To Console    "Product names are sorted in ascending order: ${products_list}"
    Close Browser



Verify Product Names - Z to A Filter
   Open Browser    ${URL}    Edge    executable_path=${EDGEDRIVER}
    Maximize Browser Window
    Input Text      xpath=//input[@id="user-name"]    ${USERNAME}
    Input Text      xpath=//input[@id="password"]     ${PASSWORD}
    Click Button    ${LGN_BTN}
    Wait Until Page Contains Element    ${FILTER_DROPDOWN}    timeout=10s

    Log To Console    Login successful, applying A-Z filter...
    Select From List By Value    ${FILTER_DROPDOWN}    za
    Sleep    2s    # Small delay to ensure filter applies
    Wait Until Page Contains Element    ${PRODUCT_NAMES}    timeout=10s

    ${products}=    Get WebElements    ${PRODUCT_NAMES}
    ${products_list}=    Create List

    FOR    ${product}    IN    @{products}
        ${product_name_text}=    Get Text    ${product}
        Append To List    ${products_list}    ${product_name_text}
    END

    ${sorted_products}=    Evaluate    sorted(${products_list}, reverse=True)
    Should Be Equal    ${products_list}    ${sorted_products}    msg=Product names are not sorted in descending order (Z to A)
    Log To Console    "Product names are sorted in descending order: ${products_list}"
    Close Browser