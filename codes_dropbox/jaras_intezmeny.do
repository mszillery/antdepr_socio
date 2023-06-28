cd "C:\Users\Balázs\Dropbox\OTKA_mental_health\data\psych_capacity"
**
import delimited "jaro_2009.txt", asdouble varnames(1) clear

keep intkod irszam hely




for any eleje elejeszam elejebetu elejebetu2szam elejeszam2szam vege ujintkod: cap drop X


gen eleje =  substr(intkod,-4,1)
replace eleje="0" if eleje==""
gen elejeszam = eleje if eleje=="0"
foreach i of numlist 1/9 {
replace elejeszam = eleje if eleje=="`i'"
}
destring elejeszam, replace

gen elejebetu = eleje if elejeszam==. 

gen elejebetu2szam = 201 if elejebetu=="A"
replace elejebetu2szam = 202 if elejebetu=="B"
replace elejebetu2szam = 203 if elejebetu=="C"
replace elejebetu2szam = 204 if elejebetu=="D"
replace elejebetu2szam = 205 if elejebetu=="E"
replace elejebetu2szam = 206 if elejebetu=="F"
replace elejebetu2szam = 207 if elejebetu=="G"
replace elejebetu2szam = 208 if elejebetu=="H"
replace elejebetu2szam = 209 if elejebetu=="I"
replace elejebetu2szam = 210 if elejebetu=="J"
replace elejebetu2szam = 211 if elejebetu=="K"
replace elejebetu2szam = 212 if elejebetu=="L"
replace elejebetu2szam = 213 if elejebetu=="M"
replace elejebetu2szam = 214 if elejebetu=="N"
replace elejebetu2szam = 215 if elejebetu=="O"
replace elejebetu2szam = 216 if elejebetu=="P"
replace elejebetu2szam = 217 if elejebetu=="Q"
replace elejebetu2szam = 218 if elejebetu=="R"
replace elejebetu2szam = 219 if elejebetu=="S"
replace elejebetu2szam = 220 if elejebetu=="T"
replace elejebetu2szam = 221 if elejebetu=="U"
replace elejebetu2szam = 222 if elejebetu=="V"
replace elejebetu2szam = 223 if elejebetu=="W"
replace elejebetu2szam = 224 if elejebetu=="X"
replace elejebetu2szam = 225 if elejebetu=="Y"
replace elejebetu2szam = 226 if elejebetu=="Z"


gen elejeszam2szam=100+elejeszam

gen vege = substr(intkod, -3, 3)
cap drop if vege=="P01" | vege=="P02" | vege=="P03" | vege=="P04" | vege=="P05" | vege=="P06" | vege=="P07" | vege=="P08"
destring vege, replace


gen ujintkod=1000*elejebetu2szam + vege if elejebetu2szam!=.
replace ujintkod=1000*elejeszam2szam + vege if elejeszam2szam!=.
replace ujintkod=100074 if intkod=="74"

save "jaro_2009_small.dta", replace





**
import delimited "Jaro_intezmenyek-2012-10-26.txt", asdouble varnames(3) clear
rename v1 intkod
rename v2 inte
rename v3 hely
rename v4 irszam
keep intkod irszam hely


for any eleje elejeszam elejebetu elejebetu2szam elejeszam2szam vege ujintkod: cap drop X


gen eleje =  substr(intkod,-4,1)
replace eleje="0" if eleje==""
gen elejeszam = eleje if eleje=="0"
foreach i of numlist 1/9 {
replace elejeszam = eleje if eleje=="`i'"
}
destring elejeszam, replace

gen elejebetu = eleje if elejeszam==. 

gen elejebetu2szam = 201 if elejebetu=="A"
replace elejebetu2szam = 202 if elejebetu=="B"
replace elejebetu2szam = 203 if elejebetu=="C"
replace elejebetu2szam = 204 if elejebetu=="D"
replace elejebetu2szam = 205 if elejebetu=="E"
replace elejebetu2szam = 206 if elejebetu=="F"
replace elejebetu2szam = 207 if elejebetu=="G"
replace elejebetu2szam = 208 if elejebetu=="H"
replace elejebetu2szam = 209 if elejebetu=="I"
replace elejebetu2szam = 210 if elejebetu=="J"
replace elejebetu2szam = 211 if elejebetu=="K"
replace elejebetu2szam = 212 if elejebetu=="L"
replace elejebetu2szam = 213 if elejebetu=="M"
replace elejebetu2szam = 214 if elejebetu=="N"
replace elejebetu2szam = 215 if elejebetu=="O"
replace elejebetu2szam = 216 if elejebetu=="P"
replace elejebetu2szam = 217 if elejebetu=="Q"
replace elejebetu2szam = 218 if elejebetu=="R"
replace elejebetu2szam = 219 if elejebetu=="S"
replace elejebetu2szam = 220 if elejebetu=="T"
replace elejebetu2szam = 221 if elejebetu=="U"
replace elejebetu2szam = 222 if elejebetu=="V"
replace elejebetu2szam = 223 if elejebetu=="W"
replace elejebetu2szam = 224 if elejebetu=="X"
replace elejebetu2szam = 225 if elejebetu=="Y"
replace elejebetu2szam = 226 if elejebetu=="Z"


gen elejeszam2szam=100+elejeszam

gen vege = substr(intkod, -3, 3)
cap drop if vege=="P01" | vege=="P02" | vege=="P03" | vege=="P04" | vege=="P05" | vege=="P06" | vege=="P07" | vege=="P08"
destring vege, replace


gen ujintkod=1000*elejebetu2szam + vege if elejebetu2szam!=.
replace ujintkod=1000*elejeszam2szam + vege if elejeszam2szam!=.
replace ujintkod=100074 if intkod=="74"



save "Jaro_intezmenyek-2012-10-26_small.dta", replace


**
import delimited "psych_capacity_raw.txt", asdouble varnames(1) clear
keep intzmnynv megyeneve hetiszakorvosirkszma hetinemszakorvosirkszma ///
ateljestmnydjalapjulszolglpontrt kifizetettdjsszegeteljestmnydjef esetszm idszak intzmnykd
rename intzmnykd intkod

destring, replace dpcomma

tostring idszak, replace

gen year=substr(idszak,1,4)
gen month=substr(idszak,5,2)

destring month, replace
destring year, replace

gen ym=ym(year, month)
format ym %tm

tabstat hetiszakorvosirkszma, by (ym) stat (sum)



for any eleje elejeszam elejebetu elejebetu2szam elejeszam2szam vege ujintkod: cap drop X


gen eleje =  substr(intkod,-4,1)
replace eleje="0" if eleje==""
gen elejeszam = eleje if eleje=="0"
foreach i of numlist 1/9 {
replace elejeszam = eleje if eleje=="`i'"
}
destring elejeszam, replace

gen elejebetu = eleje if elejeszam==. 

gen elejebetu2szam = 201 if elejebetu=="A"
replace elejebetu2szam = 202 if elejebetu=="B"
replace elejebetu2szam = 203 if elejebetu=="C"
replace elejebetu2szam = 204 if elejebetu=="D"
replace elejebetu2szam = 205 if elejebetu=="E"
replace elejebetu2szam = 206 if elejebetu=="F"
replace elejebetu2szam = 207 if elejebetu=="G"
replace elejebetu2szam = 208 if elejebetu=="H"
replace elejebetu2szam = 209 if elejebetu=="I"
replace elejebetu2szam = 210 if elejebetu=="J"
replace elejebetu2szam = 211 if elejebetu=="K"
replace elejebetu2szam = 212 if elejebetu=="L"
replace elejebetu2szam = 213 if elejebetu=="M"
replace elejebetu2szam = 214 if elejebetu=="N"
replace elejebetu2szam = 215 if elejebetu=="O"
replace elejebetu2szam = 216 if elejebetu=="P"
replace elejebetu2szam = 217 if elejebetu=="Q"
replace elejebetu2szam = 218 if elejebetu=="R"
replace elejebetu2szam = 219 if elejebetu=="S"
replace elejebetu2szam = 220 if elejebetu=="T"
replace elejebetu2szam = 221 if elejebetu=="U"
replace elejebetu2szam = 222 if elejebetu=="V"
replace elejebetu2szam = 223 if elejebetu=="W"
replace elejebetu2szam = 224 if elejebetu=="X"
replace elejebetu2szam = 225 if elejebetu=="Y"
replace elejebetu2szam = 226 if elejebetu=="Z"


gen elejeszam2szam=100+elejeszam

gen vege = substr(intkod, -3, 3)
cap drop if vege=="P01" | vege=="P02" | vege=="P03" | vege=="P04" | vege=="P05" | vege=="P06" | vege=="P07" | vege=="P08"
destring vege, replace


gen ujintkod=1000*elejebetu2szam + vege if elejebetu2szam!=.
replace ujintkod=1000*elejeszam2szam + vege if elejeszam2szam!=.
replace ujintkod=100074 if intkod=="74"



save "psych_capacity_raw_small.dta",  replace

/*
use "psych_capacity_raw_small.dta", clear
merge m:1 ujintkod using "jaro_2009_small.dta", nogen keep(master match)
save "psych_capacity_raw_small_irsz_2009.dta",  replace
*/

*import delimited "kodolo.txt", asdouble varnames(1) clear
*save "kodolo.dta", replace

use "psych_capacity_raw_small.dta", clear
merge m:1 ujintkod using "Jaro_intezmenyek-2012-10-26_small.dta", nogen keep(master match) keepusing(irszam)
destring irszam, replace
*merge m:1 ujintkod using "kodolo.dta", nogen keep(master match) 
replace irszam=3000 if ujintkod==214581
replace irszam=3600 if ujintkod==214684
replace irszam=3526 if ujintkod==218730
replace irszam=3200 if ujintkod==214682
replace irszam=5700 if ujintkod==218464
replace irszam=8200 if ujintkod==214594
replace irszam=4031 if ujintkod==218787
replace irszam=8300 if ujintkod==214592
replace irszam=7200 if ujintkod==214582
replace irszam=2510 if ujintkod==214598
replace irszam=6640 if ujintkod==218325
replace irszam=2120 if ujintkod==218984
replace irszam=8000 if ujintkod==218540
replace irszam=3360 if ujintkod==214651
replace irszam=2040 if ujintkod==218595
replace irszam=5100 if ujintkod==214596
replace irszam=4031 if ujintkod==214600
replace irszam=6400 if ujintkod==214590
replace irszam=7300 if ujintkod==214584
replace irszam=2400 if ujintkod==218598
replace irszam=3300 if ujintkod==214585
replace irszam=9700 if ujintkod==214595
replace irszam=5400 if ujintkod==214586
replace irszam=3529 if ujintkod==214587
replace irszam=2112 if ujintkod==214588
replace irszam=1051 if ujintkod==218232
replace irszam=7500 if ujintkod==214683
replace irszam=2840 if ujintkod==214589
replace irszam=2484 if ujintkod==218511
replace irszam=4400 if ujintkod==214599
replace irszam=1032 if ujintkod==214511
replace irszam=7900 if ujintkod==214591
replace irszam=8127 if ujintkod==218665
replace irszam=1101 if ujintkod==214984
replace irszam=2700 if ujintkod==214593
replace irszam=9100 if ujintkod==214799
replace irszam=4287 if ujintkod==214451
replace irszam=1051 if ujintkod==218732


sort intkod idszak
save "psych_capacity_raw_small_irsz_2012.dta",  replace


use "psych_capacity_raw_small_irsz_2012.dta", clear
recode irszam (2542=2541)
merge m:1 irszam using "irsz1_tazon.dta", nogen keep(master match)
merge m:1 tazon using "kist_jaras_olstata.dta", nogen keep(master match) keepusing(jaras174)
replace jaras174=int((irszam-1000)/10) if irszam>=1000 & irszam<2000


destring, replace
rename hetiszakorvosirkszma szakorvosi_oraszam
rename hetinemszakorvosirkszma nemszakorvosi_oraszam
rename esetszm esetszam
rename ateljestmnydjalapjulszolglpontrt nemetpont
rename kifizetettdjsszegeteljestmnydjef dijazas
keep idszak szakorvosi_oraszam nemszakorvosi_oraszam esetszam nemetpont dijazas jaras174


destring, replace dpcomma

tostring idszak, replace

gen year=substr(idszak,1,4)
gen month=substr(idszak,5,2)

destring month, replace
destring year, replace

gen ym=ym(year, month)
format ym %tm

fillin jaras174 ym
collapse (sum) szakorvosi nemszakorvosi eset nemet dij, by(ym jaras174 year)

save "psych_capacity_raw_all.dta", replace


foreach var of varlist szakorvosi nemszakorvosi eset nemet dij {
tabstat `var', by (ym) stat (sum)
}

*javitas

*import delimited "jaraskodok.txt", asdouble varnames(1) clear
*save "jaraskodok.dta",  replace


use "psych_capacity_raw_all.dta", clear
keep if year==2012
merge m:1 jaras174 using "jaraskodok.dta", nogen
recode szakorvosi .=0
recode nemszakorvosi .=0
recode year .=2012

fillin jaras174 ym

drop if (ym==. & year==.) | ym==.
drop year _fillin jarasnev

for any szakorvosi nemszakorvosi esetszam nemetpont dijazas: cap recode X .=0


gen szakorv_jav=szakorvosi
replace szakorv_jav=szakorvosi-18 if jaras174==181
replace szakorv_jav=szakorvosi+18 if jaras174==178
replace szakorv_jav=szakorvosi-45 if jaras174==38
replace szakorv_jav=szakorvosi+45 if jaras174==39
replace szakorv_jav=szakorvosi-31 if jaras174==85
replace szakorv_jav=szakorvosi+25 if jaras174==79
replace szakorv_jav=szakorvosi+6 if jaras174==84
replace szakorv_jav=szakorvosi-27 if jaras174==102
replace szakorv_jav=szakorvosi+27 if jaras174==122
replace szakorv_jav=szakorvosi-15 if jaras174==150
replace szakorv_jav=szakorvosi+15 if jaras174==156
replace szakorv_jav=szakorvosi-8 if jaras174==157
replace szakorv_jav=szakorvosi+8 if jaras174==159
replace szakorv_jav=szakorvosi-30 if jaras174==171
replace szakorv_jav=szakorvosi+30 if jaras174==174

gen nemszakorv_jav=nemszakorvosi
replace nemszakorv_jav=nemszakorvosi-2 if jaras174==38
replace nemszakorv_jav=nemszakorvosi+2 if jaras174==39
replace nemszakorv_jav=nemszakorvosi-6 if jaras174==150
replace nemszakorv_jav=nemszakorvosi+6 if jaras174==156
replace nemszakorv_jav=nemszakorvosi-7 if jaras174==157
replace nemszakorv_jav=nemszakorvosi+7 if jaras174==159


save "psych_capacity_2012.dta", replace
tabstat szakorvosi_oraszam szakorv_jav , stat(sum)
