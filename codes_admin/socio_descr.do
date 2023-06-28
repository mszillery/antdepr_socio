import excel "E:\AntiDepr\data_aggr\util_byage.xlsx", sheet("Sheet1") firstrow clear

cd E:\AntiDepr\graphs_desc

set scheme white_tableau
twoway connected a* year if year>2009, ///
title("Antidepressant users",) ///
ytitle("") ///
legend(label(1 "-20") label(2 "20-30") label(3 "30-40") ///
label(4 "40-50")label(5 "50-60") label(6 "60-70") label(7 "70-80") ///
label(8 "80-") position(6) cols(4) size(*1.3)) msymbol(O D T S V Dh oh |) ///
color(sand dkorange cranberry purple blue navy olive black)
graph export byage_ad.pdf, as(pdf) name("Graph") replace

twoway connected o* year, ///
title("Any psychiatric outpatient visit",) ///
ytitle("") ///
legend(label(1 "-20") label(2 "20-30") label(3 "30-40") ///
label(4 "40-50")label(5 "50-60") label(6 "60-70") label(7 "70-80") ///
label(8 "80-") position(6) cols(4) size(*1.3) ) msymbol(O D T S V Dh oh |) ///
color(sand dkorange cranberry purple blue navy olive black)
graph export byage_od.pdf, as(pdf) name("Graph") replace

twoway connected i* year, ///
title("Any psychiatric hospitalization",) ///
ytitle("") ///
legend(label(1 "-20") label(2 "20-30") label(3 "30-40") ///
label(4 "40-50")label(5 "50-60") label(6 "60-70") label(7 "70-80") ///
label(8 "80-") position(6) cols(4) size(*1.3) ) msymbol(O D T S V Dh oh |) ///
color(sand dkorange cranberry purple blue navy olive black)
graph export byage_id.pdf, as(pdf) name("Graph") replace

import excel "E:\AntiDepr\data_aggr\util_bysocio.xlsx", sheet("Sheet1") firstrow clear

twoway(connected antidep_dum year if year>2009 & w_cat==1,  msymbol(O) )|| ///
(connected antidep_dum year if year>2009 & w_cat==2,  msymbol(D)) || /// 
(connected antidep_dum year if year>2009 & w_cat==3, msymbol(T)) || ///
(connected antidep_dum year if year>2009 & w_cat==4, msymbol(S)) || ///
(connected antidep_dum year if year>2009 & emp3==1, msymbol(V)) || ///
(connected antidep_dum year if year>2009 & emp3==0, msymbol(|)), ///
title("Antidepressant users",) ///
ytitle("") ///
 legend(label(1 "1st wage quartile") label(2 "2nd wage quartile") ///
 label(3 "3rd wage quartile") label(4 "4st wage quartile") ///
 label(5 "Partial employment") label(6 "No employment") ///
 position(6) cols(3) size(*1.3)) 
 
 graph export bysocio_ad.pdf, as(pdf) name("Graph") replace


 twoway(connected  inpsy_dum year if year>2009 & w_cat==1,  msymbol(O) ) || ///
(connected  inpsy_dum year if year>2009 & w_cat==2,  msymbol(D)) || /// 
(connected inpsy_dum year if year>2009 & w_cat==3, msymbol(T)) || ///
(connected  inpsy_dum year if year>2009 & w_cat==4, msymbol(S) ) || ///
(connected inpsy_dum year if year>2009 & emp3==1, msymbol(V)) || ///
(connected  inpsy_dum year if year>2009 & emp3==0, msymbol(|)), ///
title("Any psychiatric hospitalization") ///
ytitle("") ///
 legend(label(1 "1st wage quartile") label(2 "2nd wage quartile") ///
 label(3 "3rd wage quartile") label(4 "4st wage quartile") ///
 label(5 "Partial employment") label(6 "No employment") ///
label(8 "80-") position(6) cols(3) size(*1.3))
 
 graph export bysocio_id.pdf, as(pdf) name("Graph") replace
 
  twoway(connected  outpsy_dum year if year>2009 & w_cat==1, msymbol(O) ) || ///
(connected  outpsy_dum year if year>2009 & w_cat==2,  msymbol(D)) || /// 
(connected  outpsy_dum year if year>2009 & w_cat==3, msymbol(T)) || ///
(connected  outpsy_dum year if year>2009 & w_cat==4, msymbol(S) ) || ///
(connected  outpsy_dum year if year>2009 & emp3==1, msymbol(V)) || ///
(connected  outpsy_dum year if year>2009 & emp3==0, msymbol(|)), ///
title("Any psychiatric outpatient visit",) ///
ytitle("") ///
 legend(label(1 "1st wage quartile") label(2 "2nd wage quartile") ///
 label(3 "3rd wage quartile") label(4 "4st wage quartile") ///
 label(5 "Partial employment") label(6 "No employment") ///
label(8 "80-") position(6) cols(3) size(*1.3))
 
 graph export bysocio_od.pdf, as(pdf) name("Graph") replace
 
 import excel "E:\AntiDepr\data_aggr\util_bygend.xlsx", sheet("Sheet1") firstrow clear
 
 gen labor=emp3
 replace labor=labor+w_cat-1 if emp3==2
 
label define lab 0 "Unemployed", add
label define lab 1 "Partially employed", add
label define lab 2 "1st wage quartile", add
label define lab 3 "2nd wage quartile", add
label define lab 4 "3rd wage quartile", add
label define lab 5 "4th wage quartile", add

gen labor1=labor-0.2
gen labor2=labor+0.2

label values labor1 lab

 
 twoway (bar antidep_dum labor1  if man=="igen",  barwidth(0.5) fcolor(midblue*1.5))  ///
(bar antidep_dum labor2  if man=="nem",  barwidth(0.4) fcolor(cranberry*1.2)), ///
legend(order(1 "Male" 2 "Female" ) position(6) cols(2) size(*1.5)) ///
title("Antidepressant use", size(*1)) yscale(range(0 0.1)) ///
xlabel(`var2values', valuelabels angle(15) labsize(*1.5)) xtitle("") ///
ytitle("")
 graph export bygend_ad.pdf, as(pdf) name("Graph") replace

 twoway (bar outpsy_dum labor1  if man=="igen", barwidth(0.5) fcolor(midblue*1.5))  ///
(bar outpsy_dum labor2  if man=="nem", barwidth(0.5) fcolor(cranberry*1.2)) , ///
legend(order(1 "Male" 2 "Female" ) position(6) cols(2) size(*1.5)) ///
title("Any psychiatric outpatient visit", size(*1)) yscale(range(0 0.1)) ///
xlabel(`var2values', valuelabels angle(15) labsize(*1.5)) xtitle("") ///
ytitle("")
 graph export bygend_od.pdf, as(pdf) name("Graph") replace

 twoway (bar inpsy_dum labor1  if man=="igen", barwidth(0.5) fcolor(midblue*1.5))  ///
(bar inpsy_dum labor2  if man=="nem", barwidth(0.5) fcolor(cranberry*1.2)) , ///
legend(order(1 "Male" 2 "Female" ) position(6) cols(2) size(*1.5)) ///
title("Any psychiatric hospitalization", size(*1)) yscale(range(0 0.015)) ///
xlabel(`var2values', valuelabels angle(15) labsize(*1.5)) xtitle("") ///
ytitle("")
 graph export bygend_id.pdf, as(pdf) name("Graph") replace
 
 
 
 
import excel "E:\AntiDepr\data_aggr\util_bysocio.xlsx", sheet("Sheet1") firstrow clear
 
 gen labor=emp3
 replace labor=labor+w_cat-1 if emp3==2
 
label define lab 0 "Unemployed", add
label define lab 1 "Partially employed", add
label define lab 2 "1st wage quartile", add
label define lab 3 "2nd wage quartile", add
label define lab 4 "3rd wage quartile", add
label define lab 5 "4th wage quartile", add

gen labor1=labor-0.2
gen labor2=labor+0.2

label values labor1 lab
label values labor lab
 
set scheme white_tableau
twoway bar antidep_dum labor  if year==2010,  barwidth(0.9) fcolor(midblue*1.5) ///
legend( position(6) cols(2) size(*1.5)) ///
title("Antidepressant use", size(*1)) yscale(range(0 0.1)) ///
xlabel(`var2values', valuelabels angle(15) labsize(*1.2)) xtitle("") ///
ytitle("")
 graph export byemp_ad.pdf, as(pdf) name("Graph") replace

twoway bar outpsy_dum labor if year==2010, barwidth(0.9) fcolor(midblue*1.5) ///
legend(position(6) cols(2) size(*1.5)) ///
title("Any psychiatric outpatient visit", size(*1)) yscale(range(0 0.1)) ///
xlabel(`var2values', valuelabels angle(15) labsize(*1.2)) xtitle("") ///
ytitle("")
 graph export byemp_od.pdf, as(pdf) name("Graph") replace

twoway bar inpsy_dum labor  if year==2010, barwidth(0.9) fcolor(midblue*1.5) ///
legend(order(1 "Male" 2 "Female" ) position(6) cols(2) size(*1.5)) ///
title("Any psychiatric hospitalization", size(*1)) yscale(range(0 0.015)) ///
xlabel(`var2values', valuelabels angle(15) labsize(*1.2)) xtitle("") ///
ytitle("")
 graph export byemp_id.pdf, as(pdf) name("Graph") replace
 
 
 
 
 