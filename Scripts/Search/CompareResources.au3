;Compares the searched values to the minimum values, returns false if doesn't meet.
;Every 20 searches, it will decrease minimum by certain amounts.

Func CompareResources() ;Compares resources and returns true if conditions meet, otherwise returns false
	If Mod($SearchCount, 20) = 0 Then _WinAPI_EmptyWorkingSet(WinGetProcess($Title)) ; Reduce BlueStacks Memory Usage
	If $SearchCount <> 0 And Mod($SearchCount, $itxtRedSearchDead) = 0 And $ichkredDead = 1 Then
		If $MinDeadGold - $itxtGoldRedDead >= 0 Then $MinDeadGold -= $itxtGoldRedDead
		If $MinDeadElixir - $itxtElixRedDead >= 0 Then $MinDeadElixir -= $itxtElixRedDead
		If $MinDeadDark - $itxtDERedDead >= 0 Then $MinDeadDark -= $itxtDERedDead
		If $MinDeadTrophy - $itxtTroRedDead >= 0 Then $MinDeadTrophy -= $itxtTroRedDead
		If $AtkDeadEnabled Then SetLog("~Dead - " & _
				((GUICtrlRead($chkDeadGE) = $GUI_CHECKED) ? "Gold: " & $MinDeadGold & "; Elixir: " & $MinDeadElixir & "; " : "") & _
				((GUICtrlRead($chkDeadMeetDE) = $GUI_CHECKED) ? "Dark: " & $MinDeadDark & "; " : "" ) & _
				((GUICtrlRead($chkDeadMeetTrophy) = $GUI_CHECKED) ? "Trophy: " & $MinDeadTrophy & "; " : "" ) & _
				((GUICtrlRead($chkDeadMeetTH) = $GUI_CHECKED) ? "Townhall: " & $MaxDeadTH & "; " : "" ) & _
				((GUICtrlRead($chkDeadMeetTHO) = $GUI_CHECKED) ? "TH Outside" : "") , $COLOR_GREEN)
	EndIf

	If $SearchCount <> 0 And Mod($SearchCount, $itxtRedSearchAny) = 0 And $ichkredAny = 1 Then
		If $MinGold - $itxtGoldRedAny >= 0 Then $MinGold -= $itxtGoldRedAny
		If $MinElixir - $itxtElixRedAny >= 0 Then $MinElixir -= $itxtElixRedAny
		If $MinDark - $itxtDERedAny >= 0 Then $MinDark -= $itxtDERedAny
		If $MinTrophy - $itxtTroRedAny >= 0 Then $MinTrophy -= $itxtTroRedAny
		If $AtkAnyEnabled Then SetLog("~Any  - " & _
				((GUICtrlRead($chkMeetGE) = $GUI_CHECKED) ? "Gold: " & $MinGold & "; Elixir: " & $MinElixir & "; " : "") & _
				((GUICtrlRead($chkMeetDE) = $GUI_CHECKED) ? "Dark: " & $MinDark & "; " : "" ) & _
				((GUICtrlRead($chkMeetTrophy) = $GUI_CHECKED) ? "Trophy: " & $MinTrophy & "; " : "" ) & _
				((GUICtrlRead($chkMeetTH) = $GUI_CHECKED) ? "Townhall: " & $MaxTH & "; " : "" ) & _
				((GUICtrlRead($chkMeetTHO) = $GUI_CHECKED) ? "TH Outside" : "") , $COLOR_GREEN)
	EndIf

	Local $DG = (Number($searchGold) >= Number($MinDeadGold)), $DE = (Number($searchElixir) >= Number($MinDeadElixir)), $DD = (Number($searchDark) >= Number($MinDeadDark)), $DT = (Number($searchTrophy) >= Number($MinDeadTrophy))
	Local $G = (Number($searchGold) >= Number($MinGold)), $E = (Number($searchElixir) >= Number($MinElixir)), $D = (Number($searchDark) >= Number($MinDark)), $T = (Number($searchTrophy) >= Number($MinTrophy))
	Local $THL = -1, $THLO = -1

	For $i = 0 To 4
		If $searchTH = $THText[$i] Then $THL = $i
	Next

	Switch $THLoc
		Case "In"
			$THLO = 0
		Case "Out"
			$THLO = 1
	EndSwitch

	If $THLoc = "Out" And ($icmbAttackTH > 0 Or ($searchDead And $icmbDeadAttackTH > 0)) And $LoginType = 2 Then
		SetLog("~~~~~~~Outside Townhall Found!~~~~~~~", $COLOR_PURPLE)
		Return True
	EndIf

	; Variable to check whether to attack a dead base
	Local $conditionPass = True

	; check conditions for a dead base
	If $searchDead And $AtkDeadEnabled Then
		If GUICtrlRead($chkDeadGE) = $GUI_CHECKED Then
			If $icmbDead = 0 Then ; And
				If $DG = False Or $DE = False Then $conditionPass = False
			Else ; Or
				If $DG = False And $DE = False Then $conditionPass = False
			EndIf
		EndIf

		If GUICtrlRead($chkDeadMeetDE) = $GUI_CHECKED Then
			If $DD = False Then $conditionPass = False
		EndIf

		If GUICtrlRead($chkDeadMeetTrophy) = $GUI_CHECKED Then
			If $DT = False Then $conditionPass = False
		EndIf

		If GUICtrlRead($chkDeadMeetTH) = $GUI_CHECKED Then
			If $THL = -1 Or $THL > _GUICtrlComboBox_GetCurSel($cmbDeadTH) Then $conditionPass = False
		EndIf

		If GUICtrlRead($chkDeadMeetTHO) = $GUI_CHECKED Then
			If $THLO <> 1 Then $conditionPass = False
		EndIf

		If $conditionPass Then
			SetLog("~~~~~~~Dead Base Found!~~~~~~~", $COLOR_GREEN)
			Return True
		EndIf
	EndIf

	; check conditions for any base
	If $AtkAnyEnabled Then
		If GUICtrlRead($chkMeetGE) = $GUI_CHECKED Then
			If $icmbAny = 0 Then ; And
				If $G = False Or $E = False Then Return False
			Else ; Or
				If $G = False And $E = False Then Return False
			EndIf
		EndIf

		If GUICtrlRead($chkMeetDE) = $GUI_CHECKED Then
			If $D = False Then Return False
		EndIf

		If GUICtrlRead($chkMeetTrophy) = $GUI_CHECKED Then
			If $T = False Then Return False
		EndIf

		If GUICtrlRead($chkMeetTH) = $GUI_CHECKED Then
			If $THL = -1 Or $THL > _GUICtrlComboBox_GetCurSel($cmbTH) Then Return False
		EndIf

		If GUICtrlRead($chkMeetTHO) = $GUI_CHECKED Then
			If $THLO <> 1 Then Return False
		EndIf

		Return True
	EndIf

	Return False
EndFunc   ;==>CompareResources
