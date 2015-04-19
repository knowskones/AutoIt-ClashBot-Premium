Global $avoidDefense[26]

For $i = 0 To 25
	$avoidDefense[$i] = @ScriptDir & "\images\Defense\" & $i + 1 & ".bmp"
Next

Global $Tolerance1 = 80

Func checkDefense()
	If _Sleep(500) Then Return
	For $i = 0 To 25
		_CaptureRegion(0, 0, 851, 460)
		$DefenseLoc = _ImageSearch($avoidDefense[$i], 1, $Defensex, $Defensey, $Tolerance1)
		If $DefenseLoc = 1 Then
			Return $DefenseLoc
		EndIf
	Next
	If $DefenseLoc = 0 Then
		$Defensex = 0
		$Defensey = 0
		Return $DefenseLoc
	EndIf
EndFunc   ;==>checkDefense
