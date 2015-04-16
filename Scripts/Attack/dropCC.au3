;Drops Clan Castle troops, given the slot and x, y coordinates.

Func dropCC($x, $y, $slot, $CenterLoc = 1) ;Drop clan castle
	Local $useCastle = ($searchDead) ? $checkDeadUseClanCastle : $checkUseClanCastle
	If $slot <> -1 And $useCastle = 1 Then
		SetLog("Dropping Clan Castle", $COLOR_BLUE)
		Click(68 + (72 * $slot), 595, 1, 500)
		If _Sleep(500) Then Return
		Click($x, $y, 1, 0, $CenterLoc)
	EndIf
EndFunc   ;==>dropCC
