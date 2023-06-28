

global rfold "E:\AntiDepr"

use "${rfold}\pupha\sales_c_y_N06A", clear

bysort t: egen dot_nat_all=total(dotforg)
bysort t hatoanyag: egen dot_nat0=total(dotforg)
gen dot_share=dot_nat0/dot_nat_all
bysort hatoanyag: egen maxshare=max(dot_share)
gen hatoanyag2=hatoanyag
replace hatoanyag2="other" if maxshare<0.05

collapse (sum) dotforg tbtam fogyar terdij kvater, by(t megye hatoanyag2)

gen avgpr_=fogyar/dotforg
gen avgcop_=tbtam/dotforg
rename dotforg dot_

drop tbtam fogyar terdij kvater

merge m:1 megye t using "${rfold}\ksh\temp\pop.dta
keep if _merge==3
drop _merge

gen dotpop_=dot_/pop_all
drop pop* dot_

reshape wide  dotpop_ avgpr_ avgcop_, i(t megye) j(hatoanyag2) string

egen sum_dotpop=rsum(dotpop_venlafaxin dotpop_sertraline dotpop_paroxetin dotpop_other dotpop_mirtazapin dotpop_escitalopram dotpop_duloxetin dotpop_citalopram)

xtset id t

gen d6_sum_dotpop=sum_dotpop-L6.sum_dotpop
gen d6_dotpop_e=dotpop_e-L6.dotpop_e

scatter L6.sum_dotpop d6_sum_dotpop if t==2017
scatter d6_dotpop_e d6_sum_dotpop if t==2017

line dotpop_* t, sort by(megye, title("DOT per population per active ingridient")) xline(2013, lcolor(red)) legend(off)

scatter 

