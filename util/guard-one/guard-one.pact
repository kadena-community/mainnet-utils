(namespace 'util)

(module guard-one AUTONOMOUS

  "Functions for implementing gas guards."

  (defcap AUTONOMOUS ()
    (enforce false "Non-upgradeable"))

  (use guards)

  (defun guard-all:guard (guards:[guard])
    "Guard to enforce all guards in GUARDS"
    (enforce (< 0 (length guards)) "Guard list cannot be empty")
    (create-user-guard (enforce-guard-all guards)))

  (defun enforce-guard-all:bool (guards:[guard])
    "Enforces all guards in the GUARDS"
    (map (enforce-guard) guards)
  )

  (defun guard-any:guard (guards:[guard])
    "Guard to enforce one of the guards in GUARDS"
    (enforce (< 0 (length guards)) "Guard list cannot be empty")
    (create-user-guard (enforce-guard-any guards)))

  (defun enforce-guard-any:bool (guards:[guard])
    "Enforces one of the guards in the GUARDS"
    (enforce (< 0
      (length
        (filter
          (= true)
          (map (try-enforce-guard) guards))))
      "None of the guards passed")
  )

  (defun try-enforce-guard (g:guard)
    (try false (enforce-guard g))
  )

  (defun max-gas:guard (gas:decimal)
    "Guard to enforce gas price * gas limit is smaller than or equal to GAS"
    (create-user-guard
      (enforce-below-or-at-gas gas)))

  (defun max-gas-price:guard (gasPrice:decimal)
    "Guard to enforce gas price is smaller than or equal to GAS PRICE"
    (create-user-guard
      (enforce-below-or-at-gas-price gasPrice)))

  (defun max-gas-limit:guard (gasLimit:integer)
    "Guard to enforce gas limit is smaller than or equal to GAS LIMIT"
    (create-user-guard
      (enforce-below-or-at-gas-limit gasLimit)))

  (defun enforce-below-gas (gas:decimal)
    (enforce (< (chain-gas) gas)
      (format "Gas Limit * Gas Price must be smaller than {}" [gas])))

  (defun enforce-below-or-at-gas (gas:decimal)
    (enforce (<= (chain-gas) gas)
      (format "Gas Limit * Gas Price must be bigger than or equal to {}" [gas])))

  (defun enforce-at-gas-price:bool (gasPrice:decimal)
    (enforce (= (chain-gas-price) gasPrice)
    (format "Gas Price must be at {}" [gasPrice])))

  (defun enforce-below-gas-price:bool (gasPrice:decimal)
    (enforce (< (chain-gas-price) gasPrice)
      (format "Gas Price must be smaller than {}" [gasPrice])))

  (defun enforce-below-or-at-gas-price:bool (gasPrice:decimal)
    (enforce (<= (chain-gas-price) gasPrice)
      (format "Gas Price must be smaller than or equal to {}" [gasPrice])))

  (defun enforce-at-gas-limit:bool (gasLimit:integer)
    (enforce (= (chain-gas-limit) gasLimit)
    (format "Gas Limit must be at {}" [gasLimit])))

  (defun enforce-below-gas-limit:bool (gasLimit:integer)
    (enforce (< (chain-gas-limit) gasLimit)
      (format "Gas Limit must be smaller than {}" [gasLimit])))

  (defun enforce-below-or-at-gas-limit:bool (gasLimit:integer)
    (enforce (<= (chain-gas-limit) gasLimit)
      (format "Gas Limit must be smaller than {}" [gasLimit])))

  (defun chain-gas-price ()
    "Return gas price from chain-data"
    (at 'gas-price (chain-data)))

  (defun chain-gas-limit ()
    "Return gas limit from chain-data"
    (at 'gas-limit (chain-data)))

  (defun chain-gas ()
    "Return gas limit * gas price from chain-data"
    (* (chain-gas-price) (chain-gas-limit)))
)
