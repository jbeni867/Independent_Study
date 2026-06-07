;; QUESTION 1
;; Implement a function called (big st n) that returns true if a string st is longer than n characters.
user=> (defn big [st n]
(if (> (count st) n) true false))
#'user/big
user=> (big "four" 4)
false
user=>

;; QUESTION 2
;; Write a function called (collection-type col) that returns :list, :map, or :vector based on the type of collection col.
user=> (defn big [st n]
(if (> (count st) n) true false))
#'user/big
user=> (big "four" 4)
false
user=> (defn collection-type [col]
(cond
(list? col) :list
(vector? col) :vector
(map? col) :map
:else :unknown))
#'user/collection-type
user=> (collection-type (list 1 2 3))
:list
user=>
