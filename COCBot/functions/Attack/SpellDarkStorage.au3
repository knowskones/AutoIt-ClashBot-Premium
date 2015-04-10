	Global $SDark, $SDark2
    Global $LightPosition[11]
	Global $LightSpell
	Global $TakeDarkStorageSS = 1

Func CheckDarkStorage()
	If $SpellDarkStorage = 0 Or $searchDark = 0 Then Return

	$SDark = getDarkElixir(51, 66 + 57)
	$DELocation = checkDarkElix()

	SetLog("Dark Elixir Left: " & $SDark & " / Dark Elixir Target: " & $itxtSpellDarkStorage, $COLOR_BLUE)
    SpellDarkStorage()
EndFunc  ;==>CheckDarkStorage

Func SpellDarkStorage()
	$LSpell = -1
    For $i = 0 To 10
	  $LightSpell = IdentifySpell($i)
	  If $LightSpell = $eLSpell Then
	  $LightPosition[$i] = $LightSpell
	  $LSpell = $i
	  EndIf
	Next

	If ($SDark - $itxtSpellDarkStorage >= 0) And ($DELocation = 1) And ($LSpell <> -1) Then
		SetLog("Found Dark Storage at PosX: " & $DElixx & ", PosY: " & $DElixy & ", activate Lightning Skill", $COLOR_BLUE)
		Click(68 + (72 * $LSpell), 595) ;Select Spell
		If _Sleep(500) Then Return
		Click($DElixx, $DElixy)
		If _Sleep(3000) Then Return
		If CheckDarkStorage2() = True And $ichkMultiLight = 1 Then SpellDarkStorage()
		$CreateSpell = True
	ElseIf $LSpell = -1 Then
		SetLog("You have used up all your Lightning Spell, skipping Lightning Attack...", $COLOR_RED)
	ElseIf ($SDark - $itxtSpellDarkStorage <= -1) Then
		SetLog("Dark Elixir do not meet min requirement, skipping Lightning Attack...", $COLOR_RED)
	ElseIf $DELocation = 0 Then
		SetLog("Unable to locate Dark Storage or Dark Storage is empty, skipping Lightning Attack...", $COLOR_RED)
			If $TakeDarkStorageSS = 1 Then
				Local $Date = @MDAY & "." & @MON & "." & @YEAR
				Local $Time = @HOUR & "." & @MIN & "." & @SEC
				_CaptureRegion(0, 0, 845, 540)
				_GDIPlus_ImageSaveToFile($hBitmap, @ScriptDir & "\DarkStorages\" & $Date & " at " & $Time & ".bmp")
			EndIf
    EndIf
	ClickP($TopLeftClient) ;Click Away
EndFunc   ;==>SpellDarkStorage

Func CheckDarkStorage2()
 $SDark2 = $SDark
 If _Sleep(2000) Then Return
 $SDark = getDarkElixir(51, 66 + 57)
 If _Sleep(1000) Then Return
 SetLog("Dark Elixir Left: " & $SDark & " / Dark Elixir Target: " & $itxtSpellDarkStorage, $COLOR_BLUE)
 If $SDark <> $SDark2 And ($SDark - $itxtSpellDarkStorage >= 0) Then
 SetLog("There is still plenty Dark Elixir left, proceed for next Lightning Attack... ", $COLOR_GREEN)
	Return True
 ElseIf ($SDark - $itxtSpellDarkStorage <= -1) Then
 SetLog("Dark Elixir do not meet min requirement, skipping Lightning Attack...", $COLOR_RED)
    Return False
 ElseIf $SDark = $SDark2 Then
 SetLog("Previous Lightning Spell fail to zap Dark Elixir Storage, skipping Lightning Attack...", $COLOR_RED)
    Return False
 EndIf
EndFunc	  ;==>CheckDarkStorage2