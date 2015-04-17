Func handleBarracksError($i) ;Sets the text for the log

If $ichkRaxRestart = 0 then Return
If $i = 0 then $barracksError[0] = True
If $i = 1 then $barracksError[1] = True
If $i = 2 then $barracksError[2] = True
If $i = 3 then $barracksError[3] = True

If $barracksError[0]= True And $barracksError[1]= True And $barracksError[2]= True And $barracksError[3]= True Then
	SetLog("Restarting BlueStack to fix stuck error!", $COLOR_RED)
	Local $RestartApp = StringReplace(_WinAPI_GetProcessFileName(WinGetProcess($Title)), "Frontend", "Restart")
	Run($RestartApp & " Android")
	If _Sleep(10000) Then Return
		Do
			If _Sleep(5000) Then Return
		Until ControlGetHandle($Title, "", "BlueStacksApp1") <> 0
EndIf
EndFunc   ;==>_AllWordsExist

Func resetBarracksError()
If $ichkRaxRestart = 0 then Return
	$barracksError[0] = False
	$barracksError[1] = False
	$barracksError[2] = False
	$barracksError[3] = False
EndFunc