
use anon jaras_al t kor ev ferfi ///
using "/homeProspSSD/Admin3/admin3_alap_v2.dta", clear
keep if ev>=2009
*merge az outcome valtozokkal
merge 1:1 anon t using "/homeProspSSD/Admin3/admin3_eu_hazio_v2.dta", ///
keep (master match) keepusing (hsz_eset) nogen
*recode hsz_eset .=0 if anon!=. & ev>=2009
merge 1:1 anon t using "/homeProspSSD/Admin3/admin3_eu_jaro_v2.dta", ///
keep (master match) keepusing (jaro_db jaro_ft_ossz) nogen
*recode jaro_db .=0 if anon!=. & ev>=2009
*recode jaro_ft_ossz .=0 if anon!=. & ev>=2009
merge 1:1 anon t using "/homeProspSSD/Admin3/admin3_eu_fekvo_v2.dta", ///
keep (master match) keepusing (fekvo_nap fekvo_ft) nogen
*recode fekvo_nap .=0 if anon!=. & ev>=2009
*recode fekvo_ft .=0 if anon!=. & ev>=2009
merge 1:1 anon t using "/homeProspSSD/Admin3/admin3_eu_veny_v2.dta", ///
keep (master match) keepusing (db_ossz betegft_ossz tbtam_ossz) nogen
*recode db_ossz .=0 if anon!=. & ev>=2009
*recode betegft_ossz .=0 if anon!=. & ev>=2009
*recode tbtam_ossz .=0 if anon!=. & ev>=2009
merge 1:1 anon t using "/homeProspSSD/Admin3_H2_NEAK_veny/admin3_eu_veny_H2_v2.dta", ///
keep (master match) keepusing (C02_09_ft A10_ft N05_ft N06_ft J01_ft R03_ft L_ft) nogen
*recode C02_09_ft .=0 if anon!=. & ev>=2009
*recode A10_ft .=0 if anon!=. & ev>=2009
*recode N05_ft .=0 if anon!=. & ev>=2009
*recode N06_ft .=0 if anon!=. & ev>=2009

gcollapse (sum) hsz_eset jaro_db jaro_ft_ossz fekvo_nap fekvo_ft db_ossz betegft_ossz ///
tbtam_ossz C02_09_ft A10_ft N05_ft N06_ft J01_ft R03_ft L_ft osszeg_nyufig ///
(firstnm) kor ferfi (lastnm)jaras_al (max) koltozes, ///
by (anon ev)

for any hsz_eset jaro_db jaro_ft_ossz fekvo_ft fekvo_nap db_ossz ///
betegft_ossz tbtam_ossz C02_09_ft A10_ft N05_ft N06_ft J01_ft R03_ft L_ft : recode X .=0

cap drop korcsop
gen korcsop=int(kor/5)


compress
save "/homeKRTK/egeszseg_dekomp/Admin3_ev.dta", replace
