

use "/homeProspSSD/Admin3_H2_NEAK_veny/admin3_eu_veny_H2_v2.dta"

keep anon t N06
keep if N06~=.

gen ev=2003+int((t-1)/12)

cap drop cav
gen cav=.
replace cav=N06 if inlist(N06, 1673, 1678, 761, 798)
replace cav=N06 if inlist(N06, 1673*2, 1678*2, 761*2, 798*2)
replace cav=N06 if inlist(N06, 1673*3, 1678*3, 761*3, 798*3)

gen antidep=N06
replace antidep=. if cav~=.

hist antidep if ev>=2010 & ev<=2013 & antidep<5000 & antidep>0, by(ev)
hist antidep if ev>=2013 & ev<=2016 & antidep<5000 & antidep>0, by(ev)

tabstat antidep, by(ev) stat(sum)

gcollapse (sum) antidep, by(anon ev)

save "/homeKRTK/elekp_prosp/antidep_ev.dta", replace

***********

use "/homeKRTK/egeszseg_dekomp/Admin3_ev.dta", clear

merge 1:1 anon ev using "/homeKRTK/elekp_prosp/antidep_ev.dta", keepusing(antidep) ///
nogen keep(master match)
recode antidep .=0
rename antidep antidep_ft


cap drop antidep_dum
gen antidep_dum=0
replace antidep_dum=1 if antidep_ft>0 & antidep_ft<.

hist antidep_ft if ev>=2010 & ev<=2013 & antidep_ft>0, by(ev)

tab ev antidep_dum if L2.antidep_dum==1

tab ev if L.antidep_dum==0 & antidep_dum==1 & kor>=25 & kor<., sum(antidep_ft)

tab ev if L.antidep_dum==1 & antidep_dum==1 & kor>=25 & kor<., sum(antidep_ft)

gen dlogantidep=log(antidep_ft/L.antidep_ft)

tab ev if kor>=25 & kor<., sum(dlogantidep) nofr nost

tab ev if kor>=25 & kor<49 & antidep_ft>0, sum(antidep_ft) nofr nost

