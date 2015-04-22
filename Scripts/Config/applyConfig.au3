;Applies all of the  variable to the GUI

Func applyConfig() ;Applies the data from config to the controls in GUI
	;Locate settings

	If $TownHallPos[0] < 1 Then GUICtrlSetStyle($btnLocateTownHall, 0, $WS_EX_STATICEDGE)
	If $CCPos[0] < 1 Then GUICtrlSetStyle($btnLocateClanCastle2, 0, $WS_EX_STATICEDGE)
	If $ArmyPos[0] < 1 Then GUICtrlSetStyle($btnLocateCamp, 0, $WS_EX_STATICEDGE)
	If $barrackPos[0][0] < 1 Then GUICtrlSetStyle($btnLocateBarracks, 0, $WS_EX_STATICEDGE)
	If $DarkBarrackPos[0][0] < 1 Then GUICtrlSetStyle($btnLocateDarkBarracks, 0, $WS_EX_STATICEDGE)
	If $KingPos[0] < 1 Then GUICtrlSetStyle($btnLocateKingAltar, 0, $WS_EX_STATICEDGE)
	If $QueenPos[0] < 1 Then GUICtrlSetStyle($btnLocateQueenAltar, 0, $WS_EX_STATICEDGE)
	If $SFactoryPos[0] < 1 Then GUICtrlSetStyle($btnLocateSFactory, 0, $WS_EX_STATICEDGE)
	If $RunState = True Then
		GUICtrlSetState($btnLocateTownHall, $GUI_DISABLE)
		GUICtrlSetState($btnLocateClanCastle2, $GUI_DISABLE)
		GUICtrlSetState($btnLocateCamp, $GUI_DISABLE)
		GUICtrlSetState($btnLocateBarracks, $GUI_DISABLE)
		GUICtrlSetState($btnLocateDarkBarracks, $GUI_DISABLE)
		GUICtrlSetState($btnLocateKingAltar, $GUI_DISABLE)
		GUICtrlSetState($btnLocateQueenAltar, $GUI_DISABLE)
		GUICtrlSetState($btnLocateSFactory, $GUI_DISABLE)
	EndIf

	;Search Settings------------------------------------------------------------------------
	GUICtrlSetData($txtDeadMinGold, $MinDeadGold)
	GUICtrlSetData($txtDeadMinElixir, $MinDeadElixir)
	GUICtrlSetData($txtDeadMinDarkElixir, $MinDeadDark)
	GUICtrlSetData($txtDeadMinTrophy, $MinDeadTrophy)
	GUICtrlSetData($txtMinGold, $MinGold)
	GUICtrlSetData($txtMinElixir, $MinElixir)
	GUICtrlSetData($txtMinDarkElixir, $MinDark)
	GUICtrlSetData($txtMinTrophy, $MinTrophy)

	_GUICtrlComboBox_SetCurSel($cmbAny, $icmbAny)
	_GUICtrlComboBox_SetCurSel($cmbDead, $icmbDead)

	For $i = 0 To 4
		If $icmbTH = $i Then $MaxTH = $THText[$i]
		If $icmbDeadTH = $i Then $MaxDeadTH = $THText[$i]
	Next

	If $chkConditions[0] = 1 Then
		GUICtrlSetState($chkDeadGE, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDeadGE, $GUI_UNCHECKED)
	EndIf

	If $chkConditions[1] = 1 Then
		GUICtrlSetState($chkDeadMeetDE, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDeadMeetDE, $GUI_UNCHECKED)
	EndIf

	If $chkConditions[2] = 1 Then
		GUICtrlSetState($chkDeadMeetTrophy, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDeadMeetTrophy, $GUI_UNCHECKED)
	EndIf

	If $chkConditions[3] = 1 Then
		GUICtrlSetState($chkDeadMeetTH, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDeadMeetTH, $GUI_UNCHECKED)
	EndIf

	If $chkConditions[4] = 1 Then
		GUICtrlSetState($chkDeadMeetTHO, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDeadMeetTHO, $GUI_UNCHECKED)
	EndIf

	If $chkConditions[5] = 1 Then
		GUICtrlSetState($chkMeetGE, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkMeetGE, $GUI_UNCHECKED)
	EndIf

	If $chkConditions[6] = 1 Then
		GUICtrlSetState($chkMeetDE, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkMeetDE, $GUI_UNCHECKED)
	EndIf

	If $chkConditions[7] = 1 Then
		GUICtrlSetState($chkMeetTrophy, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkMeetTrophy, $GUI_UNCHECKED)
	EndIf

	If $chkConditions[8] = 1 Then
		GUICtrlSetState($chkMeetTH, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkMeetTH, $GUI_UNCHECKED)
	EndIf

	If $chkConditions[9] = 1 Then
		GUICtrlSetState($chkMeetTHO, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkMeetTHO, $GUI_UNCHECKED)
	EndIf

	If $AlertBaseFound = 1 Then
		GUICtrlSetState($chkAlertSearch, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkAlertSearch, $GUI_UNCHECKED)
	EndIf

	If $TakeLootSnapShot = 1 Then
		GUICtrlSetState($chkTakeLootSS, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkTakeLootSS, $GUI_UNCHECKED)
	EndIf

	If $TakeAllTownSnapShot = 1 Then
		GUICtrlSetState($chkTakeTownSS, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkTakeTownSS, $GUI_UNCHECKED)
	EndIf

	If $ichkWideEdge = 1 Then
		GUICtrlSetState($chkWideEdge, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkWideEdge, $GUI_UNCHECKED)
	EndIf

	If $ichkRedLine = 1 Then
		GUICtrlSetState($chkRedLine_vip, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkRedLine_vip, $GUI_UNCHECKED)
	EndIf

	_GUICtrlComboBox_SetCurSel($cmbTH, $icmbTH)
	_GUICtrlComboBox_SetCurSel($cmbDeadTH, $icmbDeadTH)

	;Search Settings------------------------------------------------------------------------
	If $ichkredDead = 1 Then
		GUICtrlSetState($chkredDead, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkredDead, $GUI_UNCHECKED)
	EndIf
	GUICtrlSetData($txtGoldRedDead, $itxtGoldRedDead)
	GUICtrlSetData($txtElixRedDead, $itxtElixRedDead)
	GUICtrlSetData($txtDERedDead, $itxtDERedDead)
	GUICtrlSetData($txtTroRedDead, $itxtTroRedDead)
	GUICtrlSetData($txtRedSearchDead, $itxtRedSearchDead)
	GUICtrlSetData($txtGoldElixRedDead, $itxtGoldElixRedDead)

	If $ichkredAny = 1 Then
		GUICtrlSetState($chkredAny, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkredAny, $GUI_UNCHECKED)
	EndIf
	GUICtrlSetData($txtGoldRedAny, $itxtGoldRedAny)
	GUICtrlSetData($txtElixRedAny, $itxtElixRedAny)
	GUICtrlSetData($txtDERedAny, $itxtDERedAny)
	GUICtrlSetData($txtTroRedAny, $itxtTroRedAny)
	GUICtrlSetData($txtRedSearchAny, $itxtRedSearchAny)
	GUICtrlSetData($txtGoldElixRedAny, $itxtGoldElixRedAny)
	;Attack Settings-------------------------------------------------------------------------
	_GUICtrlComboBox_SetCurSel($cmbDeadDeploy, $deployDeadSettings)
	_GUICtrlComboBox_SetCurSel($cmbDeadAlgorithm, $icmbDeadAlgorithm)

	If $checkDeadUseKing = 1 Then
		GUICtrlSetState($chkDeadUseKing, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDeadUseKing, $GUI_UNCHECKED)
	EndIf

	If $checkDeadUseQueen = 1 Then
		GUICtrlSetState($chkDeadUseQueen, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDeadUseQueen, $GUI_UNCHECKED)
	EndIf

	If $checkDeadUseClanCastle = 1 Then
		GUICtrlSetState($chkDeadUseClanCastle, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDeadUseClanCastle, $GUI_UNCHECKED)
	EndIf

	_GUICtrlComboBox_SetCurSel($cmbDeadAttackTH_vip, $icmbDeadAttackTH)

	_GUICtrlComboBox_SetCurSel($cmbDeploy, $deploySettings)
	_GUICtrlComboBox_SetCurSel($cmbAlgorithm, $icmbAlgorithm)

	If $checkUseKing = 1 Then
		GUICtrlSetState($chkUseKing, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkUseKing, $GUI_UNCHECKED)
	EndIf

	If $checkUseQueen = 1 Then
		GUICtrlSetState($chkUseQueen, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkUseQueen, $GUI_UNCHECKED)
	EndIf

	If $checkUseClanCastle = 1 Then
		GUICtrlSetState($chkUseClanCastle, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkUseClanCastle, $GUI_UNCHECKED)
	EndIf

	_GUICtrlComboBox_SetCurSel($cmbAttackTH_vip, $icmbAttackTH)

	_GUICtrlComboBox_SetCurSel($cmbUnitDelay_vip, $icmbUnitDelay)
	_GUICtrlComboBox_SetCurSel($cmbWaveDelay_vip, $icmbWaveDelay)

	If $iRandomspeedatk = 1 Then
		GUICtrlSetState($chkRandomSpeedAtk_vip, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkRandomSpeedAtk_vip, $GUI_UNCHECKED)
	EndIf
	Randomspeedatk()

	;Donate Settings-------------------------------------------------------------------------
	If $ichkBlacklist = 1 Then
		GUICtrlSetState($chkBlacklist, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkBlacklist, $GUI_UNCHECKED)
	EndIf
	;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	If $ichkRequest = 1 Then
		GUICtrlSetState($chkRequest, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkRequest, $GUI_UNCHECKED)
	EndIf
	;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	If $ichkDonateBarbarians = 1 Then
		GUICtrlSetState($chkDonateBarbarians, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDonateBarbarians, $GUI_UNCHECKED)
	EndIf
	If $ichkDonateAllBarbarians = 1 Then
		GUICtrlSetState($chkDonateAllBarbarians, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDonateAllBarbarians, $GUI_UNCHECKED)
	EndIf
	;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	If $ichkDonateArchers = 1 Then
		GUICtrlSetState($chkDonateArchers, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDonateArchers, $GUI_UNCHECKED)
	EndIf
	If $ichkDonateAllArchers = 1 Then
		GUICtrlSetState($chkDonateAllArchers, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDonateAllArchers, $GUI_UNCHECKED)
	EndIf
	;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	If $ichkDonateGiants = 1 Then
		GUICtrlSetState($chkDonateGiants, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDonateGiants, $GUI_UNCHECKED)
	EndIf
	If $ichkDonateAllGiants = 1 Then
		GUICtrlSetState($chkDonateAllGiants, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDonateAllGiants, $GUI_UNCHECKED)
	EndIf

	GUICtrlSetData($txtDonateBarbarians, $itxtDonateBarbarians)
	GUICtrlSetData($txtDonateArchers, $itxtDonateArchers)
	GUICtrlSetData($txtDonateGiants, $itxtDonateGiants)
	GUICtrlSetData($cmbDonateBarbarians1, IniRead($config, "donate", "donate11", "Barbarian"), "Barbarian")
	GUICtrlSetData($cmbDonateBarbarians2, IniRead($config, "donate", "donate12", "None"), "None")
	GUICtrlSetData($cmbDonateBarbarians3, IniRead($config, "donate", "donate13", "None"), "None")
	GUICtrlSetData($NoOfBarbarians1, IniRead($config, "donate", "amount11", 1), 1)
	GUICtrlSetData($NoOfBarbarians2, IniRead($config, "donate", "amount12", 1), 1)
	GUICtrlSetData($NoOfBarbarians3, IniRead($config, "donate", "amount13", 1), 1)
	GUICtrlSetData($cmbDonateArchers1, IniRead($config, "donate", "donate21", "Archer"), "Archer")
	GUICtrlSetData($cmbDonateArchers2, IniRead($config, "donate", "donate22", "None"), "None")
	GUICtrlSetData($cmbDonateArchers3, IniRead($config, "donate", "donate23", "None"), "None")
	GUICtrlSetData($NoOfArchers1, IniRead($config, "donate", "amount21", 1), 1)
	GUICtrlSetData($NoOfArchers2, IniRead($config, "donate", "amount22", 1), 1)
	GUICtrlSetData($NoOfArchers3, IniRead($config, "donate", "amount23", 1), 1)
	GUICtrlSetData($cmbDonateGiants1, IniRead($config, "donate", "donate31", "Giant"), "Giant")
	GUICtrlSetData($cmbDonateGiants2, IniRead($config, "donate", "donate32", "None"), "None")
	GUICtrlSetData($cmbDonateGiants3, IniRead($config, "donate", "donate33", "None"), "None")
	GUICtrlSetData($NoOfGiants1, IniRead($config, "donate", "amount31", 1), 1)
	GUICtrlSetData($NoOfGiants2, IniRead($config, "donate", "amount32", 1), 1)
	GUICtrlSetData($NoOfGiants3, IniRead($config, "donate", "amount33", 1), 1)

	GUICtrlSetData($txtDonateBarbarians, $itxtDonateBarbarians)
	GUICtrlSetData($txtDonateArchers, $itxtDonateArchers)
	GUICtrlSetData($txtDonateGiants, $itxtDonateGiants)

	GUICtrlSetData($txtRequest, $itxtRequest)
	chkRequest()

	GUICtrlSetData($txtNotDonate, $itxtNotDonate)
	chkBlacklist()
	;Troop Settings--------------------------------------------------------------------------
	_GUICtrlComboBox_SetCurSel($cmbTroopComp, $icmbTroopComp)
	_GUICtrlComboBox_SetCurSel($cmbRaidcap, $icmbRaidcap)
	GUICtrlSetData($txtCapacity, $itxtcampCap)
	GUICtrlSetData($txtBarbarians, $BarbariansComp)
	GUICtrlSetData($txtArchers, $ArchersComp)
	GUICtrlSetData($txtNumGiants, $GiantsComp)
	GUICtrlSetData($txtGoblins, $GoblinsComp)
	GUICtrlSetData($txtNumWallbreakers, $WBComp)
	SetComboTroopComp()

	_GUICtrlComboBox_SetCurSel($cmbBarrack1, $barrackTroop[0])
	_GUICtrlComboBox_SetCurSel($cmbBarrack2, $barrackTroop[1])
	_GUICtrlComboBox_SetCurSel($cmbBarrack3, $barrackTroop[2])
	_GUICtrlComboBox_SetCurSel($cmbBarrack4, $barrackTroop[3])

	If $ichkDarkTroop = 1 Then
		GUICtrlSetState($chkDarkTroop, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDarkTroop, $GUI_UNCHECKED)
	EndIf
	_GUICtrlComboBox_SetCurSel($cmbDarkBarrack1, $DarkBarrackTroop[0])
	_GUICtrlComboBox_SetCurSel($cmbDarkBarrack2, $DarkBarrackTroop[1])
	GUICtrlSetData($txtDarkBarrack1, $itxtDarkBarrack1)
	GUICtrlSetData($txtDarkBarrack2, $itxtDarkBarrack2)

	;Custom Troop 2 Settings--------------------------------------------------------------------------
	GUICtrlSetData($txtFirstTroop1, $itxtFirstTroop[0])
	GUICtrlSetData($txtFirstTroop2, $itxtFirstTroop[1])
	GUICtrlSetData($txtFirstTroop3, $itxtFirstTroop[2])
	GUICtrlSetData($txtFirstTroop4, $itxtFirstTroop[3])
	_GUICtrlComboBox_SetCurSel($cmbFirstTroop1, $CustomTroopF[0])
	_GUICtrlComboBox_SetCurSel($cmbFirstTroop2, $CustomTroopF[1])
	_GUICtrlComboBox_SetCurSel($cmbFirstTroop3, $CustomTroopF[2])
	_GUICtrlComboBox_SetCurSel($cmbFirstTroop4, $CustomTroopF[3])

	_GUICtrlComboBox_SetCurSel($cmbSecondTroop1, $CustomTroopS[0])
	_GUICtrlComboBox_SetCurSel($cmbSecondTroop2, $CustomTroopS[1])
	_GUICtrlComboBox_SetCurSel($cmbSecondTroop3, $CustomTroopS[2])
	_GUICtrlComboBox_SetCurSel($cmbSecondTroop4, $CustomTroopS[3])

	;Other Settings--------------------------------------------------------------------------
	If $ichkWalls = 1 Then
		GUICtrlSetState($chkWalls_vip, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkWalls_vip, $GUI_UNCHECKED)
	EndIf
	_GUICtrlComboBox_SetCurSel($cmbWalls_vip, $icmbWalls)
	_GUICtrlComboBox_SetCurSel($cmbTolerance_vip, $icmbTolerance)

	Switch $iUseStorage
		Case 0
			GUICtrlSetState($UseGold_vip, $GUI_CHECKED)
			GUICtrlSetState($UseElixir_vip, $GUI_UNCHECKED)
			GUICtrlSetState($UseGoldElix_vip, $GUI_UNCHECKED)
		Case 1
			GUICtrlSetState($UseElixir_vip, $GUI_CHECKED)
			GUICtrlSetState($UseGold_vip, $GUI_UNCHECKED)
			GUICtrlSetState($UseGoldElix_vip, $GUI_UNCHECKED)
		Case 2
			GUICtrlSetState($UseGoldElix_vip, $GUI_CHECKED)
			GUICtrlSetState($UseGold_vip, $GUI_UNCHECKED)
			GUICtrlSetState($UseElixir_vip, $GUI_UNCHECKED)
	EndSwitch

	GUICtrlSetData($txtWallMinGold_vip, $itxtWallMinGold)
	GUICtrlSetData($txtWallMinElixir_vip, $itxtWallMinElixir)
	GUICtrlSetData($txtBldgMinGold_vip, $itxtBldgMinGold)
	GUICtrlSetData($txtBldgMinElixir_vip, $itxtBldgMinElixir)

	If $ichkUpgrade1 = 1 Then
		GUICtrlSetState($chkUpgrade1_vip, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkUpgrade1_vip, $GUI_UNCHECKED)
	EndIf
	If $ichkUpgrade2 = 1 Then
		GUICtrlSetState($chkUpgrade2_vip, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkUpgrade2_vip, $GUI_UNCHECKED)
	EndIf
	If $ichkUpgrade3 = 1 Then
		GUICtrlSetState($chkUpgrade3_vip, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkUpgrade3_vip, $GUI_UNCHECKED)
	EndIf
	GUICtrlSetData($txtUpgradeX1_vip, $itxtUpgradeX1)
	GUICtrlSetData($txtUpgradeY1_vip, $itxtUpgradeY1)
	GUICtrlSetData($txtUpgradeX2_vip, $itxtUpgradeX2)
	GUICtrlSetData($txtUpgradeY2_vip, $itxtUpgradeY2)
	GUICtrlSetData($txtUpgradeX3_vip, $itxtUpgradeX3)
	GUICtrlSetData($txtUpgradeY3_vip, $itxtUpgradeY3)

    If $ichkBoostRax1 = 1 Then
	   GUICtrlSetState($chkBoostRax1_vip, $GUI_CHECKED)
	Else
	   GUICtrlSetState($chkBoostRax1_vip, $GUI_UNCHECKED)
	EndIf
    If $ichkBoostRax2 = 1 Then
	   GUICtrlSetState($chkBoostRax2_vip, $GUI_CHECKED)
	Else
	   GUICtrlSetState($chkBoostRax2_vip, $GUI_UNCHECKED)
	EndIf
    If $ichkBoostRax3 = 1 Then
	   GUICtrlSetState($chkBoostRax3_vip, $GUI_CHECKED)
	Else
	   GUICtrlSetState($chkBoostRax3_vip, $GUI_UNCHECKED)
	EndIf
    If $ichkBoostRax4 = 1 Then
	   GUICtrlSetState($chkBoostRax4_vip, $GUI_CHECKED)
	Else
	   GUICtrlSetState($chkBoostRax4_vip, $GUI_UNCHECKED)
	EndIf
    If $ichkBoostDark1 = 1 Then
	   GUICtrlSetState($chkBoostDark1_vip, $GUI_CHECKED)
	Else
	   GUICtrlSetState($chkBoostDark1_vip, $GUI_UNCHECKED)
	EndIf
    If $ichkBoostDark1 = 1 Then
	   GUICtrlSetState($chkBoostDark2_vip, $GUI_CHECKED)
	Else
	   GUICtrlSetState($chkBoostDark2_vip, $GUI_UNCHECKED)
	EndIf
    If $ichkBoostKing = 1 Then
	   GUICtrlSetState($chkBoostKing_vip, $GUI_CHECKED)
	Else
	   GUICtrlSetState($chkBoostKing_vip, $GUI_UNCHECKED)
	EndIf
    If $ichkBoostQueen = 1 Then
	   GUICtrlSetState($chkBoostQueen_vip, $GUI_CHECKED)
	Else
	   GUICtrlSetState($chkBoostQueen_vip, $GUI_UNCHECKED)
	EndIf
    If $ichkBoostSpell = 1 Then
	   GUICtrlSetState($chkBoostSpell_vip, $GUI_CHECKED)
	Else
	   GUICtrlSetState($chkBoostSpell_vip, $GUI_UNCHECKED)
	EndIf
	;General Settings--------------------------------------------------------------------------
	If $frmBotPosX <> -32000 Then WinMove($sBotTitle, "", $frmBotPosX, $frmBotPosY)
	GUICtrlSetData($txtMinimumTrophy, $itxtMinTrophy)
	GUICtrlSetData($txtMaxTrophy, $itxtMaxTrophy)

	;Misc Settings--------------------------------------------------------------------------
	GUICtrlSetData($txtReconnect, $itxtReconnect)
	GUICtrlSetData($txtReturnh, $itxtReturnh)
	GUICtrlSetData($txtKingSkill, $itxtKingSkill)
	GUICtrlSetData($txtQueenSkill, $itxtQueenSkill)
	GUICtrlSetData($txtSpellDarkStorage_vip, $itxtSpellDarkStorage)
	GUICtrlSetData($txtSearchsp, $itxtSearchsp)
	GUICtrlSetData($txtwhitecloud, $itxtwhitecloud)
	If $ichkTrap = 1 Then
		GUICtrlSetState($chkTrap, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkTrap, $GUI_UNCHECKED)
	EndIf

	If $ichkCollect = 1 Then
		GUICtrlSetState($chkCollect, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkCollect, $GUI_UNCHECKED)
	EndIf

	If $ichkRaxRestart = 1 Then
		GUICtrlSetState($chkRaxRestart, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkRaxRestart, $GUI_UNCHECKED)
	EndIf

	If $SpellDarkStorage = 1 Then
		GUICtrlSetState($chkSpellDarkStorage_vip, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkSpellDarkStorage_vip, $GUI_UNCHECKED)
	EndIf

	If $ichkMultiLight = 1 Then
		GUICtrlSetState($chkMultiLight_vip, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkMultiLight_vip, $GUI_UNCHECKED)
	EndIf
	chkSpellDarkStorage()

	If $ichkBackground = 1 Then
		GUICtrlSetState($chkBackground, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkBackground, $GUI_UNCHECKED)
	EndIf
	chkBackground() ;Applies it to hidden button

	If $ichkBotStop = 1 Then
		GUICtrlSetState($chkBotStop, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkBotStop, $GUI_UNCHECKED)
	EndIf
	_GUICtrlComboBox_SetCurSel($cmbBotCommand, $icmbBotCommand)
	_GUICtrlComboBox_SetCurSel($cmbBotCond, $icmbBotCond)

	If $ichkForceBS = 1 Then
		GUICtrlSetState($chkForceBS, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkForceBS, $GUI_UNCHECKED)
	EndIf

	If $ichkNoAttack = 1 Then
		GUICtrlSetState($chkNoAttack, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkNoAttack, $GUI_UNCHECKED)
	EndIf

	If $ichkDonateOnly = 1 Then
		GUICtrlSetState($chkDonateOnly, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkDonateOnly, $GUI_UNCHECKED)
	EndIf

	;Misc
	Switch $iSkillActivateCond
	    Case 0
			GUICtrlSetState($UseSkillAuto, $GUI_UNCHECKED)
			GUICtrlSetState($UseSkillTimed, $GUI_CHECKED)
		Case 1
			GUICtrlSetState($UseSkillAuto, $GUI_CHECKED)
			GUICtrlSetState($UseSkillTimed, $GUI_UNCHECKED)
	EndSwitch

	If $ichkKeepLogs = 1 Then
		GUICtrlSetState($chkKeepLogs, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkKeepLogs, $GUI_UNCHECKED)
	EndIf
	GUICtrlSetData($txtKeepLogs, $itxtKeepLogs)
	chkKeepLogs()

	;Push Bullet
    If $PushBulletEnabled = 1 Then
	   GUICtrlSetState($chkPushBulletEnabled_vip, $GUI_CHECKED)
	Else
	   GUICtrlSetState($chkPushBulletEnabled_vip, $GUI_UNCHECKED)
    EndIf

	GUICtrlSetData($txtPushBulletTokenValue_vip, $PushBullettoken)

    If $PushBulletvillagereport = 1 Then
	   GUICtrlSetState($chkPushVillageReport_vip, $GUI_CHECKED)
	Else
	   GUICtrlSetState($chkPushVillageReport_vip, $GUI_UNCHECKED)
    EndIf

    If $PushBulletmatchfound = 1 Then
	   GUICtrlSetState($chkPushMatchFound_vip, $GUI_CHECKED)
	Else
	   GUICtrlSetState($chkPushMatchFound_vip, $GUI_UNCHECKED)
    EndIf

	If $PushBulletlastraid = 1 Then
	   GUICtrlSetState($chkPushLastRaid_vip, $GUI_CHECKED)
	Else
	   GUICtrlSetState($chkPushLastRaid_vip, $GUI_UNCHECKED)
    EndIf

	If $PushBullettotalraid = 1 Then
	   GUICtrlSetState($chkPushTotalRaid_vip, $GUI_CHECKED)
	Else
	   GUICtrlSetState($chkPushTotalRaid_vip, $GUI_UNCHECKED)
    EndIf

	If $PushBulletdebug = 1 Then
	   GUICtrlSetState($chkPushBulletDebug_vip, $GUI_CHECKED)
	Else
	   GUICtrlSetState($chkPushBulletDebug_vip, $GUI_UNCHECKED)
    EndIf

	If $PushBulletremote = 1 Then
	   GUICtrlSetState($chkPushBulletRemote_vip, $GUI_CHECKED)
	Else
	   GUICtrlSetState($chkPushBulletRemote_vip, $GUI_UNCHECKED)
    EndIf

    If $PushBulletdelete = 1 Then
	   GUICtrlSetState($chkPushBulletDelete_vip, $GUI_CHECKED)
	Else
	   GUICtrlSetState($chkPushBulletDelete_vip, $GUI_UNCHECKED)
    EndIf

	If $PushBulletbuilder = 1 Then
	   GUICtrlSetState($chkPushFreeBuilder_vip, $GUI_CHECKED)
	Else
	   GUICtrlSetState($chkPushFreeBuilder_vip, $GUI_UNCHECKED)
    EndIf

    If $PushBulleterror = 1 Then
	   GUICtrlSetState($chkPushError_vip, $GUI_CHECKED)
	Else
	   GUICtrlSetState($chkPushError_vip, $GUI_UNCHECKED)
	EndIf

   Switch $PushBullettype
		Case 0
			GUICtrlSetState($UsePushJPG_vip, $GUI_CHECKED)
		Case 1
			GUICtrlSetState($UsePushText_vip, $GUI_CHECKED)
    EndSwitch

	GUICtrlSetData($txtPushBulletInterval_vip, $PushBulletinterval)
	GUICtrlSetData($txtPushBulletMessages_vip, $PushBulletmessages)
	GUICtrlSetData($cmbPushDevice_vip, $PushBulletDevice)
EndFunc   ;==>applyConfig
