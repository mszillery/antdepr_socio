cd "C:\Users\Balázs\Dropbox\OTKA_mental_health\data"
use "haziorvos\haziorvos_unfilled_nr_pract.dta", clear

merge m:1 tazon using "psych_capacity\kist_jaras.dta", nogen keep(master match) keepusing(jaras174)
merge m:1 tazon using "haziorvos\tazon_kerulet.dta", nogen keep(master match) keepusing(kerulet23)
replace jaras174=kerulet23 if kerulet23~=.
*Balatonakarattya 2014-ig Balatonkenese, járása: Balatonalmádi járás
replace jaras174=184 if tazon==3442
recode jaras174 (.=199) 

collapse (sum) unfilled nr_pract, by(jaras174 ev)

save "haziorvos\haziorvos_unfilled_nr_pract_jarasev_2007_2015.dta", replace

***** 2005-2017 havi unfilled

use "haziorvos\unfilled_ellattazon_t.dta", clear

merge m:1 tazon using "psych_capacity\kist_jaras.dta", nogen keep(master match) keepusing(jaras174)
merge m:1 tazon using "haziorvos\tazon_kerulet.dta", nogen keep(master match) keepusing(kerulet23)
replace jaras174=kerulet23 if kerulet23~=.
*Balatonakarattya 2014-ig Balatonkenese, járása: Balatonalmádi járás
replace jaras174=184 if tazon==3442
recode jaras174 (.=199) 

cap drop _fillin
fillin tazon t

collapse (sum) unfilled, by(jaras174 t)

gen ev=yofd(dofm(t))
drop if ev<2005
drop if ev>2017
fillin jaras174 ev
collapse (lastnm) unfilled, by(jaras174 ev)
* Bp1ker, Szegedi , Morahalmi jaras hianyzik, de itt unfilled==0, kezeljuk:

append using "haziorvos\hianyzok.dta"
save "haziorvos\unfilled_ellattazon_jarasev.dta", replace

**merge**
use "haziorvos\unfilled_ellattazon_jarasev.dta", clear
rename unfilled unfilled_0517
merge 1:1 jaras174 ev using "haziorvos\haziorvos_unfilled_nr_pract_jarasev_2007_2015.dta"
browse if unfilled_0517!=. & unfilled!=. & unfilled_0517!= unfilled
* 116/2562 

keep jaras174 ev unfilled_0517 nr_pract
rename unfilled_0517 unfilled
recode unfilled (.=0)
save "haziorvos\haziorvos_unfilled_nrpract_jarasev.dta", replace
cap erase "haziorvos\haziorvos_unfilled_nr_pract_jarasev_2007_2015.dta"


**checking**
use "haziorvos\unfilled_ellattazon_t.dta", clear
cap gen ev=yofd(dofm(t))
drop if ev<2005
drop if ev>2017
cap drop _fillin
fillin tazon ev
collapse (lastnm) unfilled, by(tazon ev)
rename unfilled unfilled_t
merge 1:1 tazon ev using "haziorvos\haziorvos_unfilled_nr_pract.dta", keepusing(unfilled) 
browse tazon unfilled if unfilled_t==. & unfilled!=0 
* hianyzik, azonban unfilled===1 : 262 |        298 |        425 |      2553 |      3230 (17 eset)
browse tazon ev unfilled unfilled_t if unfilled_t!=. & unfilled!=. & unfilled_t!= unfilled
