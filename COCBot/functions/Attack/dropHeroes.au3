Global $KingTimer, $QueenTimer

;Will drop heroes in a specific coordinates, only if slot is not -1
;Only drops when option is clicked.
Func dropHeroes($x, $y, $KingSlot = -1, $QueenSlot = -1) ;Drops for king and queen
	While 1
		If _Sleep(2000, False) Then ExitLoop

		Local $useKing = ($searchDead) ? $checkDeadUseKing : $checkUseKing
		Local $useQueen = ($searchDead) ? $checkDeadUseQueen : $checkUseQueen

		If $KingSlot <> -1 And $useKing = 1 Then
			SetLog("Dropping King", $COLOR_BLUE)
			Click(68 + (72 * $KingSlot), 595) ;Select King
			If _Sleep(500, False) Then Return
			Click($x, $y)
			$KingTimer = TimerInit()
			AdlibRegister("UseKingSkill")
		EndIf

		If _Sleep(1000, False) Then ExitLoop

		If $QueenSlot <> -1 And $useQueen = 1 Then
			SetLog("Dropping Queen", $COLOR_BLUE)
			Click(68 + (72 * $QueenSlot), 595) ;Select Queen
			If _Sleep(500, False) Then Return
			Click($x, $y)
			$QueenTimer = TimerInit()
			AdlibRegister("UseQueenSkill")
		EndIf

		ExitLoop
	WEnd
EndFunc   ;==>dropHeroes


; function used to check for king skill in background and activate it as necessary
Func UseKingSkill()
	If $iSkillActivateCond = 0 Then ; Activate by time
		If TimerDiff($KingTimer) > $itxtKingSkill * 1000 Then
			SetLog("Activate King's power", $COLOR_BLUE)
			SelectDropTroupe($King)
			AdlibUnRegister("UseKingSkill")
		EndIf
	Else ; Activate by hero health
		Local $PositionKing = 47 + (72 * $King)
		Local $Pos = _PixelSearch($PositionKing, 555, $PositionKing + 20, 555, Hex(0xDD8208, 6), 5)
		If $Pos <> 0 Then
			SetLog("Activate King's power", $COLOR_BLUE)
			SelectDropTroupe($King)
			AdlibUnRegister("UseKingSkill")
		ElseIf TimerDiff($KingTimer) > 60000 Then
			; If still in battle activate skill after 60s regardless
			If getGold(51, 66) <> "" Then
				SetLog("Activate King's power", $COLOR_BLUE)
				SelectDropTroupe($King)
			EndIf
			AdlibUnRegister("UseKingSkill")
		EndIf
	EndIf
EndFunc   ;==>UseKingSkill

; function used to check for queen skill in background and activate it as necessary
Func UseQueenSkill()
	If $iSkillActivateCond = 0 Then ; Activate by time
		If TimerDiff($QueenTimer) > $itxtQueenSkill * 1000 Then
			SetLog("Activate Queen's power", $COLOR_BLUE)
			SelectDropTroupe($Queen)
			AdlibUnRegister("UseQueenSkill")
		EndIf
	Else ; Activate by hero health
		Local $PositionQueen = 47 + (72 * $Queen)
		Local $Pos = _PixelSearch($PositionQueen, 555, $PositionQueen + 20, 555, Hex(0xDD8208, 6), 5)
		If $Pos <> 0 Then
			SetLog("Activate Queen's power", $COLOR_BLUE)
			SelectDropTroupe($Queen)
			AdlibUnRegister("UseQueenSkill")
		ElseIf TimerDiff($QueenTimer) > 60000 Then
			; If still in battle activate skill after 60s regardless
			If getGold(51, 66) <> "" Then
				SetLog("Activate Queen's power", $COLOR_BLUE)
				SelectDropTroupe($Queen)
			EndIf
			AdlibUnRegister("UseQueenSkill")
		EndIf
	EndIf
EndFunc   ;==>UseQueenSkill
