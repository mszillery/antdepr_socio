import excel "E:\AntiDepr\data_aggr\antidep_filt_match.xlsx", sheet("Sheet1") cellrange(A1:E10) firstrow clear

set scheme white_tableau
twoway (connected N06A_sp year, msymbol(T)  mcolor(navy) lcolor(blue)) ///
(connected antidep_sp year, msymbol(S) mcolor(maroon) lcolor(cranberry)), ///
 legend(label(1 "Drug sales data") label(2 "Our filtered antidepressant measure") ///
 position(6) cols(2) size(*1.5)) title("Spending match", size(*1.3))
graph export "E:\AntiDepr\graphs\antidep_sp.pdf", as(pdf) name("Graph") replace

twoway (connected N06A_dum year, msymbol(T)  mcolor(navy) lcolor(blue)) ///
(connected antidep_dum year, msymbol(S) mcolor(maroon) lcolor(cranberry)), ///
 legend(label(1 "Drug sales data") label(2 "Our filtered antidepressant measure") ///
 position(6) cols(2) size(*1.5)) title("Users match", size(*1.3))
graph export "E:\AntiDepr\graphs\antidep_usr.pdf", as(pdf) name("Graph") replace
