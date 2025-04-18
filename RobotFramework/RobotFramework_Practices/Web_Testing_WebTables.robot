*** Settings ***
Library    SeleniumLibrary


*** Variables ***
${URL}                https://demoqa.com/webtables
${EDGEDRIVER}         C:/Users/antony.vinith/Downloads/msedgedriver.exe



*** Test Cases ***
Add Edit Delete Table Entry
    Open Browser    ${URL}    Edge    executable_path=${EDGEDRIVER}
    Maximize Browser Window

    Click Button    id=addNewRecordButton
    Input Text      id=firstName     Antony
    Input Text      id=lastName      Vinith
    Input Text      id=userEmail     antony@gmail.com
    Input Text      id=age           20
    Input Text      id=salary        50000
    Input Text      id=department    QA
    Click Button    id=submit
    Sleep           1s

    Page Should Contain    Antony
    Log To Console         Entry added successfully
    Sleep            10s

    Click Element    xpath=//div[text()='John']/following::span[@title='Edit'][1]
    Sleep            10s
    Input Text       id=department    Automation
    Click Button     id=submit
    Sleep            10s
    Page Should Contain    Automation
    Log To Console         Entry edited successfully
    Sleep            10s

    Click Element    xpath=//div[text()='John']/following::span[@title='Delete'][1]
    Sleep            10s
    Page Should Not Contain    Antony
    Log To Console             Entry deleted successfully

    Close Browser

