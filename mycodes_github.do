* Load Data Individuals w/ Symptomatic and Symptomatic-Seropositivity Status
*---------------------------------------------------------------------
use "${data_blood_end}\01_clean\endlineBlood_data.dta", clear

* Drop All Individuals Identified in Baseline that We Did Not Collect
* Symptom Data on in the Midline or Endline Surveys
drop if mi_symp == 1 

* Drop All Individuals that Were Symptomatic in Midline or Endline,
* But We Did not Draw Their Blood
drop if elig_no_blood == 1

* Drop All Individuals that we thought we drew blood from, but couldn't
* match to a sample
drop if recorded_blood_no_result == 1


* Run Regressions
*---------------------------------------------------------------------

* (3) Symptomatic-Seropositivity (Pooled, Proportional)
* ---------------------------------------------------------------------
* Drop Pairs Which Don't Have any Adults that are Symptomatic-Seropositive
bys pairID: egen count_sympsero = total(posXsymp)
drop if count_sympsero == 0

* With Baseline Controls
* glm posXsymp treatment proper_mask_base prop_resp_ill_base_2 i.pairID, family(poisson) link(log) vce(cluster union)

xtpoisson posXsymp treatment proper_mask_base prop_resp_ill_base_2 i.pairID, i(union) re vce(robust)
est store m1

* No Baseline Controls
* glm posXsymp treatment i.pairID, family(poisson) link(log) vce(cluster union)

xtpoisson posXsymp treatment i.pairID, i(union) re vce(robust)
est store m2


* (4) Symptomatic-Seropositivity (By Mask Type, Proportional)
* ---------------------------------------------------------------------
* Mask Type, With Baseline Controls
* glm posXsymp treat_surg treat_cloth proper_mask_base prop_resp_ill_base_2 i.pairID, family(poisson) link(log) vce(cluster union)

xtpoisson posXsymp treat_surg treat_cloth proper_mask_base prop_resp_ill_base_2 i.pairID, i(union) re vce(robust)
est store m3


* Mask Type, No Baseline Controls
* glm posXsymp treat_surg treat_cloth i.pairID, family(poisson) link(log) vce(cluster union)

xtpoisson posXsymp treat_surg treat_cloth i.pairID, i(union) re vce(robust)
est store m4

est table m*, drop(i.pairID) b(%8.3f) p(%8.3f) varwidth(20) eform

capture noisily /// 
esttab m* using results.html, drop(*pairID) b(%8.3f) ci star nodep ///
mtitles("Pooled with bc" "Pooled w.o. bc" "By mask type with bc" "By mask type w.o. bc") title("Symptomatic Seroprevalence with Poisson random-effects models") addnotes("bc: baseline control; results for pairID not displayed") eform
