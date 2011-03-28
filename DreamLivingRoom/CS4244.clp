;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                     Define modules                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Control flow with modules
(defmodule MAIN (export ?ALL)) 
(defmodule QUESTION (import MAIN ?ALL))
(defmodule SELECTION (import MAIN ?ALL))
(defmodule SELECTION-QUESTION (import MAIN ?ALL))
(defmodule POSITIONING (import MAIN ?ALL))
(defmodule COLOR (import MAIN ?ALL))
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
(slot orientation (allowed-values v h))
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

(furniture (id CT0001) (function coffee-table) (name EXPEDIT-coffee-table) (color white) (theme modern cozy nature warm) (length 1180)(width 590) (height 380))
(furniture (id CT0002) (function coffee-table) (name EXPEDIT-coffee-table) (color brown) (theme cozy nature warm) (length 1180)(width 590) (height 380))
(furniture (id CT0003) (function coffee-table) (name EXPEDIT-coffee-table) (color black) (theme modern cozy) (length 1180)(width 590) (height 380))
(furniture (id CT0004) (function coffee-table) (name EXPEDIT-S-coffee-table) (color black) (theme modern cozy) (length 780)(width 780) (height 380))
(furniture (id CT0005) (function coffee-table) (name EXPEDIT-S-coffee-table) (color white) (theme modern cozy nature warm) (length 780)(width 780) (height 380))
(furniture (id CT0006) (function coffee-table) (name EXPEDIT-S-coffee-table) (color brown) (theme cozy nature warm) (length 780)(width 780) (height 380))
(furniture (id CT0007) (function coffee-table) (name HOL-storage-coffee-table) (color brown) (theme cozy nature warm) (length 980)(width 500) (height 500))
(furniture (id CT0008) (function coffee-table) (name KLUBBO-coffee-table) (color brown) (theme cozy nature warm) (length 780)(width 780) (height 370))
(furniture (id CT0009) (function coffee-table) (name VEJMON-coffee-table) (color black) (theme modern cozy) (length 1400)(width 660) (height 470))
(furniture (id CT0010) (function coffee-table) (name LIATORP-coffee-table) (color white) (theme modern cozy nature warm) (length 1180)(width 780) (height 500))
(furniture (id CT0011) (function coffee-table) (name VEJMON-coffee-table) (color brown) (theme cozy nature warm) (length 1400)(width 660) (height 470))
(furniture (id CT0012) (function coffee-table) (name BRADSHAW-coffee-table) (color dark-brown) (theme cozy nature warm) (length 1185)(width 600) (height 450))
(furniture (id CT0013) (function coffee-table) (name SILENTNIGHT-SOMERTON-coffee-table) (color black) (theme modern cozy nature warm) (length 1200)(width 550) (height 400))
(furniture (id CT0014) (function coffee-table) (name GADINA-coffee-table) (color white) (theme modern cozy nature) (length 1000)(width 1000) (height 350))
(furniture (id CT0015) (function coffee-table) (name ROCKALL-coffee-table) (color black) (theme modern cozy) (length 1200)(width 700) (height 330))
(furniture (id CT0016) (function coffee-table) (name AVOLA-coffee-table) (color brown) (theme cozy nature warm) (length 900)(width 900) (height 250))
(furniture (id CT0017) (function coffee-table) (name LACK-coffee-table) (color black) (theme cozy) (length 900)(width 550) (height 450))
(furniture (id CT0018) (function coffee-table) (name STRIND-coffee-table) (color black) (theme modern ozy) (length 750)(width 750) (height 450))

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

(furniture (id MS0001) (function media-system) (name PHILIPS-DCM580-DOCKING-ENTERTAINMENT-SYSTEM) (color black) (theme modern cozy) (length 300) (width 300) (height 1022))
(furniture (id MS0002) (function media-system) (name LG-FBD103-DVD-MICROSYSTEM) (color black) (theme modern cozy) (length 658) (width 262) (height 341))
(furniture (id MS0003) (function media-system) (name PHILIPS-HTS7140-BLURAY-SOUNDBAR) (color black) (theme modern cozy) (length 1040) (width 390) (height 400))
(furniture (id MS0004) (function media-system) (name PHILIPS-MCD170-DVD-MICROSYSTEM) (color black) (theme modern cozy) (length 415) (width 209) (height 233))
(furniture (id MS0005) (function media-system) (name SONY-CMTMX500I-CD-MICROSYTEM) (color black) (theme modern cozy) (length 609) (width 247) (height 240))
(furniture (id MS0006) (function media-system) (name PHILIPS-HTS2500) (color black) (theme modern cozy) (length 960) (width 331) (height 100))
(furniture (id MS0007) (function media-system) (name PHILIPS-HTS7540) (color black) (theme modern cozy) (length 1380) (width 358) (height 1199))

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

(furniture (id ST0001) (function small-table) (name DALOM-pedestal-table) (color brown) (theme cozy nature warm) (length 490) (width 490) (height 500))
(furniture (id ST0002) (function small-table) (name HATTEN-side-table) (color white) (theme modern) (length 400) (width 400) (height 500))
(furniture (id ST0003) (function small-table) (name TROLLSTA-side-table) (color yellow) (theme cozy nature warm) (length 380) (width 380) (height 400))
(furniture (id ST0004) (function small-table) (name LACK-side-table) (color red) (theme cozy nature warm) (length 550) (width 550) (height 450))
(furniture (id ST0005) (function small-table) (name IKEA-STOCKHOLM-side-table) (color white) (theme modern cozy nature warm) (length 360) (width 360) (height 500))
(furniture (id ST0006) (function small-table) (name IKEA-STOCKHOLM-side-table) (color black) (theme modern cozy) (length 360) (width 360) (height 500))
(furniture (id ST0007) (function small-table) (name IKEA-PS-KARLJOHAN-side-table) (color brown) (theme cozy nature warm) (length 470) (width 470) (height 270))
(furniture (id ST0008) (function small-table) (name LINDVED-side-table) (color white) (theme cozy nature warm) (length 500) (width 500) (height 500))
(furniture (id ST0009) (function small-table) (name VEJMON-side-table) (color beige) (theme cozy nature warm) (length 600) (width 600) (height 600))
(furniture (id ST0010) (function small-table) (name RAMVIK-side-table) (color dark-brown) (theme modern cozy) (length 430) (width 450) (height 500))
(furniture (id ST0011) (function small-table) (name SILENTNIGHT-SOMERTON-side-table) (color dark-brown) (theme modern cozy nature warm) (length 500) (width 400) (height 500))
(furniture (id ST0012) (function small-table) (name BRADSHAW-side-table) (color brown) (theme cozy nature warm) (length 585) (width 600) (height 450))
(furniture (id ST0013) (function small-table) (name GERACE-side-table) (color brown) (theme cozy nature warm) (length 450) (width 450) (height 450))
(furniture (id ST0014) (function small-table) (name LORENZO-HAMPSHIRE-side-table) (color black) (theme modern cozy nature) (length 600) (width 600) (height 600))

)




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       MAIN rules                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; The first focus must be on QUESTION when there is a new
;; answer
(defrule MAIN::answer-focus-question
   (answer (question-id ?id))
   (question (question-id ?id)
      (question-type ~furniture-preference&~advice&~layout))
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
   (focus COLOR))


;; If there is at most one furniture of each type, we place
;; the objects then we show the layout
(defrule MAIN::focus-layout
   (forall (furniture (id ?id1) (function ?function))
      (not(exists(furniture (id ?id2&~?id1) (function ?function)))))
   =>
   (focus POSITIONING LAYOUT))


;; If there is an answer for a layout, we retract the question
;; and show the advices
(defrule MAIN::answer-focus-color
   (answer (question-id ?id))
   (question (question-id ?id)
      (question-type layout))
   =>
   (focus LAYOUT COLOR))


;; Copy all the furnitures
(defrule MAIN::copy-all-furnitures
   (furniture (id ?id) (function ?function) (name ?name)
      (color ?color) (theme ?theme) (length ?length)
      (width ?width) (height ?height))
=>
   (assert (copy-furniture (id ?id) (function ?function)
      (name ?name) (color ?color) (theme ?theme)
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
	(theme)
	(room-size (length ?room-l) (width ?room-w))
	(test (> ?room-l 0))
	(test (> ?room-w 0))
	?largefurniture <- (furniture (length ?l) (width ?w))
	;;roomarea = (* ?room-l ?room-w)
	;;furniturearea = (* ?l ?w)
	;;if roomarea is smaller than the furniturearea, remove the furniture from the facts
	(test (<= (* ?room-l ?room-w) (* ?l ?w)))
=>
	(retract ?largefurniture)
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
(defrule POSITIONING::close
        ?distance <- (distance (category1 ?c1) (category2 ?c2) (prefer ?p))
        (room-size (length ?rlength) (width ?rwidth))
=>
        (if (eq ?p close) then
            (modify ?distance (range 0.3 0.5))
         else
            (modify ?distance (range 0.6 0.8))))


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


;; loop to find the position of the furniture
;; needs to be modified for turning.
(defrule POSITIONING::loop-for-position
    ?f<-(current-pos (fid ?fid)(toleft ?tl)(toright ?tr)(totop ?tt)(tobottom ?tb)(direction ?d)(orientation ?o)(cycle ?c))
    (room-size (length ?rlength) (width ?rwidth))
    (furniture (id ?fid) (length ?length) (width ?width))
    (exists (and (furniture-pos (toleft ?tl1) (toright ?tr1) (totop ?tt1) (tobottom ?tb1)) (overlap ?tl ?tr ?tt ?tb ?tl1 ?tr1 ?tt1 ?tb1 ?rlength ?rwidth)))
=>
    (if (eq ?c c) then (switch ?d 
        (case left then (if (< (- ?tl 1) 0) then (modify ?f (direction top)(orientation vertical)(toleft 0)(toright (- ?rlength ?width))(totop (- (- ?rwidth ?length) ?tb))) else (modify ?f (toleft (- ?tl 1)) (toright (+ ?tr 1)))))
        (case right then (if (< (- ?tr 1) 0) then (modify ?f (direction bottom)(orientation vertical)(toright 0)(toleft (- ?rlength ?width))(tobottom (- (- ?rwidth ?length) ?tt))) else (modify ?f (toleft (+ ?tl 1)) (toright (- ?tr 1)))))
        (case top then (if (< (- ?tt 1) 0) then (modify ?f (direction right)(orientation horizontal)(totop 0)(tobottom (- ?rwidth ?width))(toright (- (- ?rlength ?length) ?tl))) else (modify ?f (totop (- ?tt 1))(tobottom (+ ?tb 1)))))
        (case bottom then (if (< (- ?tb 1) 0) then (modify ?f (direction left)(orientation horizontal)(tobottom 0)(totop (- ?rwidth ?width))(toleft (- (- ?rlength ?length) ?tr))) else (modify ?f (totop (+ ?tt 1)) (tobottom (- ?tb 1))))))
    else (switch ?d
        (case left then (if (< (- ?tl 1) 0) then (modify ?f (direction bottom)(orientation vertical)(toleft 0)(toright (- ?rlength ?width))(tobottom (- (- ?rwidth ?length) ?tt))) else (modify ?f (toleft (- ?tl 1)) (toright (+ ?tr 1)))))
        (case right then (if (< (- ?tr 1) 0) then (modify ?f (direction top)(orientation vertical)(toright 0)(toleft (- ?rlength ?width))(totop (- (- ?rwidth ?length) ?tb))) else (modify ?f (toleft (+ ?tl 1)) (toright (- ?tr 1)))))
        (case top then (if (< (- ?tt 1) 0) then (modify ?f (direction left)(orientation horizontal)(totop 0)(tobottom (- ?rwidth ?width))(toleft (- (- ?rlength ?length) ?tr))) else (modify ?f (totop (- ?tt 1))(tobottom (+ ?tb 1)))))
        (case bottom then (if (< (- ?tb 1) 0) then (modify ?f (direction right)(orientation horizontal)(tobottom 0)(totop (- ?rwidth ?width))(toright (- (- ?rlength ?length) ?tl))) else (modify ?f (totop (+ ?tt 1)) (tobottom (- ?tb 1))))))))



;; set the position of the furniture when there is not overlapping
(defrule POSITIONING::set-position
    ?f<-(current-pos (fid ?fid)(toleft ?tl)(toright ?tr)(totop ?tt)(tobottom ?tb)(direction ?d)(orientation ?o)(cycle ?c))
    (room-size (length ?rlength) (width ?rwidth))
    (forall (furniture-pos (toleft ?tl1) (toright ?tr1) (totop ?tt1) (tobottom ?tb1)) (test (eq (overlap ?tl ?tr ?tt ?tb ?tl1 ?tr1 ?tt1 ?tb1 ?rlength ?rwidth) False)))
=>
    (retract ?f)
    (assert (furniture-pos (fid ?fid)(toleft ?tl)(toright ?tr)(totop ?tt)(tobottom ?tb)(orientation ?o))))
                




;; find the starting position of the furniture.
(defrule POSITIONING::find-start
    ?a<-(ori-rank ?fid ?first ?second ?ori3 ?ori4)
    (room-size (length ?rlength) (width ?rwidth))
    (furniture (id ?fid) (length ?length) (width ?width))
=>
    (retract ?a)
    (bind ?totop 0)
    (bind ?toleft 0)
    (bind ?toright 0)
    (bind ?tobottom 0)
    (if (or (eq ?first left) (eq ?first right)) then
        (bind ?orientation vertical)
        (bind ?totop (/ (- ?rwidth ?length) 2))
        (bind ?tobbtom (- (- ?rwidth ?length) ?totop)))
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
        (bind ?orientation horizontal)
        (bind ?toleft (/ (- ?rlength ?length) 2))
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
 
;; Use bubble sort to sort the rankings of the orientations
(defrule POSITIONING::bubble-sort
    (sort-status ?fid no)
    ?f<-(sort-list ?fid ?ori1 ?rank1 ?place1)
    ?g<-(sort-list ?fid ?ori2 ?rank2 ?place2)
    (test (> ?rank1 ?rank2))
    (test (= ?place1 (+ ?place2 1)))
=>
    (retract ?f ?g)
    (assert (sort-list ?ori1 ?rank1 ?place2)
            (sort-list ?ori2 ?rank2 ?place1)))


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
    (assert (ori-rank ?fid ?ori1 ?ori2 ?ori3 ?ori4)))


;; Position TV first.
(defrule POSITIONING::position-TV
        (furniture  (id ?id) (function TV) (length ?tvlength) (width ?tvwidth) (height ?tvheight))
        (room-size (length ?rlength) (width ?rwidth))
        (window (toleft ?wl) (toright ?wr) (totop ?wt) (tobottom ?wb))
        (door (toleft ?dl) (toright ?dr) (totop ?dt) (tobottom ?db))
        (not (furniture-pos))
        (distance (category1 TV|window) (category2 TV|window) (prefer ?tw))
        (distance (category1 TV|door) (category2 TV|door) (prefer ?td))
=>
        (bind ?wrank (rank ?tw ?wl ?wr ?wt ?wb))
        (bind ?drank (rank ?td ?dl ?dr ?dt ?db))
        (assert (sort-list ?id left (+ (nth 1 ?wrank) (nth 1 ?drank)) 1)
                (sort-list ?id right (+ (nth 2 ?wrank) (nth 2 ?drank)) 2)
                (sort-list ?id top (+ (nth 3 ?wrank) (nth 3 ?drank)) 3)
                (sort-list ?id bottom (+ (nth 4 ?wrank) (nth 4 ?drank)) 4)
                (sort-status ?id no)))


(defrule POSITIONING::position-cupboard
    (furniture (id ?id) (function cupboard) (length ?cblength) (width ?cbwidth) (height ?cbheight))
    (room-size (length ?rlength) (width ?rwidth))
    (window (toleft ?wl) (toright ?wr) (totop ?wt) (tobottom ?wb))
    (door (toleft ?dl) (toright ?dr) (totop ?dt) (tobottom ?db))
    (furniture (id ?tvid) (function TV))
    (furniture-pos (fid ?tvid) (toleft ?tvl) (toright ?tvr) (totop ?tvt) (tobottom ?tvb))
    (distance (category1 cupboard|window) (category2 window|cupboard) (prefer ?cbw))
    (distance (category1 cupboard|door) (category2 door|cupboard) (prefer ?cbd))
=>
    (bind ?wrank (rank ?cbw ?wl ?wr ?wt ?wb))
    (bind ?drank (rank ?cbd ?dl ?dr ?dt ?db))
    (assert (sort-list ?id left (+ (nth 1 ?wrank) (nth 1 ?drank)) 1)
            (sort-list ?id left (+ (nth 2 ?wrank) (nth 2 ?drank)) 2)
            (sort-list ?id left (+ (nth 3 ?wrank) (nth 3 ?drank)) 3)
            (sort-list ?id left (+ (nth 4 ?wrank) (nth 4 ?drank)) 4)
            (sort-status ?id no)))


(defrule POSITIONING::position-bookshelf
    (furniture (id ?id)(function bookshelf)(length ?bslength)(width ?bswidth)(height ?bsheight))
    (room-size (length ?rlength)(width ?rwidth))
    (window (toleft ?wl)(toright ?wr)(totop ?wt)(tobottom ?wb))
    (door (toleft ?dl)(toright ?dr)(totop ?dt)(tobottom ?db))
    (furniture (id ?cbid)(function cupboard))
    (furniture-pos (fid ?cbid))
    (distance (category1 bookshelf|window)(category2 bookshelf|window)(prefer ?bsw))
    (distance (category1 bookshelf|door)(category2 bookshelf|door)(prefer ?bsd))
=>
    (bind ?wrank (rank ?bsw ?wl ?wr ?wt ?wb))
    (bind ?drank (rank ?bsd ?dl ?dr ?dt ?db))
    (assert (sort-list ?id left (+ (nth 1 ?wrank) (nth 1 ?drank)) 1)
            (sort-list ?id left (+ (nth 2 ?wrank) (nth 2 ?drank)) 2)
            (sort-list ?id left (+ (nth 3 ?wrank) (nth 3 ?drank)) 3)
            (sort-list ?id left (+ (nth 4 ?wrank) (nth 4 ?drank)) 4)
            (sort-status ?id no)))



(deffunction furniture-ratio
	(?furniture-length ?furniture-width ?room-length ?room-width)
	(/ (* ?furniture-length ?furniture-width) (* ?room-length ?room-width)))

;;This is quite complicated
;;My rules is that taking the ratio of the sofa compared with the room in terms of area
;;Using the ratio to determine the range of distance between  the sofa and the window,door
;;Also considering the orientation of the window and door
(defrule POSITIONING::position-sofa
	(furniture (id ?id) (function sofa) (length ?sofalength) (width ?sofawidth))
	(room-size (length ?rlength) (width ?rwidth))
	(window (orientation ?wo))
	(door (orientation ?do))
	(distance (category1 sofa|window) (category2 sofa|window) (range ?sws ?swl))
	(distance (category1 sofa|door) (category2 sofa|door) (range ?sds ?sdl))
	(bind ?tl 0)
	(bind ?tr 0)
	(bind ?tt 0)
	(bind ?tb 0)
=>
(if (and (or (eq ?wo left) (eq ?wo right)) (or (eq ?do bottom) (eq ?do top))) then
	(if (> (furniture-ratio ?sofalength ?sofawidth ?rlength ?rwidth) 0.5) then
		(bind ?tl (* ?rlength ?sws))
		(bind ?tr (- ?rlength (+ ?tl ?sofalength))) 
		(bind ?tt (* ?rwidth ?sds))
		(bind ?tb (- ?rwidth (+ ?tt ?sofawidth)))
	else 
		(bind ?tl (* ?rlength ?swl))
		(bind ?tr (- ?rlength (+ ?tl ?sofalength))) 

		(bind ?tt (* ?rwidth ?sdl))
		(bind ?tb (- ?rwidth (+ ?tt ?sofawidth))) 

	)
)
(if (and (or (eq ?do left) (eq ?do right)) (or (eq ?wo bottom) (eq ?wo top))) then
	(if (> (furniture-ratio ?sofalength ?sofawidth ?rlength ?rwidth) 0.5) then
		(bind ?tl (* ?rlength ?sds))
		(bind ?tr (- ?rlength (+ ?tl ?sofalength)))
		(bind ?tt (* ?rwidth ?sws))
		(bind ?tb (- ?rwidth (+ ?tt ?sofawidth)))
	else 
		(bind ?tl (* ?rlength ?sdl))
		(bind ?tr (- ?rlength (+ ?tl ?sofalength))) 
		(bind ?tt (* ?rwidth ?swl))
		(bind ?tb (- ?rwidth (+ ?tt ?sofawidth)))
	)
)

(if (or (and (eq ?wo top) (eq ?do bottom)) (and (eq ?wo bottom) (eq ?do top)))  then
	(bind ?tl (* ?rlength 0.4))
	(bind ?tr (- ?rlength (+ ?tl ?sofalength)))
	(bind ?tt (* ?rwidth 0.4))
	(bind ?tb (- ?rwidth (+ ?tt ?sofawidth)))
)
(if (and (eq ?wo top) (eq ?do top))  then
	(bind ?tl (* ?rlength ?swl))
	(bind ?tr (- ?rlength (+ ?tl ?sofalength)))
	(bind ?tt (* ?rwidth ?swl))
	(bind ?tb (- ?rwidth (+ ?tt ?sofawidth)))
)
(if (and (eq ?wo bottom) (eq ?do bottom))  then
	(bind ?tl (* ?rlength ?sws))
	(bind ?tr (- ?rlength (+ ?tl ?sofalength)))
	(bind ?tt (* ?rwidth ?sws))
	(bind ?tb (- ?rwidth (+ ?tt ?sofawidth)))
)
	(assert (furniture-pos (fid ?id) (toleft ?tl) (toright ?tr) (totop ?tt) (tobottom ?tb)))
)





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                   COLORS rules                           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Calculate new vertical size
(deffunction COLOR::new-vertical-size (?old-to-vertical ?old-length ?new-length ?old-width ?new-width ?orientation)
   (if (= (str-compare ?orientation "vertical") 0) then
      (return (+ ?old-to-vertical (/ (- ?new-width ?old-width) 2)))
   else
      (return (+ ?old-to-vertical (/ (- ?new-length ?old-length) 2))))
)


;; Calculate new horizontal size
(deffunction COLOR::new-horizontal-size (?old-to-horizontal ?old-length ?new-length ?old-width ?new-width ?orientation)
   (if (= (str-compare ?orientation "horizontal") 0) then
      (return (+ ?old-to-horizontal (/ (- ?new-length ?old-length) 2)))
   else
      (return (+ ?old-to-horizontal (/ (- ?new-width ?old-width) 2))))
)
   

;; Answer color advice
(defrule COLOR::advice-answer-can-place
   (answer (question-id ?id) (value ?value))
   ?question <- (question (question-id ?id) (question-type advice) (valid-answers ?old-id ?new-id))
   ?old-fact <- (furniture (id ?old-id) (width ?old-width) (length ?old-length))
   (copy-furniture (id ?new-id) (function ?function)
      (name ?name) (color ?color) (theme ?theme)
      (length ?length) (width ?width) (height ?height))
   ?furniture-pos <- (furniture-pos (fid ?old-id) (toleft ?tlo) (toright ?tro) (totop ?tto) (tobottom ?tbo) (orientation ?orientation))
   (room-size (length ?rlength) (width ?rwidth))
   (forall (furniture-pos (fid ~?old-id) (toleft ?tl1) (toright ?tr1) (totop ?tt1) (tobottom ?tb1))
        (test (eq (overlap
            (new-horizontal-size ?tlo ?old-length ?length ?old-width ?width ?orientation)
            (new-horizontal-size ?tro ?old-length ?length ?old-width ?width ?orientation) 
            (new-vertical-size ?tto ?old-length ?length ?old-width ?width ?orientation)
            (new-vertical-size ?tbo ?old-length ?length ?old-width ?width ?orientation)
             ?tl1 ?tr1 ?tt1 ?tb1 ?rlength ?rwidth) False)))
=>
   (if (= (str-compare ?value ?new-id) 0) then
      (modify ?furniture-pos (fid ?new-id) (toleft ?tlo) (toright ?tro) (totop ?tto) (tobottom ?tbo))
      (assert (furniture (id ?new-id)
         (function ?function) (name ?name) (color ?color)
         (theme ?theme) (length ?length) (width ?width)
         (height ?height)))
      (retract ?old-fact)
   )
   (retract ?question)
)


;; Answer color advice
(defrule COLOR::advice-answer-cannot-place
   (answer (question-id ?id) (value ?value))
   ?question <- (question (question-id ?id) (question-type advice) (valid-answers ?old-id ?new-id))
   ?old-fact <- (furniture (id ?old-id) (width ?old-width) (length ?old-length))
   (copy-furniture (id ?new-id) (function ?function)
      (name ?name) (color ?color) (theme ?theme)
      (length ?length) (width ?width) (height ?height))
   ?furniture-pos <- (furniture-pos (fid ?old-id) (toleft ?tlo) (toright ?tro) (totop ?tto) (tobottom ?tbo) (orientation ?orientation))
   (room-size (length ?rlength) (width ?rwidth))
   (not (forall (furniture-pos (fid ~?old-id) (toleft ?tl1) (toright ?tr1) (totop ?tt1) (tobottom ?tb1))
        (test (eq (overlap
            (new-horizontal-size ?tlo ?old-length ?length ?old-width ?width ?orientation)
            (new-horizontal-size ?tro ?old-length ?length ?old-width ?width ?orientation) 
            (new-vertical-size ?tto ?old-length ?length ?old-width ?width ?orientation)
            (new-vertical-size ?tbo ?old-length ?length ?old-width ?width ?orientation)
             ?tl1 ?tr1 ?tt1 ?tb1 ?rlength ?rwidth) False))))
=>
   (retract ?question)
)


;; Red green color
(defrule COLOR::red-green-remove
   (furniture (id ?red-id) (color red) (function ?function))
   (furniture (id ?green-id) (color green))
   (copy-furniture (id ?new-id) (color beige|dark-brown|brown|silver|black|yellow|blue|pink|purple|white) (function ?function))
=>
   (assert (question (question-id red-green)
      (question-type advice) (text (sym-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?green-id)))
)

;; Blue green color
(defrule COLOR::blue-green-remove
   (furniture (id ?blue-id) (color blue) (function ?function))
   (furniture (id ?green-id) (color green))
   (copy-furniture (id ?new-id) (color pink|beige|brown|dark-brown|black|silver|red|yellow|white) (function ?function))
=>
   (assert (question (question-id blue-green)
      (question-type advice) (text (sym-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?green-id)))
)

;; Purple green color
(defrule COLOR::purple-green-remove
   (furniture (id ?purple-id) (color purple) (function ?function))
   (furniture (id ?green-id) (color green))
   (copy-furniture (id ?new-id) (color beige|dark-brown|brown|silver|black|pink|red|white) (function ?function))
=>
   (assert (question (question-id purple-green)
      (question-type advice) (text (sym-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?green-id)))
)

;; Yellow green color
(defrule COLOR::yellow-green-remove
   (furniture (id ?yellow-id) (color yellow) (function ?function))
   (furniture (id ?green-id) (color green))
   (copy-furniture (id ?new-id) (color beige|dark-brown|brown|silver|black|pink|red|white) (function ?function))
=>
   (assert (question (question-id purple-yellow)
      (question-type advice) (text (sym-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?yellow-id)))
)

;; Pink Green color
(defrule COLOR::pink-green-remove
   (furniture (id ?pink-id) (color pink) (function ?function))
   (furniture (id ?green-id) (color green))
   (copy-furniture (id ?new-id) (color purple|beige|dark-brown|brown|silver|black|blue|red|white) (function ?function))
=>
   (assert (question (question-id pink-green)
      (question-type advice) (text (sym-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?green-id)))
)


;; Grey Green color
(defrule COLOR::grey-green-remove
   (furniture (id ?grey-id) (color grey) (function ?function))
   (furniture (id ?green-id) (color green))
   (copy-furniture (id ?new-id) (color beige|dark-brown|brown|silver|black|purple|yellow|white) (function ?function))
=>
   (assert (question (question-id grey-green)
      (question-type advice) (text (sym-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?green-id)))
)

;; Flory Green color
(defrule COLOR::flory-green-remove
   (furniture (id ?flory-id) (color flory) (function ?function))
   (furniture (id ?green-id) (color green))
   (copy-furniture (id ?new-id) (color beige|brown|dark-brown|black|silver|yellow|white) (function ?function))
=>
   (assert (question (question-id flory-green)
      (question-type advice) (text (sym-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?green-id)))
)


;;Flory Red color
(defrule COLOR::flory-red-remove
   (furniture (id ?flory-id) (color flory) (function ?function))
   (furniture (id ?red-id) (color red))
   (copy-furniture (id ?new-id) (color beige|brown|dark-brown|black|silver|yellow|white) (function ?function))
=>
   (assert (question (question-id flory-red)
      (question-type advice) (text (sym-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?red-id)))
)

;; Flory Blue color
(defrule COLOR::flory-blue-remove
   (furniture (id ?flory-id) (color flory) (function ?function))
   (furniture (id ?blue-id) (color blue))
   (copy-furniture (id ?new-id) (color beige|brown|dark-brown|black|silver|yellow|white) (function ?function))
=>
   (assert (question (question-id flory-blue)
      (question-type advice) (text (sym-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?blue-id)))
)

;; Flory Grey color
(defrule COLOR::flory-grey-remove
   (furniture (id ?flory-id) (color flory) (function ?function))
   (furniture (id ?grey-id) (color grey))
   (copy-furniture (id ?new-id) (color beige|brown|dark-brown|black|silver|yellow|white) (function ?function))
=>
   (assert (question (question-id flory-grey)
      (question-type advice) (text (sym-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?grey-id)))
)

;; Flory pink color
(defrule COLOR::flory-pink-remove
   (furniture (id ?flory-id) (color flory) (function ?function))
   (furniture (id ?pink-id) (color pink))
   (copy-furniture (id ?new-id) (color beige|brown|dark-brown|black|silver|yellow|white) (function ?function))
=>
   (assert (question (question-id flory-pink)
      (question-type advice) (text (sym-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?pink-id)))
)

;;Flory purple color
(defrule COLOR::flory-purple-remove
   (furniture (id ?flory-id) (color flory) (function ?function))
   (furniture (id ?purple-id) (color purple))
   (copy-furniture (id ?new-id) (color beige|brown|dark-brown|black|silver|yellow|white) (function ?function))
=>
   (assert (question (question-id flory-purple)
      (question-type advice) (text (sym-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?purple-id)))
)

;; Blue Grey Color
(defrule COLOR::blue-grey-remove
   (furniture (id ?blue-id) (color blue) (function ?function))
   (furniture (id ?grey-id) (color grey))
   (copy-furniture (id ?new-id) (color pink|beige|brown|dark-brown|black|silver|red|yellow|white) (function ?function))
=>
   (assert (question (question-id blue-grey)
      (question-type advice) (text (sym-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?grey-id)))
)

;; Blue purple color
(defrule COLOR::blue-purple-remove
   (furniture (id ?blue-id) (color blue) (function ?function))
   (furniture (id ?purple-id) (color purple))
   (copy-furniture (id ?new-id) (color pink|beige|brown|dark-brown|black|silver|red|yellow|white) (function ?function))
=>
   (assert (question (question-id blue-purple)
      (question-type advice) (text (sym-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?purple-id)))
)

;; Purple Blue color
(defrule COLOR::purple-blue-remove
   (furniture (id ?purple-id) (color purple) (function ?function))
   (furniture (id ?blue-id) (color blue))
   (copy-furniture (id ?new-id) (color beige|dark-brown|brown|silver|black|pink|red|white) (function ?function))
=>
   (assert (question (question-id purple-blue)
      (question-type advice) (text (sym-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?blue-id)))
)

;; Purple yellow color
(defrule COLOR::purple-yellow-remove
   (furniture (id ?purple-id) (color purple) (function ?function))
   (furniture (id ?yellow-id) (color yellow))
   (copy-furniture (id ?new-id) (color beige|dark-brown|brown|silver|black|pink|red|white) (function ?function))
=>
   (assert (question (question-id purple-yellow)
      (question-type advice) (text (sym-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?yellow-id)))
)


;; Red Flory Color
(defrule COLOR::red-flory-remove
   (furniture (id ?red-id) (color red) (function ?function))
   (furniture (id ?flory-id) (color flory))
   (copy-furniture (id ?new-id) (color beige|dark-brown|brown|silver|black|yellow|blue|pink|white) (function ?function))
=>
   (assert (question (question-id red-flory)
      (question-type advice) (text (sym-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?flory-id)))
)
	
;; Grey Flory Color
(defrule COLOR::grey-flory-remove
   (furniture (id ?grey-id) (color grey) (function ?function))
   (furniture (id ?flory-id) (color flory))
   (copy-furniture (id ?new-id) (color beige|dark-brown|brown|silver|black|purple|yellow|white) (function ?function))
=>
   (assert (question (question-id grey-flory)
      (question-type advice) (text (sym-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?flory-id)))
)

;; Grey Red Color
(defrule COLOR::grey-red-remove
   (furniture (id ?grey-id) (color grey) (function ?function))
   (furniture (id ?red-id) (color red))
   (copy-furniture (id ?new-id) (color bbeige|dark-brown|brown|silver|black|purple|yellow|white) (function ?function))
=>
   (assert (question (question-id grey-red)
      (question-type advice) (text (sym-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?red-id)))
)

;; Grey Blue Color
(defrule COLOR::grey-blue-remove
   (furniture (id ?grey-id) (color grey) (function ?function))
   (furniture (id ?blue-id) (color blue))
   (copy-furniture (id ?new-id) (color beige|dark-brown|brown|silver|black|purple|yellow|white) (function ?function))
=>
   (assert (question (question-id grey-blue)
      (question-type advice) (text (sym-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?blue-id)))
)

;; Pink Flory Color
(defrule COLOR::pink-flory-remove
   (furniture (id ?pink-id) (color pink) (function ?function))
   (furniture (id ?flory-id) (color flory))
   (copy-furniture (id ?new-id) (color purple|beige|dark-brown|brown|silver|black|blue|red|white) (function ?function))
=>
   (assert (question (question-id pink-flory)
      (question-type advice) (text (sym-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?flory-id)))
)

;; Pink Yellow Color
(defrule COLOR::pink-yellow-remove
   (furniture (id ?pink-id) (color pink) (function ?function))
   (furniture (id ?yellow-id) (color yellow))
   (copy-furniture (id ?new-id) (color purple|beige|dark-brown|brown|silver|black|blue|red|white) (function ?function))
=>
   (assert (question (question-id pink-yellow)
      (question-type advice) (text (sym-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?yellow-id)))
)

;;; Green red Color
(defrule COLOR::green-red-remove
   (furniture (id ?green-id) (color green) (function ?function))
   (furniture (id ?red-id) (color red))
   (copy-furniture (id ?new-id) (color beige|brown|dark-brown|black|silver|yellow|white) (function ?function))
=>
   (assert (question (question-id green-red)
      (question-type advice) (text (sym-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?red-id)))
)

;; Green blue color
(defrule COLOR::green-red-remove
   (furniture (id ?green-id) (color green) (function ?function))
   (furniture (id ?blue-id) (color blue))
   (copy-furniture (id ?new-id) (color beige|brown|dark-brown|black|silver|yellow|white) (function ?function))
=>
   (assert (question (question-id green-blue)
      (question-type advice) (text (sym-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?blue-id)))
)

;; Green flory color
(defrule COLOR::green-flory-remove
   (furniture (id ?green-id) (color green) (function ?function))
   (furniture (id ?flory-id) (color flory))
   (copy-furniture (id ?new-id) (color beige|brown|dark-brown|black|silver|white) (function ?function))
=>
   (assert (question (question-id green-flory)
      (question-type advice) (text (sym-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?flory-id)))
)

;; Green grey color
(defrule COLOR::green-grey-remove
   (furniture (id ?green-id) (color green) (function ?function))
   (furniture (id ?grey-id) (color grey))
   (copy-furniture (id ?new-id) (color beige|brown|dark-brown|black|silver|white) (function ?function))
=>
   (assert (question (question-id green-grey)
      (question-type advice) (text (sym-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?grey-id)))
)
;; Green pink color
(defrule COLOR::green-pink-remove
   (furniture (id ?green-id) (color green) (function ?function))
   (furniture (id ?pink-id) (color pink))
   (copy-furniture (id ?new-id) (color beige|brown|dark-brown|black|silver|white) (function ?function))
=>
   (assert (question (question-id green-pink)
      (question-type advice) (text (sym-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?pink-id)))
)
;; Green purple color
(defrule COLOR::green-purple-remove
   (furniture (id ?green-id) (color green) (function ?function))
   (furniture (id ?purple-id) (color purple))
   (copy-furniture (id ?new-id) (color beige|brown|dark-brown|black|silver|white) (function ?function))
=>
   (assert (question (question-id green-purple)
      (question-type advice) (text (sym-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?purple-id)))
)

;; Green yellow
(defrule COLOR::green-yellow-remove
   (furniture (id ?green-id) (color green) (function ?function))
   (furniture (id ?yellow-id) (color yellow))
   (copy-furniture (id ?new-id) (color beige|brown|dark-brown|black|silver|white) (function ?function))
=>
   (assert (question (question-id green-yellow)
      (question-type advice) (text (sym-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?yellow-id)))
)

;; Yellow pink color
(defrule COLOR::yellow-pink-remove
   (furniture (id ?yellow-id) (color yellow) (function ?function))
   (furniture (id ?pink-id) (color pink))
   (copy-furniture (id ?new-id) (color beige|dark-brown|brown|silver|black|flory|blue|red|white) (function ?function))
=>
   (assert (question (question-id yellow-pink)
      (question-type advice) (text (sym-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?pink-id)))
)

;; Yellow purple color
(defrule COLOR::yellow-purple-remove
   (furniture (id ?yellow-id) (color yellow) (function ?function))
   (furniture (id ?purple-id) (color purple))
   (copy-furniture (id ?new-id) (color beige|dark-brown|brown|silver|black|flory|blue|red|white) (function ?function))
=>
   (assert (question (question-id yellow-purple)
      (question-type advice) (text (sym-cat "We recommend you the first " ?function " instead of the second one. Which one do you prefer?")) (valid-answers ?new-id ?purple-id)))
)



;;; White color generally
;;; can be used to match with any other colors.
;;; But in duo color combination
(defrule COLOR::black-white-selection
	?black-white <- (furniture (color black|white))
	=>(create$ ?black-white)
)

(defrule COLOR::blue-white-selection
	?blue-white <- (furniture (color blue|white))
	=>(create$ ?blue-white)
)

(defrule COLOR::red-white-selection
	?red-white <- (furniture (color red|white))
	=>(create$ ?red-white)
)

(defrule COLOR::green-white-selection
	?green-white <- (furniture (color green|white))
	=>(create$ ?green-white)
)

(defrule COLOR::beige-white-selection
	?beige-white <- (furniture (color beige|white))
	=>(create$ ?beige-white)
)

(defrule COLOR::brown-white-selection
	?brown-white <- (furniture (color brown|white))
	=>(create$ ?brown-white)
)

(defrule COLOR::dark-brown-white-selection
	?dark-brown-white <- (furniture (color dark-brown|white))
	=>(create$ ?dark-brown-white)
)

(defrule COLOR::pink-white-selection
	?pink-white <- (furniture (color pink|white))
	=>(create$ ?pink-white)
)

(defrule COLOR::purple-white-selection
	?purple-white <- (furniture (color purple|white))
	=>(create$ ?purple-white)
)

(defrule COLOR::flory-white-selection
	?flory-white <- (furniture (color flory|white))
	=>(create$ ?flory-white)
)
(defrule COLOR::yellow-white-selection
	?yellow-white <- (furniture (color yellow|white))
	=>(create$ ?yellow-white)
)

(defrule COLOR::grey-white-selection
	?grey-white <- (furniture (color grey|white))
	=>(create$ ?grey-white)
)

(defrule COLOR::silver-white-selection
	?silver-white <- (furniture (color silver|white))
	=>(create$ ?silver-white)
)

;;; Green can be matched with beige, brown, dark-brown, black,silver
(defrule COLOR::green-selection
	?green <- (furniture (color green|beige|brown|dark-brown|black|silver))
	=>(create$ ?green)
)

;;;flory can be matched with beige, brown, dark-brown, silver,yellow, black
(defrule COLOR::flory-selection
	?flory <- (furniture (color flory|beige|brown|dark-brown|silver|yellow|black))
	=>(create$ ?flory)
)

;;; Blue can be matched with black, beige, dark-brown, brown, silver, red, yellow
(defrule COLOR::blue-selection
	?blue <- (furniture (color pink|blue|beige|brown|dark-brown|black|silver|red|yellow))
	=>(create$ ?blue)
)
;;; Red can be matched with beige, brown, dark-brown, silver,black, yellow, blue, pink, purple
(defrule COLOR::red-selection
	?red <- (furniture (color red|beige|dark-brown|brown|silver|black|yellow|blue|pink|purple))
	=>(create$ ?red)
)
;;;Purple can be matched with beige, brown, dark-brown, silver, black,pink, red
(defrule COLOR::purple-selection
	?purple <- (furniture (color purple|beige|dark-brown|brown|silver|black|pink|red))
	=>(create$ ?purple)
)

;;;Pink can be matched with beige, brown, dark-brown, silver, black, blue, red
(defrule COLOR::pink-selection
	?pink <- (furniture (color pink|purple|beige|dark-brown|brown|silver|black|blue|red))
	=>(create$ ?pink)
)

;;;Grey can be matched with beige, dark-brown, silver, black, purple, brown, yellow
(defrule COLOR::grey-selection
	?grey <- (furniture (color grey|beige|dark-brown|brown|silver|black|purple|yellow))
	=>(create$ ?grey)
)

;;; Yellow can be matched with beige, dark-brown, silver, black, brown,flory, blue, red
(defrule COLOR::yellow-selection
	?yellow <- (furniture (color yellow|beige|dark-brown|brown|silver|black|flory|blue|red))
	=>(create$ ?yellow)
)





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                   LAYOUT rules                           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ask a question do display the layout
(defrule LAYOUT::ask-layout
   (initial-fact)
   (not(exists(question)))
=>
   (assert(question (question-id layout) (question-type layout) (text "Here is the layout")))
)


;; Answer a question about the layout
(defrule LAYOUT::ask-layout
   ?question <- (question (question-id layout))
   (answer (question-id layout))
=>
   (retract ?question)
)
