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
   (slot prefer (allowed-values close far))
   (multislot range (type FLOAT))


;; Furniture is a template to store the information of
;; furnitures.
;; Each furniture should have a distinct id.
(deftemplate MAIN::furniture
	(slot id (type SYMBOL))
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
(slot fid (type INTEGER))
(slot orientation (allowed-values 1 2 3 4))
(slot x1 (type INTEGER))
(slot y1 (type INTEGER))
(slot x2 (type INTEGER))
(slot y2 (type INTEGER))
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
(furniture (id SOFA0005) (function sofa) (name EKTORP-2-seater-sofa) (color blue-white-stripes) (theme cozy nature warm) (length 1385)(width 740) (height 800))
(furniture (id SOFA0006) (function sofa) (name EKTORP-3-seater-sofa) (color white) (theme modern cozy nature warm) (length 2590)(width 770) (height 730))
(furniture (id SOFA0007) (function sofa) (name EKTORP-3-seater-sofa) (color black) (theme modern cozy) (length 2590)(width 770) (height 730))
(furniture (id SOFA0008) (function sofa) (name EKTORP-3-seater-sofa) (color blue) (theme modern cozy nature) (length 2590)(width 770) (height 730))
(furniture (id SOFA0009) (function sofa) (name EKTORP-3-seater-sofa) (color green) (theme cozy nature) (length 2590)(width 770) (height 730))
(furniture (id SOFA0010) (function sofa) (name EKTORP-2-seater-sofa) (color white) (theme modern cozy nature warm) (length 1080)(width 770) (height 730))
(furniture (id SOFA0011) (function sofa) (name EKTORP-2-seater-sofa) (color black) (theme modern cozy) (length 1080)(width 770) (height 730))
(furniture (id SOFA0012) (function sofa) (name EKTORP-2-seater-sofa) (color red) (theme cozy warm) (length 1080)(width 770) (height 730))
(furniture (id SOFA0013) (function sofa) (name EKTORP-2-seater-sofa) (color dark-brown) (theme cozy nature warm) (length 1080)(width 770) (height 730))
(furniture (id SOFA0014) (function sofa) (name EKTORP-2-seater-sofa) (color flory-white) (theme cozy nature warm) (length 1080)(width 770) (height 730))
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
(furniture (id SOFA0033) (function sofa) (name LORENZO-BRAXTON-3-seater-sofa) (color light-green) (theme cozy nature) (length 2240)(width 950) (height 800))
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
(furniture (id piano0002) (function piano) (name YAMAHA-YUS1) (color black) (theme modern cozy warm) (length 1520) (width 610) (height 1210))
(furniture (id piano0003) (function piano) (name YAMAHA-YUS5) (color black) (theme modern cozy warm) (length 1520) (width 650) (height 1310))
(furniture (id piano0004) (function piano) (name YAMAHA-U1) (color brown) (theme cozy nature warm) (length 1530) (width 610) (height 1210))
(furniture (id piano0005) (function piano) (name YAMAHA-CFX) (color black) (theme modern cozy nature warm) (length 1530) (width 1530) (height 1210))
(furniture (id piano0006) (function piano) (name YAMAHA-YDP-V240) (color dark-brown) (theme cozy nature warm) (length 1369) (width 502) (height 852))
(furniture (id piano0007) (function piano) (name YAMAHA-CVP-409GP) (color black) (theme modern cozy warm) (length 1435) (width 1147) (height 905))

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
(furniture (id ST0010) (function small-table) (name RAMVIK-side-table) (color black-brown) (theme modern cozy) (length 430) (width 450) (height 500))
(furniture (id ST0011) (function small-table) (name SILENTNIGHT-SOMERTON-side-table) (color black-brown) (theme modern cozy nature warm) (length 500) (width 400) (height 500))
(furniture (id ST0012) (function small-table) (name BRADSHAW-side-table) (color brown) (theme cozy nature warm) (length 585) (width 600) (height 450))
(furniture (id ST0013) (function small-table) (name GERACE-side-table) (color brown) (theme cozy nature warm) (length 450) (width 450) (height 450))
(furniture (id ST0014) (function small-table) (name LORENZO-HAMPSHIRE-side-table) (color black) (theme modern cozy nature) (length 600) (width 600) (height 600))

(furniture (id TL0001) (function tablelamp) (name ALANG-table-lamp) (color white) (theme modern cozy nature warm) (length 270) (width 270) (height 260))
(furniture (id TL0002) (function tablelamp) (name ARSTID-table-lamp) (color white) (theme modern cozy nature warm) (length 170) (width 170) (height 170))
(furniture (id TL0003) (function tablelamp) (name BOJA-table-lamp) (color brown) (theme cozy nature warm) (length 200) (width 200) (height 400))
(furniture (id TL0004) (function tablelamp) (name FADO-table-lamp) (color white) (theme modern cozy nature warm) (length 250) (width 250) (height 230))
(furniture (id TL0005) (function tablelamp) (name FILLSTA-table-lamp) (color white) (theme modern cozy nature warm) (length 270) (width 270) (height 310))
(furniture (id TL0006) (function tablelamp) (name FILLSTA-table-lamp) (color orange) (theme modern cozy nature warm) (length 270) (width 270) (height 310))
(furniture (id TL0007) (function tablelamp) (name GRONO-table-lamp) (color white) (theme modern cozy nature warm) (length 100) (width 100) (height 220))
(furniture (id TL0008) (function tablelamp) (name KNUBBIG-table-lamp) (color green) (theme cozy nature warm) (length 200) (width 200) (height 110))
(furniture (id TL0009) (function tablelamp) (name BRASA-table-lamp) (color black) (theme modern cozy) (length 470) (width 470) (height 260))
(furniture (id TL0010) (function tablelamp) (name LAMPAN-table-lamp) (color red) (theme cozy warm) (length 190) (width 190) (height 290))
(furniture (id TL0011) (function tablelamp) (name LJUSAS-SALBO-table-lamp) (color beige) (theme cozy nature warm) (length 140) (width 140) (height 610))
)




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       MAIN rules                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; The first focus must be on QUESTION when there is a new
;; answer
(defrule MAIN::answer-focus-question
   (answer)
   =>
   (focus QUESTION SELECTION))







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


;; Advanced user-selection rules
;; If more than one facts were selected, need to prompt question
;; to user to ask them to select their preference furniture.
;; Every furniture categories will be covered.
;; The value that capture would be the ID of the furniture.
(defrule SELECTION::user-select-furniture
	(furniture (id ?id1) (function ?function)) 
	(furniture (id ?id2&~?id1) (function ?function))
=> 
	(assert (question (question-id (sym-cat ?id1 ?id2)) (question-type furniture-preference) (text "Please select you favorite furniture.") (valid-answers ?id1 ?id2))))


;; Furniture preference question template
(deftemplate MAIN::furniture-preference-question
   (multislot furniture-for-user (type SYMBOL))
)

;; The furniture that user has chosen
(deftemplate MAIN::favorite-furniture
    (multislot furniture-for-user(type SYMBOL))
    (slot favorite (type SYMBOL))
)


(defrule SELECTION::answer-user-select-furniture
        (answer (question-id ?id) (value ?v))
        ?question <- (question (question-id ?id) (question-type furniture-preference) (valid-answers ?id1 ?id2))
=>
    (if (= ?v ?id1) then
        (retract ?id2)
        (assert (furniture-for-user ?id1) (favorite ?id1))
     else
        (retract ?id1)
        (assert (furniture-for-user ?id2) (favorite ?id2)))
     (retract ?question))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                   POSITIONING rules                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defrule POSITIONING::close
        ?distance <- (distance (category1 ?c1) (category2 ?c2) (prefer ?p))
        (room-size (length ?rlength) (width ?rwidth))
=>
        (if (= ?p close) then
            (modify ?distance (range 0.3 0.5))
         else
            (modify ?distance (range 0.6 0.8))))

;; Position TV first.
(defrule POSITIONING::position-TV
        (furniture  (id ?id) (function TV) (length ?tvlength) (width ?tvwidth) (height ?tvheight))
        (room-size (length ?rlength) (width ?rwidth))
        (window (x ?wx) (y ?wy) (length ?wl) (orientation ?wo))
        (door (x ?dx) (y ?dy) (length ?dl) (orientation ?do))
        (not furniture-pos (id ?other))
        (distance (category1 TV|window) (category2 TV|window) (prefer ?tw))
        (distance (category1 TV|door) (category2 TV|door) (prefer ?td))
=>
        (printout t "test" crlf)) 


