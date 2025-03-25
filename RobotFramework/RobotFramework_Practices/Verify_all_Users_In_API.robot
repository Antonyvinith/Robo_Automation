*** Settings ***
Library  RequestsLibrary
Library  Collections
Test Setup  Create Session  Session  ${BASE_URL}  verify=true
Test Teardown  Delete All Sessions

*** Variables ***
${BASE_URL}=  https://jsonplaceholder.typicode.com
@{EXPECTED_NAMES}
...    Leanne Graham
...    Ervin Howell
...    Clementine Bauch
...    Patricia Lebsack
...    Chelsey Dietrich
...    Mrs. Dennis Schulist
...    Kurtis Weissnat
...    Nicholas Runolfsdottir V
...    Glenna Reichert
...    Clementina DuBuque


*** Test Cases ***
Retrieve Users and Verify all
    ${response}  Get On Session  Session  users
    Status Should be  200  ${response}

    FOR  ${Index}  IN RANGE  10
        ${name}=  Get From Dictionary  ${response.json()}[${Index}]  name
        Should Be Equal   ${name}   ${EXPECTED_NAMES}[${Index}]
    END



