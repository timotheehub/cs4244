;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                     Define modules                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Control flow with modules
(defmodule MAIN (export ?ALL)) 
(defmodule QUESTION (import MAIN ?ALL))
(defmodule SELECTION (import MAIN ?ALL))
(defmodule POSITIONING (import MAIN ?ALL))
(defmodule LAYOUT (import MAIN ?ALL))





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                      MAIN templates                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Question template. Category1 and Category2 correspond to 
;; the categories of furniture. This is used in the preference
;; questions.
(deftemplate MAIN::question
   (slot question-id (type SYMBOL))
   (slot question-type (type SYMBOL))
   (slot category1 (type SYMBOL))
   (slot category2 (type SYMBOL))
   (slot text (type STRING))
   (multislot valid-answers))


;; Answer template. Value can have any type.
(deftemplate MAIN::answer
   (slot question-id (type SYMBOL))
   (slot name (type SYMBOL))
   (slot value))


;; Preference question template
(deftemplate MAIN::preference-question
   (slot category1 (type SYMBOL))
   (slot category2 (type SYMBOL)))


;; Theme template
(deftemplate MAIN::theme
   (slot theme (allowed-values modern warm nature cozy)))


;; Room size template. Length and Width are in millimeters.
(deftemplate MAIN::room-size
   (slot length (type INTEGER))
   (slot width (type INTEGER)))


;; Window template. X and Y are in millimeters.
(deftemplate MAIN::window
   (slot x (type INTEGER))
   (slot y (type INTEGER)))


;; Door template. X and Y are in millimeters.
(deftemplate MAIN::door
   (slot x (type INTEGER))
   (slot y (type INTEGER)))


;; The preferred distances between different categories of
;; furnitures
(deftemplate MAIN::distance
   (slot category1 (type SYMBOL)) 
   (slot category2 (type SYMBOL))
   (slot prefer (allowed-values close far)))





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       MAIN facts                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(deffacts MAIN::the-facts
	(question (question-id size) (question-type size) (text "What is the size of the room?")))





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       MAIN rules                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; The first focus must be on QUESTION when there is a new
;; answer
(defrule MAIN::answer-focus-question
   (answer)
   =>
   (focus QUESTION))





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                      QUESTION rules                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If there is an answer for the size of the room, we retract
;; the question, update the size and ask the next question
(defrule QUESTION::answer-size
   (answer (question-id ?id) (name room-length) (value ?l))
   (answer (question-id ?id) (name room-width) (value ?w))
   ?question <- (question (question-id ?id))
=>
   (retract ?question)
   (assert (room-size (length ?l) (width ?w)))
   (assert (question (question-id window-door) (question-type window-door) (text "Please drag the window and door to proper positions."))))


;; If there is an answer for the position of the window and
;; of the door, we retract the question and ask the next
;; question
(defrule QUESTION::answer-window-door
   (answer (question-id ?id) (name window-x) (value ?wx))
   (answer (question-id ?id) (name window-y) (value ?wy))
   (answer (question-id ?id) (name door-x) (value ?dx))
   (answer (question-id ?id) (name door-y) (value ?dy))
   ?question <- (question (question-id ?id))
=>
   (retract ?question)
   (assert (window (x ?wx) (y ?wy)))
   (assert (door (x ?dx) (y ?dy)))
   (assert (question (question-id theme) (question-type list) (text "Please select your favorite theme(s) for the living room design: ") (valid-answers modern cozy nature warm))))


;; If there is an answer for the theme, we retract the
;; question and ask the next question
(defrule QUESTION::answer-theme
   (answer (question-id theme) (value ?v))
   ?question <- (question (question-id theme))
=>
   (assert (theme (theme ?v)))
   (retract ?question))


;; Ask the prefered distance between two categories
(defrule QUESTION::ask-distance-preference
   ?preference <- (preference-question (category1 ?cat1) (category2 ?cat2))
=>
   (assert (question (question-id (sym-cat ?cat1 ?cat2)) (question-type preference) (category1 ?cat1) (category2 ?cat2)
      (text (str-cat "What would be your preference for the distance between " ?cat1 " and " ?cat2 "?"))
      (valid-answers "As far as possible" "As close as possible"))))


;; If there is an answer for a preference of distance, we 
;; add a fact that corresponds to this preference
(defrule QUESTION::answer-distance-preference
   (answer (question-id ?id) (value ?v))
   ?question <- (question (question-id ?id) (question-type preference) (category1 ?cat1) (category2 ?cat2))
=>  
   (if (= (str-compare ?v "As close as possible") 0) then
      (assert (distance (category1 ?cat1) (category2 ?cat2)
         (prefer close)))
   else
      (assert (distance (category1 ?cat1) (category2 ?cat2)
         (prefer far))))
   (retract ?question))


;; Ask the prefered distance between the TV and the sofa
(defrule QUESTION::distance-TV-sofa
   (theme (theme modern|cozy))
=>
   (assert (preference-question (category1 TV) (category2 sofa))))


;; Ask the prefered distance between the sofa and the
;; bookshelf
(defrule QUESTION::distance-sofa-bookshelf
   (theme (theme cozy|warm))
=>
   (assert (preference-question (category1 sofa) (category2 bookshelf))))


;; Ask the prefered distance between the sofa and the cupboard
(defrule QUESTION::distance-sofa-cupboard
   (theme (theme modern|nature))
=>
   (assert (preference-question (category1 sofa) (category2 cupboard))))


;; Ask the prefered distance between the sofa and the piano
(defrule QUESTION::distance-sofa-piano
   (theme (theme nature|warm))
=>
   (assert (preference-question (category1 sofa) (category2 piano))))


;; Ask the prefered distance between the bookshelf and the
;; piano
(defrule QUESTION::distance-bookshelf-piano
   (theme (theme warm))
=>
   (assert (preference-question (category1 bookshelf) (category2 piano))))


;; Ask the prefered distance between the cupboard and the
;; piano
(defrule QUESTION::distance-cupboard-piano
   (theme (theme nature))
=>
   (assert (preference-question (category1 cupboard) (category2 piano))))


;; Ask the prefered distance between the window and the piano
(defrule QUESTION::distance-window-piano
   (theme (theme nature|warm))
=>
   (assert (preference-question (category1 window) (category2 piano))))


;; Ask the prefered distance between the door and the piano
(defrule QUESTION::distance-door-piano
   (theme (theme nature|warm))
=>
   (assert (preference-question (category1 door) (category2 piano))))


;; Ask the prefered distance between the window and the
;; bookshelf 
(defrule QUESTION::distance-window-bookshelf 
   (theme (theme cozy|warm))
=>
   (assert (preference-question (category1 window) (category2 bookshelf))))


;; Ask the prefered distance between the door and the
;; bookshelf 
(defrule QUESTION::distance-door-bookshelf 
   (theme (theme cozy|warm))
=>
   (assert (preference-question (category1 door) (category2 bookshelf))))


;; Ask the prefered distance between the window and the
;; cupboard
(defrule QUESTION::distance-window-cupboard
   (theme (theme modern|nature))
=>
   (assert (preference-question (category1 window) (category2 cupboard))))


;; Ask the prefered distance between the door and the
;; cupboard
(defrule QUESTION::distance-door-cupboard
   (theme (theme modern|nature))
=>
   (assert (preference-question (category1 door) (category2 cupboard))))


;; Ask the prefered distance between the window and the TV
(defrule QUESTION::distance-window-TV
   (theme (theme modern|cozy))
=>
   (assert (preference-question (category1 window) (category2 TV))))


;; Ask the prefered distance between the door and the TV
(defrule QUESTION::distance-door-TV
   (theme (theme modern|cozy))
=>
   (assert (preference-question (category1 door) (category2 TV))))


;; Ask the prefered distance between the window and the sofa
(defrule QUESTION::distance-window-sofa
   (theme (theme modern|cozy|nature|warm))
=>
   (assert (preference-question (category1 window) (category2 sofa))))


;; Ask the prefered distance between the door and the sofa
(defrule QUESTION::distance-door-sofa
   (theme (theme modern|cozy|nature|warm))
=>
   (assert (preference-question (category1 door) (category2 sofa))))








