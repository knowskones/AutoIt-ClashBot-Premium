;Searches for a village that until meets conditions
Global $AtkDeadEnabled, $AtkAnyEnabled

Func VillageSearch() ;Control for searching a village that meets conditions
	Local $skippedVillages
	_WinAPI_EmptyWorkingSet(WinGetProcess($Title)) ; Reduce BlueStacks Memory Usage

	$AtkDeadEnabled = False
	$AtkAnyEnabled = False

	If GUICtrlRead($chkDeadGE) = $GUI_CHECKED Or GUICtrlRead($chkDeadMeetDE) = $GUI_CHECKED Or GUICtrlRead($chkDeadMeetTrophy) = $GUI_CHECKED Or GUICtrlRead($chkDeadMeetTH) = $GUI_CHECKED Or GUICtrlRead($chkDeadMeetTHO) = $GUI_CHECKED Then $AtkDeadEnabled = True
	If GUICtrlRead($chkMeetGE) = $GUI_CHECKED Or GUICtrlRead($chkMeetDE) = $GUI_CHECKED Or GUICtrlRead($chkMeetTrophy) = $GUI_CHECKED Or GUICtrlRead($chkMeetTH) = $GUI_CHECKED Or GUICtrlRead($chkMeetTHO) = $GUI_CHECKED Then $AtkAnyEnabled = True

	If Not $AtkDeadEnabled And Not $AtkAnyEnabled Then
		SetLog("~~~No search conditions enabled, deactivating attack mode~~~", $COLOR_RED)
		GUICtrlSetState($chkNoAttack, $GUI_CHECKED)
		chkNoAttack()
		Return
	EndIf

	While 1
		If $AtkDeadEnabled Then SetLog("~Dead - " & _
				((GUICtrlRead($chkDeadGE) = $GUI_CHECKED) ? "Gold: " & $MinDeadGold & "; Elixir: " & $MinDeadElixir & "; " : "") & _
				((GUICtrlRead($chkDeadMeetDE) = $GUI_CHECKED) ? "Dark: " & $MinDeadDark & "; " : "") & _
				((GUICtrlRead($chkDeadMeetTrophy) = $GUI_CHECKED) ? "Trophy: " & $MinDeadTrophy & "; " : "") & _
				((GUICtrlRead($chkDeadMeetTH) = $GUI_CHECKED) ? "Townhall: " & $MaxDeadTH & "; " : "") & _
				((GUICtrlRead($chkDeadMeetTHO) = $GUI_CHECKED) ? "TH Outside" : ""), $COLOR_GREEN)
		If $AtkAnyEnabled Then SetLog("~Any  - " & _
				((GUICtrlRead($chkMeetGE) = $GUI_CHECKED) ? "Gold: " & $MinGold & "; Elixir: " & $MinElixir & "; " : "") & _
				((GUICtrlRead($chkMeetDE) = $GUI_CHECKED) ? "Dark: " & $MinDark & "; " : "") & _
				((GUICtrlRead($chkMeetTrophy) = $GUI_CHECKED) ? "Trophy: " & $MinTrophy & "; " : "") & _
				((GUICtrlRead($chkMeetTH) = $GUI_CHECKED) ? "Townhall: " & $MaxTH & "; " : "") & _
				((GUICtrlRead($chkMeetTHO) = $GUI_CHECKED) ? "TH Outside" : ""), $COLOR_GREEN)
		If $TakeAllTownSnapShot = 1 Then SetLog("Will save all of the towns when searching", $COLOR_GREEN)
		$SearchCount = 0
		_BlockInputEx(3, "", "", $HWnD)
		GUICtrlSetData($lblresultsearchcost, GUICtrlRead($lblresultsearchcost) + $SearchCost)
		While 1
			If _Sleep(1000) Then ExitLoop (2)
			GUICtrlSetState($btnAtkNow, $GUI_ENABLE)
			GetResources() ;Reads Resource Values

			If $Restart = True Then ExitLoop (2)

			If $TakeAllTownSnapShot = 1 Then
				Local $Date = @MDAY & "." & @MON & "." & @YEAR
				Local $Time = @HOUR & "." & @MIN & "." & @SEC
				_CaptureRegion()
				_GDIPlus_ImageSaveToFile($hBitmap, @ScriptDir & "\AllTowns\" & $Date & " at " & $Time & ".png")
			EndIf

			; read setting directly to allow speed change while searching to use attack now
			If _Sleep($itxtSearchsp * 1000) Then ExitLoop (2)

			; Attack instantly if Attack Now button pressed
			GUICtrlSetState($btnAtkNow, $GUI_DISABLE)
			If $AttackNow Then
				$AttackNow = False
				SetLog("~~~~~~~Attack Now Clicked!~~~~~~~", $COLOR_GREEN)
				ExitLoop
			EndIf

			If CompareResources() Then
				ExitLoop
			Else
				Click(750, 500) ;Click Next
				GUICtrlSetData($lblresultvillagesskipped, GUICtrlRead($lblresultvillagesskipped) + 1)
				GUICtrlSetData($lblresultsearchcost, GUICtrlRead($lblresultsearchcost) + $SearchCost)
			EndIf
		WEnd

		GUICtrlSetData($lblresultsearchcost, GUICtrlRead($lblresultsearchcost) + $SearchCost)
		If GUICtrlRead($chkAlertSearch) = $GUI_CHECKED Then
			TrayTip("Match Found!", "Gold: " & $searchGold & "; Elixir: " & $searchElixir & "; Dark: " & $searchDark & "; Trophy: " & $searchTrophy & "; Townhall: " & $searchTH & ", " & $THLoc, 0)
			If GUICtrlRead($chkPushBulletEnabled) = $GUI_CHECKED And GUICtrlRead($chkPushMatchFound) = $GUI_CHECKED Then
				_Push("Match Found!", "[G]: " & _NumberFormat($searchGold) & "; [E]: " & _NumberFormat($searchElixir) & "; [D]: " & _NumberFormat($searchDark) & "; [T]: " & $searchTrophy & "; [TH Lvl]: " & $searchTH & ", Loc: " & $THLoc)
				SetLog("Push: Match Found", $COLOR_GREEN)
			EndIf
			If FileExists(@WindowsDir & "\media\Windows Exclamation.wav") Then
				SoundPlay(@WindowsDir & "\media\Windows Exclamation.wav", 1)
			Else
				SoundPlay(@WindowsDir & "\media\Festival\Windows Exclamation.wav", 1)
			EndIf
		EndIf
		SetLog("===============Searching Complete===============", $COLOR_BLUE)
		readConfig()
		_BlockInputEx(0, "", "", $HWnD)
		ExitLoop
	WEnd
EndFunc   ;==>VillageSearch
