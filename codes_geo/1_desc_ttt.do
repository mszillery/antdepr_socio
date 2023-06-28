

use "E:\AntiDepr\jaras_ttt\psych_jarasevttt_atc.dta"



rename ev year
rename jaras174 district 

gen ttt_no=1

collapse (sum) ttt_no tb_tot=tb cons_tot=beteg packs=doboz dot=dot,by(year district atc)

gen atc5=substr(atc,1,5)

collapse (sum) ttt_no tb_tot cons_tot packs dot,by(year district atc5)

bysort year district: egen all_dot=total(dot)

gen atc5_share=dot/all_dot

drop if district==.


*reshape wide ttt_no  tb_tot cons_tot packs dot atc5_share, i(year district) j(atc5) string


gen pr_cons=cons_tot/dot
gen pr_all=(cons_tot+tb_tot)/dot


/*
 ///
keepusing(d_ps_cap d_now* d_w d_pop1) */

merge m:1 district year using "/homeKRTK/mental_health_socio/admin3_jaras.dta" 

drop if year<2010
drop if year>2016