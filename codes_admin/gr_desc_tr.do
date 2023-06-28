

global rfold "E:\AntiDepr"
cd "$rfold"

import delimited "E:\AntiDepr\data_aggr\tiop1112_match_all.csv", clear
/*
gen gr=""
replace gr="_treated" if jartre==1
replace gr="_control" if jartre==0

drop jartre wg
reshape wide age-empm,i(year) j(gr) string
*/

label variable empm "Months of employment"

set scheme white_tableau

/*
twoway (line empm2 year if jartre==0 & rural==1 & matched==1) ///
(line empm2 year if jartre==1 & rural==1 & matched==1), ///
xline(2011 2012) legend(label(1 "Unmatched all") label(2 "Unmatched rural") position(6))


graph export "E:\AntiDepr\graphsTrCont\empm.pdf", as(pdf) name("Graph") replace
*/

cd "$rfold\graphsTrCont"
twoway (connected empm1 year if jartre==0 & rural==1 & matched==1, msymbol(T) mcolor(navy) lcolor(blue)) ///
(connected empm1 year if jartre==1 & rural==1 & matched==0, msymbol(S) mcolor(maroon) lcolor(cranberry)), ///
xline(2010 2012, lw(thick)) legend(label(1 "Control") label(2 "Treated")position(6) size(*1.5) cols(4))
graph export "E:\AntiDepr\graphsTrCont\empm.pdf", as(pdf) name("Graph") replace



foreach var of varlist in_alldays in_psy in_dep in_anx in_alld in_psyd antidep_m antidep_dum prim_v out_allv out_psyc pres_all {
	twoway (connected `var' year if jartre==0 & rural==1 & matched==1 & match=="D"& year>2008, ///
	msymbol(T) mcolor(navy) lcolor(blue)) ///
	(connected `var' year if jartre==1 & rural==1 & matched==1 & match=="D" & year>2008, msymbol(S) ///
	mcolor(maroon) lcolor(cranberry)), ///
	xline(2010 2012, lw(thick)) legend(label(1 "Control") label(2 "Treated") position(6) size(*1.5) cols(4) )
	
	graph export `var'.pdf, as(pdf) name("Graph") replace
}

/*

twoway (connected empm1 year if jartre==0 & rural==0 & matched==0, msymbol(O)) ///
(connected empm1 year if jartre==0 & rural==1 & matched==0, msymbol(D)) ///
(connected empm1 year if jartre==0 & rural==1 & matched==1, msymbol(T) ) ///
(connected empm1 year if jartre==1 & rural==1 & matched==0, msymbol(S)), ///
xline(2010 2012, lw(thick)) legend(label(1 "Unmatched all") label(2 "Unmatched rural") label(3 "Control") label(4 "Treated") position(3))
graph export "E:\AntiDepr\graphsTrCont\empm.pdf", as(pdf) name("Graph") replace


cd "$rfold\graphsTrCont"
foreach var of varlist in_alldays in_psy in_dep in_anx in_alld in_psyd antidep_m antidep_dum prim_v out_allv out_psyc pres_all {
	twoway (connected `var' year if jartre==0 & rural==0 & matched==0 & year>2008, msymbol(O)) ///
	(connected `var' year if jartre==0 & rural==1 & matched==0 & year>2008, msymbol(D)) ///
	(connected `var' year if jartre==0 & rural==1 & matched==1 & match=="D"& year>2008, msymbol(T)) ///
	(connected `var' year if jartre==1 & rural==1 & matched==1 & match=="D" & year>2008, msymbol(S)), ///
	xline(2010 2012, lw(thick)) legend(label(1 "Unmatched all") label(2 "Unmatched rural") label(3 "Control") label(4 "Treated") position(6) size(*1.5) cols(4) )
	
	graph export `var'.pdf, as(pdf) name("Graph") replace
}
*/
