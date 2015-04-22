;Donates troops

Func DonateCC($DonateChat = True)
   Global $ColDist = 1, $RowDist = 0 ; default to archer
   ;Global $BClick1 = Number(GUICtrlRead($NoOfBarbarians1)), $BClick2 = Number(GUICtrlRead($NoOfBarbarians2)), $BClick3 = Number(GUICtrlRead($NoOfBarbarians3))
   Global $AClick1 = Number(GUICtrlRead($NoOfArchers1)), $AClick2 = Number(GUICtrlRead($NoOfArchers2)), $AClick3 = Number(GUICtrlRead($NoOfArchers3))
   Global $GClick1 = Number(GUICtrlRead($NoOfGiants1)), $GClick2 = Number(GUICtrlRead($NoOfGiants2)), $GClick3 = Number(GUICtrlRead($NoOfGiants3))

	Global $Donate = $ichkDonateBarbarians = 1 Or $ichkDonateArchers = 1 Or $ichkDonateGiants = 1 Or $ichkDonateAllBarbarians = 1 Or $ichkDonateAllArchers = 1 Or $ichkDonateAllGiants = 1
	If $Donate = False Then Return
	Local $y = 119
	SetLog("Donating Troops", $COLOR_BLUE)

	_CaptureRegion()
	If $DonateChat = False Then
	  If _ColorCheck(_GetPixelColor(34, 321), Hex(0xE00300, 6), 20) = False Then
		 SetLog("No new chats, skip donating", $COLOR_ORANGE)
		 Return
	  EndIf
   EndIf

	ClickP($TopLeftClient) ;Click Away
	If _ColorCheck(_GetPixelColor(331, 330), Hex(0xF0A03B, 6), 20) = False Then Click(19, 349) ;Clicks chat thing
	If _Sleep(500) Then Return
	Click(189, 24) ; clicking clan tab

	While $Donate
		Local $offColors[3][3] = [[0x000000, 0, -2], [0x262926, 0, 1], [0xF8FCF0, 0, 11]]
		While 1
			If _Sleep(1000) Then ExitLoop
			Global $DonatePixel = _MultiPixelSearch(202, $y, 203, 670, 1, 1, Hex(0x262926, 6), $offColors, 20)
			If IsArray($DonatePixel) Then
				$Donate = False
				If ($ichkDonateAllBarbarians = 0 And $ichkDonateAllArchers = 0 And $ichkDonateAllGiants = 0) And ($ichkDonateBarbarians = 1 Or $ichkDonateArchers = 1 Or $ichkDonateGiants = 1) Then
					_CaptureRegion(0, 0, 435, $DonatePixel[1] + 50)
					Local $String = getString($DonatePixel[1] - 28)
					If $String = "" Then
						$String = getString($DonatePixel[1] - 17)
					Else
						$String = $String & @CRLF & getString($DonatePixel[1] - 17)
					EndIf

					Local $BlacklistCheck = 0
					If $ichkBlacklist = 1 Then
						Local $Blacklist = StringSplit($itxtNotDonate, @CRLF)
						For $i = 0 To UBound($Blacklist) - 1
							If CheckDonate($Blacklist[$i], $String) Then
								$BlacklistCheck = 1
								SetLog("Chat Text: " & $String, $COLOR_RED)
								SetLog("Blacklist Keyword found in Chat Text, skip donating...", $COLOR_RED)
							EndIf
						Next
					EndIf

					If $BlacklistCheck = 0 Then SetLog("Chat Text: " & $String, $COLOR_GREEN)

					If $ichkDonateBarbarians = 1 And $BlacklistCheck = 0 Then
						Local $Barbs = StringSplit($itxtDonateBarbarians, @CRLF)
						For $i = 0 To UBound($Barbs) - 1
							If CheckDonate($Barbs[$i], $String) Then
							   GetTroopCoord(GUICtrlRead($cmbDonateBarbarians1))
							   DonateTroops(GUICtrlRead($cmbDonateBarbarians1), Number(GUICtrlRead($NoOfBarbarians1)))
							   If GUICtrlRead($cmbDonateBarbarians2) = "None" Then
								  ExitLoop
							   Else
								 GetTroopCoord(GUICtrlRead($cmbDonateBarbarians2))
								 DonateTroops(GUICtrlRead($cmbDonateBarbarians2), Number(GUICtrlRead($NoOfBarbarians2)))
							   EndIf
							   If GUICtrlRead($cmbDonateBarbarians3) = "None" Then
								  ExitLoop
							   Else
								 GetTroopCoord(GUICtrlRead($cmbDonateBarbarians3))
								 DonateTroops(GUICtrlRead($cmbDonateBarbarians3), Number(GUICtrlRead($NoOfBarbarians3)))
							   EndIf
							   ExitLoop
						    EndIf
						Next
						If $Donate Then
							If _Sleep(500) Then ExitLoop
							$y = $DonatePixel[1] + 10
							ExitLoop
						EndIf
					EndIf
					If $ichkDonateArchers = 1 And $BlacklistCheck = 0 Then
						Local $Archers = StringSplit($itxtDonateArchers, @CRLF)
						For $i = 0 To UBound($Archers) - 1
							If CheckDonate($Archers[$i], $String) Then
							   GetTroopCoord(GUICtrlRead($cmbDonateArchers1))
							   DonateTroops(GUICtrlRead($cmbDonateArchers1), Number(GUICtrlRead($NoOfArchers1)))
							   If GUICtrlRead($cmbDonateArchers2) = "None" Then
								  ExitLoop
							   Else
								 GetTroopCoord(GUICtrlRead($cmbDonateArchers2))
								 DonateTroops(GUICtrlRead($cmbDonateArchers2), Number(GUICtrlRead($NoOfArchers2)))
							   EndIf
							   If GUICtrlRead($cmbDonateArchers3) = "None" Then
								  ExitLoop
							   Else
								 GetTroopCoord(GUICtrlRead($cmbDonateArchers3))
								 DonateTroops(GUICtrlRead($cmbDonateArchers3), Number(GUICtrlRead($NoOfArchers3)))
							   EndIf
							   ExitLoop
							EndIf
						Next
						If $Donate Then
							If _Sleep(500) Then ExitLoop
							$y = $DonatePixel[1] + 10
							ExitLoop
						EndIf
					EndIf
					If $ichkDonateGiants = 1 And $BlacklistCheck = 0 Then
						Local $Giants = StringSplit($itxtDonateGiants, @CRLF)
						For $i = 0 To UBound($Giants) - 1
							If CheckDonate($Giants[$i], $String) Then
							   GetTroopCoord(GUICtrlRead($cmbDonateGiants1))
							   DonateTroops(GUICtrlRead($cmbDonateGiants1), Number(GUICtrlRead($NoOfGiants1)))
							   If GUICtrlRead($cmbDonateGiants2) = "None" Then
								  ExitLoop
							   Else
								 GetTroopCoord(GUICtrlRead($cmbDonateGiants2))
								 DonateTroops(GUICtrlRead($cmbDonateGiants2), Number(GUICtrlRead($NoOfGiants2)))
							   EndIf
							   If GUICtrlRead($cmbDonateGiants3) = "None" Then
								  ExitLoop
							   Else
								 GetTroopCoord(GUICtrlRead($cmbDonateGiants3))
								 DonateTroops(GUICtrlRead($cmbDonateGiants3), Number(GUICtrlRead($NoOfGiants3)))
							   EndIf
							   ExitLoop
							EndIf
						Next
						If $Donate Then
							If _Sleep(500) Then ExitLoop
							$y = $DonatePixel[1] + 10
							ExitLoop
						EndIf
					EndIf
				Else
					_CaptureRegion(0, 0, 435, $DonatePixel[1] + 50)
					Local $String = getString($DonatePixel[1] - 28)
					If $String = "" Then
						$String = getString($DonatePixel[1] - 17)
					Else
						$String = $String & @CRLF & getString($DonatePixel[1] - 17)
					 EndIf

					Local $BlacklistCheck = 0
					If $ichkBlacklist = 1 Then
						Local $Blacklist = StringSplit($itxtNotDonate, @CRLF)
						For $i = 0 To UBound($Blacklist) - 1
							If CheckDonate($Blacklist[$i], $String) Then
								$BlacklistCheck = 1
								SetLog("Chat Text: " & $String, $COLOR_RED)
								SetLog("Blacklist Keyword found in Chat Text, skip donating...", $COLOR_RED)
							EndIf
						Next
					EndIf
					Select
						Case $ichkDonateAllBarbarians = 1 And $BlacklistCheck = 0
							   GetTroopCoord(GUICtrlRead($cmbDonateBarbarians1))
							   DonateTroops(GUICtrlRead($cmbDonateBarbarians1), Number(GUICtrlRead($NoOfBarbarians1)))
							   If GUICtrlRead($cmbDonateBarbarians2) = "None" Then
								  ExitLoop
							   Else
								 GetTroopCoord(GUICtrlRead($cmbDonateBarbarians2))
								 DonateTroops(GUICtrlRead($cmbDonateBarbarians2), Number(GUICtrlRead($NoOfBarbarians2)))
							   EndIf
							   If GUICtrlRead($cmbDonateBarbarians3) = "None" Then
								  ExitLoop
							   Else
								 GetTroopCoord(GUICtrlRead($cmbDonateBarbarians3))
								 DonateTroops(GUICtrlRead($cmbDonateBarbarians3), Number(GUICtrlRead($NoOfBarbarians3)))
							   EndIf
						Case $ichkDonateAllArchers = 1 And $BlacklistCheck = 0
							   GetTroopCoord(GUICtrlRead($cmbDonateArchers1))
							   DonateTroops(GUICtrlRead($cmbDonateArchers1), Number(GUICtrlRead($NoOfArchers1)))
							   If GUICtrlRead($cmbDonateArchers2) = "None" Then
								  ExitLoop
							   Else
								 GetTroopCoord(GUICtrlRead($cmbDonateArchers2))
								 DonateTroops(GUICtrlRead($cmbDonateArchers2), Number(GUICtrlRead($NoOfArchers2)))
							   EndIf
							   If GUICtrlRead($cmbDonateArchers3) = "None" Then
								  ExitLoop
							   Else
								 GetTroopCoord(GUICtrlRead($cmbDonateArchers3))
								 DonateTroops(GUICtrlRead($cmbDonateArchers3), Number(GUICtrlRead($NoOfArchers3)))
							   EndIf
						Case $ichkDonateAllGiants = 1 And $BlacklistCheck = 0
							   GetTroopCoord(GUICtrlRead($cmbDonateGiants1))
							   DonateTroops(GUICtrlRead($cmbDonateGiants1), Number(GUICtrlRead($NoOfGiants1)))
							   If GUICtrlRead($cmbDonateGiants2) = "None" Then
								  ExitLoop
							   Else
								 GetTroopCoord(GUICtrlRead($cmbDonateGiants2))
								 DonateTroops(GUICtrlRead($cmbDonateGiants2), Number(GUICtrlRead($NoOfGiants2)))
							   EndIf
							   If GUICtrlRead($cmbDonateGiants3) = "None" Then
								  ExitLoop
							   Else
								 GetTroopCoord(GUICtrlRead($cmbDonateGiants3))
								 DonateTroops(GUICtrlRead($cmbDonateGiants3), Number(GUICtrlRead($NoOfGiants3)))
							   EndIf
					EndSelect
				EndIf
			Else
				ExitLoop
			EndIf
			If _Sleep(500) Then Return
			ClickP($TopLeftClient) ;Click Away
			$y = $DonatePixel[1] + 10
		WEnd
		ClickP($TopLeftClient) ;Click Away
		If _Sleep(1000) Then ExitLoop
		$DonatePixel = _MultiPixelSearch(202, $y, 203, 670, 1, 1, Hex(0x262926, 6), $offColors, 20)
		Local $Scroll = _PixelSearch(285, 650, 287, 700, Hex(0x97E405, 6), 20)
		$Donate = True
		If IsArray($Scroll) Then
			Click($Scroll[0], $Scroll[1])
			$y = 119
			If _Sleep(700) Then ExitLoop
		ElseIf Not IsArray($DonatePixel) Then
			$Donate = False
		EndIf
	WEnd

	If _WaitForPixel(331, 330, Hex(0xF0A03B, 6), 20) Then
		Click(331, 330) ;Clicks chat thing
		If _Sleep(500) Then Return
	EndIf
	SetLog("Finished Donating", $COLOR_BLUE)
EndFunc   ;==>DonateCC

Func CheckDonate($String, $clanString) ;Checks if it exact
	$Contains = StringMid($String, 1, 1) & StringMid($String, StringLen($String), 1)
	If $Contains = "[]" Then
		If $clanString = StringMid($String, 2, StringLen($String) - 2) Then
			Return True
		Else
			Return False
		EndIf
	Else
		If StringInStr($clanString, $String, 2) Then
			Return True
		Else
			Return False
		EndIf
	EndIf
EndFunc   ;==>CheckDonate

Func DonateTroops($Troop, $number)
   Local $x, $y
   If $ichkDonateAllBarbarians = 1 Or $ichkDonateAllArchers= 1 Or $ichkDonateAllGiants= 1 Then
       Click($DonatePixel[0], $DonatePixel[1] + 11)
   ElseIf _ColorCheck(_GetPixelColor($DonatePixel[0], $DonatePixel[1]), Hex(0x262926, 6), 10) Then
       Click($DonatePixel[0], $DonatePixel[1] + 11)
   EndIf
   If _Sleep(1000) Then Return
   _CaptureRegion(0, 0, 860, $DonatePixel[1] + 200)
   If $ColDist >= 0 Then $x = 237 + $ColDist * 80
   If $RowDist = 0 Then
	  $y = $DonatePixel[1] - 5
   ElseIf $RowDist = 1 Then
	  $y = $DonatePixel[1] + 91
   Else
	  $y = $DonatePixel[1] + 185
   EndIf
   If _ColorCheck(_GetPixelColor($x, $y), Hex(0x507C00, 6), 10) Or _ColorCheck(_GetPixelColor($x, $y - 5), Hex(0x507C00, 6), 10) Then
	   SetLog("Donating " & $number & " " & $Troop, $COLOR_BLUE)
	   If _Sleep(500) Then Return
	   Click($x, $y, $number, 50)
	   $Donate = True
	   Select
		  Case $Troop = "Barbarian"
			  $CurBarb += $number
			  $ArmyComp -= 1*$number
		  Case $Troop = "WallBreaker"
			  $CurWB += $number
			  $ArmyComp -= 2*$number
		  Case $Troop = "Archer"
			  $CurArch += $number
			  $ArmyComp -= 1*$number
		  Case $Troop = "Giant"
			  $CurGiant += $number
			  $ArmyComp -= 5*$number
		  Case $Troop = "Goblin"
			  $CurGoblin += $number
			  $ArmyComp -= 1*$number
	   EndSelect
	Else
	  SetLog("No " & $Troop & " available for donation or Clan Castle don't have enough space.", $COLOR_ORANGE)
	  Return
   EndIf
   If _Sleep(500) Then Return
EndFunc   ;==>DonateTroops

Func GetTroopCoord($Troop)
   Switch $Troop
	  Case "Barbarian", "Healer", "Witch"
		 $ColDist = 0
	  Case "Archer", "Dragon", "Lava"
		 $ColDist = 1
	  Case "Giant", "Pekka"
		 $ColDist = 2
	  Case "Goblin", "Minion"
		 $ColDist = 3
	  Case "WallBreaker", "Hog"
		 $ColDist = 4
	  Case "Balloon", "Valkyrie"
		 $ColDist = 5
	  Case "Wizard", "Golem"
		 $ColDist = 6
  	  Case Else
		 SetLog("Unable to determine troop ($i) to donate.", $COLOR_RED)
		 $ColDist = -1
   EndSwitch

   Switch $Troop
	  Case "Barbarian", "Archer", "Giant", "Goblin", "WallBreaker", "Balloon", "Wizard"
		 $RowDist = 0
	  Case "Healer", "Dragon", "Pekka", "Minion", "Hog", "Valkyrie", "Golem"
		 $RowDist = 1
	  Case "Witch", "Lava"
		 $RowDist = 2
	  Case Else
		 SetLog("Unable to determine troop ($row) to donate.", $COLOR_RED)
		 $RowDist = -1
   EndSwitch
EndFunc ;==> Select troop color and button coordinate