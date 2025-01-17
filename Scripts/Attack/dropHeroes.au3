Global $KingTimer, $QueenTimer

;Will drop heroes in a specific coordinates, only if slot is not -1
;Only drops when option is clicked.
Func dropHeroes($x, $y, $KingSlot = -1, $QueenSlot = -1, $CenterLoc = 1) ;Drops for king and queen
	While 1
		If _Sleep(2000) Then ExitLoop

		Local $useKing = ($searchDead) ? $checkDeadUseKing : $checkUseKing
		Local $useQueen = ($searchDead) ? $checkDeadUseQueen : $checkUseQueen

		If $KingSlot <> -1 And $useKing = 1 Then
			SetLog("Dropping King", $COLOR_BLUE)
			Click(68 + (72 * $KingSlot), 595) ;Select King
			If _Sleep(500) Then Return
			Click($x, $y, 1, 0, $CenterLoc)
			$KingTimer = TimerInit()
			AdlibRegister("UseKingSkill",1000)
		EndIf

		If _Sleep(1000) Then ExitLoop

		If $QueenSlot <> -1 And $useQueen = 1 Then
			SetLog("Dropping Queen", $COLOR_BLUE)
			Click(68 + (72 * $QueenSlot), 595) ;Select Queen
			If _Sleep(500) Then Return
			Click($x, $y, 1, 0, $CenterLoc)
			$QueenTimer = TimerInit()
			AdlibRegister("UseQueenSkill",1000)
		EndIf

		ExitLoop
	WEnd
EndFunc   ;==>dropHeroes


; function used to check for king skill in background and activate it as necessary
Func UseKingSkill()
	If $iSkillActivateCond = 1 Then ; Activate by hero health
		_CaptureRegion(0, 553, 660, 557)
		If _Sleep(100) Then ExitLoop
		If _ColorCheck(_GetPixelColor(68 + (72 * $King), 555 - 553), Hex(0x00B4A0, 6), 10, "Red") Then
			If _Sleep(100) Then ExitLoop
			If getGold(51, 66) <> "" Then
				SetLog("Activate King's power", $COLOR_BLUE)
				If _Sleep(100) Then ExitLoop
				SelectDropTroupe($King)
			EndIf
			AdlibUnRegister("UseKingSkill")
		EndIf
	Else ; Activate by time
		If TimerDiff($KingTimer) > $itxtKingSkill * 1000 Then
			SetLog("Activate King's power", $COLOR_BLUE)
			SelectDropTroupe($King)
			AdlibUnRegister("UseKingSkill")
		EndIf
	EndIf
EndFunc   ;==>UseKingSkill

; function used to check for queen skill in background and activate it as necessary
Func UseQueenSkill()
	If $iSkillActivateCond = 1 Then ; Activate by hero health
		_CaptureRegion(0, 553, 660, 557)
	 	If _Sleep(100) Then ExitLoop
	 	If _ColorCheck(_GetPixelColor(68 + (72 * $Queen), 555 - 553), Hex(0x007E1E, 6), 10, "Red") Then
			If _Sleep(100) Then ExitLoop
			If getGold(51, 66) <> "" Then
				SetLog("Activate Queen's power", $COLOR_BLUE)
				If _Sleep(100) Then ExitLoop
				SelectDropTroupe($Queen)
			EndIf
			AdlibUnRegister("UseQueenSkill")
		EndIf
	Else ; Activate by time
		If TimerDiff($QueenTimer) > $itxtQueenSkill * 1000 Then
			SetLog("Activate Queen's power", $COLOR_BLUE)
			SelectDropTroupe($Queen)
			AdlibUnRegister("UseQueenSkill")
		EndIf
	EndIf
EndFunc   ;==>UseQueenSkill

Func IsSkillAutoActivate()
	Return ($iSkillActivateCond = 1)
EndFunc
