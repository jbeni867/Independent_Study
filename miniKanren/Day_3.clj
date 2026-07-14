;; QUESTION 1
;; Code some other mathematical equations and have core.logic fill in the answers.
(ns minikanren-day3.core
  (:require [clojure.core.logic :refer [run run* fresh == project]]))

;; y = x + 5
(defn plus-fiveo [x y]
  (project [x]
    (== y (+ x 5))))

;; Running it to let core.logic find the answer
(run 1 [q]
  (plus-fiveo 10 q))
;; Output: (15)

;; QUESTION 2
;; Generate stories where the motorist never appears and there are at least two murderers.
(defn storyo [start end moves]
  (conde
    ((== start end) (== moves []))
    ((fresh [next-state move rest-moves]
       (actiono start next-state move)
       (storyo next-state end rest-moves)
       (== moves (cons move rest-moves))))))

(run 5 [actions]
  (fresh [start end]
    (== start [:wadsworth-alive :plum-alive :mustard-alive])
    (storyo start end actions)))

(use 'clojure.core.logic :only [membero])

(run 1 [actions]
  (fresh [start end]
    (== start [:wadsworth-alive :plum-alive :mustard-alive :green-alive])
    (storyo start end actions)
    
    (membero :plum-killed-wadsworth actions)
    (membero :mustard-killed-green actions)))