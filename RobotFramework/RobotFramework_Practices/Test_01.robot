*** Settings ***
Library    RequestsLibrary

*** Variables ***
${BASE_URL}    https://reqres.in/api

*** Test Cases ***
Retrieve data for user 2 and check the response status code
    Create Session    Session    ${BASE_URL}    verify=True
    ${response}    GET On Session    Session    /users/2
    Status Should Be    200    ${response}
    Log To Console    ${response.json()}
    Delete All Sessions
