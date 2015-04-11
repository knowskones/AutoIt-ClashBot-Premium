;Uses multiple pixels with coordinates of each color in a certain region, works for memory BMP

;$xSkip and $ySkip for numbers of pixels skip
;$offColor[2][COLOR/OFFSETX/OFFSETY] offset relative to firstColor coordination
;$iLeft, $iTop, $iRight, $iBottom define bounds to search for $firstColor pixel only
;remaining pixels in $offColor can be outside this area

Func _MultiPixelSearch($iLeft, $iTop, $iRight, $iBottom, $xSkip, $ySkip, $firstColor, $offColor, $iColorVariation)
	_CaptureRegion()
	For $x = $iLeft To $iRight Step $xSkip
		For $y = $iTop To $iBottom Step $ySkip
			If _ColorCheck(_GetPixelColor($x, $y), $firstColor, $iColorVariation) Then
				Local $allchecked = True
				For $i = 0 To UBound($offColor) - 1
					If _ColorCheck(_GetPixelColor($x + $offColor[$i][1], $y + $offColor[$i][2]), Hex($offColor[$i][0], 6), $iColorVariation) = False Then
						$allchecked = False
						ExitLoop
					EndIf
				Next
				If $allchecked Then
					Local $Pos[2] = [$x, $y]
					Return $Pos
				EndIf
			EndIf
		Next
	Next
	Return 0
EndFunc   ;==>_MultiPixelSearch
