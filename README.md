# mainnet-utils

This repo contains utility modules under namespace **util**, which allows users to create custom guards.   

For additional information on namespaces, please refer to [Pact documentation](https://pact-language.readthedocs.io/en/latest/pact-reference.html#namespaces)

## Namespace `util`

### Deployed Modules:
* [**guards**](#guards)
  * [guard-one](#guard-one)
  * [guard-or](#guard-or)
  * [after-date](#after-date)
  * [at-after-date](#at-after-date)
  * [before-date](#before-date)
  * [at-before-date](#at-before-date)
* [**guard-one**](#guard-one)
  * [guard-all](#guard-all)
  * [guard-any](#guard-any)
  * [max-gas](#max-gas)
  * [max-gas-price](#max-gas-price)
  * [max-gas-limit](#max-gas-limit)


There are two ways to access functions in modules:
```
(util.guards.guard-and a b)
```
or
```
(use util.guards)   
(guard-and a b)
```

## [guards](./util/guards/guards.pact)


#### guard-and

`(guard-and a b)`

GUARD that enforces both guard A and guard B

- takes a:guard
- takes b: guard
- produces `guard`

#### guard-or

`(guard-or a b)`

GUARD that enforces guard A or guard B

- takes a:guard
- takes b: guard
- produces `guard`

#### after-date
`(after-date a)`

GUARD that enforces TIME is after time A

- takes a:time
- produces `guard`

#### at-after-date
`(at-after-date a)`

GUARD that enforces TIME is at or after time A

- takes a:time
- produces `guard`

#### before-date
`(before-date a)`

GUARD that enforces TIME is before time A

- takes a:time
- produces `guard`

#### at-before-date
`(at-before-date a)`

GUARD that enforces TIME is at or before time A

- takes a:time
- produces `guard`

## [`guard-one`](./util/guards/guard-one.pact)

#### guard-all
`(guard-all guard-list)`

GUARD that enforces all guards in a list

- takes guard-list: [guard]
- produces `guard`

#### guard-any
`(guard-any guard-list)`

GUARD that enforces at least one of the guards in a list

- takes guard-list: [guard]
- produces `guard`

#### max-gas
`(max-gas a)`

GUARD that enforces gas-limit * gas-price at or below a

- takes a:decimal
- produces `guard`

#### max-gas-price
`(max-gas-price a)`

GUARD that enforces gas-price is at or below a

- takes a:decimal
- produces `guard`

#### max-gas-limit
`(max-gas-limit a)`

GUARD that enforces gas-limit is at or below a

- takes a:integer
- produces `guard`
