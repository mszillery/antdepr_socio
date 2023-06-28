
use "E:\AntiDepr\jaras_ttt\psych_jarasevttt_atc.dta", clear

gen no=1

gcollapse (sum) tb beteg doboz dot no, by(atc ev jaras174)

gen pr_cons=beteg/dot
gen pr_subs=tb/dot

encode atc, gen(atc_num)
gen id=jaras174*100+atc_num

drop if id==.
xtset id ev

gen dot_gr=d.dot