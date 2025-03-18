*** Settings ***
Library  RequestsLibrary
Library  Collections
Test Setup  Create Session  Session  ${BASE_URL}  verify=true
Test Teardown   Delete All Sessions

*** Variables ***
${BASE_URL}=  https://jsonplaceholder.typicode.com


*** Test Cases ***

Retrieve User 1 name by using Dictionary
    ${response}=  Get On Session  Session  users/1
    Status should be  200  ${response}
    ${username1}=  Get From Dictionary  ${response.json()}  name
    Should be Equal  ${username1}  Leanne Graham

Retrieve User 3 name by Using Dictionary
    ${response}=  Get On Session  Session  users/3
    Status should be  200  ${response}
    ${username3}=  Get From Dictionary  ${response.json()}  name
    Should be Equal  ${username3}   Clementine Bauch





