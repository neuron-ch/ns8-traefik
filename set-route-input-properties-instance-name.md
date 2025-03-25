# Instance name Schema

```txt
http://schema.nethserver.org/traefik/set-route-input.json#/properties/instance
```

The instance name, which is unique inside the cluster.

| Abstract            | Extensible | Status         | Identifiable            | Custom Properties | Additional Properties | Access Restrictions | Defined In                                                                    |
| :------------------ | :--------- | :------------- | :---------------------- | :---------------- | :-------------------- | :------------------ | :---------------------------------------------------------------------------- |
| Can be instantiated | No         | Unknown status | Unknown identifiability | Forbidden         | Allowed               | none                | [set-route-input.json\*](traefik/set-route-input.json "open original schema") |

## instance Type

`string` ([Instance name](set-route-input-properties-instance-name.md))

## instance Constraints

**pattern**: the string must match the following regular expression:&#x20;

```regexp
^[a-zA-Z0-9_\.-]+$
```

[try pattern](https://regexr.com/?expression=%5E%5Ba-zA-Z0-9_%5C.-%5D%2B%24 "try regular expression with regexr.com")

## instance Examples

```json
"module1"
```
