;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname editor) (read-case-sensitive #t) (teachpacks ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor mixed-fraction #f #t none #f ((lib "image.rkt" "teachpack" "2htdp") (lib "batch-io.rkt" "teachpack" "2htdp") (lib "universe.rkt" "teachpack" "2htdp")))))
(require rackunit)
(require "extras.rkt")

;(provide
;  make-editor?
;  editor-pre?
;  editor-post?
;  edit?)

;;CONSTANTS
;; dimensions of the textbox
(define TEXTBOX-WIDTH 200)
(define TEXTBOX-HEIGHT 20)
(define EMPTY-TEXTBOX (empty-scene TEXTBOX-WIDTH TEXTBOX-HEIGHT))

;;Editor
(define-struct ed(text pos))
;;An editor is one of (make-ed String PosInt)
;;INTERP:
;; Text is a string of characters available for editing 
;; Pos is the cursor position in text string
;ed-fn : Editor -> ??
;(define (ed-fn e)
;  (...
;   (ed-text e)
;   (ed-pos e)))

;; A TextEditKeyEvent is a KeyEvent, which is one of
;; -- "left" (interp: causes cursor to shift 1 position to left)
;; -- "right" (interp: causes cursor to shift 1 position to right)
;; -- backspace ("\b") truncates charcter to left of cursor position
;; -- other key events are ascii character equivilent
;; template:
;; texteditor-kev-fn : TextEditorKeyEvent -> ??
;; examples for testing
(define left-key-event "left")
(define right-key-event "right")
(define backspace-key-event "\b")

;;edit : Editor KeyEvent -> ??
;;GIVEN: An editor with text string and cursor position and a Key Event
;;RETURN: determines key event; routing to proper key event function handlers
;; and finally calling make-editor for final display
;;STRATEGY: Functional Composition 
;;(make-editor original text + key event character)
(define (edit ed ke)
  (editor-pre ed ke)
  (make-editor "test" 1))


;;make-editor : String PosInt -> Image 
;;GIVEN: A text string and cursor position
;;RETURN: display text as image inside 'text box' containing string 
(define (make-editor str int)
  (overlay/align "left" "center" 
               (text str 11 'black) 
                EMPTY-TEXTBOX))

;;editor-pre : Editor KeyEvent -> ??
;;GIVEN: A KeyEvent 
;;RETURNS: A editor with either updated string or changed cursor position
;;STRATEGY: 
(define (editor-pre ed ke)
   (cond
    [(key=? "right") ] ;cursor position +1 if position < string length
    [(key=? "left") ]  ;cursor position -1 if position > 0
    [(key=? "\b")]     ;string = string truncate character before cursor position
    [else ]))          ;add key event character at cursor position in string

;editor-post
