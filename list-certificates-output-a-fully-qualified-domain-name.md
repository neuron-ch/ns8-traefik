# A fully qualified domain name Schema

```txt
http://schema.nethserver.org/samba/list-certificates-output.json#/items
```



| Abstract            | Extensible | Status         | Identifiable            | Custom Properties | Additional Properties | Access Restrictions | Defined In                                                                                    |
| :------------------ | :--------- | :------------- | :---------------------- | :---------------- | :-------------------- | :------------------ | :-------------------------------------------------------------------------------------------- |
| Can be instantiated | No         | Unknown status | Unknown identifiability | Forbidden         | Allowed               | none                | [list-certificates-output.json\*](samba/list-certificates-output.json "open original schema") |

## items Type

`string` ([A fully qualified domain name](list-certificates-output-a-fully-qualified-domain-name.md))

## items Constraints

**hostname**: the string must be a hostname, according to [RFC 1123, section 2.1](https://tools.ietf.org/html/rfc1123 "check the specification")
