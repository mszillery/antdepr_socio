** Mirjam Szillery
** Generic Entry on the Antidepressant Market in Hungary
* Create PUPHA datafiles (County-level sales, yearly) 

global rfold "E:\AntiDepr"
log using "${rfold}\codes\p_create_log.log", replace

global years 2009 2010 2011 2013 2014 2015 2016 2017 2018 
/*Note: none of the 2012 files from the webpage seemed to work for me, should figure this out */


foreach year of global years {
	
	import excel "${rfold}\pupha_raw\eves\pupha_`year'.xlsx", firstrow case(lower) clear
	
	* Valtozo nevek standardizalasa a kulonbozo evekre
	
	gen t=`year'
	
	capture rename dot_forg_ dotforg
	capture rename brand_id brandid
	capture rename brandnev brand
	capture drop idoszak
	capture drop ev
	
	local vars "doboz" "dotforg" "tbtam" "fogyar" "terdij" "kvater"
	foreach var of local vars {
		capture rename sumof`var' `var'
	}
	
	capture rename sumofdoboz doboz /*not clear why this is needed, should be done by loop above*/
	capture rename sumof doboz
	
	save E:\AntiDepr\pupha\temp\sales_c_y`year'.dta, replace
}

cd E:\AntiDepr\pupha\temp

append using `: dir . files "*.dta"' /* appends all dta files in cd */

keep if (strpos(atc, "N05") == 1 | strpos(atc, "N06") == 1)
save E:\AntiDepr\pupha\sales_c_y_N0506, replace

keep if strpos(atc, "N06A") == 1 
save E:\AntiDepr\pupha\sales_c_y_N06A, replace

log close
