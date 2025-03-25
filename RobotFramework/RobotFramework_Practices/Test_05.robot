*** Settings ***
Library  RequestsLibrary
Library  Collections
Test Setup  Create Session  Session  ${BASE_URL}  verify=true
Test Teardown  Delete All Sessions

*** Variables ***
${BASE_URL}=  https://jsonplaceholder.typicode.com


*** Test Cases ***
Retrieve User 1 and Verify the name
    ${response}=  Get On Session  Session  users/1
    Verify the name and the status of the API   ${response}  200  Leanne Graham

Retrieve User 8 and Verify the name
    ${response}=  Get on Session  Session  users/8
    Verify the name and the status of the API  ${response}  200  Nicholas Runolfsdottir V



*** Keywords ***
Verify the name and the status of the API
    [Arguments]   ${response}  ${expected_status_code}  ${expected_name}
    Status Should be  ${expected_status_code}  ${response}
    ${name}=  Get From Dictionary  ${response.json()}  name
    Should be Equal  ${name}  ${expected_name}


