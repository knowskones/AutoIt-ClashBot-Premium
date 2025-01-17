Func CreateSpell()
	If $SpellDarkStorage = 0 Or $CreateSpell = False Or $LoginType < 2 Then Return

	SetLog("Create Lightning Spells...", $COLOR_BLUE)

	If $SFactoryPos[0] = "" Then
		LocateSFactory()
		SaveConfig()
		If _Sleep(1000) Then Return
	EndIf

	ClickP($TopLeftClient) ;Click Away
	If _Sleep(500) Then Return

	Click($SFactoryPos[0], $SFactoryPos[1]) ;Click Spell Factory

	Local $CreatePos = _WaitForPixelSearch(440, 596, 600, 603, Hex(0x001048, 6)) ;Finds Create Spells button
	If IsArray($CreatePos) = False Then
		SetLog("Spell Factory is not available", $COLOR_RED)
		If _Sleep(500) Then Return
	Else
		Click($CreatePos[0], $CreatePos[1]) ;Click Create Spell
		While _WaitForPixel(250, 357, Hex(0xCC4FC6, 6), 20, $TrainTimeout, $TrainDelay)
			Click(220, 320, 1) ;Lightning Spell
		WEnd
		$CreateSpell = False
	EndIf

	If _Sleep(500) Then Return
	Click($TopLeftClient[0], $TopLeftClient[1], 2, 250); Click away twice with 250ms delay
	SetLog("Create Spell Complete...", $COLOR_BLUE)

EndFunc   ;==>CreateSpell
