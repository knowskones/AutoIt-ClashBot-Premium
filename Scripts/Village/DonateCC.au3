;Donates troops

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

 Func ProcessNbTroops($indexTroop, $Value)
   ;here we make a special processing for barbarians, archers & giants (training Algorithm)
	Switch $indexTroop
		Case 0;barbs
			$CurBarb += $Value
			$ArmyComp -= 1*$Value
		Case 1;archs
			$CurArch += $Value
			$ArmyComp -= 1*$Value
		Case 2;giants
			$CurGiant += $Value
			$ArmyComp -= 5*$Value
	EndSwitch

EndFunc ;==>CalculateNbTroops

Func DonateTroops($NbTroops, $PosYDemand)
	Local $IndexTable = 0
    Local $UnitIndex
    Local $CurrentPosY
    Local $SaveNb = $NbTroops
	Local $flagexit = True

   ;inform user of donation state
	If $NbTroops = 1 Then SetLog("Donating " & $NameStateTroop[$indexDonate.Item(0)], $COLOR_BLUE)
	If $NbTroops > 1 And GUICtrlRead($chkMultiMode) = $GUI_CHECKED Then
		$NbTroops -= 1
		Local $TextTroops = "Multi Troops Mode : "
		For $i = 0 To $NbTroops
			$TextTroops = $TextTroops & $NameStateTroop[$indexDonate.Item($i)] & ", "
		Next
		SetLog(StringTrimRight($TextTroops, 2), $COLOR_BLUE)
	EndIf


	_Sleep(250)

	While 1 ; infinite loop because we can't know how much troops we can give (Clan donate bonus - currently 8 max..)
		_Sleep(250)
		_CaptureRegion();capture new screen
		If _ColorCheck(_GetPixelColor(193, $PosYDemand), Hex(0xF8FCFF, 6)) Then; check if the donation window is open
			$UnitIndex = $indexDonate.Item($IndexTable); loading troop index with the loop index
			$CurrentPosY = $PosYDemand + $PosUnits[$UnitIndex][1]
			If _ColorCheck(_GetPixelColor($PosUnits[$UnitIndex][0], $CurrentPosY), Hex(0x507C00, 6), 10) Then; check if the troop is available
				While _WaitForPixelCapture(0, 0, 860, 720, $PosUnits[$UnitIndex][0], $CurrentPosY, Hex(0x507C00, 6), 10, 800, 50)
					Click($PosUnits[$UnitIndex][0], $CurrentPosY); we give 1 troop of this type
					$SucessDonate = True
					ProcessNbTroops($UnitIndex, 1)
					If $SaveNb > 1 And GUICtrlRead($chkMultiMode) = $GUI_CHECKED Then
						_Sleep(250)
						ExitLoop; we alternate troops, else we just spam the same troop
					EndIf
				WEnd
			Else
				SetLog($NameStateTroop[$UnitIndex] & " can't be given or is not available for donation", $COLOR_ORANGE)
			EndIf
			For $i = 0 To $NbTroops
				If _ColorCheck(_GetPixelColor($PosUnits[$indexDonate.Item($i)][0], $PosYDemand + $PosUnits[$indexDonate.Item($i)][1]), Hex(0x507C00, 6), 10) Then
					$flagexit = False
					ExitLoop
				EndIf
			Next
			If $flagexit And $IndexTable = $NbTroops Then
				ExitLoop
			Else
				$flagexit = True
			EndIf
		Else
			ExitLoop ;donation window disapear (end of donation)
		EndIf

		$IndexTable += 1;we increment index
		If $IndexTable > $NbTroops Then $IndexTable = 0 ; out of table range, we reset the index
	WEnd

	ProcessNbTroops($UnitIndex, -1);_WaitForPixel tends to allow one extra click due to delay in picture going grey, the the last unit get -1 in value (if it's recognized)
EndFunc   ;==>DonateTroops

Func DonateCC($DonateChat = True)
	If StringReplace(GUICtrlRead($txtDonationStatus), @CRLF, "\r\n") = "None" Then
		SetLog("No donation settings, skip donating", $COLOR_ORANGE)
		Return
	EndIf

	Local $offColors[3][3] = [[0x000000, 0, -2], [0x262926, 0, 1], [0xF8FCF0, 0, 11]]
	Local $CountResult = 0
	Local $Filters
	Local $DonatePixel
	Local $Savepos = -1
	Local $SizeTableTroop = UBound($StateTroop) - 1
	Local $Scroll
	$SucessDonate = False
	$indexDonate = ObjCreate("System.Collections.ArrayList")

	SetLog("Donating Troops", $COLOR_BLUE)

	_CaptureRegion()
	If Not $DonateChat Then
		If _ColorCheck(_GetPixelColor(34, 321), Hex(0xE00300, 6), 20) = False And $CommandStop <> 3 Then
			SetLog("No new chats, skip donating", $COLOR_ORANGE)
			Return
		EndIf
	EndIf

	ClickP($TopLeftClient) ;Click Away
	If _ColorCheck(_GetPixelColor(331, 330), Hex(0xF0A03B, 6), 20) = False Then Click(19, 349) ;Clicks chat thing
	If _Sleep(500) Then Return
	Click(189, 24) ; clicking clan tab

	While 1
		While 1
			If $SucessDonate Or $Savepos = -1 Then;first turn or the donation was a succes, then we can take the same screen dimension
				$DonatePixel = _MultiPixelSearch(202, 119, 203, 670, 1, 1, Hex(0x262926, 6), $offColors, 20)
			Else;we take special screen to avoid fails result in the past
				If ($Savepos + 30) > 720 Then ExitLoop (2);we quit this donation tab because we are out of screen
				$DonatePixel = _MultiPixelSearch(202, $Savepos + 30, 203, 670, 1, 1, Hex(0x262926, 6), $offColors, 20)
			EndIf
			$SucessDonate = False
			If IsArray($DonatePixel) Then
				$CountResult = 0
				$indexDonate.RemoveAll

				;identify donate button & associated text
				_CaptureRegion(0, 0, 435, $DonatePixel[1] + 50)
				Local $String = getString($DonatePixel[1] - 28)
				If $String = "" Then
					$String = getString($DonatePixel[1] - 17)
				Else
					$String = $String & @CRLF & getString($DonatePixel[1] - 17)
				EndIf

				SetLog("Chat Text: " & $String, $COLOR_GREEN)

				;searching words in troops table
				For $i = 0 To $SizeTableTroop ; run donate troop
					If $StateTroop[$i][0] Then ;here we got a give to all option then we give this unit
						Local $Blacklistcheck = False
						If $StateTroop[$i][2] Then
							Local $Blacklist = StringSplit(StringReplace($StateTroop[$i][4],"\r\n","|"), "|")
							For $j = 0 To UBound($Blacklist) - 1
								If CheckDonate($Blacklist[$j], $String) Then
									$BlacklistCheck = True
									SetLog("Donation Blacklist found in Chat Text, skip donating...", $COLOR_RED)
									ExitLoop
								EndIf
							Next
						EndIf
						If Not $Blacklistcheck Then
							SetLog("Give " & $NameStateTroop[$i] & " to ALL requests", $COLOR_ORANGE)
							$indexDonate.Add($i)
							$CountResult = 1
							ExitLoop
						EndIf
					EndIf

					If $StateTroop[$i][1] Then ;here we check all filters to find keywords
						Local $Blacklistcheck = False
						If $StateTroop[$i][2] Then
							Local $Blacklist = StringSplit(StringReplace($StateTroop[$i][4],"\r\n","|"), "|")
							For $j = 0 To UBound($Blacklist) - 1
								If CheckDonate($Blacklist[$j], $String) Then
									$BlacklistCheck = True
									SetLog("Donation Blacklist found in Chat Text, skip donating...", $COLOR_RED)
									ExitLoop
								EndIf
							Next
						EndIf
						If Not $BlacklistCheck Then
							$Filters = StringSplit(StringReplace($StateTroop[$i][3],"\r\n","|"), "|")

							For $j = 0 To UBound($Filters) - 1
								If CheckDonate($Filters[$j], $String) Then
									SetLog("Donation Keywords found for : " & $NameStateTroop[$i], $COLOR_ORANGE)
									$indexDonate.Add($i)
									$CountResult += 1
									ExitLoop
								EndIf
							Next

							If GUICtrlRead($chkMultiMode) = $GUI_UNCHECKED And $CountResult = 1 Then
								SetLog("Multi Troops Mode is DISABLED, Donate " & $NameStateTroop[$i] & " only", $COLOR_ORANGE)
								ExitLoop; we force exit because we only need the first good result
							EndIf
						EndIf
					EndIf
				Next

				$Savepos = $DonatePixel[1]
				If $CountResult > 0 Then
					Click($DonatePixel[0], $DonatePixel[1] + 11); openning donation window
					DonateTroops($CountResult, $DonatePixel[1]);donate troops
				Else
					ExitLoop
				EndIf

				If _Sleep(500) Then Return
				If $SucessDonate <> True Then ExitLoop
				ClickP($TopLeftClient) ;Click Away
			Else
				ExitLoop (2)
			EndIf
		WEnd
		If $SucessDonate <> True Then; fail on first demand checking if there is another one..
			_Sleep(500) ; we need wait a bit befor the next processing in this case
		Else
			$Savepos = -1
			$DonatePixel = _MultiPixelSearch(202, 119, 203, 670, 1, 1, Hex(0x262926, 6), $offColors, 20); checking if there is other demands ..
			If Not IsArray($DonatePixel) Then
				$Scroll = _PixelSearch(285, 650, 287, 700, Hex(0x97E405, 6), 20);checking green indicator for troops demands
				If IsArray($Scroll) Then
					Click($Scroll[0], $Scroll[1])
					If _Sleep(500) Then ExitLoop
				Else
					ExitLoop;we quit loop because there is nore more demands
				EndIf
			EndIf
		EndIf
	WEnd

	If _WaitForPixel(331, 330, Hex(0xF0A03B, 6), 20) Then
		Click(331, 330) ;Clicks chat thing
		If _Sleep(500) Then Return
	EndIf
	SetLog("Finished Donating", $COLOR_BLUE)
 EndFunc   ;==>DonateCC
