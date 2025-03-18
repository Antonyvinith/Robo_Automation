*** Settings ***
Library    RequestsLibrary

*** Variables ***
${BASE_URL}  https://jsonplaceholder.typicode.com

*** Test Cases ***

Retrieve data for user 1 and check the response status code
    Create Session  Session  ${BASE_URL}  verify=True
    ${response}  GET On Session  Session  /users/1
    Status Should Be    200  ${response}

Retrieve data for user 1 and check the response status code
    Create Session  Session  ${BASE_URL}  verify=True
    ${response}  GET On Session  Session  /users/1
    Status Should Be    200  ${response}
    Delete All Sessions








