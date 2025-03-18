*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    String
Test Setup  Create Session  Session  ${BASE_URL}  verify=true
Test Teardown  Delete All Sessions



*** Variables ***
${BASE_URL}    https://jsonplaceholder.typicode.com
${EMAIL_REGEX}  ^[a-zA-Z0-9._%+-]+@[a-zA-Z.-]+\.[a-zA-Z]{2,}$
@{EXPECTED_ATTRIBUTES}
...  name
...  username
...  email
...  address
...  phone
...  website
...  company




*** Test Cases ***
Retrive Users and Verify the Email Formats
    ${response}=  Get On Session  Session  users
    Status Should be  200  ${response}
    ${users}=  Set Variable   ${response.json()}
    FOR  ${user}   IN   @{users}
        ${email}=  Get From Dictionary   ${user}   email
        Should match Regexp   ${email}   ${EMAIL_REGEX}
    END



Retrieve Users and Verify all the Attributes are present
    ${response}=    Get On Session    Session    users
    Status Should Be    200    ${response}
    ${users}=    Set Variable    ${response.json()}

    FOR  ${User}  IN  @{Users}
        FOR  ${attribute}  IN   @{EXPECTED_ATTRIBUTES}
            Dictionary Should Contain Key  ${User}  ${attribute}
        END
    END





Verify the attributes are not Empty
    ${response}=    Get On Session    Session    users
    Status Should Be    200    ${response}
    ${Users}=  Set Variable  ${response.json()}

    FOR    ${user}    IN    @{users}
        FOR    ${attribute}    IN    @{EXPECTED_ATTRIBUTES}
            ${value}=    Get From Dictionary    ${user}    ${attribute}
            Should Not Be Empty    ${value}    ${attribute} is empty
        END
    END


Verify the attribute ID is not Empty
    ${response}=    Get On Session    Session    users
    Status Should Be    200    ${response}
     ${Users}=  Set Variable  ${response.json()}

    FOR    ${User}    IN    @{Users}
         Should Not Be Equal    ${user["id"]}    ${EMPTY}    User ID is empty for ${user["name"]}
        Should Not Be Equal    ${user["id"]}    0    User ID is zero for ${user["name"]}
    END
