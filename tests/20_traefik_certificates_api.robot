*** Settings ***
Library    SSHLibrary
Resource          api.resource

*** Test Cases ***
Request an invalid certificate
    ${response} =  Run task    module/traefik1/set-certificate
    ...    {"fqdn":"example.com"}

Get invalid cerficate status
    ${response} =  Run task    module/traefik1/get-certificate    {"fqdn": "example.com"}
    Should Be Equal As Strings    ${response['fqdn']}        example.com
    Should Be Equal As Strings    ${response['obtained']}    False

Get certificate list
    ${response} =  Run task    module/traefik1/list-certificates    {}
    Should Contain    ${response}    example.com

Delete certificate
    Run task    module/traefik1/delete-certificate   	 {"fqdn": "example.com"}

Get empty certificates list
    ${response} =  Run task    module/traefik1/list-certificates    {}
    Should Be Empty    ${response}
