;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname snacks) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor mixed-fraction #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
(require rackunit)
(require "extras.rkt")

;(provide
;  initial-machine?
;  machine-next-state?
;  machine-chocolates?
;  machine-carrots?
;  machine-bank?)

;;DATA DEFINITIONS

;;Machine
(define-struct machine (numChocolate numCarrots money))
;; A Machine is a (make-machine NonNegInt NonNegInt NonNegInt)
;; INTERP:
;;  numChocolate are the available quantity chocolates for vending
;;  numCarrots are the available quantity carrots for vending
;;  money is the amount change inserted available for next purchase 
;;    or return to customer
;; TEMPLATE:
;;  machine-fn : Machine -> ??
(define (machine-fn m)
  (...
   (machine-numChocolate m)
   (machine-numCarrots m)
   (machine-money m)))

;;examples of machines, for testing
(define machine-for-test1 (make-machine 10 10 225))  
(define machine-for-test2 (make-machine 5 5 175))

(define-struct customerInput (cInput))
;A CustomerInput is one of (make-customerInput String/PosInt)
;-- a PosInt interp: insert the specified number of cents
;-- "chocolate"  interp: request a chocolate bar
;-- "carrots"    interp: request a package of carrot sticks
;-- "release"    interp: return all the coins that the customer has put in
;; TEMPLATE:
;;  customerInput-fn : CustomerInput -> ??
(define (customerInput-fn ci)
  (...
   (customerInput-chocolate ci)
   (customerInput-carrots ci)
   (customerInput-release ci)
   (customerInput-PosInt ci)))

;;examples of customerInput, for testing
(define customerInput-for-test1 (make-customerInput "carrots"))  
(define customerInput-for-test2 (make-customerInput "chocolate"))
(define customerInput-for-test1 (make-customerInput "release"))  
(define customerInput-for-test2 (make-customerInput 25))

;initial-machine : NonNegInt NonNegInt-> Machine
;GIVEN: the number of chocolate bars and the number of packages of
;carrot sticks
;RETURNS: a machine loaded with the given number of chocolate bars and
;carrot sticks, with an empty bank.
;STRATEGY: Functional Composition
(define (initial-machine i j)
  (make-machine i j 0))

;;TESTS
(define initial-machine-test1 (make-initial-machine 10 10))
(define initial-machine-test1 (make-initial-machine 5 10))

;machine-next-state : Machine CustomerInput -> Machine
;GIVEN: a machine state and a customer input
;RETURNS: the state of the machine that should follow the customer's input
;STRATEGY:
(define (machine-next-state m ci)
  )

;machine-chocolates : Machine ->  NonNegInt
;GIVEN: a machine state
;RETURNS: the number of chocolate bars left in the machine
;STRATEGY:

;machine-carrots : Machine ->  NonNegInt
;GIVEN: a machine state
;RETURNS: the number of packages of carrot sticks left in the machine
;STRATEGY:

;machine-bank : Machine ->  NonNegInt
;GIVEN: a machine state
;RETURNS: the amount of money in the machine's bank, in cents
;STRATEGY: