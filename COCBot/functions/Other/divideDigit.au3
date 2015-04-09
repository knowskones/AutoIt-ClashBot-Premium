
;For division of troops spreads evenly in barracks training.
;For example, 78 archers / 4 barracks = array with value 20, 20, 19, 19

Func DivideValue($integer, $barrackscount)

	Local $var, $i, $Remainder
	Local $array[$barrackscount]

	$Remainder = Mod($integer, $barrackscount)
	$var = Floor($integer / $barrackscount)

	for $i = 0 to $barrackscount - 1
		$array[$i] = $var
		if $Remainder <> 0 Then
			$array[$i] += 1
			$Remainder -= 1
		EndIf
	Next

	Return $array
EndFunc