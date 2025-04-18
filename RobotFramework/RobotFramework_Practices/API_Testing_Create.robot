*** Settings ***
Library    RequestsLibrary

*** Variables ***
${BASE_URL}    https://reqres.in

*** Test Cases ***
Create User
    Create Session    mysession    ${BASE_URL}

    ${payload}=    Create Dictionary    name=Antony Vinith    job=Engineer

    ${response}=    Post Request    mysession    /api/users    json=${payload}
    Status Should Be    201    ${response}

    ${body}=    To JSON    ${response.content}
    Should Contain    ${body}    name
    Should Contain    ${body}    job
    Log To Console    \nUser created successfully: ${body}
