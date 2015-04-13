Func checkTownhall()
	Local $path
	Local $bumpTolerance = 70

	If _Sleep(500) Then Return
	Do
		_CaptureRegion()
		For $i = 6 To 10
			For $j = 1 to 11
				$path = @ScriptDir & "\images\TH\TH" & String($i) & "\townhall" & String($j) & ".bmp"
				If FileExists($path) Then
					$THLocation = _ImageSearch($path, 1, $THx, $THy, $bumpTolerance) ; Getting TH Location
					If $THLocation = 1 Then
						If ((((65 - 280) / (367 - 78)) * ($THx - 78)) + 280 > $THy) Or ((((277 - 62) / (780 - 481)) * ($THx - 481)) + 62 > $THy) Or ((((540 - 343) / (338 - 78)) * ($THx - 78)) + 343 < $THy) Or ((((345 - 538) / (780 - 524)) * ($THx - 524)) + 538 < $THy) Then
							$THLocation = 0
							$THx = 0
							$THy = 0
						EndIf
					EndIf
					If $THLocation = 1 Then
						Return $THText[$i-6]
					EndIf
				EndIf
			Next
		Next
		$bumpTolerance += 5
		If $THLocation = 1 Then ExitLoop
	Until $bumpTolerance > 80
	If $THLocation = 0 Then
		Return "-"
	EndIf
EndFunc   ;==>checkTownhall
