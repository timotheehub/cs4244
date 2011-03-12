(deftemplate question
(slot question-id)
(slot text)
(multislot valid-answers))


(deftemplate answer
(slot question-id)
(slot attribute)
(slot value))

(deffacts the-facts
(question (question-id 1) (text "Please select your favorite theme(s) for the living room design: ") (valid-answers modern cozy nature warm))
(question (question-id 2) (text "What would be your preference for the distance between TV and sofa?") (valid-answers "As far as possible." "As close as possible."))
(question (question-id 3) (text "What would be your preference for the distance between TV and the door?") (valid-answers "As far as possible." "As close as possible."))
(question (question-id 4) (text "What would be your preference for the distance between sofa and the window?") (valid-answers "As far as possible." "As close as possible."))
(question (question-id 5) (text "What would be your preference for the distance between sofa and bookshelf?") (valid-answers "As far as possible." "As close as possible."))
(question (question-id 6) (text "What would be your preference for the distance between sofa and cabinet?") (valid-answers "As far as possible." "As close as possible."))
(question (question-id 7) (text "What would be your preference for the distance between sofa and piano?") (valid-answers "As far as possible." "As close as possible."))
(question (question-id 8) (text "What would be your preference for the distance between bookshelf and piano?") (valid-answers "As far as possible." "As close as possible."))
(question (question-id 9) (text "What would be your preference for the distance between cabinet and piano?") (valid-answers "As far as possible." "As close as possible."))
(question (question-id 10) (text "What would be your preference for the distance between piano and the window?") (valid-answers "As far as possible." "As close as possible."))
(question (question-id 11) (text "What would be your preference for the distance between piano and the door?") (valid-answers "As far as possible." "As close as possible."))
(question (question-id 12) (text "What would be your preference for the distance between bookshelf and the window?") (valid-answers "As far as possible." "As close as possible."))
(question (question-id 13) (text "What would be your preference for the distance between bookshelf and the door?") (valid-answers "As far as possible." "As close as possible."))
(question (question-id 14) (text "What would be your preference for the distance between cabinet and the window?") (valid-answers "As far as possible." "As close as possible."))
(question (question-id 15) (text "What would be your preference for the distance between cabinet and the door?") (valid-answers "As far as possible." "As close as possible."))
(question (question-id 16) (text "What would be your preference for the distance between TV and the window?") (valid-answers "As far as possible." "As close as possible."))
(question (question-id 17) (text "What would be your preference for the distance between TV and the door?") (valid-answers "As far as possible." "As close as possible."))


