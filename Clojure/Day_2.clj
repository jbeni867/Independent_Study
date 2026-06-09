;; QUESTION 1
;; Implement an unless with an else condition using macros.
user=> (defmacro unless [test if-false if-true]
`(if ~test
~if-true
~if-false))
#'user/unless
user=> (unless (> 5 1) "no" "yes")
"yes"
user=>

;; QUESTION 2
;; Write a type using defrecord that implements a protocol.
user=> (defprotocol Speaker
  (speak [this]))
Speaker
user=> (defrecord Robot [name]
  Speaker
  (speak [this]
    (str "Beep boop, I am " name)))
user=> (def wall-e (->Robot "WALL-E"))
#'user/wall-e
user=> (speak wall-e)
"Beep boop, I am WALL-E"
