;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                     Define modules                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Control flow with modules
(defmodule MAIN (export ?ALL)) 
(defmodule QUESTION (import MAIN ?ALL))
(defmodule SELECTION (import MAIN ?ALL))
(defmodule SELECTION-QUESTION (import MAIN ?ALL))
(defmodule POSITIONING (import MAIN ?ALL))
(defmodule LAYOUT (import MAIN ?ALL))
(defmodule COLOR (import MAIN ?ALL))
(defmodule FINAL-LAYOUT (import MAIN ?ALL))





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


;; Room size template. Length and Width are in units of 10 centimeters.
(deftemplate MAIN::room-size
   (slot length (type INTEGER))
   (slot width (type INTEGER)))


;; Window template. X and Y are in millimeters.
(deftemplate MAIN::window
   (slot toleft (type INTEGER))
   (slot toright (type INTEGER))
   (slot totop (type INTEGER))
   (slot tobottom (type INTEGER))
   (slot orientation (allowed-values left right top bottom)))


;; Door template. X and Y are in millimeters.
(deftemplate MAIN::door
   (slot toleft (type INTEGER))
   (slot toright (type INTEGER))
   (slot totop (type INTEGER))
   (slot tobottom (type INTEGER))
   (slot orientation (allowed-values left right top bottom)))


;; The preferred distances between different categories of
;; furnitures
(deftemplate MAIN::distance
   (slot category1 (type SYMBOL)) 
   (slot category2 (type SYMBOL))
   (slot prefer (allowed-values close far))
   (multislot range (type FLOAT)))


;; Furniture is a template to store the information of
;; furnitures.
;; Each furniture should have a distinct id.
(deftemplate MAIN::furniture
	(slot id)
	(slot function (type SYMBOL))
	(slot name (type SYMBOL))
	(slot color (type SYMBOL))
	(multislot theme (type SYMBOL))
	(slot length (type INTEGER))
	(slot width (type INTEGER))
	(slot height (type INTEGER))
)


;; Copy-furniture is a template to store the information of
;; furnitures. Each furniture has a copy so that when we
;; remove a furniture, we still have access to the copy.
(deftemplate MAIN::copy-furniture
	(slot id)
	(slot function (type SYMBOL))
	(slot name (type SYMBOL))
	(slot color (type SYMBOL))
	(multislot theme (type SYMBOL))
	(slot length (type INTEGER))
	(slot width (type INTEGER))
	(slot height (type INTEGER))
)



;; The space the furniture occupies.
;; fid is the id of the furniture.
;; (x1,y1) is the position of the top-left corner of the
;; furniture in the room.
;; (x2,y2) is the position of the bottom-right corner of the
;; furniture in the room.
;; Note that since the furniture could have two kinds of
;; orientations, thus x2-x1 may not always
;; represent the length.
;; 4 orientations.
(deftemplate furniture-pos
(slot fid (type SYMBOL))
(slot orientation (allowed-values left right top bottom vertical horizontal))
(slot toleft (type INTEGER))
(slot toright (type INTEGER))
(slot totop (type INTEGER))
(slot tobottom (type INTEGER))
)






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       MAIN facts                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Main facts
(deffacts MAIN::the-facts
	(question (question-id size) (question-type size) (text "What is the size of the room?")))


;; Define facts for furniture database. 
;; Included every category furniture
(deffacts MAIN::furniture-database
(furniture (id TV0001) (function TV) (name LG-47-FULL-LED-TV) (color black) (theme modern cozy nature warm) (length 1127)(width 285) (height 762))
(furniture (id TV0002) (function TV) (name PANASONIC-42-Full-HD-PLASMA-TV) (color silver) (theme modern cozy nature warm) (length 1080)(width 320)(height 682))
(furniture (id TV0003) (function TV) (name SAMSUNG-32-Full-HD-LCD-TV) (color black) (theme modern cozy nature warm) (length 865) (width 79) (height 500))
(furniture (id TV0004) (function TV) (name PHILIPS-40-Full-HD-LED-TV) (color black) (theme modern cozy nature warm) (length 977) (width 236) (height 649))
(furniture (id TV0005) (function TV) (name PANASONIC-22-LCD-TV) (color silver) (theme modern cozy nature warm) (length 798) (width 93) (height 378))
(furniture (id TV0006) (function TV) (name TOSHIBA-55-LED-TV) (color black) (theme modern cozy nature warm) (length 1319) (width 48) (height 837))
(furniture (id TV0007) (function TV) (name PANASONIC-37-LED-TV) (color black) (theme modern cozy nature warm) (length 1041) (width 381) (height 632))
(furniture (id TV0008) (function TV) (name SAMSUNG-46-LED-TV) (color silver) (theme modern cozy nature warm) (length 1091) (width 302) (height 723))
(furniture (id TV0009) (function TV) (name TOSHIBA-47-LED-TV) (color black) (theme modern cozy nature warm) (length 1020) (width 329) (height 761))
(furniture (id TV0010) (function TV) (name TOSHIBA-24-FLAT-SCREEN-TV) (color silver) (theme cozy nature warm) (length 762) (width 610) (height 680))
(furniture (id TV0011) (function TV) (name LG-50-PLASMA-TV) (color black) (theme modern cozy nature warm) (length 1171) (width 309) (height 782))

(furniture (id SOFA0001) (function sofa) (name ARILD-3-seater-sofa) (color black) (theme modern cozy) (length 2070)(width 940) (height 810))
(furniture (id SOFA0002) (function sofa) (name ARILD-3-seater-sofa) (color white) (theme modern cozy nature warm) (length 2070) (width 940) (height 810))
(furniture (id SOFA0003) (function sofa) (name ARILD-2-seater-sofa) (color black) (theme modern cozy) (length 1560) (width 940) (height 810))
(furniture (id SOFA0004) (function sofa) (name ARILD-2-seater-sofa) (color white) (theme modern cozy nature warm) (length 1560)(width 940) (height 810))
(furniture (id SOFA0005) (function sofa) (name EKTORP-2-seater-sofa) (color blue) (theme cozy nature warm) (length 1385)(width 740) (height 800))
(furniture (id SOFA0006) (function sofa) (name EKTORP-3-seater-sofa) (color white) (theme modern cozy nature warm) (length 2590)(width 770) (height 730))
(furniture (id SOFA0007) (function sofa) (name EKTORP-3-seater-sofa) (color black) (theme modern cozy) (length 2590)(width 770) (height 730))
(furniture (id SOFA0008) (function sofa) (name EKTORP-3-seater-sofa) (color blue) (theme modern cozy nature) (length 2590)(width 770) (height 730))
(furniture (id SOFA0009) (function sofa) (name EKTORP-3-seater-sofa) (color green) (theme cozy nature) (length 2590)(width 770) (height 730))
(furniture (id SOFA0010) (function sofa) (name EKTORP-2-seater-sofa) (color white) (theme modern cozy nature warm) (length 1080)(width 770) (height 730))
(furniture (id SOFA0011) (function sofa) (name EKTORP-2-seater-sofa) (color black) (theme modern cozy) (length 1080)(width 770) (height 730))
(furniture (id SOFA0012) (function sofa) (name EKTORP-2-seater-sofa) (color red) (theme cozy warm) (length 1080)(width 770) (height 730))
(furniture (id SOFA0013) (function sofa) (name EKTORP-2-seater-sofa) (color dark-brown) (theme cozy nature warm) (length 1080)(width 770) (height 730))
(furniture (id SOFA0014) (function sofa) (name EKTORP-2-seater-sofa) (color flory) (theme cozy nature warm) (length 1080)(width 770) (height 730))
(furniture (id SOFA0015) (function sofa) (name IKEA-STOCKHOLM-3-seater-sofa) (color black) (theme modern cozy) (length 2120)(width 890) (height 720))
(furniture (id SOFA0016) (function sofa) (name IKEA-STOCKHOLM-3-seater-sofa) (color white) (theme modern cozy nature warm) (length 2120)(width 890) (height 720))
(furniture (id SOFA0017) (function sofa) (name KARLSTAD-armchair) (color black) (theme modern cozy) (length 970)(width 940) (height 810))
(furniture (id SOFA0018) (function sofa) (name KARLSTAD-armchair) (color flory) (theme cozy nature warm) (length 970)(width 940) (height 810))
(furniture (id SOFA0019) (function sofa) (name KARLSTAD-armchair) (color red) (theme cozy warm) (length 970)(width 940) (height 810))
(furniture (id SOFA0020) (function sofa) (name KARLSTAD-armchair) (color blue) (theme modern cozy nature) (length 970)(width 940) (height 810))
(furniture (id SOFA0021) (function sofa) (name KARLSTAD-corner-sofa) (color red) (theme cozy warm) (length 2800)(width 930) (height 800))
(furniture (id SOFA0022) (function sofa) (name KARLSTAD-corner-sofa) (color blue) (theme modern cozy nature) (length 2800)(width 930) (height 800))
(furniture (id SOFA0023) (function sofa) (name KARLSTAD-corner-sofa) (color black) (theme modern cozy) (length 2800)(width 930) (height 800))
(furniture (id SOFA0024) (function sofa) (name KARLSTAD-corner-sofa) (color white) (theme modern cozy nature warm) (length 2800)(width 930) (height 800))
(furniture (id SOFA0025) (function sofa) (name ARMADIO-CARONIA-3-seater-sofa) (color white) (theme cozy nature warm) (length 2060)(width 940) (height 930))
(furniture (id SOFA0026) (function sofa) (name ARMADIO-SEVESCO-3-seater-sofa) (color red) (theme cozy warm) (length 2040)(width 1000) (height 880))
(furniture (id SOFA0027) (function sofa) (name ARMADIO-SEVESCO-2-seater-sofa) (color red) (theme cozy warm) (length 1560)(width 1000) (height 880))
(furniture (id SOFA0028) (function sofa) (name ARMADIO-LEON-3-seatere-sofa) (color purple) (theme modern cozy) (length 2210)(width 1030) (height 910))
(furniture (id SOFA0029) (function sofa) (name DYNAMIC-PICENO-CHESTERFIELD-3-seater-sofa) (color dark-brown) (theme cozy nature warm) (length 2160)(width 750) (height 890))
(furniture (id SOFA0030) (function sofa) (name DYNAMIC-PICENO-CHESTERFIELD-2-seater-sofa) (color dark-brown) (theme cozy nature warm) (length 1650)(width 750) (height 890))
(furniture (id SOFA0031) (function sofa) (name ITALSOFA-CROSIA-3-seater-sofa) (color pink) (theme cozy nature warm) (length 2240)(width 950) (height 850))
(furniture (id SOFA0032) (function sofa) (name ITALSOFA-VEGA-3-seater-sofa) (color red) (theme cozy nature warm) (length 2250)(width 950) (height 950))
(furniture (id SOFA0033) (function sofa) (name LORENZO-BRAXTON-3-seater-sofa) (color green) (theme cozy nature) (length 2240)(width 950) (height 800))
(furniture (id SOFA0034) (function sofa) (name DYNAMIC-MARCEL-3-seater-sofa) (color green) (theme cozy nature) (length 2180)(width 950) (height 950))
(furniture (id SOFA0035) (function sofa) (name DYNAMIC-LUCIA-3-seater-sofa) (color brown) (theme cozy nature) (length 2130)(width 820) (height 860))
(furniture (id SOFA0036) (function sofa) (name DYNAMIC-CARLA-3-seater-sofa) (color red) (theme cozy warm) (length 2130)(width 960) (height 910))
(furniture (id SOFA0037) (function sofa) (name DYNAMIC-CARLA-2-seater-sofa) (color red) (theme cozy warm) (length 1520)(width 960) (height 910))
(furniture (id SOFA0038) (function sofa) (name KINGKOIL-IP-SWICH-3-seater-sofa) (color purple) (theme cozy) (length 2110)(width 920) (height 860))
(furniture (id SOFA0039) (function sofa) (name KINGKOIL-RENEE-3-seater-sofa) (color red) (theme cozy warm) (length 1980)(width 940) (height 910))
(furniture (id SOFA0040) (function sofa) (name KINGKOIL-RENEE-2-seater-sofa) (color red) (theme cozy warm) (length 1480)(width 940) (height 910))
(furniture (id SOFA0041) (function sofa) (name STITCH-ALLERGO-2-seater-sofa) (color flory) (theme cozy warm) (length 1390)(width 890) (height 870))
(furniture (id SOFA0042) (function sofa) (name SILENTNIGHT-3-seater-sofa) (color flory) (theme cozy warm) (length 1950)(width 850) (height 840))
(furniture (id SOFA0043) (function sofa) (name SILENTNIGHT-2-seater-sofa) (color flory) (theme cozy warm) (length 1400)(width 850) (height 840))
(furniture (id SOFA0044) (function sofa) (name DYNAMIC-VINO-3-seater-sofa) (color flory) (theme cozy nature warm) (length 2200)(width 850) (height 840))
(furniture (id SOFA0045) (function sofa) (name DYNAMIC-VINO-2-seater-sofa) (color flory) (theme cozy nature warm) (length 1450)(width 850) (height 840))

(furniture (id CB0001) (function cupboard) (name IKEA-STOCKHOLM-BENCH) (color black) (theme modern cozy) (length 1650) (width 1650) (height 1000))
(furniture (id CB0002) (function cupboard) (name BATON-BUFFET) (color black) (theme cozy nature) (length 1200) (width 420) (height 830))
(furniture (id CB0003) (function cupboard) (name NEW_ASHBOURNE_BUFFET_UNITRICOLO_OAK) (color brown) (theme cozy nature warm) (length 1150) (width 440) (height 830))
(furniture (id CB0004) (function cupboard) (name VIZZINI-DISPLAY-cabinet) (color black-brown) (theme modern cozy nature warm) (length 1070) (width 480) (height 1160))
(furniture (id CB0005) (function cupboard) (name AVOLA-ROOMDIVIDER) (color brown) (theme cozy nature warm) (length 1530) (width 320) (height 1800))
(furniture (id CB0006) (function cupboard) (name CATANIA-WALLDIVIDER) (color white) (theme modern cozy) (length 1000) (width 380) (height 1090))
(furniture (id CB0007) (function cupboard) (name IKEA-STOCKHOLM-glass-door-cabinet) (color brown) (theme modern cozy nature warm) (length 1305) (width 1305) (height 1740))
(furniture (id CB0008) (function cupboard) (name BESTA-Wall-Shelf) (color black) (theme modern cozy) (length 1200) (width 200) (height 640))
(furniture (id CB0009) (function cupboard) (name IKEA-STOCKHOLM-glass-door-cabinet) (color black) (theme modern cozy) (length 1305) (width 1305) (height 1740))
(furniture (id CB0010) (function cupboard) (name IVAR-chest-of-3-drawers) (color brown) (theme cozy nature warm) (length 800) (width 500) (height 570))
(furniture (id CB0011) (function cupboard) (name KLINGSBO-glass-door-cabinet) (color black) (theme modern cozy) (length 450) (width 450) (height 1800))
(furniture (id CB0012) (function cupboard) (name KLINGSBO-glass-door-cabinet) (color black) (theme modern cozy) (length 1200) (width 400) (height 800))
(furniture (id CB0013) (function cupboard) (name SILENTNIGHT-TALBOT) (color white) (theme cozy nature warm) (length 1000) (width 350) (height 750))
(furniture (id CB0014) (function cupboard) (name SILENTNIGHT-SOMERTON-SIDEBOARD) (color black) (theme modern cozy nature warm) (length 1000) (width 350) (height 750))
(furniture (id CB0015) (function cupboard) (name HEMNES-glass-door-cabinet) (color brown) (theme cozy nature warm) (length 900) (width 370) (height 1970))

(furniture (id PIANO0001) (function piano) (name KAWAI-K15-E) (color black) (theme cozy nature warm) (length 1490) (width 590) (height 1100))
(furniture (id PIANO0002) (function piano) (name YAMAHA-YUS1) (color black) (theme modern cozy warm) (length 1520) (width 610) (height 1210))
(furniture (id PIANO0003) (function piano) (name YAMAHA-YUS5) (color black) (theme modern cozy warm) (length 1520) (width 650) (height 1310))
(furniture (id PIANO0004) (function piano) (name YAMAHA-U1) (color brown) (theme cozy nature warm) (length 1530) (width 610) (height 1210))
(furniture (id PIANO0005) (function piano) (name YAMAHA-CFX) (color black) (theme modern cozy nature warm) (length 1530) (width 1530) (height 1210))
(furniture (id PIANO0006) (function piano) (name YAMAHA-YDP-V240) (color dark-brown) (theme cozy nature warm) (length 1369) (width 502) (height 852))
(furniture (id PIANO0007) (function piano) (name YAMAHA-CVP-409GP) (color black) (theme modern cozy warm) (length 1435) (width 1147) (height 905))

(furniture (id BS0001) (function bookshelf) (name BILLY-Bookcase) (color red) (theme cozy warm) (length 800) (width 280) (height 2020))
(furniture (id BS0002) (function bookshelf) (name EXPEDIT-Bookcase) (color black) (theme modern cozy nature) (length 1850) (width 390) (height 1850))
(furniture (id BS0003) (function bookshelf) (name BESTA-shelf) (color white) (theme modern cozy) (length 1200) (width 400) (height 1280))
(furniture (id BS0004) (function bookshelf) (name BESTA-shelf) (color dark-brown) (theme cozy nature warm) (length 600) (width 400) (height 1920))
(furniture (id BS0005) (function bookshelf) (name BILLY-Bookcase) (color blue) (theme cozy nature) (length 800) (width 280) (height 2020))
(furniture (id BS0006) (function bookshelf) (name BILLY-Bookcase) (color brown) (theme cozy nature warm) (length 800) (width 280) (height 1020))
(furniture (id BS0007) (function bookshelf) (name BILLY-Bookcase) (color white) (theme modern cozy nature warm) (length 400) (width 280) (height 2202))
(furniture (id BS0008) (function bookshelf) (name EXPEDIT-Bookcase) (color white) (theme modern cozy nature warm) (length 1850) (width 390) (height 1850))
(furniture (id BS0009) (function bookshelf) (name EXPEDIT-shelf) (color black) (theme modern cozy nature) (length 890) (width 390) (height 1490))
(furniture (id BS0010) (function bookshelf) (name EXPEDIT-shelf) (color black) (theme modern cozy nature) (length 440) (width 390) (height 1850))
(furniture (id BS0011) (function bookshelf) (name HEMNES-Bookcase) (color grey) (theme cozy nature warm) (length 900) (width 370) (height 1970))
(furniture (id BS0012) (function bookshelf) (name HEMNES-Bookcase) (color white) (theme modern cozy nature warm) (length 900) (width 370) (height 1970))
(furniture (id BS0013) (function bookshelf) (name KILBY-Bookcase) (color beige) (theme cozy nature warm) (length 670) (width 240) (height 1940))
(furniture (id BS0014) (function bookshelf) (name LACK-Bookcase) (color red) (theme cozy nature warm) (length 1050) (width 380) (height 1900))
(furniture (id BS0015) (function bookshelf) (name LAVIA-Bookcase) (color black) (theme modern cozy) (length 620) (width 240) (height 1650))
)




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       MAIN rules                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; The first focus must be on QUESTION when there is a new
;; answer
(defrule MAIN::answer-focus-question
   (answer (question-id ?id))
   (question (question-id ?id)
      (question-type ~furniture-preference&~advice&~layout&~final-layout))
   =>
   (focus QUESTION))


;; If we know the theme and all the preference question has
;; been answered then we will ask the selection question
(defrule MAIN::focus-selection
   (distance)
   (furniture (id ?id1) (function ?function))
   (furniture (id ?id2&~?id1) (function ?function))
   (not(exists(question)))
   =>
   (focus SELECTION SELECTION-QUESTION))


;; If there is an answer for a furniture-preference question,
;; we will ask the next selection question
(defrule MAIN::answer-focus-selection-question
   (answer (question-id ?id))
   (question (question-id ?id)
      (question-type furniture-preference))
   =>
   (focus SELECTION-QUESTION))


;; If there is an answer for an advice, we show the next
;; advice.
(defrule MAIN::answer-focus-color
   (answer (question-id ?id))
   (question (question-id ?id)
      (question-type advice))
   =>
   (focus COLOR POSITIONING FINAL-LAYOUT))


;; If there is at most one furniture of each type, we place
;; the objects then we show the layout
(defrule MAIN::focus-layout
   (forall (furniture (id ?id1) (function ?function))
      (not(exists(furniture (id ?id2&~?id1) (function ?function)))))
   (not(exists(furniture-pos)))
   =>
   (focus POSITIONING LAYOUT))
  

;; If there is an answer for a layout, we retract the question
;; and show the advices
(defrule MAIN::answer-focus-layout
   (answer (question-id ?id))
   (question (question-id ?id)
      (question-type layout))
   =>
   (focus LAYOUT COLOR))



;; If there is an answer for the final layout, we retract the ;; question
(defrule MAIN::answer-focus-final-layout
   (answer (question-id ?id))
   (question (question-id ?id)
      (question-type final-layout))
   =>
   (focus FINAL-LAYOUT))


;; Copy all the furnitures
(defrule MAIN::copy-all-furnitures
   (furniture (id ?id) (function ?function) (name ?name)
      (color ?color) (theme $?theme) (length ?length)
      (width ?width) (height ?height))
=>
   (assert (copy-furniture (id ?id) (function ?function)
      (name ?name) (color ?color) (theme $?theme)
      (length ?length) (width ?width) (height ?height))))






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                     MAIN functions                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Tests if the two furnitures will overlap.
(deffunction MAIN::overlap (?tl1 ?tr1 ?tt1 ?tb1 ?tl2 ?tr2 ?tt2 ?tb2 ?rlength ?rwidth)
    (if (and (< (+ (max ?tl1 ?tl2) (max ?tr1 ?tr2)) ?rlength) (< (+ (max ?tt1 ?tt2) (max ?tb1 ?tb2)) ?rwidth)) then
        (return True)
     else
        (return False))
    (return False))





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
   (answer (question-id ?id) (name window-toleft) (value ?wl))
   (answer (question-id ?id) (name window-toright) (value ?wr))
   (answer (question-id ?id) (name window-totop) (value ?wt))
   (answer (question-id ?id) (name window-tobottom) (value ?wb))
   (answer (question-id ?id) (name window-orientation) (value ?wo))
   (answer (question-id ?id) (name door-toleft) (value ?dl))
   (answer (question-id ?id) (name door-toright) (value ?dr))
   (answer (question-id ?id) (name door-totop) (value ?dt))
   (answer (question-id ?id) (name door-tobottom) (value ?db))
   (answer (question-id ?id) (name door-orientation) (value ?do))
   ?question <- (question (question-id ?id))
=>
   (retract ?question)
   (assert (window (toleft ?wl) (toright ?wr) (totop ?wt)
(tobottom ?wb) (orientation ?wo)))
   (assert (door (toleft ?dl) (toright ?dr) (totop ?dt)
(tobottom ?db) (orientation ?do)))
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
      (valid-answers "As far as possible" "As close as possible")))
    (retract ?preference))


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





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                    SELECTION rules                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Remove all the furniture that is not suitable with
;; modern
(defrule SELECTION::modern-selection
	(theme (theme modern))
	;;Use $?theme as theme is multifield and I am using subset property to find out which furniture don't have (modern)
	?notmodern <- (furniture (theme $?theme&:(not (subsetp (create$ modern) $?theme))))
=>
	(retract ?notmodern)
)

;; Remove all the furniture that is not suitable with
;; warm
(defrule SELECTION::warm-selection
	(theme (theme warm))
	;;Use $?theme as theme is multifield and I am using subset property to find out which furniture don't have (warm)
	?notwarm <- (furniture (theme $?theme&:(not (subsetp (create$ warm) $?theme))))
=>
	(retract ?notwarm)
)

;; Remove all the furniture that is not suitable with
;; cozy
(defrule SELECTION::cozy-selection
	(theme (theme cozy))
	;;Use $?theme as theme is multifield and I am using subset property to find out which furniture don't have (cozy)
	?notcozy <- (furniture (theme $?theme&:(not (subsetp (create$ cozy) $?theme))))
=>
	(retract ?notcozy)
)

;; Remove all the furniture that is not suitable with nature
(defrule SELECTION::nature-selection
	(theme (theme nature))
	;;Use $?theme as theme is multifield and I am using subset property to find out which furniture don't have (nature)
	?notnature <- (furniture (theme $?theme&:(not (subsetp (create$ nature) $?theme))))
=>
	(retract ?notnature)
)

;; Size rules;;;;;
;; Simple rule: Take a furniture, compare its size with room
;; size. If the furniture is larger, retract it from facts.
(defrule SELECTION::eliminate-wrong-size-furniture
	(room-size (length ?room-l) (width ?room-w))
	(test (> ?room-l 0))
	(test (> ?room-w 0))
	?largefurniture <- (furniture (length ?l) (width ?w))
	;;roomarea = (* ?room-l ?room-w)
	;;furniturearea = (* ?l ?w)
	;;if roomarea is smaller than the furniturearea, remove the furniture from the facts
	(test (<= (* ?room-l ?room-w) (* 4 ?l ?w)))
=>
	(retract ?largefurniture)
)


;; Create a default distance preference between TV and door 
;; if no distance preference has been chosen
(defrule SELECTION::create-preference-TV-door
   (not (exists (distance (category1 TV|door) (category2 TV|door))))
=>
   (assert (distance (category1 TV) (category2 door) (prefer far)))
)


;; Create a default distance preference between TV and window
;; if no distance preference has been chosen
(defrule SELECTION::create-preference-TV-window
   (not (exists (distance (category1 TV|window) (category2 TV|window))))
=>
   (assert (distance (category1 TV) (category2 window) (prefer far)))
)

;; Create a default distance preference between cupboard and 
;; door if no distance preference has been chosen
(defrule SELECTION::create-preference-cupboard-door
   (not (exists (distance (category1 cupboard|door) (category2 cupboard|door))))
=>
   (assert (distance (category1 cupboard) (category2 door) (prefer far)))
)


;; Create a default distance preference between cupboard and 
;; window if no distance preference has been chosen
(defrule SELECTION::create-preference-cupboard-window
   (not (exists (distance (category1 cupboard|window) (category2 cupboard|window))))
=>
   (assert (distance (category1 cupboard) (category2 window) (prefer far)))
)


;; Create a default distance preference between bookshelf and 
;; door if no distance preference has been chosen
(defrule SELECTION::create-preference-bookshelf-door
   (not (exists (distance (category1 bookshelf|door) (category2 bookshelf|door))))
=>
   (assert (distance (category1 bookshelf) (category2 door) (prefer far)))
)


;; Create a default distance preference between bookshelf and 
;; window if no distance preference has been chosen
(defrule SELECTION::create-preference-bookshelf-window
   (not (exists (distance (category1 bookshelf|window) (category2 bookshelf|window))))
=>
   (assert (distance (category1 bookshelf) (category2 window) (prefer far)))
)


;; Create a default distance preference between piano and 
;; door if no distance preference has been chosen
(defrule SELECTION::create-preference-piano-door
   (not (exists (distance (category1 piano|door) (category2 piano|door))))
=>
   (assert (distance (category1 piano) (category2 door) (prefer far)))
)


;; Create a default distance preference between piano and 
;; window if no distance preference has been chosen
(defrule SELECTION::create-preference-piano-window
   (not (exists (distance (category1 piano|window) (category2 piano|window))))
=>
   (assert (distance (category1 piano) (category2 window) (prefer far)))
)


;; Create a default distance preference between sofa and 
;; door if no distance preference has been chosen
(defrule SELECTION::create-preference-sofa-door
   (not (exists (distance (category1 sofa|door) (category2 sofa|door))))
=>
   (assert (distance (category1 sofa) (category2 door) (prefer far)))
)


;; Create a default distance preference between sofa and 
;; window if no distance preference has been chosen
(defrule SELECTION::create-preference-sofa-window
   (not (exists (distance (category1 sofa|window) (category2 sofa|window))))
=>
   (assert (distance (category1 sofa) (category2 window) (prefer far)))
)


;; Create a default distance preference between sofa and 
;; bookshelf if no distance preference has been chosen
(defrule SELECTION::create-preference-sofa-bookshelf
   (not (exists (distance (category1 sofa|bookshelf) (category2 sofa|bookshelf))))
=>
   (assert (distance (category1 sofa) (category2 bookshelf) (prefer far)))
)


;; Create a default distance preference between sofa and 
;; cupboard if no distance preference has been chosen
(defrule SELECTION::create-preference-sofa-cupboard
   (not (exists (distance (category1 sofa|cupboard) (category2 sofa|cupboard))))
=>
   (assert (distance (category1 sofa) (category2 cupboard) (prefer far)))
)


;; Create a default distance preference between sofa and TV
;; if no distance preference has been chosen
(defrule SELECTION::create-preference-sofa-TV
   (not (exists (distance (category1 sofa|TV) (category2 sofa|TV))))
=>
   (assert (distance (category1 sofa) (category2 TV) (prefer far)))
)





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;               SELECTION-QUESTION rules                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; If more than one facts were selected, need to prompt question
;; to user to ask them to select their preference furniture.
;; Every furniture categories will be covered.
;; The value that capture would be the ID of the furniture.
(defrule SELECTION-QUESTION::user-select-furniture
	(furniture (id ?id1) (function ?function)) 
	(furniture (id ?id2&~?id1) (function ?function))
     (not(exists(question)))
=> 
	(assert (question (question-id (sym-cat ?id1 ?id2)) (question-type furniture-preference) (text "Please select you favorite furniture.") (valid-answers ?id1 ?id2))))


;; Apply the rules when the question is answered
(defrule SELECTION-QUESTION::answer-user-select-furniture
   (answer (question-id ?id) (value ?v))
   ?question <- (question (question-id ?id) (question-type furniture-preference) (valid-answers ?id1 ?id2))
   ?furniture1 <- (furniture (id ?id1))
   ?furniture2 <- (furniture (id ?id2))
=>
   (if (= (str-compare ?v ?id1) 0) then
        (retract ?furniture2)
   else
        (retract ?furniture1))
   (retract ?question)
)




	 



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                   POSITIONING rules                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; rank the sides of the place to start with based on the preference of the user.
(deffunction POSITIONING::rank (?distance ?wl ?wr ?wt ?wb)
    (bind ?rankleft 0)
    (bind ?rankright 0)
    (bind ?ranktop 0)
    (bind ?rankbottom 0)
    (if (eq ?distance far) then 
        (if (> ?wl ?wr) then
            (bind ?rankleft (+ ?rankleft 1))
         else
            (bind ?rankright (+ ?rankright 1)))
        (if (> ?wt ?wb) then
            (bind ?ranktop (+ ?ranktop 1))
         else
            (bind ?rankbottom (+ ?rankbottom 1)))
        (if (> ?wl ?wt) then
            (bind ?rankleft (+ ?rankleft 1))
         else
            (bind ?ranktop (+ ?ranktop 1)))
        (if (> ?wl ?wb) then
            (bind ?rankleft (+ ?rankleft 1))
         else
            (bind ?rankbottom (+ ?rankbottom 1)))
        (if (> ?wt ?wr) then
            (bind ?ranktop (+ ?ranktop 1))
         else
            (bind ?rankright (+ ?rankright 1)))
        (if (> ?wr ?wb) then
            (bind ?rankright (+ ?rankright 1))
         else
            (bind ?rankbottom (+ ?rankbottom 1)))
     else
        (if (< ?wl ?wr) then
            (bind ?rankleft (+ ?rankleft 1))
         else
            (bind ?rankright (+ ?rankright 1)))
        (if (< ?wt ?wb) then
            (bind ?ranktop (+ ?ranktop 1))
         else
            (bind ?rankbottom (+ ?rankbottom 1)))
        (if (< ?wl ?wt) then
            (bind ?rankleft (+ ?rankleft 1))
         else
            (bind ?ranktop (+ ?ranktop 1)))
        (if (< ?wl ?wb) then
            (bind ?rankleft (+ ?rankleft 1))
         else
            (bind ?rankbottom (+ ?rankbottom 1)))
        (if (< ?wt ?wr) then
            (bind ?ranktop (+ ?ranktop 1))
         else
            (bind ?rankright (+ ?rankright 1)))
        (if (< ?wr ?wb) then
            (bind ?rankright (+ ?rankright 1))
         else
            (bind ?rankbottom (+ ?rankbottom 1))))
    (return (create$ ?rankleft ?rankright ?ranktop ?rankbottom)))


;; a template to store the start position of the furniture
(deftemplate POSITIONING::current-pos 
    (slot fid (type SYMBOL))
    (slot toleft (type INTEGER))
    (slot toright (type INTEGER))
    (slot totop (type INTEGER))
    (slot tobottom (type INTEGER))
    (slot direction (type SYMBOL))
    (slot orientation (type SYMBOL))
    (slot cycle (allowed-values c cc))
    (slot fixed (type SYMBOL))
)


;; a template define in which range (rectangle) a furniture
;; can be put
(deftemplate MAIN::range
    (slot fid (type SYMBOL))
    (slot toleftmin (type INTEGER))
    (slot toleftmax (type INTEGER))
    (slot totopmin (type INTEGER))
    (slot totopmax (type INTEGER)))


;; loop to find the position of the furniture
;; needs to be modified for turning.
(defrule POSITIONING::loop-for-position
    ?f <- (current-pos (fid ?fid)(toleft ?tl)(toright ?tr)(totop ?tt)(tobottom ?tb)(direction ?d)(orientation ?o)(cycle ?c))
    (room-size (length ?rlength) (width ?rwidth))
    (furniture (id ?fid) (function ~sofa)(length ?length) (width ?width))
    (exists (and (furniture-pos (toleft ?tl1) (toright ?tr1) (totop ?tt1) (tobottom ?tb1)) (test (eq (overlap ?tl ?tr ?tt ?tb ?tl1 ?tr1 ?tt1 ?tb1 ?rlength ?rwidth) True))))
=>
    (if (eq ?c c) then (switch ?d 
        (case left then (if (< (- ?tl 100) 0) then (modify ?f (direction top)(orientation left)(toleft 0)(toright (- ?rlength ?width))(totop (- (- ?rwidth ?length) ?tb))) else (modify ?f (toleft (- ?tl 100)) (toright (+ ?tr 100)))))
        (case right then (if (< (- ?tr 100) 0) then (modify ?f (direction bottom)(orientation right)(toright 0)(toleft (- ?rlength ?width))(tobottom (- (- ?rwidth ?length) ?tt))) else (modify ?f (toleft (+ ?tl 100)) (toright (- ?tr 100)))))
        (case top then (if (< (- ?tt 100) 0) then (modify ?f (direction right)(orientation top)(totop 0)(tobottom (- ?rwidth ?width))(toright (- (- ?rlength ?length) ?tl))) else (modify ?f (totop (- ?tt 100))(tobottom (+ ?tb 100)))))
        (case bottom then (if (< (- ?tb 100) 0) then (modify ?f (direction left)(orientation bottom)(tobottom 0)(totop (- ?rwidth ?width))(toleft (- (- ?rlength ?length) ?tr))) else (modify ?f (totop (+ ?tt 100)) (tobottom (- ?tb 100))))))
    else (switch ?d
        (case left then (if (< (- ?tl 100) 0) then (modify ?f (direction bottom)(orientation left)(toleft 0)(toright (- ?rlength ?width))(tobottom (- (- ?rwidth ?length) ?tt))) else (modify ?f (toleft (- ?tl 100)) (toright (+ ?tr 100)))))
        (case right then (if (< (- ?tr 100) 0) then (modify ?f (direction top)(orientation right)(toright 0)(toleft (- ?rlength ?width))(totop (- (- ?rwidth ?length) ?tb))) else (modify ?f (toleft (+ ?tl 100)) (toright (- ?tr 100)))))
        (case top then (if (< (- ?tt 100) 0) then (modify ?f (direction left)(orientation top)(totop 0)(tobottom (- ?rwidth ?width))(toleft (- (- ?rlength ?length) ?tr))) else (modify ?f (totop (- ?tt 100))(tobottom (+ ?tb 100)))))
        (case bottom then (if (< (- ?tb 100) 0) then (modify ?f (direction right)(orientation bottom)(tobottom 0)(totop (- ?rwidth ?width))(toright (- (- ?rlength ?length) ?tl))) else (modify ?f (totop (+ ?tt 100)) (tobottom (- ?tb 100))))))))


(defrule POSITIONING::loop-for-position-sofa
    ?f <- (current-pos (fid ?fid)(toleft ?tl)(toright ?tr)(totop ?tt)(tobottom ?tb)(direction ?d)(orientation ?o))
    (room-size (length ?rlength)(width ?rwidth))
    (range (fid ?fid)(toleftmin ?tlmin)(toleftmax ?tlmax)(totopmin ?ttmin)(totopmax ?ttmax))
    (exists (and (furniture-pos (toleft ?tl1) (toright ?tr1) (totop ?tt1) (tobottom ?tb1)) (test (eq (overlap ?tl ?tr ?tt ?tb ?tl1 ?tr1 ?tt1 ?tb1 ?rlength ?rwidth) True))))
=>
    (switch ?d 
        (case left then
            (if (< (- ?tl 100) ?tlmin) then 
                (modify ?f (direction right)(totop (+ ?tt 100))(tobottom (- ?tb 100)))
                (if (> ?tt ?ttmax) then (modify ?f (totop ?ttmin) (tobottom (- (+ ?tb ?tt) ?ttmin))))
            else (modify ?f (toleft (- ?tl 100))(toright (+ ?tr 100)))))
        (case right then
            (if (> (+ ?tl 100) ?tlmax) then
                (modify ?f (direction left)(totop (+ ?tt 100))(tobottom (- ?tb 100)))
                (if (> ?tt ?ttmax) then (modify ?f (totop ?ttmin)(tobottom (- (+ ?tb ?tt) ?ttmin))))
            else (modify ?f (toleft (+ ?tl 100))(toright (- ?tr 100)))))
        (case top then
            (if (< (- ?tt 100) ?ttmin) then
                (modify ?f (direction bottom)(toleft (+ ?tl 100))(toright (- ?tr 100)))
                (if (> ?tl ?tlmax) then (modify ?f (toleft ?tlmin)(toright (- (+ ?tl ?tr) ?tlmin))))
            else (modify ?f (totop (- ?tt 100))(tobottom (+ ?tb 00)))))
        (case bottom then
            (if (< (+ ?tt 100) ?ttmax) then
                (modify ?f (direction top)(toleft (+ ?tl 100))(toright (- ?tr 100)))
                (if (> ?tl ?tlmax) then (modify ?f (toleft ?tlmin)(toright (- (+ ?tl ?tr) ?tlmin))))
            else (modify ?f (totop (+ ?tt 100)) (tobottom (- ?tb 100)))))))


;; set the position of the furniture when there is not overlapping
(defrule POSITIONING::set-position
    ?f <- (current-pos (fid ?fid)(toleft ?tl)(toright ?tr)(totop ?tt)(tobottom ?tb)(direction ?d)(orientation ?o)(cycle ?c))
    (room-size (length ?rlength) (width ?rwidth))
    (forall (furniture-pos (toleft ?tl1) (toright ?tr1) (totop ?tt1) (tobottom ?tb1)) (test (eq (overlap ?tl ?tr ?tt ?tb ?tl1 ?tr1 ?tt1 ?tb1 ?rlength ?rwidth) False)))
=>
    (retract ?f)
    (assert (furniture-pos (fid ?fid)(toleft ?tl)(toright ?tr)(totop ?tt)(tobottom ?tb)(orientation ?o))))


;; find the starting position of the furniture.
(defrule POSITIONING::find-start
    ?a <- (ori-rank ?fid ?first ?second ?ori3 ?ori4)
    (room-size (length ?rlength) (width ?rwidth))
    (furniture (id ?fid) (function ~sofa)(length ?length) (width ?width))
=>
    (retract ?a)
    (bind ?totop 0)
    (bind ?toleft 0)
    (bind ?toright 0)
    (bind ?tobottom 0)
    (if (or (eq ?first left) (eq ?first right)) then
        (if (eq ?first left) then (bind ?orientation left) else (bind ?orientation right))
        (bind ?totop (integer (/ (- ?rwidth ?length) 2)))
        (bind ?tobottom (- (- ?rwidth ?length) ?totop)))
    (if (eq ?first left) then
        (bind ?toright (- ?rlength ?width))
        (switch ?second 
            (case right then (bind ?direction top) (bind ?cycle c))
            (case top then (bind ?direction top) (bind ?cycle c))
            (case bottom then (bind ?direction bottom) (bind ?cycle cc))))
    (if (eq ?first right) then
        (bind ?toleft (- ?rlength ?width))
        (switch ?second 
            (case left then (bind ?direction bottom)(bind ?cycle c))
            (case top then (bind ?direction top)(bind ?cycle cc))
            (case bottom then (bind ?direction bottom)(bind ?cycle c))))
    (if (or (eq ?first top) (eq ?first bottom)) then
        (if (eq ?first top) then (bind ?orientation top) else (bind ?orientation bottom))
        (bind ?toleft (integer (/ (- ?rlength ?length) 2)))
        (bind ?toright (- (- ?rlength ?length) ?toleft)))
    (if (eq ?first top) then
        (bind ?tobottom (- ?rwidth ?width))
        (switch ?second 
            (case left then (bind ?direction left)(bind ?cycle cc))
            (case right then (bind ?direction right)(bind ?cycle c))
            (case bottom then (bind ?direction right)(bind ?cycle c)))) 
    (if (eq ?first bottom) then
        (bind ?totop (- ?rwidth ?width))
        (switch ?second 
            (case left then (bind ?direction left)(bind ?cycle c))
            (case right then (bind ?direction right)(bind ?cycle cc))
            (case top then (bind ?direction left)(bind ?cycle c))))
    (assert (current-pos (fid ?fid) (toleft ?toleft) (toright ?toright) (totop ?totop) (tobottom ?tobottom)(cycle ?cycle)(orientation ?orientation) (direction ?direction))))


;; find the starting position of the sofa
(defrule POSITIONING::find-start-sofa
    ?a<-(ori-rank ?fid ?first ?second ?ori3 ?ori4)
    (range (fid ?fid) (toleftmin ?tlmin)(toleftmax ?tlmax)(totopmin ?ttmin)(totopmax ?ttmax))
    (furniture (id ?fid)(function sofa)(length ?length)(width ?width))
    (room-size (length ?rlength)(width ?rwidth))
    (furniture (id ?tvid)(function TV))
    (furniture-pos (fid ?tvid)(toleft ?tvl)(toright ?tvr)(totop ?tvt)(tobottom ?tvb)(orientation ?tvo))
=>
    (retract ?a)
    (bind ?orientation left)
    (bind ?toleft 0)
    (bind ?toright 0)
    (bind ?totop 0)
    (bind ?tobottom 0)
    (bind ?direction left)
    (switch ?tvo 
        (case left then (bind ?orientation left))
        (case right then (bind ?orientation right))
        (case top then (bind ?orientation top))
        (case bottom then (bind ?orientation bottom)))
    (switch ?first 
        (case left then (bind ?toleft ?tlmin)
                        (bind ?direction right)
                        (bind ?toright (- ?rlength ?toleft))
                        (switch ?second 
                            (case top then (bind ?totop ?ttmin)(bind ?tobottom (- ?rwidth ?totop)))
                            (case bottom then (bind ?totop ?ttmax)(bind ?tobottom (- ?rwidth ?totop)))
                            (case right then (bind ?totop (integer (/ (+ ?ttmin ?ttmax) 2)))(bind ?tobottom (- ?rwidth ?totop)))))
        (case right then (bind ?toleft ?tlmax)
                         (bind ?direction left)
                         (bind ?toright (- ?rlength ?toleft))
                         (switch ?second
                            (case top then (bind ?totop ?ttmin)(bind ?tobottom (- ?rwidth ?totop)))
                            (case bottom then (bind ?totop ?ttmax)(bind ?tobottom (- ?rwidth ?totop)))
                            (case left then (bind ?totop (integer (/ (+ ?ttmin ?ttmax) 2)))(bind ?tobottom (- ?rwidth ?totop)))))
        (case top  then (bind ?totop ?ttmin)
                        (bind ?direction bottom)
                        (bind ?tobottom (- ?rwidth ?totop))
                        (switch ?second
                            (case left then (bind ?toleft ?tlmin)(bind ?toright (- ?rlength ?toleft)))
                            (case right then (bind ?toleft ?tlmax)(bind ?toright (- ?rlength ?toleft)))
                            (case bottom then (bind ?toleft (integer (/ (+ ?tlmin ?tlmax) 2)))(bind ?toright (- ?rlength ?toleft)))))
        (case bottom then (bind ?totop ?ttmax)
                        (bind ?direction top)
                        (bind ?tobottom (- ?rwidth ?totop))
                        (switch ?second
                            (case left then (bind ?toleft ?tlmin)(bind ?toright (- ?rlength ?toleft)))
                            (case right then (bind ?toleft ?tlmax)(bind ?toright (- ?rlength ?toleft)))
                            (case top then (bind ?toleft (integer (/ (+ ?tlmin ?tlmax) 2))) (bind ?toright (- ?rlength ?toleft))))))
   (if (or (eq ?orientation left) (eq ?orientation right)) then 
        (bind ?toright (- ?toright ?width)) (bind ?tobottom (- ?tobottom ?length))
    else (bind ?toright (- ?toright ?length))(bind ?tobottom (- ?tobottom ?width)))
   (assert (current-pos (fid ?fid)(toleft ?toleft)(toright ?toright)(totop ?totop)(tobottom ?tobottom)(direction ?direction)(orientation ?orientation)))
)


 
;; Use bubble sort to sort the rankings of the orientations
(defrule POSITIONING::bubble-sort
    (sort-status ?fid no)
    ?f<-(sort-list ?fid ?ori1 ?rank1 ?place1)
    ?g<-(sort-list ?fid ?ori2 ?rank2 ?place2)
    (test (> ?rank1 ?rank2))
    (test (= ?place1 (+ ?place2 1)))
=> 
    (retract ?f ?g)
    (assert (sort-list ?fid ?ori1 ?rank1 ?place2)
            (sort-list ?fid ?ori2 ?rank2 ?place1))) 


;; Check whether the sorting is completed
(defrule POSITIONING::check-sort-status
    ?a<-(sort-list ?fid ?ori1 ?rank1 ?place1)
    ?b<-(sort-list ?fid ?ori2 ?rank2 ?place2)
    ?c<-(sort-list ?fid ?ori3 ?rank3 ?place3)
    ?d<-(sort-list ?fid ?ori4 ?rank4 ?place4)
    ?e<-(sort-status ?fid no)
    (test (>= ?rank1 ?rank2 ?rank3 ?rank4))
    (test (< ?place1 ?place2 ?place3 ?place4))
=>
    (retract ?a ?b ?c ?d ?e)
    (assert (ori-rank ?fid ?ori1 ?ori2 ?ori3 ?ori4))
)


;; Position TV first.
(defrule POSITIONING::position-TV
        (furniture  (id ?id) (function TV) (length ?tvlength) (width ?tvwidth) (height ?tvheight))
        (room-size (length ?rlength) (width ?rwidth))
        (window (toleft ?wl) (toright ?wr) (totop ?wt) (tobottom ?wb))
        (door (toleft ?dl) (toright ?dr) (totop ?dt) (tobottom ?db))
        (not (furniture-pos (fid ?id)))
        (distance (category1 TV|window) (category2 TV|window) (prefer ?tw))
        (distance (category1 TV|door) (category2 TV|door) (prefer ?td))
=>
        (bind ?wrank (rank ?tw ?wl ?wr ?wt ?wb))
        (bind ?drank (rank ?td ?dl ?dr ?dt ?db))
        (assert (sort-list ?id left (+ (nth 1 ?wrank) (nth 1 ?drank)) 1)
                (sort-list ?id right (+ (nth 2 ?wrank) (nth 2 ?drank)) 2)
                (sort-list ?id top (+ (nth 3 ?wrank) (nth 3 ?drank)) 3)
                (sort-list ?id bottom (+ (nth 4 ?wrank) (nth 4 ?drank)) 4)
                (sort-status ?id no))
)


(defrule POSITIONING::position-cupboard
    (furniture (id ?id) (function cupboard) (length ?cblength) (width ?cbwidth) (height ?cbheight))
    (room-size (length ?rlength) (width ?rwidth))
    (window (toleft ?wl) (toright ?wr) (totop ?wt) (tobottom ?wb))
    (door (toleft ?dl) (toright ?dr) (totop ?dt) (tobottom ?db))
    (furniture (id ?tvid) (function TV))
    (not (furniture-pos (fid ?id)))
    (furniture-pos (fid ?tvid) (toleft ?tvl) (toright ?tvr) (totop ?tvt) (tobottom ?tvb))
    (distance (category1 cupboard|window) (category2 window|cupboard) (prefer ?cbw))
    (distance (category1 cupboard|door) (category2 door|cupboard) (prefer ?cbd))
=>
    (bind ?wrank (rank ?cbw ?wl ?wr ?wt ?wb))
    (bind ?drank (rank ?cbd ?dl ?dr ?dt ?db))
    (assert (sort-list ?id left (+ (nth 1 ?wrank) (nth 1 ?drank)) 1)
            (sort-list ?id right (+ (nth 2 ?wrank) (nth 2 ?drank)) 2)
            (sort-list ?id top (+ (nth 3 ?wrank) (nth 3 ?drank)) 3)
            (sort-list ?id bottom (+ (nth 4 ?wrank) (nth 4 ?drank)) 4)
            (sort-status ?id no))
)


(defrule POSITIONING::position-bookshelf
    (furniture (id ?id)(function bookshelf)(length ?bslength)(width ?bswidth)(height ?bsheight))
    (room-size (length ?rlength)(width ?rwidth))
    (window (toleft ?wl)(toright ?wr)(totop ?wt)(tobottom ?wb))
    (door (toleft ?dl)(toright ?dr)(totop ?dt)(tobottom ?db))
    (furniture (id ?cbid)(function cupboard))
    (furniture-pos (fid ?cbid))
    (not (furniture-pos (fid ?id)))
    (distance (category1 bookshelf|window)(category2 bookshelf|window)(prefer ?bsw))
    (distance (category1 bookshelf|door)(category2 bookshelf|door)(prefer ?bsd))
=>
    (bind ?wrank (rank ?bsw ?wl ?wr ?wt ?wb))
    (bind ?drank (rank ?bsd ?dl ?dr ?dt ?db))
    (assert (sort-list ?id left (+ (nth 1 ?wrank) (nth 1 ?drank)) 1)
            (sort-list ?id right (+ (nth 2 ?wrank) (nth 2 ?drank)) 2)
            (sort-list ?id top (+ (nth 3 ?wrank) (nth 3 ?drank)) 3)
            (sort-list ?id bottom (+ (nth 4 ?wrank) (nth 4 ?drank)) 4)
            (sort-status ?id no))
)


(defrule POSITIONING::position-piano
    (furniture (id ?id)(function piano)(length ?bslength)(width ?bswidth)(height ?bsheight))
    (room-size (length ?rlength)(width ?rwidth))
    (window (toleft ?wl)(toright ?wr)(totop ?wt)(tobottom ?wb))
    (door (toleft ?dl)(toright ?dr)(totop ?dt)(tobottom ?db))
    (furniture (id ?cbid)(function bookshelf))
    (furniture-pos (fid ?cbid))
    (not (furniture-pos (fid ?id)))
    (distance (category1 bookshelf|window)(category2 piano|window)(prefer ?bsw))
    (distance (category1 bookshelf|door)(category2 piano|door)(prefer ?bsd))
=>
    (bind ?wrank (rank ?bsw ?wl ?wr ?wt ?wb))
    (bind ?drank (rank ?bsd ?dl ?dr ?dt ?db))
    (assert (sort-list ?id left (+ (nth 1 ?wrank) (nth 1 ?drank)) 1)
            (sort-list ?id right (+ (nth 2 ?wrank) (nth 2 ?drank)) 2)
            (sort-list ?id top (+ (nth 3 ?wrank) (nth 3 ?drank)) 3)
            (sort-list ?id bottom (+ (nth 4 ?wrank) (nth 4 ?drank)) 4)
            (sort-status ?id no))
)


(defrule POSITIONING::position-sofa
    (furniture (id ?id)(function sofa)(length ?sflength)(width ?sfwidth)(height ?sfheight))
    (room-size (length ?rlength)(width ?rwidth))
    (window (toleft ?wl)(toright ?wr)(totop ?wt)(tobottom ?wb))
    (door (toleft ?dl)(toright ?dr)(totop ?dt)(tobottom ?db))
    (furniture (id ?bsid)(function bookshelf))
    (furniture-pos (fid ?bsid)(toleft ?bsl)(toright ?bsr)(totop ?bst)(tobottom ?bsb)(orientation ?bso))
    (furniture (id ?cbid)(function cupboard))
    (furniture-pos (fid ?cbid)(toleft ?cbl)(toright ?cbr)(totop ?cbt)(tobottom ?cbb)(orientation ?cbo))
    (furniture (id ?tvid)(function TV)(length ?tvlength)(width ?tvwidth))
    (furniture-pos (fid ?tvid)(toleft ?tvl)(toright ?tvr)(totop ?tvt)(tobottom ?tvb)(orientation ?tvo))
    (not (furniture-pos (fid ?id)))
    (distance (category1 sofa|window)(category2 sofa|window)(prefer ?sfw))
    (distance (category1 sofa|door)(category2 sofa|door)(prefer ?sfd))
    (distance (category1 sofa|bookshelf)(category2 sofa|bookshelf)(prefer ?sfbs))
    (distance (category1 sofa|cupboard)(category2 sofa|cupboard)(prefer ?sfcb))
    (distance (category1 sofa|TV) (category2 sofa|TV) (prefer ?sftv))
=>
    (bind ?wrank (rank ?sfw ?wl ?wr ?wt ?wb))
    (bind ?drank (rank ?sfd ?dl ?dr ?dt ?db))
    (bind ?tvrank (rank ?sftv ?tvl ?tvr ?tvt ?tvb))
    (bind ?bsrank (rank ?sfbs ?bsl ?bsr ?bst ?bsb))
    (bind ?cbrank (rank ?sfcb ?cbl ?cbr ?cbt ?cbb))
    (switch ?tvo
        (case left then 
            (bind ?totopmin (- (- ?rwidth ?tvb) ?sflength))
            (if (< ?totopmin 0) then (bind ?totopmin 0))
            (assert (range (fid ?id)(toleftmin (+ (+ ?tvl ?tvwidth) 1500))(toleftmax (- ?rlength ?sfwidth))(totopmin ?totopmin)(totopmax ?tvt))))
        (case right then
            (bind ?totopmin (- (- ?rwidth ?tvb) ?sflength))
            (if (< ?totopmin 0) then (bind ?totopmin 0))
            (assert (range (fid ?id)(toleftmin 0)(toleftmax (- (- (- ?rlength ?sfwidth) ?tvwidth) 1500))(totopmin ?totopmin)(totopmax ?tvt))))
        (case top then
            (bind ?toleftmin (- (- ?rlength ?sflength) ?tvr))
            (if (< ?toleftmin 0) then (bind ?toleftmin 0))
            (assert (range (fid ?id)(toleftmin ?toleftmin)(toleftmax ?tvl)(totopmin (+ (+ ?tvwidth ?tvt) 1500))(totopmax (- ?rwidth ?sfwidth)))))
        (case bottom then
            (bind ?toleftmin (- (- ?rlength ?sflength) ?tvr))
            (if (< ?toleftmin 0) then (bind ?toleftmin 0))
            (assert (range (fid ?id)(toleftmin ?toleftmin)(toleftmax ?tvl)(totopmin 0)(totopmax (- (- (- ?rwidth ?sfwidth) ?tvwidth) 1500))))))
    (assert (sort-list ?id left (+ (+ (+ (+ (nth 1 ?wrank) (nth 1 ?drank)) (nth 1 ?tvrank)) (nth 1 ?bsrank)) (nth 1 ?cbrank)) 1)
            (sort-list ?id right (+ (+ (+ (+ (nth 2 ?wrank) (nth 2 ?drank)) (nth 2 ?tvrank)) (nth 2 ?bsrank)) (nth 2 ?cbrank)) 2)
            (sort-list ?id top (+ (+ (+ (+ (nth 3 ?wrank) (nth 3 ?drank)) (nth 3 ?tvrank)) (nth 3 ?bsrank)) (nth 3 ?cbrank)) 3)
            (sort-list ?id bottom (+ (+ (+ (+ (nth 4 ?wrank) (nth 4 ?drank)) (nth 4 ?tvrank)) (nth 4 ?bsrank)) (nth 4 ?cbrank)) 4)
            (sort-status ?id no))
)





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                   LAYOUT rules                           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ask a question do display the layout
(defrule LAYOUT::ask-layout
   (not(exists(question)))
   (not (exists(answer (question-id layout))))
=>
   (assert(question (question-id layout) (question-type layout) (text "Here is the layout")))
)


;; Answer a question about the layout
(defrule LAYOUT::answer-layout
   ?question <- (question (question-id layout))
   (answer (question-id layout))
=>
   (retract ?question)
)





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                   COLOR rules                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Answer from color advice
;; Add the new furniture that will be placed by the
;; positioning rules.
(defrule COLOR::advice-answer-can-place
   (answer (question-id ?id) (value ?value))
   ?question <- (question (question-id ?id) (question-type advice) (valid-answers ?new-id ?old-id))
   ?old-fact <- (furniture (id ?old-id) (width ?old-width) (length ?old-length))
   (copy-furniture (id ?new-id) (function ?function)
      (name ?name) (color ?color) (theme $?theme)
      (length ?length) (width ?width) (height ?height))
   ?furniture-pos <- (furniture-pos (fid ?old-id) (toleft ?tlo) (toright ?tro) (totop ?tto) (tobottom ?tbo) (orientation ?orientation))
   (room-size (length ?rlength) (width ?rwidth))
 =>
   (if (= (str-compare ?value ?new-id) 0) then
      (retract ?furniture-pos)
      (assert (furniture (id ?new-id)
         (function ?function) (name ?name) (color ?color)
         (theme $?theme) (length ?length) (width ?width)
         (height ?height)))
      (retract ?old-fact)
   )
   (retract ?question)
)



;; Red green color
(defrule COLOR::red-green-remove
   (furniture (id ?red-id) (color red))
   (furniture (id ?green-id) (color green) (function ?function))
   (copy-furniture (id ?new-id) (color beige|dark-brown|brown|silver|black|yellow|blue|pink|purple|white) (function ?function))
   (not(exists(question)))
   (not(exists(answer (question-id red-green))))
=>
   (assert (question (question-id red-green)
      (question-type advice) (text (str-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?green-id)))
)


;; Blue green color
(defrule COLOR::blue-green-remove
   (furniture (id ?blue-id) (color blue))
   (furniture (id ?green-id) (color green) (function ?function))
   (copy-furniture (id ?new-id) (color pink|beige|brown|dark-brown|black|silver|red|yellow|white) (function ?function))
   (not(exists(question)))
   (not(exists(answer (question-id blue-green))))
=>
   (assert (question (question-id blue-green)
      (question-type advice) (text (str-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?green-id)))
)


;; Purple green color
(defrule COLOR::purple-green-remove
   (furniture (id ?purple-id) (color purple))
   (furniture (id ?green-id) (color green) (function ?function))
   (copy-furniture (id ?new-id) (color beige|dark-brown|brown|silver|black|pink|red|white) (function ?function))
   (not(exists(question)))
   (not(exists(answer (question-id purple-green))))
=>
   (assert (question (question-id purple-green)
      (question-type advice) (text (str-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?green-id)))
)


;; Yellow green color
(defrule COLOR::yellow-green-remove
   (furniture (id ?yellow-id) (color yellow))
   (furniture (id ?green-id) (color green) (function ?function))
   (copy-furniture (id ?new-id) (color beige|dark-brown|brown|silver|black|pink|red|white) (function ?function))
   (not(exists(question)))
   (not(exists(answer (question-id yellow-green))))
=>
   (assert (question (question-id yellow-green)
      (question-type advice) (text (str-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?yellow-id)))
)


;; Pink Green color
(defrule COLOR::pink-green-remove
   (furniture (id ?pink-id) (color pink))
   (furniture (id ?green-id) (color green) (function ?function))
   (copy-furniture (id ?new-id) (color purple|beige|dark-brown|brown|silver|black|blue|red|white) (function ?function))
   (not(exists(question)))
   (not(exists(answer (question-id pink-green))))
=>
   (assert (question (question-id pink-green)
      (question-type advice) (text (str-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?green-id)))
)


;; Grey Green color
(defrule COLOR::grey-green-remove
   (furniture (id ?grey-id) (color grey))
   (furniture (id ?green-id) (color green) (function ?function))
   (copy-furniture (id ?new-id) (color beige|dark-brown|brown|silver|black|purple|yellow|white) (function ?function))
   (not(exists(question)))
   (not(exists(answer (question-id grey-green))))
=>
   (assert (question (question-id grey-green)
      (question-type advice) (text (str-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?green-id)))
)


;; Flory Green color
(defrule COLOR::flory-green-remove
   (furniture (id ?flory-id) (color flory))
   (furniture (id ?green-id) (color green) (function ?function))
   (copy-furniture (id ?new-id) (color beige|brown|dark-brown|black|silver|yellow|white) (function ?function))
   (not(exists(question)))
   (not(exists(answer (question-id flory-green))))
=>
   (assert (question (question-id flory-green)
      (question-type advice) (text (str-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?green-id)))
)


;;Flory Red color
(defrule COLOR::flory-red-remove
   (furniture (id ?flory-id) (color flory))
   (furniture (id ?red-id) (color red) (function ?function))
   (copy-furniture (id ?new-id) (color beige|brown|dark-brown|black|silver|yellow|white) (function ?function))
   (not(exists(question)))
   (not(exists(answer (question-id flory-red))))
=>
   (assert (question (question-id flory-red)
      (question-type advice) (text (str-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?red-id)))
)


;; Flory Blue color
(defrule COLOR::flory-blue-remove
   (furniture (id ?flory-id) (color flory))
   (furniture (id ?blue-id) (color blue) (function ?function))
   (copy-furniture (id ?new-id) (color beige|brown|dark-brown|black|silver|yellow|white) (function ?function))
   (not(exists(question)))
   (not(exists(answer (question-id flory-blue))))
=>
   (assert (question (question-id flory-blue)
      (question-type advice) (text (str-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?blue-id)))
)

;; Flory Grey color
(defrule COLOR::flory-grey-remove
   (furniture (id ?flory-id) (color flory))
   (furniture (id ?grey-id) (color grey) (function ?function))
   (copy-furniture (id ?new-id) (color beige|brown|dark-brown|black|silver|yellow|white) (function ?function))
   (not(exists(question)))
   (not(exists(answer (question-id flory-grey))))
=>
   (assert (question (question-id flory-grey)
      (question-type advice) (text (str-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?grey-id)))
)

;; Flory pink color
(defrule COLOR::flory-pink-remove
   (furniture (id ?flory-id) (color flory))
   (furniture (id ?pink-id) (color pink) (function ?function))
   (copy-furniture (id ?new-id) (color beige|brown|dark-brown|black|silver|yellow|white) (function ?function))
   (not(exists(question)))
   (not(exists(answer (question-id flory-pink))))
=>
   (assert (question (question-id flory-pink)
      (question-type advice) (text (str-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?pink-id)))
)

;;Flory purple color
(defrule COLOR::flory-purple-remove
   (furniture (id ?flory-id) (color flory))
   (furniture (id ?purple-id) (color purple) (function ?function))
   (copy-furniture (id ?new-id) (color beige|brown|dark-brown|black|silver|yellow|white) (function ?function))
   (not(exists(question)))
   (not(exists(answer (question-id flory-purple))))
=>
   (assert (question (question-id flory-purple)
      (question-type advice) (text (str-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?purple-id)))
)

;; Blue Grey Color
(defrule COLOR::blue-grey-remove
   (furniture (id ?blue-id) (color blue))
   (furniture (id ?grey-id) (color grey) (function ?function))
   (copy-furniture (id ?new-id) (color pink|beige|brown|dark-brown|black|silver|red|yellow|white) (function ?function))
   (not(exists(question)))
   (not(exists(answer (question-id blue-grey))))
=>
   (assert (question (question-id blue-grey)
      (question-type advice) (text (str-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?grey-id)))
)

;; Blue purple color
(defrule COLOR::blue-purple-remove
   (furniture (id ?blue-id) (color blue))
   (furniture (id ?purple-id) (color purple) (function ?function))
   (copy-furniture (id ?new-id) (color pink|beige|brown|dark-brown|black|silver|red|yellow|white) (function ?function))
   (not(exists(question)))
   (not(exists(answer (question-id blue-purple))))
=>
   (assert (question (question-id blue-purple)
      (question-type advice) (text (str-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?purple-id)))
)

;; Purple Blue color
(defrule COLOR::purple-blue-remove
   (furniture (id ?purple-id) (color purple))
   (furniture (id ?blue-id) (color blue) (function ?function))
   (copy-furniture (id ?new-id) (color beige|dark-brown|brown|silver|black|pink|red|white) (function ?function))
   (not(exists(question)))
   (not(exists(answer (question-id purple-blue))))
=>
   (assert (question (question-id purple-blue)
      (question-type advice) (text (str-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?blue-id)))
)

;; Purple yellow color
(defrule COLOR::purple-yellow-remove
   (furniture (id ?purple-id) (color purple))
   (furniture (id ?yellow-id) (color yellow) (function ?function))
   (copy-furniture (id ?new-id) (color beige|dark-brown|brown|silver|black|pink|red|white) (function ?function))
   (not(exists(question)))
   (not(exists(answer (question-id purple-yellow))))
=>
   (assert (question (question-id purple-yellow)
      (question-type advice) (text (str-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?yellow-id)))
)


;; Red Flory Color
(defrule COLOR::red-flory-remove
   (furniture (id ?red-id) (color red))
   (furniture (id ?flory-id) (color flory) (function ?function))
   (copy-furniture (id ?new-id) (color beige|dark-brown|brown|silver|black|yellow|blue|pink|white) (function ?function))
   (not(exists(question)))
   (not(exists(answer (question-id red-flory))))
=>
   (assert (question (question-id red-flory)
      (question-type advice) (text (str-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?flory-id)))
)

	
;; Grey Flory Color
(defrule COLOR::grey-flory-remove
   (furniture (id ?grey-id) (color grey))
   (furniture (id ?flory-id) (color flory) (function ?function))
   (copy-furniture (id ?new-id) (color beige|dark-brown|brown|silver|black|purple|yellow|white) (function ?function))
   (not(exists(question)))
   (not(exists(answer (question-id grey-flory))))
=>
   (assert (question (question-id grey-flory)
      (question-type advice) (text (str-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?flory-id)))
)


;; Grey Red Color
(defrule COLOR::grey-red-remove
   (furniture (id ?grey-id) (color grey))
   (furniture (id ?red-id) (color red) (function ?function))
   (copy-furniture (id ?new-id) (color bbeige|dark-brown|brown|silver|black|purple|yellow|white) (function ?function))
   (not(exists(question)))
   (not(exists(answer (question-id grey-red))))
=>
   (assert (question (question-id grey-red)
      (question-type advice) (text (str-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?red-id)))
)


;; Grey Blue Color
(defrule COLOR::grey-blue-remove
   (furniture (id ?grey-id) (color grey))
   (furniture (id ?blue-id) (color blue) (function ?function))
   (copy-furniture (id ?new-id) (color beige|dark-brown|brown|silver|black|purple|yellow|white) (function ?function))
   (not(exists(question)))
   (not(exists(answer (question-id grey-blue))))
=>
   (assert (question (question-id grey-blue)
      (question-type advice) (text (str-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?blue-id)))
)


;; Pink Flory Color
(defrule COLOR::pink-flory-remove
   (furniture (id ?pink-id) (color pink))
   (furniture (id ?flory-id) (color flory) (function ?function))
   (copy-furniture (id ?new-id) (color purple|beige|dark-brown|brown|silver|black|blue|red|white) (function ?function))
   (not(exists(question)))
   (not(exists(answer (question-id pink-flory))))
=>
   (assert (question (question-id pink-flory)
      (question-type advice) (text (str-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?flory-id)))
)


;; Pink Yellow Color
(defrule COLOR::pink-yellow-remove
   (furniture (id ?pink-id) (color pink))
   (furniture (id ?yellow-id) (color yellow) (function ?function))
   (copy-furniture (id ?new-id) (color purple|beige|dark-brown|brown|silver|black|blue|red|white) (function ?function))
   (not(exists(question)))
   (not(exists(answer (question-id pink-yellow))))
=>
   (assert (question (question-id pink-yellow)
      (question-type advice) (text (str-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?yellow-id)))
)


;;; Green red Color
(defrule COLOR::green-red-remove
   (furniture (id ?green-id) (color green))
   (furniture (id ?red-id) (color red) (function ?function))
   (copy-furniture (id ?new-id) (color beige|brown|dark-brown|black|silver|yellow|white) (function ?function))
   (not(exists(question)))
   (not(exists(answer (question-id green-red))))
=>
   (assert (question (question-id green-red)
      (question-type advice) (text (str-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?red-id)))
)


;; Green blue color
(defrule COLOR::green-blue-remove
   (furniture (id ?green-id) (color green))
   (furniture (id ?blue-id) (color blue) (function ?function))
   (copy-furniture (id ?new-id) (color beige|brown|dark-brown|black|silver|yellow|white) (function ?function))
   (not(exists(question)))
   (not(exists(answer (question-id green-blue))))
=>
   (assert (question (question-id green-blue)
      (question-type advice) (text (str-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?blue-id)))
)


;; Green flory color
(defrule COLOR::green-flory-remove
   (furniture (id ?green-id) (color green))
   (furniture (id ?flory-id) (color flory) (function ?function))
   (copy-furniture (id ?new-id) (color beige|brown|dark-brown|black|silver|white) (function ?function))
   (not(exists(question)))
   (not(exists(answer (question-id green-flory))))
=>
   (assert (question (question-id green-flory)
      (question-type advice) (text (str-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?flory-id)))
)


;; Green grey color
(defrule COLOR::green-grey-remove
   (furniture (id ?green-id) (color green))
   (furniture (id ?grey-id) (color grey) (function ?function))
   (copy-furniture (id ?new-id) (color beige|brown|dark-brown|black|silver|white) (function ?function))
   (not(exists(question)))
   (not(exists(answer (question-id green-grey))))
=>
   (assert (question (question-id green-grey)
      (question-type advice) (text (str-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?grey-id)))
)
;; Green pink color
(defrule COLOR::green-pink-remove
   (furniture (id ?green-id) (color green))
   (furniture (id ?pink-id) (color pink) (function ?function))
   (copy-furniture (id ?new-id) (color beige|brown|dark-brown|black|silver|white) (function ?function))
   (not(exists(question)))
   (not(exists(answer (question-id green-pink))))
=>
   (assert (question (question-id green-pink)
      (question-type advice) (text (str-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?pink-id)))
)


;; Green purple color
(defrule COLOR::green-purple-remove
   (furniture (id ?green-id) (color green))
   (furniture (id ?purple-id) (color purple) (function ?function))
   (copy-furniture (id ?new-id) (color beige|brown|dark-brown|black|silver|white) (function ?function))
   (not(exists(question)))
   (not(exists(answer (question-id green-purple))))
=>
   (assert (question (question-id green-purple)
      (question-type advice) (text (str-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?purple-id)))
)


;; Green yellow
(defrule COLOR::green-yellow-remove
   (furniture (id ?green-id) (color green))
   (furniture (id ?yellow-id) (color yellow) (function ?function))
   (copy-furniture (id ?new-id) (color beige|brown|dark-brown|black|silver|white) (function ?function))
   (not(exists(question)))
   (not(exists(answer (question-id green-yellow))))
=>
   (assert (question (question-id green-yellow)
      (question-type advice) (text (str-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?yellow-id)))
)


;; Yellow pink color
(defrule COLOR::yellow-pink-remove
   (furniture (id ?yellow-id) (color yellow))
   (furniture (id ?pink-id) (color pink) (function ?function))
   (copy-furniture (id ?new-id) (color beige|dark-brown|brown|silver|black|flory|blue|red|white) (function ?function))
   (not(exists(question)))
   (not(exists(answer (question-id yellow-pink))))
=>
   (assert (question (question-id yellow-pink)
      (question-type advice) (text (str-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?pink-id)))
)


;; Yellow purple color
(defrule COLOR::yellow-purple-remove
   (furniture (id ?yellow-id) (color yellow))
   (furniture (id ?purple-id) (color purple) (function ?function))
   (copy-furniture (id ?new-id) (color beige|dark-brown|brown|silver|black|flory|blue|red|white) (function ?function))
   (not(exists(question)))
   (not(exists(answer (question-id yellow-purple))))
=>
   (assert (question (question-id yellow-purple)
      (question-type advice) (text (str-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?purple-id)))
)





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                   FINAL-LAYOUT rules                     ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ask a question do display the final layout
(defrule FINAL-LAYOUT::ask-final-layout
   (not(exists(question)))
   (not (exists(answer (question-id final-layout))))
=>
   (assert(question (question-id final-layout) (question-type final-layout) (text "Here is the final layout")))
)


;; Answer a question about the layout
(defrule FINAL-LAYOUT::answer-final-layout
   ?question <- (question (question-id final-layout))
   (answer (question-id final-layout))
=>
   (retract ?question)
)
