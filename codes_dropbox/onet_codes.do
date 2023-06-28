cd "C:\Users\Balázs\Dropbox\OTKA_mental_health\data\onetonline"
******
import delimited "crosswalk_isco08_feor08.csv", delimiter(";", collapse) bindquote(strict) clear
save "crosswalk_isco08_feor08.dta", replace

import delimited "Stress_Tolerance.csv", clear
rename code  onetsoc10
replace onetsoc10 = subinstr(onetsoc10, "-", "", 1)
destring onetsoc10, replace
gen soc10=int(onetsoc10)
collapse (mean) importance , by(soc10)

joinby soc10 using "soc10_isco08.dta"
collapse (mean) importance, by(isco08)

merge 1:m isco08 using "crosswalk_isco08_feor08.dta",  nogen
drop v5


*** cleaning
egen imean=mean(importance), by( feor_08)

gen diff=imp-imean
count if feor_08==.
count if abs(diff)>5 & feor_08!=.

*** collapse
drop if feor_08==.
collapse (mean) importance, by (feor_08)
save "stress_feor08.dta", replace
count if imp==.
