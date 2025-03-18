*** Settings ***
Library    RequestsLibrary

*** Variables ***
${BASE_URL}=  https://jsonplaceholder.typicode.com
${User_Id}=  3
${User_Name}=  Clementine Bauch

*** Test Cases ***
Retrieve data and verify name
    Create Session  Session  ${BASE_URL}  verify=true
    ${response}=  GET On Session  Session  users/${User_Id}
    Should be Equal as Strings  ${response.json()['name']}  ${User_Name}

Retrieve data and verify name for User 3
    Create Session  Session  ${BASE_URL}  verify=true
    ${response}=  GET On Session  Session  users/3
    Should be Equal as Strings  ${response.json()['name']}  ${User_Name}
