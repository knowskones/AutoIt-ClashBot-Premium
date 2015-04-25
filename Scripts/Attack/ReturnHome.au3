;Returns home when in battle, will take screenshot and check for gold/elixir change unless specified not to.

Func ReturnHome($TakeSS = 1, $GoldChangeCheck = True) ;Return main screen
	If $GoldChangeCheck = True Then
		If _Sleep(15000) Then Return
		While GoldElixirChange()
			If _Sleep(1000) Then Return
		WEnd
	EndIf

	AdlibUnRegister("UseKingSkill")
	AdlibUnRegister("UseQueenSkill")
	SetLog("Returning Home", $COLOR_BLUE)
	If $RunState = False Then Return
	Click(62, 519) ;Click Surrender
	If _Sleep(500) Then Return
	Click(512, 394) ;Click Confirm
	If _Sleep(750) Then Return

	; Capture region for both TakeSS and Last Raid Resources
   If $GoldChangeCheck = True Then
	  If _Sleep(2000) Then Return
	  _CaptureRegion()
   EndIf

	If $TakeSS = 1 Then
		SetLog("Taking snapshot of your loot", $COLOR_ORANGE)
		Local $Date = @MDAY & "." & @MON & "." & @YEAR
		Local $Time = @HOUR & "." & @MIN
		$Raid = 1
		_GDIPlus_ImageSaveToFile($hBitmap, $dirLoots & $Date & "_at_" & $Time & ".jpg")
		$FileName = $Date & "_at_" & $Time & ".jpg"
	EndIf

	;Get Stars
    $Stars = 0
    _CaptureRegion()
	if _ColorCheck(_GetPixelColor(311, 193), Hex(0xCFD0CA, 6), 20) Then
		$Stars += 1
	EndIf
	if _ColorCheck(_GetPixelColor(401, 172), Hex(0xD0D2CC, 6), 20) Then
		$Stars += 1
	EndIf
	if _ColorCheck(_GetPixelColor(518, 194), Hex(0xD0D0CC, 6), 20) Then
		$Stars += 1
	EndIf

   ;Get Last Raid Resources
   If $GoldChangeCheck = True Then
		$LastRaidGold = getOther(330, 289, "LastRaidGold")
		$LastRaidElixir = getOther(330, 328, "LastRaidElixir")
		Local $trophyicon = _PixelSearch(457, 403, 467, 418, Hex(0xE8C528, 6), 5) ;Finds Trophy icon in the bottom, if it finds it then Dark Elixir is available
		If IsArray($trophyicon) = True Then
			$LastRaidDarkElixir = getOther(330, 365, "LastRaidDarkElixir")
			$LastRaidTrophy = getOther(330, 402, "LastRaidTrophy")
			SetLog("Last Raid Loot: [G]: " & $LastRaidGold & " [E]: " & $LastRaidElixir & " [D]: " & $LastRaidDarkElixir & " [T]: " & $LastRaidTrophy, $COLOR_GREEN)
		Else
			$LastRaidTrophy = getOther(330, 365, "LastRaidTrophy")
			SetLog("Last Raid Loot: [G]: " & $LastRaidGold & " [E]: " & $LastRaidElixir & " [T]: " & $LastRaidTrophy, $COLOR_GREEN)
		EndIf
   EndIf

	If _Sleep(2000) Then Return
	Click(428, 544) ;Click Return Home Button

	Local $counter = 0
	While 1
		If _Sleep(2000) Then Return
		_CaptureRegion()
		If _ColorCheck(_GetPixelColor(284, 28), Hex(0x41B1CD, 6), 20) Then
			If $GoldChangeCheck = True Then _GUICtrlEdit_SetText($txtLog, "")
			Return
		EndIf

		$counter += 1

		If $counter >= 50 Then
			SetLog("Cannot return home.", $COLOR_RED)
			checkMainScreen()
			Return
		EndIf
	WEnd
EndFunc   ;==>ReturnHome
