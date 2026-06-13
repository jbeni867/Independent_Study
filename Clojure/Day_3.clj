;; QUESTION 1
;; Use refs to create a vector of accounts in memory. Create debit and credit functions to change the balance of an account.
user=> (def accounts (ref [{:account 123 :balance 100}
                           {:account 456 :balance 50}]))
#'user/accounts

user=> (defn credit [account-number amount]
         (dosync
           (alter accounts
             (fn [current-vector]
               (mapv (fn [acc]
                       (if (= (:account acc) account-number)
                         (update acc :balance + amount)
                         acc))
                     current-vector)))))
#'user/credit

user=> (defn debit [account-number amount]
         (dosync
           (alter accounts
             (fn [current-vector]
               (mapv (fn [acc]
                       (if (= (:account acc) account-number)
                         (update acc :balance - amount)
                         acc))
                     current-vector)))))
#'user/debit

user=> @accounts
[{:account 123, :balance 100} {:account 456, :balance 50}]

user=> (credit 123 50)
[{:account 123, :balance 150} {:account 456, :balance 50}]

user=> (debit 456 20)
[{:account 123, :balance 150} {:account 456, :balance 30}]

user=> @accounts
[{:account 123, :balance 150} {:account 456, :balance 30}]


;; QUESTION 2
;; Write a multithreaded program to determine how many haircuts a barber can give in ten seconds.
user=> (def open? (atom true))
#'user/open?

user=> (def haircut-count (atom 0))
#'user/haircut-count

user=> (def turned-away-count (atom 0))
#'user/turned-away-count

user=> (def waiting-room (ref []))
#'user/waiting-room

user=> (def waiting-room-size 3)
#'user/waiting-room-size

user=> (defn start-customer-generator []
         (future
           (while @open?
             (Thread/sleep (+ 10 (rand-int 21)))
             (dosync
               (if (< (count @waiting-room) waiting-room-size)
                 (alter waiting-room conj :customer)
                 (swap! turned-away-count inc))))))
#'user/start-customer-generator

user=> (defn start-barber []
         (future
           (while @open?
             (let [customer (dosync
                              (when (seq @waiting-room)
                                (let [next-customer (first @waiting-room)]
                                  (alter waiting-room subvec 1)
                                  next-customer)))]
               (if customer
                 (do
                   (Thread/sleep 20)
                   (swap! haircut-count inc))
                 (Thread/sleep 5))))))
#'user/start-barber

user=> (defn run-simulation []
         (reset! open? true)
         (reset! haircut-count 0)
         (reset! turned-away-count 0)
         (dosync (ref-set waiting-room []))
         (println "Starting the barber shop simulation...")
         (start-customer-generator)
         (start-barber)
         (Thread/sleep 10000)
         (reset! open? false)
         (println "Shop closed!")
         (println "-------------------------------------")
         (println "Total Haircuts Given:" @haircut-count)
         (println "Customers Turned Away:" @turned-away-count))
#'user/run-simulation

user=> (run-simulation)
Starting the barber shop simulation...
Shop closed!
-------------------------------------
Total Haircuts Given: 418
Customers Turned Away: 11
nil