Func _Sleep($iDelay)
	Local $iBegin = TimerInit()
	While TimerDiff($iBegin) < $iDelay
		If $RunState = False Then Return True
		While ($PauseBot And $AllowPause)
			Sleep(200)
			tabMain()
		WEnd
		tabMain()
		Sleep(($iDelay > 50) ? 50 : 1)
	WEnd
	Return False
EndFunc   ;==>_Sleep
