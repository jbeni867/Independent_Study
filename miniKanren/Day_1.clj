(ns minikanren-exercises.core
  (:require [clojure.core.logic :refer [run run* membero appendo db-rel defrel fact facts]]))

;; QUESTION 1
;; Try running a logic program that has two membero goals, both with q as the first argument. What happens when the same element exists in both collections?
(run* [q]
  (membero q [:a :b :c])
  (membero q [:b :c :d]))

;; QUESTION 2
;; appendo is a core.logic built-in that will append two lists. Write some logic programs similar to the membero examples to get a feel for how it works. Be sure to use q in each of the three argument positions to see what happens.
(run* [q]
  (appendo q [:c :d] [:a :b :c :d]))

;; QUESTION 3
;; Create languageo and systemo database relations and add the relevant facts based on which category best classifies the person’s work.
(db-rel languageo person)
(db-rel systemo person)

(facts languageo
       ['dennis-ritchie]
       ['guido-van-rossum]
       ['rich-hickey])

(facts systemo
       ['linus-torvalds]
       ['dennis-ritchie]
       ['ken-thompson])

(run* [q]
  (languageo q))

;; Find someone who did BOTH (intersection):
(run* [q]
  (languageo q)
  (systemo q))