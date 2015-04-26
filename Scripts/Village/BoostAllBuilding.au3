;==>BoostBarracks
Func BoostAllBuilding()
	If (GUICtrlRead($cmbBoostBarracks_vip) > 0) And ($boostsEnabled = 1) Then

		If $barrackPos[0][0] < 1 Then
			LocateBarrack()
			SaveConfig()
			If _Sleep(2000) Then Return
		EndIf

		If _Sleep(500) Then Return
		ClickP($TopLeftClient) ;Click Away
		If _Sleep(500) Then Return

		If $ichkBoostRax1 + $ichkBoostRax2 + $ichkBoostRax3 + $ichkBoostRax4 = 4 Then
			SetLog("Boosting All Barrack...", $COLOR_BLUE)
			Click($barrackPos[0][0], $barrackPos[0][1]) ;Click Barrack 1
			If _Sleep(500) Then Return
			BoostAllBarrack()
		Else
			If $ichkBoostRax1 = 1 Then; Barrack 1
				SetLog("Boosting Barrack 1...", $COLOR_BLUE)
				Click($barrackPos[0][0], $barrackPos[0][1]) ;Click Barrack 1
				If _Sleep(500) Then Return
				BoostBuilding()
			EndIf

			If $ichkBoostRax2 = 1 Then; Barrack 2
				SetLog("Boosting Barrack 2...", $COLOR_BLUE)
				Click($barrackPos[1][0], $barrackPos[1][1]) ;Click Barrack 2
				If _Sleep(500) Then Return
				BoostBuilding()
			EndIf

			If $ichkBoostRax3 = 1 Then; Barrack 3
				SetLog("Boosting Barrack 3...", $COLOR_BLUE)
				Click($barrackPos[2][0], $barrackPos[2][1]) ;Click Barrack 3
				If _Sleep(500) Then Return
				BoostBuilding()
			EndIf

			If $ichkBoostRax4 = 1 Then; Barrack 4
				SetLog("Boosting Barrack 4...", $COLOR_BLUE)
				Click($barrackPos[3][0], $barrackPos[3][1]) ;Click Barrack 4
				If _Sleep(500) Then Return
				BoostBuilding()
			EndIf
		EndIf

		If $ichkBoostDark1 + $ichkBoostDark2 = 2 Then
			SetLog("Boosting All Dark Barrack...", $COLOR_BLUE)
			Click($DarkBarrackPos[0][0], $DarkBarrackPos[0][1]) ;Click Dark Barrack 1
			If _Sleep(500) Then Return
			BoostDkBarrack()
		Else
			If $ichkBoostDark1 = 1 Then; Dark Barrack 1
				If $DarkBarrackPos[0][0] < 1 Then
					SetLog("Dark Barrack 1 not located, skip boosting...", $COLOR_RED)
					$BoostAll += 1 ; Must add to avoid boosting error
				Else
					SetLog("Boosting Dark Barrack 1...", $COLOR_BLUE)
					Click($DarkBarrackPos[0][0], $DarkBarrackPos[0][1]) ;Click Dark Barrack 1
					If _Sleep(500) Then Return
					BoostBuilding()
				EndIf
			EndIf

			If $ichkBoostDark2 = 1 Then; Dark Barrack 2
				If $DarkBarrackPos[1][0] < 1 Then
					SetLog("Dark Barrack 2 not located, skip boosting...", $COLOR_RED)
					$BoostAll += 1 ; Must add to avoid boosting error
				Else
					SetLog("Boosting Dark Barrack 2...", $COLOR_BLUE)
					Click($DarkBarrackPos[1][0], $DarkBarrackPos[1][1]) ;Click Dark Barrack 2
					If _Sleep(500) Then Return
					BoostBuilding()
				EndIf
			EndIf
		EndIf

		If $ichkBoostKing = 1 Then; King Altar
			If $KingPos[0] = "" Then
				LocateKingAltar()
				SaveConfig()
				If _Sleep(2000) Then Return
				ClickP($TopLeftClient) ;Click Away
			EndIf
			SetLog("Boosting King Altar...", $COLOR_BLUE)
			Click($KingPos[0], $KingPos[1]) ;Click King Altar
			If _Sleep(500) Then Return
			BoostBuilding()
		EndIf

		If $ichkBoostQueen = 1 Then; Queen Altar
			If $QueenPos[0] = "" Then
				LocateQueenAltar()
				SaveConfig()
				If _Sleep(2000) Then Return
				ClickP($TopLeftClient) ;Click Away
			EndIf
			SetLog("Boosting Queen Altar...", $COLOR_BLUE)
			Click($QueenPos[0], $QueenPos[1]) ;Click Queen Altar
			If _Sleep(500) Then Return
			BoostBuilding()
		EndIf

		If $ichkBoostSpell = 1 Then; Spell Factory
			If $SFactoryPos[0] = "" Then
				LocateSFactory()
				SaveConfig()
				If _Sleep(2000) Then Return
				ClickP($TopLeftClient) ;Click Away
			EndIf
			SetLog("Boosting Spell Factory...", $COLOR_BLUE)
			Click($SFactoryPos[0], $SFactoryPos[1]) ;Click Spell Factory
			If _Sleep(500) Then Return
			BoostBuilding()
		EndIf

		If $BoostAll >= $ichkBoostRax1 + $ichkBoostRax2 + $ichkBoostRax3 + $ichkBoostRax4 + $ichkBoostKing + $ichkBoostQueen + $ichkBoostSpell + $ichkBoostDark1 + $ichkBoostDark2 Then
			_GUICtrlComboBox_SetCurSel($cmbBoostBarracks_vip, (GUICtrlRead($cmbBoostBarracks_vip) - 1))
			SetLog("Boost remaining : " & GUICtrlRead($cmbBoostBarracks_vip), $COLOR_GREEN)
			$BoostAll = 0
		EndIf
	EndIf
EndFunc   ;==>BoostAllBuilding

Func BoostBuilding()
	Local $Boost = _PixelSearch(295, 580, 406, 620, Hex(0xF8F66D, 6), 5) ;Check Boost
	If IsArray($Boost) Then
		Click($Boost[0], $Boost[1]) ;Click Boost
		If _WaitForPixel(420, 375, Hex(0xd2ec78, 6), 20) Then ;Confirm Message
			Click(420, 375)
			If _WaitForPixel(586, 267, Hex(0xd80405, 6), 20, 2000, 500) Then ;Not enough Gem
				_GUICtrlComboBox_SetCurSel($cmbBoostBarracks_vip, 0)
				SetLog("Not Enough GEMS...", $COLOR_RED)
			Else
				SetLog("Boost Completed...", $COLOR_GREEN)
				$BoostAll += 1
			EndIf
		Else
			SetLog("Building is already Boosted", $COLOR_ORANGE)
		EndIf
		If _Sleep(500) Then Return
		ClickP($TopLeftClient) ;Click Away
	Else
		SetLog("Building is already Boosted", $COLOR_ORANGE)
		If _Sleep(1000) Then Return
	EndIf
EndFunc   ;==>BoostBuilding

Func BoostAllBarrack()
	Local $BoostAllFix = _PixelSearch(410, 610, 493, 615, Hex(0xfffd70, 6), 10) ;Check Boost All
	If IsArray($BoostAllFix) Then
		Click($BoostAllFix[0], $BoostAllFix[1]) ;Click Boost
		If _WaitForPixel(420, 375, Hex(0xd2ec78, 6), 20) Then ;Confirm Message
			Click(420, 375)
			If _WaitForPixel(586, 267, Hex(0xd80405, 6), 20, 2000, 500) Then ;Not enough Gem
				_GUICtrlComboBox_SetCurSel($cmbBoostBarracks_vip, 0)
				SetLog("Not Enough GEMS...", $COLOR_RED)
			Else
				SetLog("All Barrack Boost Completed...", $COLOR_GREEN)
				$BoostAll += 4
			EndIf
		Else
			SetLog("Building is already Boosted", $COLOR_ORANGE)
		EndIf
		If _Sleep(500) Then Return
		ClickP($TopLeftClient) ;Click Away
	Else
		SetLog("Building is already Boosted", $COLOR_ORANGE)
		If _Sleep(1000) Then Return
	EndIf
EndFunc   ;==>BoostAllBarrack

Func BoostDkBarrack()
	Local $BoostAllDark = _PixelSearch(410, 610, 493, 615, Hex(0xfffd70, 6), 10) ;Check Boost All
	If IsArray($BoostAllDark) Then
		Click($BoostAllDark[0], $BoostAllDark[1]) ;Click Boost
		If _WaitForPixel(420, 375, Hex(0xd2ec78, 6), 20) Then ;Confirm Message
			Click(420, 375)
			If _WaitForPixel(586, 267, Hex(0xd80405, 6), 20, 2000, 500) Then ;Not enough Gem
				_GUICtrlComboBox_SetCurSel($cmbBoostBarracks_vip, 0)
				SetLog("Not Enough GEMS...", $COLOR_RED)
			Else
				SetLog("All Dark Barrack Boost Completed...", $COLOR_GREEN)
				$BoostAll += 2
			EndIf
		Else
			SetLog("Building is already Boosted", $COLOR_ORANGE)
		EndIf
		If _Sleep(500) Then Return
		ClickP($TopLeftClient) ;Click Away
	Else
		SetLog("Building is already Boosted", $COLOR_ORANGE)
		If _Sleep(1000) Then Return
	EndIf
EndFunc   ;==>BoostDkBarrack
