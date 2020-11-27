* Define the location of the main folder on your computer *
global mypath "\\Client\H$\Documents\GitHub\KenyaRoadsandDemocracy_Reproduction\ICPSR_Reproduction\AER_2013_1031_replication\main-tables-figures"

* In the "data-preparation-main-tables-figures" folder, we have used the dofile "data-preperation-main-tables-figures.do" to create the three data sets we use to run the main regressions for Kenya *
* - One data set (kenya_roads_exp) with road development expenditure as the dependent variable
* - One data set (kenya_roads_pav) with paved road construction as the dependent variable
* - One data set (kenya_roads_cabinet) with the cabinet share as the dependent variable

*******************************************************************************************
* This do-file first creates the main tables for the paper, table 1, 2, 3, 4, and 5 *******
*******************************************************************************************

*******************************************************************************************
*******************************************************************************************
*** Table 1: "Road Expenditure, Ethnicity and Democratic Change in Kenya, 1963-2011" ******
*******************************************************************************************
*******************************************************************************************

* This is the data set with road development expenditure as the dependent variable
use "$mypath\kenya_roads_exp", clear

* Column (1) Panel A: no interaction
xi: areg exp_dens_share president i.year, absorb(distnum) robust cluster(distnum)
outreg2 president using "$mypath\table_1.xls", se nocons coefastr bdec(2) adjr2 noni nolabel bracket title(Effect, "") nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) replace

* Column (1) Panel B: interaction
xi: areg exp_dens_share president presidentMP  multiparty i.year, absorb(distnum) robust cluster(distnum)
outreg2 president presidentMP using "$mypath\table_1.xls", se nocons coefastr bdec(2) adjr2 noni nolabel bracket title(Effect, "") nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append
test president + presidentMP = 0

* Column (2) Panel A: no interaction, + (Controls: Population, Area, Urbanization Rate)*trend
xi: areg exp_dens_share president pop1962_t area_t urbrate1962_t i.year, absorb(distnum) robust cluster(distnum)
outreg2 president presidentMP using "$mypath\table_1.xls", se nocons coefastr bdec(2) adjr2 noni nolabel bracket title(Effect, "") nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append

* Column (2) Panel B: interaction, + (Controls: Population, Area, Urbanization Rate)*trend
xi: areg exp_dens_share president presidentMP multiparty pop1962_t area_t urbrate1962_t i.year, absorb(distnum) robust cluster(distnum)
outreg2 president presidentMP using "$mypath\table_1.xls", se nocons coefastr bdec(2) adjr2 noni nolabel bracket title(Effect, "") nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append
test president + presidentMP = 0

* Column (3) Panel A: no interaction, + (Additional Controls: Earnings, Employment, Cash Crops)*trend
xi: areg exp_dens_share president pop1962_t area_t urbrate1962_t earnings_t wage_employment_t value_cashcrops_t i.year, absorb(distnum) robust cluster(distnum)
outreg2 president presidentMP using "$mypath\table_1.xls", se nocons coefastr bdec(2) adjr2 noni nolabel bracket title(Effect, "") nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append

* Column (3) Panel B : interaction, + (Additional Controls: Earnings, Employment, Cash Crops)*trend
xi: areg exp_dens_share president presidentMP multiparty pop1962_t area_t urbrate1962_t earnings_t wage_employment_t value_cashcrops_t i.year, absorb(distnum) robust cluster(distnum)
outreg2 president presidentMP using "$mypath\table_1.xls", se nocons coefastr bdec(2) adjr2 noni nolabel bracket title(Effect, "") nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append
test president + presidentMP = 0

* Column (4) Panel A: no interaction, + (Additional Controls: Main Highway, Border, Dist. Nairobi)*trend
xi: areg exp_dens_share president pop1962_t area_t urbrate1962_t earnings_t wage_employment_t value_cashcrops_t i.MomKam|year i.border|year dist2nairobi_t i.year, absorb(distnum) robust cluster(distnum)
outreg2 president presidentMP using "$mypath\table_1.xls", se nocons coefastr bdec(2) adjr2 noni nolabel bracket title(Effect, "") nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append

* Column (4) Panel B: interaction, + (Main Highway, Border, Dist. Nairobi)*trend
xi: areg exp_dens_share president presidentMP multiparty pop1962_t area_t urbrate1962_t earnings_t wage_employment_t value_cashcrops_t i.MomKam|year i.border|year dist2nairobi_t i.year, absorb(distnum) robust cluster(distnum)
outreg2 president presidentMP using "$mypath\table_1.xls", se nocons coefastr bdec(2) adjr2 noni nolabel bracket title(Effect, "") nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append
test president + presidentMP = 0

* Column (5) Panel A: no interaction, District time trends only
* we use xtreg to run this regression
* and use tsset to create the district and year fixed effects
tsset distnum year
xi: xtreg exp_dens_share president i.distnum*year, robust cluster(distnum) fe
outreg2 president presidentMP using "$mypath\table_1.xls", se nocons coefastr bdec(2) adjr2 noni nolabel bracket title(Effect, "") nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append

* Column (5) Panel B: interaction, District time trends only
* we use xtreg to run this regression
* and use tsset to create the district and year fixed effects
tsset distnum year
xi: xtreg exp_dens_share president presidentMP multiparty i.distnum*year, robust cluster(distnum) fe
outreg2 president presidentMP using "$mypath\table_1.xls", se nocons coefastr bdec(2) adjr2 noni nolabel bracket title(Effect, "") nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append
test president + presidentMP = 0

***************************************************************************************
***************************************************************************************
*** Table 2: "Road Building, Ethnicity and Democratic Change in Kenya, 1964-2002" *****
***************************************************************************************
***************************************************************************************

* We use the data set with paved road construction as the dependent variable *
use "$mypath\kenya_roads_pav", clear

* Column (1) Panel A: no interaction
xi: areg change_paved_share president i.year, absorb(distnum) robust cluster(distnum)
outreg2 president using "$mypath\table_2.xls", se nocons coefastr bdec(2) adjr2 noni nolabel bracket title(Effect, "") nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) replace

* Column (1) Panel B: interaction
xi: areg change_paved_share president presidentMP  multiparty i.year, absorb(distnum) robust cluster(distnum)
outreg2 president presidentMP using "$mypath\table_2.xls", se nocons coefastr bdec(2) adjr2 noni nolabel bracket title(Effect, "") nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append
test president + presidentMP = 0

* Column (2) Panel A: no interaction, + (Population, Area, Urbanization Rate)*trend
xi: areg change_paved_share president pop1962_t area_t urbrate1962_t i.year, absorb(distnum) robust cluster(distnum)
outreg2 president presidentMP using "$mypath\table_2.xls", se nocons coefastr bdec(2) adjr2 noni nolabel bracket title(Effect, "") nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append

* Column (2) Panel B: interaction, + (Population, Area, Urbanization Rate)*trend
xi: areg change_paved_share president presidentMP multiparty pop1962_t area_t urbrate1962_t i.year, absorb(distnum) robust cluster(distnum)
outreg2 president presidentMP using "$mypath\table_2.xls", se nocons coefastr bdec(2) adjr2 noni nolabel bracket title(Effect, "") nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append
test president + presidentMP = 0

* Column (3) Panel A: no interaction, + (Earnings, Employment, Cash Crops)*trend
xi: areg change_paved_share president pop1962_t area_t urbrate1962_t earnings_t wage_employment_t value_cashcrops_t i.year, absorb(distnum) robust cluster(distnum)
outreg2 president presidentMP using "$mypath\table_2.xls", se nocons coefastr bdec(2) adjr2 noni nolabel bracket title(Effect, "") nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append

* Column (3) Panel B : interaction, + (Earnings, Employment, Cash Crops)*trend
xi: areg change_paved_share president presidentMP multiparty pop1962_t area_t urbrate1962_t earnings_t wage_employment_t value_cashcrops_t i.year, absorb(distnum) robust cluster(distnum)
outreg2 president presidentMP using "$mypath\table_2.xls", se nocons coefastr bdec(2) adjr2 noni nolabel bracket title(Effect, "") nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append
test president + presidentMP = 0

* Column (4) Panel A: no interaction, + (Main Highway, Border, Dist. Nairobi)*trend
xi: areg change_paved_share president pop1962_t area_t urbrate1962_t earnings_t wage_employment_t value_cashcrops_t i.MomKam|year i.border|year dist2nairobi_t i.year, absorb(distnum) robust cluster(distnum)
outreg2 president presidentMP using "$mypath\table_2.xls", se nocons coefastr bdec(2) adjr2 noni nolabel bracket title(Effect, "") nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append

* Column (4) Panel B: interaction, + (Main Highway, Border, Dist. Nairobi)*trend
xi: areg change_paved_share president presidentMP multiparty pop1962_t area_t urbrate1962_t earnings_t wage_employment_t value_cashcrops_t i.MomKam|year i.border|year dist2nairobi_t i.year, absorb(distnum) robust cluster(distnum)
outreg2 president presidentMP using "$mypath\table_2.xls", se nocons coefastr bdec(2) adjr2 noni nolabel bracket title(Effect, "") nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append
test president + presidentMP = 0

* Column (5) Panel A: no interaction, District time trends only
* we use xtreg to run this regression
* and use tsset to create the district and year fixed effects
tsset distnum year
xi: xtreg change_paved_share president i.distnum*year, robust cluster(distnum) fe
outreg2 president presidentMP using "$mypath\table_2.xls", se nocons coefastr bdec(2) adjr2 noni nolabel bracket title(Effect, "") nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append

* Column (5) Panel B: interaction, District time trends only
* we use xtreg to run this regression
* and use tsset to create the district and year fixed effects
tsset distnum year
xi: xtreg change_paved_share president presidentMP multiparty i.distnum*year, robust cluster(distnum) fe
outreg2 president presidentMP using "$mypath\table_2.xls", se nocons coefastr bdec(2) adjr2 noni nolabel bracket title(Effect, "") nonotes addnote("", Robust standard errors clustered at the district level in parentheses, * significant at 10%; ** significant at 5%; *** significant at 1%) append
test president + presidentMP = 0


