;; QUESTION 1
;; Rewrite extendo from Day 1’s problems using matche or defne.
(defne extendo [a b l]
  ([() _ b])
  ([[h . t] _ [h . t2]] 
   (extendo t b t2)))

;; QUESTION 2
;; Create a goal not-rooto which takes a map with a :username key and succeeds only if the value is not “root”.
(run* [q]
  (not-rooto {:username "admin"})
  (== q true))
(run* [q]
  (not-rooto {:username "root"}))

;; QUESTION 3
;; Run whicho in reverse, asking for elements in one or both of the sets.
(run* [q]
  (whicho q [:a :b :c] [:c :d :e] :both))
;; Expected Output: (:c)

(run* [q]
  (whicho q [:a :b :c] [:c :d :e] :one))
;; Expected Output: (:a :b)

;; QUESTION 4
;; Add a :none branch to whicho. What happens when you use the :none branch in the whicho version built on conde?
(defn whicho [x s1 s2 r]
  (conde
    ((membero x s1) (membero x s2) (== r :both))
    ((membero x s1) (== r :one))
    ((membero x s2) (== r :two))
    ;; Attempting to add a :none branch:
    ((== r :none))))