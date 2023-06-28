*********************************************************************************
* Summer Module: Programming and Project Management
* 	Master settings file: "Settings.do" 
*
* Author: Mirjam Szillery
* Date: 08/12/2017
*
* Purpose: this file does the following:
* 	1) Define Stata settings
*	2) Define variable lists
*	3) Define OS-dependent filepaths
*	4) Define OS-independent filepaths (file names)
*
* Note 1: This file sets paths needed for the following operations:
*	a) Data preparation
*	b) Summary statistics
*	c) Regressions
*
* Note 2: Callign a file proceeds as follows:
*	1) Change the working directory to the proper folder
*	2) Call the required file
*	3) Change the working directory back
*
*********************************************************************************

********************************************************************************
* Task 1: Define Stata settings
********************************************************************************
	
	* Clear any open datasets from memory, but keep macros
		clear
	* Stop Stata from pausing when a page of the results window fills up
		set more off
	* Make sure required commands are installed
	/*
		 if $InstallCommands == 0 {
			ssc install estout
			ssc install sutex
			net install grc1leg, from(http://www.stata.com/users/vwiggins)
		} 
	
	*/
	

********************************************************************************
* Task 2: Define variable lists
********************************************************************************
/*		
	* Constant across time (ignore UniqueID)
		global Varlist_Constant		AFQTPercentile Age_1979 DOB_Year RaceEthnicity ///
									RaceEthnicity_Screener RotterScore Sample_ID ///
									Sex SociabilityAdult
									
	* Vary over time
		global Varlist_Vary			EmployStatus_Collapsed HighestGradeREV Home_Region ///
									Home_UrbRural HourlyWage NumberJobs Occupation80 ///
									WksUnemployed WksWorked
									
									*/
				
********************************************************************************
* Task 3: Define OS-dependent filepaths
********************************************************************************

	
	global Root_Folder ""E:\Drive\research\AntiDepr""
	
	if c(os) == "MacOSX" {
		
		* Report OS
			display "Mac"
		
		* Folders
		
			* Code
				global Path_F_Code								""$Root_Folder/Code""
				global Path_F_C_Labels							""$Root_Folder/Code/Labels""
				global Path_F_C_Scripts							""$Root_Folder/Code/Scripts""
			* Data
				global Path_F_Data								""$Root_Folder/Data""
				global Path_F_D_Reference						""$Root_Folder/Data/Reference""
				global Path_F_D_Temporary						""$Root_Folder/Data/Temporary""
			* Raw Data
				global Path_F_RawData							""$Root_Folder/Raw Data""
				global Path_F_RD_CPS_8991						""$Root_Folder/Raw Data/CPS""
				global Path_F_RD_NLSY79							""$Root_Folder/Raw Data/NLSY79""
			* Regressions
				global Path_F_Regressions						""$Root_Folder/Regressions""
			* Statistics
				global Path_F_Statistics						""$Root_Folder/Statistics""
				global Path_F_S_Graphs							""$Root_Folder/Statistics/Graphs""
				global Path_F_S_RawOutput						""$Root_Folder/Statistics/Raw Output""
					
	}
	else if c(os) == "Windows" {
	
		* Report OS
			display "Windows"
		
		* Folders
		
			* Code
				global Path_F_Code								""$Root_Folder\codes""
				*global Path_F_C_Labels							""$Root_Folder\Code\Labels""
				*global Path_F_C_Scripts							""$Root_Folder\Code\Scripts""
			* Data
				global Path_F_Data								""$Root_Folder\pupha""
				global Path_F_D_Reference						""$Root_Folder\pupha\Reference""
				global Path_F_D_Temporary						""$Root_Folder\pupha\Temporary""
				global Path_F_RawData							""$Root_Folder"\pupha_raw"""
				*global Path_F_RD_CPS_8991						""$Root_Folder\Raw Data\CPS""
				*global Path_F_RD_NLSY79							""$Root_Folder\Raw Data\NLSY79""
			* Regressions
				global Path_F_Regressions						""$Root_Folder\Regressions""
			* Statistics
				global Path_F_Statistics						""$Root_Folder\Statistics""
				global Path_F_S_Graphs							""$Root_Folder\Statistics\Graphs""
				global Path_F_S_RawOutput						""$Root_Folder\Statistics\Raw Output""
				
	}
	else if c(os) == "Unix" {
	
		* Report OS
			display "Unix"
		
		* Folders
			* Code
				global Path_F_Code
				global Path_F_C_Labels							""$Root_Folder/Code/Labels""
				global Path_F_C_Scripts							""$Root_Folder/Code/Scripts""
			* Data
				global Path_F_Data								""$Root_Folder/Data""
				global Path_F_D_Reference						""$Root_Folder/Data/Reference""
				global Path_F_D_Temporary						""$Root_Folder/Data/Temporary""
			* Raw Data
				global Path_F_RawData							""$Root_Folder/Raw Data""
				global Path_F_RD_CPS_8991						""$Root_Folder/Raw Data/CPS""
				global Path_F_RD_NLSY79							""$Root_Folder/Raw Data/NLSY79""
			* Regressions
				global Path_F_Regressions						""$Root_Folder/Regressions""
			* Statistics
				global Path_F_Statistics						""$Root_Folder/Statistics""
				global Path_F_S_Graphs							""$Root_Folder/Statistics/Graphs""
				global Path_F_S_RawOutput						""$Root_Folder/Statistics/Raw Output""
	
	}
	else {
		display "Unsupported Operating System"
		exit
	}


********************************************************************************
* Task 4: Define OS-independent file names
********************************************************************************					
	
	**********************
	* 4a: Do Files
	**********************
	
	
	
		* Import data
			global Path_Do_D1ImportNLSY79					""D1 - Import NLSY79.do""
			global Path_Do_D1ImportCPS						""D1 - Import CPS.do""
			global Path_Do_D2ProcessNLSY79					""D2 - Process NLSY79.do""
			global Path_Do_D2ProcessCPS						""D2 - Process CPS.do""
			global Path_Do_D3CreateMaster					""D3 - Create Master.do""
			* Labels
				global Path_Do_LabelNLSY79						""Label NLSY79.do""
				global Path_Do_RenameNLSY79						""Rename NLSY79.do""
				global Path_Do_LabelCPS8991						""Label CPS 1989-91.do""
		
		* Data Description
			global Path_Do_Tables							""S - Tables.do""
			global Path_Do_Graphs							""S - Graphs.do""
				
		* Regressions
			global Path_Do_Regressions						""Regressions.do""

	**********************
	* 4b: Data
	**********************
		
		* Raw Data
			* CPS: 1989-91
				global Path_RD_C89_Dict						""CPS - Dictionary.dct""
			* NLSY79
				global Path_RD_NLSY79						""Module.dct""
			* BLS - LAUS
				global Path_RD_BLSLAUS						""LAUS Import.dta""

		* Temporary Files
		
			* NLSY79
				global Path_TD_PUPHA						""PUPHA.dta""
				global Path_TD_PUPHATemp					""PUPHA_Temp.dta""
				
		* Reference
			* Job Requirements
				global Path_Ref_JobRequire					""Required Education.dta""
			* Processed NLSY79
				global Path_Ref_NLSY79						""Processed NLSY79.dta""
				
		* Full Datasets
			* Long
				global Path_D_Master							""Master.dta""

				
				*/
