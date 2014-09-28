;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname robot) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor mixed-fraction #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
(require rackunit)
(require 2htdp/image)
(require "extras.rkt")

;(provide
;  initial-robot
;  robot-left 
;  robot-right
;  robot-forward
;  robot-north? 
;  robot-south? 
;  robot-east? 
;  robot-west?)

;; dimensions of the room
(define ROOM-WIDTH 200)
(define ROOM-HEIGHT 400)
(define ROOM (empty-scene ROOM-WIDTH ROOM-HEIGHT))

;;; DATA DEFINITION 
(define-struct direction (direction))
;;A direction is one of (make-direction String)
;; - "north" 
;;  inter: the robot is facing north
;; - "south" 
;;  inter: the robot is facing south
;; - "east" 
;;  inter: the robot is facing east
;; - "west"
;;  inter: the robot is facing west
;; Template
;; direction-fn : Direction
;(define (direction-fn dir)
;  (cond
;    [(string=? dir "north")    
;     ...]
;    [(string=? dir "south")
;     ...]
;    [(string=? dir "east")  
;     ...])
;    [(string=? dir "west")  
;     ...]))  

(define-struct robot (direction xPos yPos))
;;A robot is a (make-robot direction PosInt PosInt)
;;INTERP:
;; dirction is the direct robot is facing
;;Template:
;; robot-fn : Robot -> ??
;(define (robot-fn r)
;  (...
;   (robot-direction r)
;   (robot-xPos r)
;   (robot-yPos r)))
 
;;CONSTANTS ** for testing **
(define ROBOT-NORTH (make-robot "north" 10 10))
(define ROBOT-SOUTH (make-robot "south" 20 20))
(define ROBOT-WEST (make-robot "west" 30 30))
(define ROBOT-EAST (make-robot "east" 40 40))

;initial-robot : Real Real-> Robot
;GIVEN: a set of (x,y) coordinates
;RETURNS: a robot with its at those coordinates, facing north(up).
;;STRATEGY: Functional Decomposition
(define (initial-robot xPos yPos)
  (make-robot "north " xPos yPos))

;Examples for tests
(define robot-initial-robot (initial-robot 10 20))

;robot-left : Robot -> Robot
;robot-right : Robot -> Robot
;GIVEN: a robot
;RETURNS: a robot like the original, but turned 90 degrees either left
;or right.
;STRATEGY: Structural Decomposition on Robot : r
(define (robot-left r)
  (robot-left-helper
   (robot-direction r)
   (robot-xPos r)
   (robot-yPos r)))

(define (robot-right r)
  (robot-right-helper
   (robot-direction r)
   (robot-xPos r)
   (robot-yPos r)))

(define (robot-left-helper dir x y)
  (cond
    [(string=? dir "north")    
     (make-robot "west" x y)]
    [(string=? dir "south")
     (make-robot "east" x y)]
    [(string=? dir "east")  
     (make-robot "north" x y)]
    [(string=? dir "west")  
     (make-robot "south" x y)])) 

(define (robot-right-helper dir x y)
  (cond
    [(string=? dir "north")    
     (make-robot "east" x y)]
    [(string=? dir "south")
     (make-robot "west" x y)]
    [(string=? dir "east")  
     (make-robot "south" x y)]
    [(string=? dir "west")  
     (make-robot "north" x y)]))

(begin-for-test  
 ;; robot-turn left 90 degrees
  (check-equal?
    (robot-right ROBOT-SOUTH)
    (make-robot "west" 20 20)
    "robot facing SOUTH turning RIGHT should result in WEST")

  (check-equal?
    (robot-right ROBOT-NORTH)
    (make-robot "east" 10 10)
    "robot facing NORTH turning RIGHT should result in EAST")
  
  (check-equal?
    (robot-right ROBOT-WEST)
    (make-robot "north" 30 30)
    "robot facing WEST turning RIGHT should result in NORTH")

  (check-equal?
    (robot-right ROBOT-EAST)
    (make-robot "south" 40 40)
    "robot facing EAST turning RIGHT should result in SOUTH")
 ;; robot-turn left 90 degrees
  (check-equal?
    (robot-left ROBOT-SOUTH)
    (make-robot "east" 20 20)
    "robot facing SOUTH turning LEFTshould result in EAST")

  (check-equal?
    (robot-left ROBOT-NORTH)
    (make-robot "west" 10 10)
    "robot facing NORTH turning LEFT should result in WEST")
  
  (check-equal?
    (robot-left ROBOT-WEST)
    (make-robot "south" 30 30)
    "robot facing WEST turning LEFT should result in SOUTH")

  (check-equal?
    (robot-left ROBOT-EAST)
    (make-robot "north" 40 40)
    "robot facing EAST turning LEFT should result in NORTH")
  )

;robot-north? : Robot -> Boolean
;robot-south? : Robot -> Boolean
;robot-east? : Robot -> Boolean
;robot-west? : Robot -> Boolean
;GIVEN: a robot
;ANSWERS: whether the robot is facing in the specified direction.
;STRATEGY: Structural decomposition on Robot : r
(define (robot-north? r)
  (robot-north-helper 
   (robot-direction r)))

(define (robot-north-helper dir)
  (if (string=? dir "north")  true false))

(define (robot-south? r)
  (robot-south-helper 
   (robot-direction r)))

(define (robot-south-helper dir)
  (cond
    [(string=? dir "south") true]
    [else false]))
  ;;(if (string=? dir "south") true false))

(define (robot-east? r)
  (robot-east-helper 
   (robot-direction r)))

(define (robot-east-helper dir)
  (if (string=? dir "east") true false))
 
(define (robot-west? r)
  (robot-west-helper
   (robot-direction r)))

(define (robot-west-helper dir)
  (cond
    [(string=? dir "west") true]
    [else false]))

(begin-for-test  
  ;; predicate function directional testing
  (check-equal?
    (robot-north? ROBOT-NORTH)
    true
    "test of robot-north? expected true")

  (check-equal?
    (robot-south? ROBOT-SOUTH)
    true
    "test of robot-south? expected true")
  
   (check-equal?
    (robot-west? ROBOT-WEST)
    true
    "test of robot-west? expected true")

   (check-equal?
    (robot-west? ROBOT-EAST)
    false
    "test of robot-west? expected false, robot 'east' given")
   
  (check-equal?
    (robot-east? ROBOT-EAST)
    true
    "test of robot-east? expected true")
  )

;robot-forward : Robot PosInt -> Robot
;GIVEN: a robot and a distance
;RETURNS: a robot like the given one, but moved forward by the
;specified number of pixels distance.  If moving forward the specified number
;of pixels distance would cause the robot to move from being
;entirely inside the canvas room to being even partially outside the canvas 
;room, then the robot should stop at the wall.
;STRATEGY: StructuralDecomposition on Robot : r
(define (robot-forward r d)
  (robot-forward-helper r d         
   (robot-direction r)
   (robot-xPos r)
   (robot-yPos r)))

(define (robot-forward-helper r dis dir x y)
  (if (or (> x 200) (> y 400))
      (cond
        [(robot-north? r) (make-robot dir x (- y dis))]
        [(robot-south? r) (make-robot dir x (+ y dis ))]
        [(robot-east? r) (make-robot dir (+ x dis) y)]
        [(robot-west? r) (make-robot dir (- x dis) y)])
  (cond
    [(robot-north? r) (if (> dis (- y 7.5)) (make-robot dir x 7.5) (make-robot dir x (- y dis)))]
    [(robot-south? r) (if (> dis (- (- ROOM-HEIGHT 7.5) y)) (make-robot dir x (- ROOM-HEIGHT 7.5)) (make-robot dir x (- y dis)))]
    [(robot-east? r) (if (> dis (- (- ROOM-WIDTH x) 7.5)) (make-robot dir (- ROOM-WIDTH 7.5) y) (make-robot dir (- x dis) y))]
    [(robot-west? r) (if (> dis (- y 7.5)) (make-robot dir 7.5 y) (make-robot dir (+ x dis) y))])))

;Examples for tests
(define robot-move-forward-s (robot-forward ROBOT-SOUTH 100))
(define robot-move-forward-n (robot-forward ROBOT-NORTH 100))
(define robot-move-forward-w (robot-forward ROBOT-WEST 100))
(define robot-move-forward-e (robot-forward ROBOT-EAST 100))

(begin-for-test  
  ;; robot-forward cardinal directions testing
  (check-equal?
    (robot-forward (make-robot "north" 10 10) 100)
    (make-robot "north" 10 15/2)
    "test of robot-foward expected (+ yPos 100) ")

  (check-equal?
    (robot-forward ROBOT-SOUTH 99)
    (make-robot "south" 20 -79)
    "test of robot-foward expected negative y-axis")
  
   (check-equal?
    (robot-forward (make-robot "west" 10 10) 98)
    (make-robot "west" 15/2 10)
    "test of robot-forward expected x-axis decrement")

  (check-equal?
    (robot-forward ROBOT-EAST 97)
   (make-robot "east" -57 40)
    "test of robot-forward expected x-axis increment")
  )
