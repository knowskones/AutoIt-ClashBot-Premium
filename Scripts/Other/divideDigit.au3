
;For division of troops spreads evenly in barracks training.
;For example, 78 archers / 4 barracks = array with value 20, 20, 19, 19

Func DivideValue($integer, $barrackscount)

	Local $var, $i, $Remainder
	Local $array[4] = [0, 0, 0, 0]

	$Remainder = Mod($integer, $barrackscount)
	$var = Floor($integer / $barrackscount)

	for $i = 0 to 3
		if Not $BarAvailable[$i] Then ContinueLoop
		$array[$i] = $var
		if $Remainder <> 0 Then
			$array[$i] += 1
			$Remainder -= 1
		EndIf
	Next

	Return $array
EndFunc