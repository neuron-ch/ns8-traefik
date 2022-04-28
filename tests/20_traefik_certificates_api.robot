*** Settings ***
Library    SSHLibrary
Resource          api.resource

*** Test Cases ***

Set ACME server url to Let's Encrypt Staging
    ${response} =  Run task    module/traefik1/set-acme-server
    ...    {"url":"https://acme-staging-v02.api.letsencrypt.org/directory"}

Get configured ACME server
    ${response} =  Run task    module/traefik1/get-acme-server    {}
    Should Be Equal As Strings    ${response['url']}        https://acme-staging-v02.api.letsencrypt.org/directory

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
