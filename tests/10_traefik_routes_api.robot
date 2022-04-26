*** Settings ***
Library    SSHLibrary
Resource          api.resource

*** Test Cases ***
Create a path rule
    ${response} =  Run task    module/traefik1/set-route
    ...    {"instance": "module1", "url": "http://127.0.0.0:2000", "path": "/foo", "lets_encrypt": false, "http2https": true}

Create a host rule
    ${response} =  Run task    module/traefik1/set-route
    ...    {"instance": "module2", "url": "http://127.0.0.0:2000", "host": "foo.example.org", "lets_encrypt": true, "http2https": true}

Create a host & path rule
    ${response} =  Run task    module/traefik1/set-route
    ...    {"instance": "module3", "url": "http://127.0.0.0:2000", "host": "bar.example.org", "path": "/bar", "lets_encrypt": true, "http2https": true}

Get path route
    ${response} =  Run task    module/traefik1/get-route    {"instance": "module1"}
    Should Be Equal As Strings    ${response['instance']}        module1
    Should Be Equal As Strings    ${response['path']}            /foo
    Should Be Equal As Strings    ${response['url']}              http://127.0.0.0:2000
    Should Be Equal As Strings    ${response['lets_encrypt']}    False
    Should Be Equal As Strings    ${response['http2https']}      True
    Should Be Equal As Strings    ${response['strip_prefix']}    False

Get host route
    ${response} =  Run task    module/traefik1/get-route    {"instance": "module2"}
    Should Be Equal As Strings    ${response['instance']}        module2
    Should Be Equal As Strings    ${response['host']}            foo.example.org
    Should Be Equal As Strings    ${response['url']}             http://127.0.0.0:2000
    Should Be Equal As Strings    ${response['lets_encrypt']}    True
    Should Be Equal As Strings    ${response['http2https']}      True

Get host & path route
    ${response} =  Run task    module/traefik1/get-route    {"instance": "module3"}
    Should Be Equal As Strings    ${response['instance']}        module3
    Should Be Equal As Strings    ${response['path']}            /bar
    Should Be Equal As Strings    ${response['host']}            bar.example.org
    Should Be Equal As Strings    ${response['url']}              http://127.0.0.0:2000
    Should Be Equal As Strings    ${response['lets_encrypt']}    True
    Should Be Equal As Strings    ${response['http2https']}      True
    Should Be Equal As Strings    ${response['strip_prefix']}    False

Get routes list
    ${response} =  Run task    module/traefik1/list-routes    {}
    Should Contain    ${response}    module1
    Should Contain    ${response}    module2
    Should Contain    ${response}    module3

Delete routes
    Run task    module/traefik1/delete-route   	 {"instance": "module1"}
    Run task    module/traefik1/delete-route   	 {"instance": "module2"}
    Run task    module/traefik1/delete-route   	 {"instance": "module3"}

Get Empty routes list
    ${response} =  Run task    module/traefik1/list-routes    {}
    Should Be Empty    ${response}
