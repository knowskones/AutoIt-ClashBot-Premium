Global $AuthTimer, $AuthConnected = True

Func AuthCheck()
	$LoginType = 2
	SetAuthMode()
	return
	If $sUsername = "" Or $sPassword = "" Then
		$LoginType = 0 ; Unregistered mode
	Else
		Local $oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
		Local $POSTData = "u=" & URLEncode($sUsername) & "&p=" & URLEncode($sPassword)

		$oHTTP.Open("POST", "https://clashbot.org/bot/validate_vip_status.php", False)
		$oHTTP.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
		$oHTTP.Send($POSTData)

		If $oHTTP.Status <> 200 Then
			If $AuthConnected Then
				$AuthConnected = False
				$AuthTimer = TimerInit()
				AdlibRegister("AuthCheck", 10000)
				SetLog("Unable to contact the login server. Trying again in 10s.", $COLOR_RED)
				Return
			Else
				If TimerDiff($AuthTimer) < 60000 Then
					SetLog("Unable to contact the login server. Trying again in 10s.", $COLOR_RED)
					Return
				Else
					SetLog("Unable to contact the login server. Continuing in unregistered mode.", $COLOR_RED)
					$LoginType = 0 ; Unregistered mode
				EndIf
			EndIf
		ElseIf $oHTTP.ResponseText == "1" Then
			$LoginType = 2 ; VIP mode
		ElseIf $oHTTP.ResponseText == "#denied#" Then
			SetLog("Invalid username and/or password specified. Unable to authorise account.", $COLOR_RED)
			$LoginType = 0 ; Unregistered mode
		Else
			$LoginType = 1 ; Registered mode
		EndIf
	EndIf

	AdlibRegister("AuthCheck", 3600000)
	SetAuthMode()
EndFunc   ;==>AuthCheck

Func SetAuthMode()
	If $LoginType = 2 Then ; VIP mode
		; Enable vip controls
		For $i = 0 To UBound($vipControls) - 1
			GUICtrlSetState($vipControls[$i], $GUI_ENABLE)
		Next

		; Set controls for deploy speed options
		Randomspeedatk()

		SetLog("VIP Mode active.", $COLOR_GREEN)
	Else ; Not VIP mode
		; Disable vip controls
		For $i = 0 To UBound($vipControls) - 1
			GUICtrlSetState($vipControls[$i], $GUI_DISABLE)
		Next

		SetLog("No VIP access, premium features disabled", $COLOR_RED)
	EndIf

	If $LoginType = 0 And $unregPopup Then
		MsgBox(0, "Unregistered", "You are currently running unregistered, please visit our forums at http://clashbot.org and register for a free account to remove this message.")
	EndIf
	$unregPopup = True
EndFunc   ;==>SetAuthMode

Func URLEncode($urlText)
	$url = ""
	For $i = 1 To StringLen($urlText)
		$acode = Asc(StringMid($urlText, $i, 1))
		Select
			Case ($acode >= 48 And $acode <= 57) Or _
					($acode >= 65 And $acode <= 90) Or _
					($acode >= 97 And $acode <= 122)
				$url = $url & StringMid($urlText, $i, 1)
			Case $acode = 32
				$url = $url & "+"
			Case Else
				$url = $url & "%" & Hex($acode, 2)
		EndSelect
	Next
	Return $url
EndFunc   ;==>URLEncode
