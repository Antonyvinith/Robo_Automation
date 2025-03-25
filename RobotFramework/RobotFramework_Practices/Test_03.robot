*** Settings ***
Library    RequestsLibrary


*** Variables ***
${BASE_URL}=  https://jsonplaceholder.typicode.com


*** Test Cases ***
Retrieve data and verify Count of the attributes in the User
    Create Session  Session  ${BASE_URL}    verify=true
    ${response}=  GET On Session  Session  users/3
    ${json_dict}=  Set Variable  ${response.json()}
    ${key_count}=  Evaluate  len($json_dict)
    Should be Equal as Numbers  ${key_count}  8
