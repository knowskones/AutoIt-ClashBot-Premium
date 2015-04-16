Func checkTownhall()
	Local $path
	Local $bumpTolerance = 70
	Local $t = Number($THLevel)
	Local $nocheck = 0
	Local $i, $j, $k
	If getTrophy(51, 66 + 90) <> "" Then
		$nocheck = 6
	Else
		$t = 6
	EndIf
	$THLocation = 0
	If ($t >= 6) And ($t <= 10) And ($t <> $nocheck) Then
		Do
			_CaptureRegion()
			For $i = 1 to 13
				$path = @ScriptDir & "\Images\TH\TH" & String($t) & "\townhall" & String($i) & ".bmp"
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
						Return $THText[$t-6]
					EndIf
				EndIf
			Next
			$bumpTolerance += 5
		Until $bumpTolerance > 80
		If $THLocation = 0 Then
			If $t > 8 Then
				$i = 7
				$j = 8
			ElseIf $t < 8 Then
				$i = 8
				$j = 9
			Else
				$i = 7
				$j = 9
			EndIf
			$bumpTolerance = 70
		EndIf
	Else
		$i = 8
		$j = 9
		$t = 0
	EndIf
	Do
		_CaptureRegion()
		While ($i >= 6) Or ($j <= 10)
			If ($i <> $t) And ($i <> $nocheck)  Then
				For $k = 1 To 13
					$path = @ScriptDir & "\Images\TH\TH" & String($i) & "\townhall" & String($k) & ".bmp"
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
			EndIf
			If ($j <> $t) And ($j <> $nocheck) Then
				For $k = 1 To 13
					$path = @ScriptDir & "\Images\TH\TH" & String($j) & "\townhall" & String($k) & ".bmp"
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
							Return $THText[$j-6]
						EndIf
					EndIf
				Next
			EndIf
			$i -= 1
			$j += 1
		WEnd
		$bumpTolerance += 5
	Until $bumpTolerance > 80
	Local $Date = @MDAY & "." & @MON & "." & @YEAR
	Local $Time = @HOUR & "." & @MIN & "." & @SEC
	Return "-"
EndFunc   ;==>checkTownhall
