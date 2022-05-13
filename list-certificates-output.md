# list-certificates output Schema

```txt
http://schema.nethserver.org/samba/list-certificates-output.json
```

Return a list of requested certificates fqdn

| Abstract            | Extensible | Status         | Identifiable            | Custom Properties | Additional Properties | Access Restrictions | Defined In                                                                                  |
| :------------------ | :--------- | :------------- | :---------------------- | :---------------- | :-------------------- | :------------------ | :------------------------------------------------------------------------------------------ |
| Can be instantiated | No         | Unknown status | Unknown identifiability | Forbidden         | Allowed               | none                | [list-certificates-output.json](samba/list-certificates-output.json "open original schema") |

## list-certificates output Type

`string[]` ([A fully qualified domain name](list-certificates-output-a-fully-qualified-domain-name.md))

## list-certificates output Examples

```json
[
  "example.com"
]
```

```json
[]
```
