Global $AuthTimer, $AuthConnected = True

;#include "forms\Login Form.au3"

Func LoginButton_Click()
	GUICtrlSetState($btnLogin, $GUI_DISABLE)
	GUICtrlSetData($btnLogin, "Authenticating...")

	If GUICtrlRead($txtUsername) = "" Or GUICtrlRead($txtPassword) = "" Then
		MsgBox(262160, "Error", "Please enter both your username and password.")
		Return False
	EndIf

	$LoggedIn = Login(StringStripWS(GUICtrlRead($txtUsername), 3), StringStripWS(GUICtrlRead($txtPassword), 3))

	GUICtrlSetState($btnLogin, $GUI_ENABLE)
	GUICtrlSetData($btnLogin, "Login")
	GUICtrlSetState($txtUsername, $GUI_FOCUS)
EndFunc   ;==>LoginButton_Click

Func AuthCheck()
	Local $Username = "" ; GUICtrlRead($txtUsername) ; edit source of username here
	Local $Password = "" ; GUICtrlRead($txtPassword) ; edit source of password here

	If $Username = "" Or $Password = "" Then
		$LoginType = 0 ; Unregistered mode
	Else
		Local $oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
		Local $POSTData = "u=" & URLEncode($Username) & "&p=" & URLEncode($Password)

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

	Else ; Not VIP mode
		; Disable vip controls
		For $i = 0 To UBound($vipControls) - 1
			GUICtrlSetState($vipControls[$i], $GUI_DISABLE)
		Next

	EndIf


EndFunc   ;==>SetAuthMode

Func Login($Username, $Password)
	Local $oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
	Local $POSTData = "u=" & URLEncode($Username) & "&p=" & URLEncode($Password)

	$oHTTP.Open("POST", "https://clashbot.org/bot/validate_vip_status.php", False)
	$oHTTP.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
	$oHTTP.Send($POSTData)

	If $oHTTP.Status <> 200 Then
		MsgBox(262160, "Error", "Unable to contact the login server.")
		Return False
	EndIf

	If $oHTTP.ResponseText == "1" Then
		Return True
	ElseIf $oHTTP.ResponseText == "#denied#" Then
		MsgBox(262160, "Error", "Invalid username and/or password.")
		Return False
	Else
		MsgBox(262160, "Error", "You must purchase a VIP package, available in the store at http://clashbot.org/forums," _
			& " to be able to run this premium bot release.")
		Return False
	EndIf
EndFunc   ;==>Login

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
