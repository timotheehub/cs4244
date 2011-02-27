(deftemplate question
   (slot question-id)
   (slot text)
   (multislot valid-answers))

(deftemplate answer
   (slot question-id)
   (slot attribute)
   (slot value))

(deffacts the-facts
   (question (question-id 1) (text "Does it work?") (valid-answers "yes" "no")))