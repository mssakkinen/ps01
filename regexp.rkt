;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname regexp) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor mixed-fraction #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
(require 2htdp/universe)
(require "extras.rkt")


;(provide
;  initial-state?
;  next-state?
;  next-state-after-ab?
;  next-state-after-cd?
;  next-state-after-e?
;  accepting-state?
;  error-state?)

;;a State is one:
;; - "State0" inter: entered (a|b)* a and/or b possible multiples of so far
;; - "State1" inter: entered (a|b)*(c|d)* a and/or b possible multiples 
;;  preceding c and/or d possible multiples of so far
;; - "State2" inter: entered (a|b)*(c|d)*(e) so far
;; - "ErrorState" inter: errorout state outside accepted key enteries
 
(define STATE0 "State0")
(define STATE1 "State1")
(define STATE2 "State1")
(define ERROR-STATE "Error")

;initial-state : Number -> State
;GIVEN: a number
;RETURNS: a representation of the initial state
;of your machine.  The given number is ignored.
(define (initial-state n)
  (next-state "a"))

;next-state : State KeyEvent -> State
;GIVEN: a state of the machine and a key event.
;RETURNS: the state that should follow the given key event.  A key
;event that is to be discarded should leave the state unchanged.
;STRATEGY: cases on keyEvent : kev
(define (next-state st kev)
  (cond
    [(key?= kev "a") (next-state-after-ab st)]
    [(key?= kev "b") (next-state-after-ab st)]
    [(key?= kev "c") (next-state-after-cd st)]
    [(key?= kev "d") (next-state-after-cd st)]
    [(key?= kev "e") (next-state-after-e st)]
    [else ERROR-STATE]))


;next-state-after-ab : State -> State
;GIVEN: state at a|b
;RETURNS: state a|b but changed
;STRATEGY: Structural Decomposition on State : s
;;EXAMPLES:
;;  (next-state-after-ab STATE0)= STATE0
;;  (next-state-after-ab STATE1)= STATE1
;;  (next-state-after-ab STATE2)= ERROR
;;  (next-state-after-ab ERROR)= ERROR
(define (next-state-after-a st)
  (cond
    [(STATE0? st) STATE1]
    [(STATE1? st) STATE1]
    [(STATE2? st) ERROR-STATE]
    [else ERROR-STATE]))

;next-state-after-cd : State -> State
;GIVEN: state at c|d
;RETURN: state at c|d but changed
;STRATEGY: Structural Decomposition on State : s
;;EXAMPLES:
;;  (next-state-after-cd STATE0)= ERROR
;;  (next-state-after-cd STATE1)= STATE1
;;  (next-state-after-cd STATE2)= STATE2
;;  (next-state-after-cd ERROR)= ERROR
(define (next-state-after-b st)
  (cond
    [(STATE0? st) ERROR-STATE]
    [(STATE1? st) STATE1]
    [(STATE2? st) STATE2]
    [else ERROR-STATE]))

;next-state-after-e : State -> State
;GIVEN: state at e
;RESULT: State at e but changed
;;EXAMPLES:
;;  (next-state-after-e STATE0)=STATE3
;;  (next-state-after-e STATE1)=STATE3
;;  (next-state-after-e STATE2)=STATE3
;;  (next-state-after-e ERROR)=ERROR

;accepting-state? : State -> Boolean
;GIVEN: a state of the machine
;RETURNS: true iff the given state is a final (accepting) state
(define (accepting-state st)
  )

;error-state? : State -> Boolean
;GIVEN: a state of the machine
;RETURNS: true iff the string seen so far does not match the specified
;regular expression and cannot possibly be extended to do so.
(define (error-state st)
  )

(begin-for-test
  (check-equal (next-state STATE0 "a") STATE0)
  (check-equal (next-state STATE1 "r") ERROR-STATE)))
