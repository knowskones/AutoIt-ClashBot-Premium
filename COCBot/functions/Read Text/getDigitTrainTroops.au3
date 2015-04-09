;==============================================================================================================
;===Get Digit TrainTroops======================================================================================
;--------------------------------------------------------------------------------------------------------------
;Finds pixel color pattern of specific X and Y values, returns digit if pixel color pattern found.
;--------------------------------------------------------------------------------------------------------------

Func getDigitTrainTroops(ByRef $x, $y)

	;Search for digit 9
	Local $c1 = Hex(0x6B6A5D, 6), $c2 = Hex(0xCACDBA, 6), $c3 = Hex(0x9FA090, 6)
	Local $pixel1[3] = [$x + 4, $y + 4, $c1], $pixel2[3] = [$x + 2, $y + 1, $c2], $pixel3[3] = [$x + 1, $y + 4, $c3]
	If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
		Return 9
	EndIf

	;Search for digit 8
	Local $c1 = Hex(0x444236, 6), $c2 = Hex(0xCED1BE, 6), $c3 = Hex(0x5B5A4D, 6)
	Local $pixel1[3] = [$x + 3, $y + 2, $c1], $pixel2[3] = [$x + 1, $y + 5, $c2], $pixel3[3] = [$x + 3, $y + 5, $c3]
	If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
		Return 8
	EndIf

	;Search for digit 7
	Local $c1 = Hex(0xB8BAA9, 6), $c2 = Hex(0x878879, 6), $c3 = Hex(0x878879, 6)
	Local $pixel1[3] = [$x, $y + 5, $c1], $pixel2[3] = [$x + 2, $y + 4, $c2], $pixel3[3] = [$x + 3, $y + 1, $c3]
	If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
		Return 7
	EndIf

	;Search for digit 6
	Local $c1 = Hex(0xB4B6A5, 6), $c2 = Hex(0xB1B3A2, 6), $c3 = Hex(0xD6DAC7, 6)
	Local $pixel1[3] = [$x + 4, $y + 2, $c1], $pixel2[3] = [$x + 2, $y + 5, $c2], $pixel3[3] = [$x + 3, $y + 1, $c3]
	If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
		Return 6
	EndIf

	;Search for digit 5
	Local $c1 = Hex(0xA1A292, 6), $c2 = Hex(0xB7BAA8, 6), $c3 = Hex(0x848576, 6)
	Local $pixel1[3] = [$x + 3, $y + 2, $c1], $pixel2[3] = [$x + 2, $y + 5, $c2], $pixel3[3] = [$x + 5, $y + 3, $c3]
	If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
		Return 5
	EndIf

	;Search for digit 4
	Local $c1 = Hex(0x616074, 6), $c2 = Hex(0x59584C, 6), $c3 = Hex(0x535246, 6)
	Local $pixel1[3] = [$x, $y + 4, $c1], $pixel2[3] = [$x + 3, $y + 1, $c2], $pixel3[3] = [$x + 4, $y + 6, $c3]
	If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
		Return 4
	EndIf

	;Search for digit 3
	Local $c1 = Hex(0x909181, 6), $c2 = Hex(0xC4C6B4, 6), $c3 = Hex(0xA2A393, 6)
	Local $pixel1[3] = [$x + 1, $y + 3, $c1], $pixel2[3] = [$x + 2, $y + 5, $c2], $pixel3[3] = [$x + 2, $y + 2, $c3]
	If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
		Return 3
	EndIf

	;Search for digit 2
	Local $c1 = Hex(0x646356, 6), $c2 = Hex(0x717062, 6), $c3 = Hex(0xC1C4B2, 6)
	Local $pixel1[3] = [$x + 3, $y + 3, $c1], $pixel2[3] = [$x + 1, $y + 5, $c2], $pixel3[3] = [$x, $y + 3, $c3]
	If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
		Return 2
	EndIf

	Search for digit 1
	Local $c1 = Hex(0x464439, 6), $c2 = Hex(0x717163, 6), $c3 = Hex(0x646456, 6)
	Local $pixel1[3] = [$x + 1, $y, $c1], $pixel2[3] = [$x + 2, $y + 3, $c2], $pixel3[3] = [$x + 1, $y + 6, $c3]
	If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
		Return 1
	EndIf

	;Search for digit 0
	Local $c1 = Hex(0x767567, 6), $c2 = Hex(0x727264, 6), $c3 = Hex(0x919282, 6)
	Local $pixel1[3] = [$x, $y + 6, $c1], $pixel2[3] = [$x + 3, $y + 4, $c2], $pixel3[3] = [$x + 1, $y + 1, $c3]
	If boolPixelSearch($pixel1, $pixel2, $pixel3) Then
		Return 0
	EndIf

	Return ""
EndFunc   ;==>getDigitTrainTroops
