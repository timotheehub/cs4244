(deftemplate question
   (slot question-id)
   (slot question-type)
   (slot text)
   (multislot valid-answers))

(deftemplate answer
   (slot question-id)
   (slot name)
   (slot value))

(deffacts the-facts
   (question (question-id 1) (question-type size) (text "What is the size of the room?")))

(defrule answer-size
   (answer (question-id ?id) (name room-length) (value ?v))
   (answer (question-id ?id) (name room-width) (value ?w))
   ?question <- (question (question-id ?id))
=>
   (retract ?question)
   (assert (question (question-id 2) (question-type window-door) (text "Please drag the window and door to proper positions."))))

(defrule answer-window-door
   (answer (question-id ?id) (name window-x) (value ?wx))
   (answer (question-id ?id) (name window-y) (value ?wy))
   (answer (question-id ?id) (name door-x) (value ?dx))
   (answer (question-id ?id) (name door-y) (value ?dy))
   ?question <- (question (question-id ?id))
=>
   (retract ?question)
   (assert (question (question-id 3) (question-type list) (text "Please select your favorite theme(s) for the living room design: ") (valid-answers modern cozy nature warm))))

(defrule answer-theme
   (answer (question-id ?id) (name list) (value ?v))
   ?question <- (question (question-id ?id))
=>
   (retract ?question))
