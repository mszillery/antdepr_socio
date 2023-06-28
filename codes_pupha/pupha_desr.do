** Mirjam Szillery
** Generic Entry on the Antidepressant Market in Hungary
* Summary stats

global rfold "E:\AntiDepr"
log using "${rfold}\codes_pupha\p_desc_log.log", replace

**********************************************************

* 1. DOT-sum and avg price in different ATC4 groups over the years

*By counties

use "${rfold}\pupha\sales_c_y_N0506"

gen atc4=substr(atc,1,4)
replace atc4="N05BA" if substr(atc,1,5)=="N05BA"
replace atc4="N05Bo" if substr(atc,1,4)=="N05B" & substr(atc,1,5)!="N05BA"

collapse (sum) dot=dotforg totprice=fogyar totcop=terdij,by(t atc4 megye)
gen avgpr=totprice/dot
gen avgcop=totprice/dot
gen dot_e04=dot/10000

merge m:1 megye t using "${rfold}\ksh\temp\pop.dta"
drop if _merge==2
drop _merge

gen dotpop_=dot/pop_all

drop if atc4=="N05C"



bysort megye atc4 (t): gen dotgr_=100*(dot_[_n])/dot_[5]
bysort megye atc4 (t): gen avgprgr_=100*(avgpr[_n])/avgpr[5]
bysort megye atc4 (t): gen dotpop_2013_=dotpop[5]
bysort megye atc4 (t): gen avgpr_2013=avgpr[5]

keep dotpop_ dotgr_ avgpr avgprgr_ dotpop_2013 avgpr_2013 avgcop t megye atc4
reshape wide dotpop_ dotgr_ avgpr avgprgr_ dotpop_2013 avgpr_2013 avgcop, i(t megye) j(atc4) string

estpost correlate dotgr_* dotpop_2013_* if t==2019, matrix listwise
esttab, unstack not noobs compress



line dotpop_N05B dotpop_N06A t, sort by(megye, title("Antidepressants (N06A) and anxiolitics (N05B) DOT/pop")) xline(2013, lcolor(red))
graph export "${rfold}\graphs\N05B_N06A_counties.pdf",replace


clear

**********************************************************************

*DOT-sum and price by subgroups

use "${rfold}\pupha\sales_c_y_N0506"

gen atc4=substr(atc,1,4)


collapse (sum) dot_nat=dotforg totprice_nat=fogyar,by(t atc4)
sort atc t
gen avgpr_nat=totprice_nat/dot_nat
gen dot_nat_e04=dot_nat/10000

graph drop _all
set graphics off
levelsof atc4, local(levels) clean
foreach l of local levels {
    scatter dot_nat_e04 t if atc4=="`l'", name(graph`l')
	}
set graphics on
graph combine graphN05A graphN05B graphN05C graphN06A graphN06B graphN06D
graph export "${rfold}\graphs\n06n06_dot",replace


graph drop _all
set graphics off
levelsof atc4, local(levels) clean
foreach l of local levels {
    scatter avgpr_nat t if atc4=="`l'", name(graph`l')
	}
set graphics on
graph combine graphN05A graphN05B graphN05C graphN06A graphN06B graphN06D
graph export "${rfold}\graphs\n06n06_pr.pdf",replace



*************************************************************

* 2. Antidepressants - national trends

* A) Overall

clear 

use "${rfold}\pupha\sales_c_y_N06A"

* dot forgalom by hatoanyag /* */

bysort t: egen dot_nat_all=total(dotforg)
bysort t hatoanyag: egen dot_nat0=total(dotforg)
gen dot_share=dot_nat0/dot_nat_all
bysort hatoanyag: egen maxshare=max(dot_share)
gen hatoanyag2=hatoanyag
replace hatoanyag2="other" if maxshare<0.05

collapse (sum) dot_nat=dotforg totprice_nat=fogyar cop=terdij,by(t)
gen avgpr_nat=totprice_nat/dot_nat
gen avgcop_nat=cop/dot_nat

graph drop _all
line dot_* t, ylabel(,labsize(tiny)) title(All antidepressants DOT) name(dot)
line avgpr_nat t,  ylabel(,labsize(tiny))  title(Trend of average total price per DOT) name(price)
line avgcop_nat t,  ylabel(,labsize(tiny))  title(Trend of average copayment per DOT) name(cop)
graph combine price cop
graph export "${rfold}\graphs\antid_alltrends.pdf",replace

* B) By active ingridients /*citalopram duloxetin escitalopram mirtazapin paroxetin sertraline venlafaxin other /

set scheme white_tableau
clear 

use "${rfold}\pupha\sales_c_y_N06A"

bysort t: egen dot_nat_all=total(dotforg)
bysort t hatoanyag: egen dot_nat0=total(dotforg)
gen dot_share=dot_nat0/dot_nat_all
bysort hatoanyag: egen maxshare=max(dot_share)
gen hatoanyag2=hatoanyag
replace hatoanyag2="other" if maxshare<0.05
*replace hatoanyag2="other" if hatoanyag!="escitalopram" & hatoanyag!="duloxetin"


collapse (sum) dot_nat=dotforg totprice_nat=fogyar cop=terdij, by(t hatoanyag2 brand)
gen one=1 
collapse (count) brands=one (sum) dot_nat totprice_nat cop, by(t hatoanyag2)

gen avgpr_nat=totprice_nat/dot_nat
gen avgcop_nat=cop/dot_nat

gen dot_nat_e06=dot_nat/1000000
gen avgpr_nat_e02=avgpr_nat/100

scatter dot_nat_e06 t, by(hatoanyag2)
graph export "${rfold}\graphs\antid_dot_trend.pdf",replace

rename dot_nat_e06 dot_e06_

keep dot_e06 avgpr_nat t hatoanyag avgcop_nat brands
reshape wide dot_e06 avgpr_nat avgcop_nat brands, i(t) j(hatoanyag) string


graph bar (sum) dot_*, over(t)   ylabel(,labsize(tiny)) title() ///
legend(label(1 "Citalopram") label(2 "Duloxetin") label(3 "Escitalopram") label(4 "Mirtazapin") ///
label(5 "Other (< 5% share)") label(6 "Paroxetine") label(7 "Sertraline") label(8 "Venlafaxin") size(*1.5)) stack
graph export "${rfold}\graphs\antid_dot_trend2.pdf",replace


graph drop _all
line avgpr_* t,  ylabel(,labsize(tiny)) xline(2014, lcolor(red) lpattern(dash)) xline(2015,lcolor(red) lpattern(dash)) title(Avg price) name(price) legend(label(1 "Duloxetine") label(2 "Escitalopram") label(3 "Others") size(*1) cols(3))
line avgcop_* t,  ylabel(,labsize(tiny)) xline(2014, lcolor(red) lpattern(dash)) xline(2015,lcolor(red) lpattern(dash)) title(Avg copayment) name(cop)  legend(label(1 "Duloxetine") label(2 "Escitalopram") label(3 "Others") size(*1) cols(3))

line brands* t,  ylabel(,labsize(tiny)) xline(2014, lcolor(red) lpattern(dash)) xline(2015,lcolor(red) lpattern(dash)) title(# brands) name(brands)  legend(label(1 "Duloxetine") label(2 "Escitalopram") label(3 "Others") size(*1) cols(3))

grc1leg price cop brands, cols(3) title()
graph export "${rfold}\graphs\antid_pr_trend.pdf",replace

*2) Anxiolytics - national trends


clear 

use "${rfold}\pupha\sales_c_y_N0506"
keep if strpos(atc, "N05B") == 1

* dot forgalom by hatoanyag /* */

bysort t: egen dot_nat_all=total(dotforg)
bysort t hatoanyag: egen dot_nat0=total(dotforg)
gen dot_share=dot_nat0/dot_nat_all
bysort hatoanyag: egen maxshare=max(dot_share)
gen hatoanyag2=hatoanyag
replace hatoanyag2="other" if maxshare<0.01

collapse (sum) dot_nat=dotforg totprice_nat=fogyar cop=terdij,by(t)
gen avgpr_nat=totprice_nat/dot_nat
gen avgcop_nat=cop/dot_nat

graph drop _all
line dot_* t, ylabel(,labsize(tiny)) title(All anxiolytics DOT) name(dot) xline(2014,lcolor(red))
line avgpr_nat t,  ylabel(,labsize(tiny) )  title(Trend of average total price per DOT) name(price)
line avgcop_nat t,  ylabel(,labsize(tiny) )  title(Trend of copayment total price per DOT) name(price)
graph combine price dot, cols(1)
graph export "${rfold}\graphs\anx_alltrends.pdf",replace


***************************************************************

* 3. Escitalopram - brands

clear

use "${rfold}\pupha\sales_c_y_N06A"

keep if hatoanyag=="escitalopram"

gen brand_= subinstr(brand," ","_",.)
replace brand_= subinstr(brand_,"-","_",.)

collapse (sum) dot_=dot totprice=fogyar, by(t brand_)
gen avgpr_=totprice/dot_
drop totprice

reshape wide dot_ avgpr_, i(t) j(brand_) string

graph bar (sum) dot_*, over(t)  legend(off) ylabel(,labsize(tiny)) title("DOT of different escitalopram brands") stack
graph export "${rfold}\graphs\escitalopram_brands.pdf",replace

***************************************************************

* 3. Duloxetin - brands


clear

use "${rfold}\pupha\sales_c_y_N06A"

keep if hatoanyag=="duloxetin"

gen brand_= subinstr(brand," ","_",.)
replace brand_= subinstr(brand_,"-","_",.)

collapse (sum) dot_=dot totprice=fogyar, by(t brand_)
gen avgpr_=totprice/dot_
drop totprice

reshape wide dot_ avgpr_, i(t) j(brand_) string

graph bar (sum) dot_*, over(t) legend(off) ylabel(,labsize(tiny)) title("DOT of different duloxetin brands") stack
graph export "${rfold}\graphs\duloxetin_brands.pdf",replace



***************************************************************

***************************************************************

* Venlafaxin and mirtazapin: generic entry before the sample, but still seems to be taking
* over during this period? or competetive effect? - average price affect!


***************************************************************

*4. Escitalopram by county

clear

use "${rfold}\pupha\sales_c_y_N06A"

keep if hatoanyag=="escitalopram"

collapse (sum) dot_=dot totprice=fogyar, by(t megye)


* Add KSH-population data

merge m:1 megye t using "${rfold}\ksh\temp\pop.dta"
drop if _merge==2
drop _merge

merge m:1 megye using "${rfold}\ksh\temp\agele.dta"
drop if _merge==2
drop _merge 

merge m:1 megye t using "${rfold}\ksh\temp\wage.dta"
drop if _merge==2
drop _merge 

gen avgpr_=totprice/dot_
drop totprice

gen dotpop=dot_/pop_all

gen leavg_2012=0.5*lem_2012+0.5*lef_2012
gen leavg_2019=0.5*lem_2019+0.5*lef_2019

line dotpop t, sort by(megye, title("Escitalopram DOT per population")) xline(2013, lcolor(red))
graph export "${rfold}\graphs\escitalopram_dotpop_counties.pdf",replace

line avgpr_ t, sort by(megye, title("Escitalopram avarage price")) xline(2013, lcolor(red))
graph export "${rfold}\graphs\escitalopram_avgpr_counties.pdf",replace

*change compared to first year*


bysort megye (t): gen dot_pr=100*(dot_[_n])/dot_[1]
bysort megye (t): gen avgpr_pr=100*(avgpr[_n])/avgpr_[1]
bysort megye (t): gen dotpop_2009_=dotpop[1]
bysort megye (t): gen avgpr_2009=avgpr_[1]
bysort megye (t): gen w_pr=100*(w_[_n])/dot_[1]
bysort megye (t): gen w_2009=w_[1]
gen leavg_pr=leavg_2019/leavg_2012

estpost correlate dot_pr dotpop_2009 w_2009 w_pr if t==2017, matrix listwise
esttab, unstack not noobs compress





***

keep dot_ dot_pr avgpr_ pop_all dotpop t megye

reshape wide dot_ dot_pr avgpr_ pop_all dotpop, i(t) j(megye) string

line dot_pr* t, legend(off) ylabel(,labsize(tiny)) xline(2013, lcolor(red)) title(Escitalopram growth from 2009 by county)
graph export "${rfold}\graphs\escitalopram_dotperc_counties.pdf",replace

line avgpr_* t, legend(size(tiny)) ylabel(,labsize(tiny)) xline(2013, lcolor(red)) title(Avarage price from 2009 by county)
graph export "${rfold}\graphs\escitalopram_avgpr_counties.pdf",replace


*****************************************


clear 

use "${rfold}\pupha\sales_c_y_N06A"

bysort t: egen dot_nat_all=total(dotforg)
bysort t hatoanyag: egen dot_nat0=total(dotforg)
gen dot_share=dot_nat0/dot_nat_all
bysort hatoanyag: egen maxshare=max(dot_share)
gen hatoanyag2=hatoanyag
*replace hatoanyag2="other" if maxshare<0.05
replace hatoanyag2="other" if hatoanyag!="escitalopram" & hatoanyag!="duloxetin"


collapse (sum) dot_=dotforg totprice_nat=fogyar cop=terdij, by(t hatoanyag2 megye)

gen avgpr_=totprice/dot_
drop totprice
gen avgcop_=cop/dot_
drop cop

keep dot_ avgpr_ t hatoanyag2 avgcop_ megye
reshape wide  dot_ avgpr_ avgcop_, i(t megye) j(hatoanyag) string

merge m:1 megye t using "${rfold}\ksh\temp\pop.dta"
drop if _merge==2
drop _merge

merge m:1 megye using "${rfold}\ksh\temp\agele.dta"
drop if _merge==2
drop _merge 

merge m:1 megye t using "${rfold}\ksh\temp\wage.dta"
drop if _merge==2
drop _merge 

gen dotpop_duloxetin=dot_duloxetin/pop_all
gen dotpop_escitalopram=dot_escitalopram/pop_all
gen dotpop_other=dot_other/pop_all


bysort megye (t): gen dul_gr=100*(dotpop_duloxetin[_n])/dotpop_duloxetin[1]
bysort megye (t): gen dul_2009=dotpop_duloxetin[1]

bysort megye (t): gen esc_gr=100*(dotpop_escitalopram[_n])/dotpop_escitalopram[1]
bysort megye (t): gen esc_2009=dotpop_escitalopram[1]

bysort megye (t): gen oth_gr=100*(dotpop_other[_n])/dotpop_other[1]
bysort megye (t): gen oth_2009=dotpop_other[1]

bysort megye (t): gen w_gr=100*(w_[_n])/w_[1]
bysort megye (t): gen w_2009=w_[1]

estpost correlate esc_gr esc_2009 dul_gr dul_2009 oth_gr oth_2009 w_2009 w_gr if t==2017, matrix listwise
esttab, b(2) unstack not noobs compress

















***************************************************************


* 5. Anxiolitics


clear 

use "${rfold}\pupha\sales_c_y_N0506"
keep if strpos(atc, "N05B") == 1

gen atc5=substr(atc,1,5)


bysort t: egen dot_nat_all=total(dotforg)
bysort t hatoanyag: egen dot_nat0=total(dotforg)
gen dot_share=dot_nat0/dot_nat_all
bysort hatoanyag: egen maxshare=max(dot_share)
gen hatoanyag2=hatoanyag
replace hatoanyag2="other" if maxshare<0.01



collapse (sum) dot_nat=dotforg totprice_nat=fogyar cop=terdij, by(t hatoanyag2 brand)
gen one=1 
collapse (count) brands=one (sum) dot_nat totprice_nat cop, by(t hatoanyag2)

gen avgpr_nat=totprice_nat/dot_nat
gen avgcop_nat=cop/dot_nat

gen dot_nat_e06=dot_nat/1000000
gen avgpr_nat_e02=avgpr_nat

scatter dot_nat_e06 t, by(hatoanyag2)
graph export "${rfold}\graphs\anx_dot_trend.pdf",replace

rename dot_nat_e06 dot_e06_

keep dot_e06 avgpr_nat t hatoanyag avgcop_nat brands
reshape wide dot_e06 avgpr_nat avgcop_nat brands, i(t) j(hatoanyag) string

graph bar (sum) dot_*, over(t)  legend(size(tiny)) ylabel(,labsize(tiny)) title(DOT by active ingridient) stack
graph export "${rfold}\graphs\anx_dot_trend2.pdf",replace


graph drop _all
line avgpr_* t,  ylabel(,labsize(tiny)) xline(2014, lcolor(red) lpattern(dash)) xline(2015,lcolor(red) lpattern(dash)) title(Avg price) name(price)
line avgcop_* t,  ylabel(,labsize(tiny)) xline(2014, lcolor(red) lpattern(dash)) xline(2015,lcolor(red) lpattern(dash)) title(Avg copayment) name(cop)

line brands* t,  ylabel(,labsize(tiny)) xline(2014, lcolor(red) lpattern(dash)) xline(2015,lcolor(red) lpattern(dash)) title(# brands) name(brands)

grc1leg price cop brands, cols(3) title(Market outcomes by active ingridient)
graph export "${rfold}\graphs\anx_pr_trend.pdf",replace


log close