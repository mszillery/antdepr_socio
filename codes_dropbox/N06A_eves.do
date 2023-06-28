use "C:\Users\Balázs\Dropbox\OTKA2\sales_c_y_N0506_old.dta", clear

gen atckod4=substr(atc,1,4)
keep if atckod4=="N06A"
rename t ev
collapse (sum) doboz dotforg tbtam fogyar terdij kvater, by (ttt ev)

save "C:\Users\Balázs\Dropbox\OTKA2\sales_c_y_N0506_old_tttev.dta",replace


****

use "C:\Users\Balázs\Dropbox\OTKA_mental_health\pupha\monthly_jans\data_201001.dta", clear
gen atc4=substr(ATC,  1, 4)
keep if atc4=="N06A"
gen doboz_ev=12*DOBOZ
gen dot_ev=12*DOTFORG
gen tb_ev=12*TBTAM
collapse (sum) doboz_ev dot_ev tb_ev,  by( IDOSZAK)

use "C:\Users\Balázs\Dropbox\OTKA_mental_health\pupha\monthly_jans\data_201101.dta", clear
gen atc4=substr(ATC,  1, 4)
keep if atc4=="N06A"
gen doboz_ev=12*DOBOZ
gen dot_ev=12*DOTFORG
gen tb_ev=12*TBTAM
collapse (sum) doboz_ev dot_ev tb_ev,  by( IDOSZAK)

use "C:\Users\Balázs\Dropbox\OTKA_mental_health\pupha\monthly_jans\data_201201.dta", clear
gen atc4=substr(ATC,  1, 4)
keep if atc4=="N06A"
gen doboz_ev=12*DOBOZ
gen dot_ev=12*DOTFORG
gen tb_ev=12*TBTAM
collapse (sum) doboz_ev dot_ev tb_ev,  by( IDOSZAK)

use "C:\Users\Balázs\Dropbox\OTKA_mental_health\pupha\monthly_jans\data_201301.dta", clear
gen atc4=substr(ATC,  1, 4)
keep if atc4=="N06A"
gen doboz_ev=12*DOBOZ
gen dot_ev=12*DOTFORG
gen tb_ev=12*TBTAM
collapse (sum) doboz_ev dot_ev tb_ev,  by( IDOSZAK)

use "C:\Users\Balázs\Dropbox\OTKA_mental_health\pupha\monthly_jans\data_201401.dta", clear
gen atc4=substr(ATC,  1, 4)
keep if atc4=="N06A"
gen doboz_ev=12*DOBOZ
gen dot_ev=12*DOTFORG
gen tb_ev=12*TBTAM
collapse (sum) doboz_ev dot_ev tb_ev,  by( IDOSZAK)

use "C:\Users\Balázs\Dropbox\OTKA_mental_health\pupha\monthly_jans\data_201501.dta", clear
gen atc4=substr(ATC,  1, 4)
keep if atc4=="N06A"
gen doboz_ev=12*DOBOZ
gen dot_ev=12*DOTFORG
gen tb_ev=12*TBTAM
collapse (sum) doboz_ev dot_ev tb_ev,  by( IDOSZAK)

use "C:\Users\Balázs\Dropbox\OTKA_mental_health\pupha\monthly_jans\data_201601.dta", clear
gen atc4=substr(ATC,  1, 4)
keep if atc4=="N06A"
gen doboz_ev=12*DOBOZ
gen dot_ev=12*DOTFORG
gen tb_ev=12*TBTAM
collapse (sum) doboz_ev dot_ev tb_ev,  by( IDOSZAK)
