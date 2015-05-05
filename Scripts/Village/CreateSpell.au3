Func CreateSpell()
	If $SpellDarkStorage = 0 Or $CreateSpell = False Then Return

	SetLog("Create Lightning Spells...", $COLOR_BLUE)

	If $SFactoryPos[0] = "" Then
		LocateSFactory()
		SaveConfig()
		If _Sleep(1000) Then Return
	EndIf

	ClickP($TopLeftClient) ;Click Away
	If _Sleep(500) Then Return

	Click($SFactoryPos[0], $SFactoryPos[1]) ;Click Spell Factory
					 If _Sleep(600) Then Return
					  _CaptureRegion()
					  If _Sleep(600) Then Return
			     If _ColorCheck(_GetPixelColor(555, 616), Hex(0xFFFFFF, 6), 20) Or _
					_ColorCheck(_GetPixelColor(555, 616), Hex(0x838669, 6), 20)  Then
						SetLog("Create Lighning Spell", $COLOR_BLUE)
						Click(566,599) ;click create spell
						 If _Sleep(1000) Then Return
							     _CaptureRegion()
								 If _Sleep(600) Then Return
						   If  _ColorCheck(_GetPixelColor(237, 354), Hex(0xFFFFFF, 6), 20) = False Then
							  setlog("Not enoug Elixir to create Spell", $COLOR_RED)
						       Elseif  _ColorCheck(_GetPixelColor(200, 346), Hex(0x1A1A1A, 6), 20) Then
							   setlog("Spell Factory Full", $COLOR_RED)
						     Else
							  Click(252,354)
							  If _Sleep(600) Then Return
							  Click(252,354)
							  If _Sleep(600) Then Return
							  Click(252,354)
							  If _Sleep(600) Then Return
							  Click(252,354)
							  If _Sleep(600) Then Return
							  Click(252,354)
							  If _Sleep(600) Then Return
						   EndIf
					     Else
						   setlog("Spell Factory is not available, Skip Create", $COLOR_RED)

			    EndIf
	   EndIf
        If _Sleep(250) Then Return
		Click(1, 1)
		If _Sleep(250) Then Return
 EndIf
EndFunc
