;Checks if red pixel located in the popup baracks window is available

Func CheckFullArmy()
	_CaptureRegion()
	$Pixel = _ColorCheck(_GetPixelColor(327, 520), Hex(0xD03838, 6), 20)
	If Not $Pixel Then
		If _sleep(200) Then Return
		_CaptureRegion()
		$Pixel = (_ColorCheck(_GetPixelColor(653, 247), Hex(0xE0E4D0, 6), 20) And Not _ColorCheck(_GetPixelColor(475, 214), Hex(0xE0E4D0, 6), 20))
	EndIf
	If $Pixel And _GUICtrlComboBox_GetCurSel($cmbTroopComp) <> 8 Then
		$fullArmy = True
		SetLog("Army Camp Full : " & $fullArmy, $COLOR_RED)
	EndIf
EndFunc   ;==>CheckFullArmy
