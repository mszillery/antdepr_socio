** Mirjam Szillery
** Generic Entry on the Antidepressant Market in Hungary
* Create KSH datafiles (County-level background data) 

global rfold "E:\AntiDepr"
log using "${rfold}\codes\k_create_log.log", replace

**** Population (by age groups)

import excel "{rfold}\ksh_raw\ksh_6_1_2i_c_pop_age.xls", sheet("6.1.2.") case(lower) cellrange(Y1:AB1821) firstrow

replace region= subinstr(region," ","_",.)
replace region= subinstr(region,"-","_",.)
replace region= subinstr(region,"á","a",.)
replace region= subinstr(region,"é","e",.)
replace region= subinstr(region,"É","E",.)
replace region= subinstr(region,"ó","o",.)
replace region= subinstr(region,"ö","o",.)
replace region= subinstr(region,"ő","o",.)
replace megye= subinstr(megye,"ú","u",.)

rename region megye
replace megye = substr(megye, 1, length(megye) - 1) if substr(megye, -1, 1) ==  "_"

egen pan_id = group(region time)
xtset pan_id age
reshape wide pop, i(pan_id) j(age) string

drop pan_id pop_00

gen pop_all=pop0_14+pop15_64+pop65_


save "${rfold}\ksh\temp\pop.dta", replace

clear

***** Average age and lifeexpentency by gender

 import excel "E:\AntiDepr\ksh_raw\ksh_6_1_7i_c_lifeexp.xls", sheet("6.1.7.") cellrange(A1:N31) firstrow case(lower)


replace region= subinstr(region," ","_",.)
replace region= subinstr(region,"-","_",.)
replace region= subinstr(region,"á","a",.)
replace region= subinstr(region,"é","e",.)
replace region= subinstr(region,"É","E",.)
replace region= subinstr(region,"ó","o",.)
replace region= subinstr(region,"ö","o",.)
replace region= subinstr(region,"ő","o",.)
replace region= subinstr(region,"ú","u",.)

rename region megye
replace megye = substr(megye, 1, length(megye) - 1) if substr(megye, -1, 1) ==  "_"

save "${rfold}\ksh\temp\agele.dta", replace


***** Wage (before taxes)

import excel "E:\AntiDepr\ksh_raw\ksh_6_2_1_15i_c_wage_br.xls", sheet("6.2.1.15.") cellrange(A3:T33) firstrow case(lower

replace region= subinstr(region," ","_",.)
replace region= subinstr(region,"-","_",.)
replace region= subinstr(region,"á","a",.)
replace region= subinstr(region,"é","e",.)
replace region= subinstr(region,"É","E",.)
replace region= subinstr(region,"ó","o",.)
replace region= subinstr(region,"ö","o",.)
replace region= subinstr(region,"ő","o",.)
replace region= subinstr(region,"ú","u",.)

keep region w_2009 w_201*
reshape long w_, i(region) j(t)

rename region megye
replace megye = substr(megye, 1, length(megye) - 1) if substr(megye, -1, 1) ==  "_"

save "${rfold}\ksh\temp\wage.dta", replace