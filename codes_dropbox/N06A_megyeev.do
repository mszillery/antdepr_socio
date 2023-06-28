*

foreach i of numlist 0/6 {
use "C:\Users\Felhasználó\Dropbox\OTKA_mental_health\pupha\monthly_jans\data_201`i'01.dta", clear
gen atc4=substr(ATC,  1, 4)
keep if atc4=="N06A"
gen doboz_ev=12*DOBOZ
gen dot_ev=12*DOTFORG
gen tb_ev=12*TBTAM
collapse (sum) doboz_ev dot_ev tb_ev, by(IDOSZAK MEGYE)
save "C:\Users\Felhasználó\Dropbox\OTKA_mental_health\pupha\monthly_jans\data_201`i'01_megyeev.dta", replace
}

use "C:\Users\Felhasználó\Dropbox\OTKA_mental_health\pupha\monthly_jans\data_201001_megyeev.dta", clear
foreach i of numlist 1/6 {
append using "C:\Users\Felhasználó\Dropbox\OTKA_mental_health\pupha\monthly_jans\data_201`i'01_megyeev.dta"
}
gen ev=substr(IDOSZAK, 1, 4)
drop IDOSZAK
destring ev, replace
sort ev MEGYE
save "C:\Users\Felhasználó\Dropbox\OTKA_mental_health\pupha\monthly_jans\N06A_megyeev.dta", replace
