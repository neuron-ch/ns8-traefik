*** Settings ***
Library    SSHLibrary
Resource          api.resource

*** Test Cases ***
Create a path rule
    ${response} =  Run task    module/traefik1/set-route
    ...    {"instance": "module1", "url": "http://127.0.0.0:2000", "path": "/foo", "lets_encrypt": false, "http2https": true, "skipCertVerify": true, "headers": {"request": {"X-foo-add": "foo", "X-bar-remove": ""}, "response": {"X-bar-add": "bar", "X-foo-remove": ""}}}

Create a host rule
    ${response} =  Run task    module/traefik1/set-route
    ...    {"instance": "module2", "url": "http://127.0.0.0:2000", "host": "foo.example.org", "lets_encrypt": true, "http2https": true, "skipCertVerify": true, "headers": {"request": {"X-foo-add": "foo", "X-bar-remove": ""}, "response": {"X-bar-add": "bar", "X-foo-remove": ""}}}

Create a host & path rule
    ${response} =  Run task    module/traefik1/set-route
    ...    {"instance": "module3", "url": "http://127.0.0.0:2000", "host": "bar.example.org", "path": "/bar", "lets_encrypt": true, "http2https": true, "skipCertVerify": true, "user_created": true, "headers": {"request": {"X-foo-add": "foo", "X-bar-remove": ""}, "response": {"X-bar-add": "bar", "X-foo-remove": ""}}}

Create an invalid path route
    Run Keyword And Expect Error    *    Run task    module/traefik1/set-route
    ...    {"instance": "module4", "url": "http://127.0.0.0:2000", "path": "bar", "lets_encrypt": true, "http2https": true, "skipCertVerify": true, "headers": {"request": {"X-foo-add": "foo", "X-bar-remove": ""}, "response": {"X-bar-add": "bar", "X-foo-remove": ""}}}

Get path route
    ${response} =  Run task    module/traefik1/get-route    {"instance": "module1"}
    Should Be Equal As Strings    ${response['instance']}        module1
    Should Be Equal As Strings    ${response['path']}            /foo
    Should Be Equal As Strings    ${response['url']}              http://127.0.0.0:2000
    Should Be Equal As Strings    ${response['lets_encrypt']}    False
    Should Be Equal As Strings    ${response['http2https']}      True
    Should Be Equal As Strings    ${response['skipCertVerify']}  True
    Should Be Equal As Strings    ${response['strip_prefix']}    False
    Should Be Equal As Strings    ${response['user_created']}    False
    Should Be Equal As Strings    ${response['headers']['request']['X-foo-add']}    foo
    Should Be Equal As Strings    ${response['headers']['request']['X-bar-remove']}    ${EMPTY}
    Should Be Equal As Strings    ${response['headers']['response']['X-bar-add']}    bar
    Should Be Equal As Strings    ${response['headers']['response']['X-foo-remove']}    ${EMPTY}

Get host route
    ${response} =  Run task    module/traefik1/get-route    {"instance": "module2"}
    Should Be Equal As Strings    ${response['instance']}        module2
    Should Be Equal As Strings    ${response['host']}            foo.example.org
    Should Be Equal As Strings    ${response['url']}             http://127.0.0.0:2000
    Should Be Equal As Strings    ${response['lets_encrypt']}    True
    Should Be Equal As Strings    ${response['http2https']}      True
    Should Be Equal As Strings    ${response['skipCertVerify']}  True
    Should Be Equal As Strings    ${response['user_created']}    False
    Should Be Equal As Strings    ${response['headers']['request']['X-foo-add']}    foo
    Should Be Equal As Strings    ${response['headers']['request']['X-bar-remove']}    ${EMPTY}
    Should Be Equal As Strings    ${response['headers']['response']['X-bar-add']}    bar
    Should Be Equal As Strings    ${response['headers']['response']['X-foo-remove']}    ${EMPTY}


Get host & path route
    ${response} =  Run task    module/traefik1/get-route    {"instance": "module3"}
    Should Be Equal As Strings    ${response['instance']}        module3
    Should Be Equal As Strings    ${response['path']}            /bar
    Should Be Equal As Strings    ${response['host']}            bar.example.org
    Should Be Equal As Strings    ${response['url']}              http://127.0.0.0:2000
    Should Be Equal As Strings    ${response['lets_encrypt']}    True
    Should Be Equal As Strings    ${response['http2https']}      True
    Should Be Equal As Strings    ${response['skipCertVerify']}  True
    Should Be Equal As Strings    ${response['strip_prefix']}    False
    Should Be Equal As Strings    ${response['user_created']}    True
    Should Be Equal As Strings    ${response['headers']['request']['X-foo-add']}    foo
    Should Be Equal As Strings    ${response['headers']['request']['X-bar-remove']}    ${EMPTY}
    Should Be Equal As Strings    ${response['headers']['response']['X-bar-add']}    bar
    Should Be Equal As Strings    ${response['headers']['response']['X-foo-remove']}    ${EMPTY}

Get routes list
    ${response} =  Run task    module/traefik1/list-routes    null
    Should Contain    ${response}    module1
    Should Contain    ${response}    module2
    Should Contain    ${response}    module3

Get expanded routes list
    ${response} =  Run task    module/traefik1/list-routes    {"expand_list": true}
    Should Be Equal As Strings    ${response[0]['instance']}        module1
    Should Be Equal As Strings    ${response[0]['path']}            /foo
    Should Be Equal As Strings    ${response[0]['url']}              http://127.0.0.0:2000
    Should Be Equal As Strings    ${response[0]['lets_encrypt']}    False
    Should Be Equal As Strings    ${response[0]['http2https']}      True
    Should Be Equal As Strings    ${response[0]['skipCertVerify']}  True
    Should Be Equal As Strings    ${response[0]['strip_prefix']}    False
    Should Be Equal As Strings    ${response[0]['user_created']}    False
    Should Be Equal As Strings    ${response[0]['headers']['request']['X-foo-add']}    foo
    Should Be Equal As Strings    ${response[0]['headers']['request']['X-bar-remove']}    ${EMPTY}
    Should Be Equal As Strings    ${response[0]['headers']['response']['X-bar-add']}    bar
    Should Be Equal As Strings    ${response[0]['headers']['response']['X-foo-remove']}    ${EMPTY}


    Should Be Equal As Strings    ${response[1]['instance']}        module2
    Should Be Equal As Strings    ${response[1]['host']}            foo.example.org
    Should Be Equal As Strings    ${response[1]['url']}             http://127.0.0.0:2000
    Should Be Equal As Strings    ${response[1]['lets_encrypt']}    True
    Should Be Equal As Strings    ${response[1]['http2https']}      True
    Should Be Equal As Strings    ${response[1]['skipCertVerify']}  True
    Should Be Equal As Strings    ${response[1]['user_created']}    False
    Should Be Equal As Strings    ${response[1]['headers']['request']['X-foo-add']}    foo
    Should Be Equal As Strings    ${response[1]['headers']['request']['X-bar-remove']}    ${EMPTY}
    Should Be Equal As Strings    ${response[1]['headers']['response']['X-bar-add']}    bar
    Should Be Equal As Strings    ${response[1]['headers']['response']['X-foo-remove']}    ${EMPTY}


    Should Be Equal As Strings    ${response[2]['instance']}        module3
    Should Be Equal As Strings    ${response[2]['path']}            /bar
    Should Be Equal As Strings    ${response[2]['host']}            bar.example.org
    Should Be Equal As Strings    ${response[2]['url']}              http://127.0.0.0:2000
    Should Be Equal As Strings    ${response[2]['lets_encrypt']}    True
    Should Be Equal As Strings    ${response[2]['http2https']}      True
    Should Be Equal As Strings    ${response[2]['skipCertVerify']}  True
    Should Be Equal As Strings    ${response[2]['strip_prefix']}    False
    Should Be Equal As Strings    ${response[2]['user_created']}    True
    Should Be Equal As Strings    ${response[2]['headers']['request']['X-foo-add']}    foo
    Should Be Equal As Strings    ${response[2]['headers']['request']['X-bar-remove']}    ${EMPTY}
    Should Be Equal As Strings    ${response[2]['headers']['response']['X-bar-add']}    bar
    Should Be Equal As Strings    ${response[2]['headers']['response']['X-foo-remove']}    ${EMPTY}

Delete routes
    Run task    module/traefik1/delete-route   	 {"instance": "module1"}
    Run task    module/traefik1/delete-route   	 {"instance": "module2"}
    Run task    module/traefik1/delete-route   	 {"instance": "module3"}

Get Empty routes list
    ${response} =  Run task    module/traefik1/list-routes    null
    Should Be Empty    ${response}
