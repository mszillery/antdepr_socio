********************************************************************************

*
*Purpose: This file does the following:
* 1)Sets up the import procedure for the PUPHA files
* 2)Runs the import procedure looping over each monthly PUPHA file
********************************************************************************

*********************************************************************************
* Task 1: Set up import procedure
********************************************************************************* 

	*Define global variables: list of variables to keep from the databases
		*global Vars_Pupha_Keep 	a_emp a_occ a_hga a_hgc a_age a_enrlw a_civlf
	*Years to import
		global Pupha_Years	2018
	
*********************************************************************************
* Task 2: Run import procedure
********************************************************************************* 

	****************************************
	* 	Run loop over years
	****************************************
	
	foreach year of global Pupha_Years {
	
	****************************************
		* 	Run loop over CPS months
		****************************************
	
			forvalues m = 1/12  {
			
				*Create local month that tacks on the leading zero
					if `m' < 10 {
						local month 0`m'
					}
					else		{
						local month `m'
					}

				*Store locals
					local Path_PUPHA_ZIP ""`year'`month'.zip""
					local Path_PUPHA_DBF ""MEGYEI_FORGALOM.DBF""
				*Unzip files
					cd E:\Drive\research\AntiDepr\pupha_raw
					unzipfile `Path_PUPHA_ZIP', replace
				*Import files using data dictionary
					import dbase using MEGYEI_FORGALOM.DBF, clear
				*Delete the original unzipped .dat file
					erase `Path_PUPHA_DBF'
					
					/*
				*Drop old labels
					label drop _all
				*Write data labels
					cd $Path_F_C_Labels
					do $Path_Do_LabelCPS8991
				*Keep relevant variables
					keep $Vars_C89_Keep
					*/
				*Generate new variable
					local tempy = `year'
					gen Year = `tempy'
				*Save the processed data
					* If its the first file save it as the pooled dataset
						if  `year' == 2018 & `m' == 1 {
							compress
							cd $Path_F_D_Temporary
						save $Path_TD_PUPHA, replace
						}
					* If its not append it to it
						else {
						* Save a temporary dataset
							compress
							cd $Path_F_D_Temporary
							save $Path_TD_PUPHATemp, replace
						* Open the pooled dataset and append the temporary data to it
							use $Path_TD_PUPHA, replace
							append using $Path_TD_PUPHATemp
							compress
							save $Path_TD_PUPHA, replace
						*Erase the temporary dataset
							erase $Path_TD_PUPHATemp
						}		
			}
			
	}
