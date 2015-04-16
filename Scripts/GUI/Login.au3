Global $LoggedIn = False

#include "forms\Login Form.au3"

Func LoginButton_Click()
	GUICtrlSetState($btnLogin, $GUI_DISABLE)
	GUICtrlSetData($btnLogin, "Authenticating...")

	$LoggedIn = Login(StringStripWS(GUICtrlRead($txtUsername), 3), StringStripWS(GUICtrlRead($txtPassword), 3))

	GUICtrlSetState($btnLogin, $GUI_ENABLE)
	GUICtrlSetData($btnLogin, "Login")
	GUICtrlSetState($txtUsername, $GUI_FOCUS)
EndFunc   ;==>LoginButton_Click

Func Login($Username, $Password)
	If $Username = "" Or $Password = "" Then
		MsgBox(262160, "Error", "Please enter both your username and password.")
		Return False
	EndIf

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
