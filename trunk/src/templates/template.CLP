; ; Template may not be the best way to represent the furnitures. Using classes can be
; ; an alternative.

; ; The global variables that stores the length and the width of the room.
; ; The values should be changed once the user is prompted for the size of the room.
(defglobal ?*length* = 0)
(defglobal ?*width* = 0)

; ; Furniture is a template to store the information of furnitures.
; ; Each furniture should have a distinct id.
; ; Windows and doors can be considered as furniture as well.
; ; Maybe we need to specified the allowed values for each of the attributes.
(deftemplate furniture
    (slot id (type INTEGER))
    (slot function (type SYMBOL))
    (slot name (type SYMBOL))
    (slot color (type SYMBOL))
    (multislot theme (type SYMBOL))
    (slot length (type INTEGER) (default NIL))
    (slot width (type INTEGER) (default NIL))
    (slot height (type INTEGER) (default NIL))
)

; ; The space the furniture occupies.
; ; fid is the id of the furniture.
; ; (x1,y1) is the position of the top-left corner of the furniture in the room.
; ; (x2,y2) is the position of the bottom-right corner of the furniture in the room.
; ; Note that since the furniture could have two kinds of orientations, thus x2-x1 may not always
; ; represent the length.
(deftemplate furniture-pos
    (slot fid (type INTEGER))
    (slot x1 (type INTEGER))
    (slot y1 (type INTEGER))
    (slot x2 (type INTEGER))
    (slot y2 (type INTEGER))
)

; ; The room.
(deftemplate room
    (slot length (type INTEGER))
    (slot width (type INTEGER))
)


;;(defrule test
;;    (not (room))
;;=>
;;    (printout t "Enter the size of the room: ")
;;    (bind ?*length* (read))
;;    (bind ?*width* (read))
;;    (assert (room (length ?*length*) (width ?*width*))))

; ; The theme.
; ; We could add the allowed values for the theme.
(deftemplate theme
    (slot theme (allowed-values modern warm nature cozy))
)

; ; The preferred distances between different categories of furnitures.
; ; I guess we do not need to allow the user to input the exact values.
; ; Just how apart they should be will do.
; ; If the user do not care, then do not create a fact.
(deftemplate distance
    (slot cat1 (type SYMBOL))
    (slot cat2 (type SYMBOL))
    (slot prefer (allowed-values close far))
)

