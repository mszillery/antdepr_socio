** Mirjam Szillery
** Generic Entry on the Antidepressant Market in Hungary
* Summary stats

log using "E:\AntiDepr\codes\p_create_log.log", replace
cd "E:\AntiDepr"

**********************************************************

* 1. ATC4 groups during the years

*DOT-sum and price by subgroups

gen atc4=substr(atc,1,4)

*dot-forgalom

collapse (sum) dot_nat=dotforg ,by(t atc4)



bysort t atc4 megye: egen dot_county=total(dotforg)
bysort t atc4 megye: gen dup0=_n

bysort t atc4: egen dot_nat=total(dotforg)
bysort t atc4: egen doboz_nat=total(doboz)

bysort t atc4: egen avgpr_nat=total(fogyar/dot_nat)
bysort t atc4: gen dup1=_n

bysort t atc megye jogcim brandid: gen dup8=_n
bysort t atc megye jogcim dup8: gen brand_no=_N

bysort t atc4: egen avgbrandno=mean(brand_no[dup8==1])

graph drop _all
levelsof atc4, local(levels) clean
foreach l of local levels {
    scatter dot_nat t if dup1==1 & atc4=="`l'", name(graph`l')
	}
	
graph combine graphN05A graphN05B graphN05C graphN06A graphN06B graphN06D
	
	
graph drop _all
levelsof atc4, local(levels) clean
foreach l of local levels {
    scatter doboz_nat t if dup1==1 & atc4=="`l'", name(graph`l')
	}
	
	
	
graph drop _all
levelsof atc4, local(levels) clean
foreach l of local levels {
    scatter avgpr_nat t if dup1==1 & atc4=="`l'", name(graph`l')
	}
	
graph combine graphN05A graphN05B graphN05C graphN06A graphN06B graphN06D

	
	
graph drop _all
levelsof atc4, local(levels) clean
foreach l of local levels {
    scatter avgbrandno t if dup1==1 & atc4=="`l'", name(graph`l')
	}	
	
scatter dot_county t if dup0==1 & atc4=="N05A", by(megye)


log close