

import excel "E:\AntiDepr\data_aggr\districts2009.xlsx", sheet("Sheet1") firstrow clear
keep district NAME_2 ID_2
duplicates drop NAME_2 ID_2, force
replace district="Budapest" if ID_2==43
save "E:\AntiDepr\data_aggr\map2009.dta", replace

import excel "E:\AntiDepr\data_aggr\jaras174_agest.xlsx", sheet("Sheet1") firstrow clear
replace district="Budapest" if jaras174==0
merge 1:m district using "E:\AntiDepr\data_aggr\map2009.dta"
save "E:\AntiDepr\data_aggr\map2009.dta", replace

import excel "E:\AntiDepr\data_aggr\jaras174.xlsx", sheet("Sheet1") firstrow clear
replace district="Budapest" if jaras174==0
keep district jaras174 d_ps_cap
merge 1:m district jaras174 using "E:\AntiDepr\data_aggr\map2009.dta", nogen

rename ID_2  id
drop if id==.
replace jartre=0 if jaras174==0

gen Bp=1 if jaras174==0
gen Pest_megyei=1 if jaras174>=122 & jaras174<=139
gen mszh=1 if inlist(jaras174, 28, 38, 46, 61, 75, 85, 87, 95, 104, 115, 120, 143, 157, 167, 173, 181, 191, 197)

gen type=0
replace type=2 if jartre==1
replace type=1 if jartre!=1 & Pest_megyei!=1 & mszh!=1 & d_ps_cap<20

gen type2=type
replace type2=0 if d_ps_cap!=0

gen type3=type
replace type3=1 if jartre!=1 & Pest_megyei!=1 & mszh!=1 & d_ps_cap<40

gen pscapp=1000*d_ps_cap/pop
gen emp2=12-now2

save "E:\AntiDepr\data_aggr\map2009.dta", replace

set scheme white_tableau
maptile jartre, geo(hun2) cutv(0.5) fcolor(Blues2) twopt( legend(lab(3 "Treated")  lab(2 "Untreated") size(*1.5)))
graph export "E:\AntiDepr\graphs_desc\map_tr1.pdf", as(pdf) name("Graph") replace

maptile jartre, geo(hun2) cutv(0.5) fcolor(Blues2) twopt(title("Treatment locations", size(*1.5)) legend(off))
graph export "E:\AntiDepr\graphs_desc\map_tr2.pdf", as(pdf) name("Graph") replace

maptile pscapp, geo(hun2) fcolor(Blues2) twopt(title("Outpatient psychiatric capacity (hrs per 1000)", size(*2)) legend(off))
graph export "E:\AntiDepr\graphs_desc\map_pscap.pdf", as(pdf) name("Graph") replace

*maptile d_age, geo(hun2) fcolor(Blues2) twopt(title("Mean age", size(*2)) legend(off))
*graph export "E:\AntiDepr\graphs_desc\map_age.pdf", as(pdf) name("Graph") replace

maptile emp2, geo(hun2) fcolor(Blues2) twopt(title("Employed months (18-65)", size(*2)) legend(off))
graph export "E:\AntiDepr\graphs_desc\map_emp.pdf", as(pdf) name("Graph") replace
maptile w, geo(hun2) fcolor(Blues2) twopt(title("Monthly wage if employed", size(*2)) legend(off))
graph export "E:\AntiDepr\graphs_desc\map_w.pdf", as(pdf) name("Graph") replace
maptile out_allv, geo(hun2) fcolor(Blues2) twopt(title("Outpatient visits (age-standardized)", size(*2)) legend(off))
graph export "E:\AntiDepr\graphs_desc\map_out_allv.pdf", as(pdf) name("Graph") replace
maptile out_psyc, geo(hun2) fcolor(Blues2) twopt(title("Psychiatric outpatient visits (age-standardized)", size(*2)) legend(off))
graph export "E:\AntiDepr\graphs_desc\map_out_psy.pdf", as(pdf) name("Graph") replace
maptile antidep_m, geo(hun2) fcolor(Blues2) twopt(title("Months of antidepressant use (age-standardized)", size(*2)) legend(off))
graph export "E:\AntiDepr\graphs_desc\map_antd.pdf", as(pdf) name("Graph") replace
maptile in_alldays, geo(hun2) fcolor(Blues2) twopt(title("Inpatient days (age-standardized)", size(*2)) legend(off))
graph export "E:\AntiDepr\graphs_desc\map_in_all.pdf", as(pdf) name("Graph") replace
maptile in_psy, geo(hun2) fcolor(Blues2) twopt(title("Psychiatric inpatient days (age-standardized)", size(*2)) legend(off))
graph export "E:\AntiDepr\graphs_desc\map_in_psy.pdf", as(pdf) name("Graph") replace

maptile type, geo(hun2) fcolor(Blues2) cutv(0.5 1.5) twopt(legend(lab(4 "Treated") lab(3 "Rural, low cap") lab(2 "Others") size(*1.5)))
*maptile type3, geo(hun2) fcolor(Blues2) cutv(0.5 1.5) twopt(legend(lab(4 "Treated") lab(3 "Rural, low cap") lab(2 "Others") size(*1.5)) saving(only02))
*graph combine less202.gph only02.gph, col(1)
graph export "E:\AntiDepr\graphsTrCont\map_trcont.pdf", as(pdf) name("Graph") replace


maptile antidep_m, geo(hun2)
maptile d_w, geo(hun2)
maptile d_now, geo(hun2)
maptile out_allv, geo(hun2)