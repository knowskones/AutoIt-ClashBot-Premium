#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=Login Form.kxf
$frmLogin = GUICreate("Login", 221, 134, -1, -1)
GUISetFont(12, 400, 0, "Arial")
$lblUsername = GUICtrlCreateLabel("Username", 5, 10, 80, 22)
$txtUsername = GUICtrlCreateInput("", 90, 8, 121, 26)
$lblPassword = GUICtrlCreateLabel("Password", 5, 45, 78, 22)
$txtPassword = GUICtrlCreateInput("", 90, 43, 121, 26, BitOR($GUI_SS_DEFAULT_INPUT,$ES_PASSWORD))
$chkSaveUsername = GUICtrlCreateCheckbox("Remember Username", 25, 76, 170, 17)
$btnLogin = GUICtrlCreateButton("Login", 5, 102, 207, 25)
GUICtrlSetCursor (-1, 0)
#EndRegion ### END Koda GUI section ###

GUICtrlSetState($btnLogin, $GUI_DEFBUTTON)
GUISetIcon(@ScriptDir & "\Icons\cocbot.ico")
TraySetIcon(@ScriptDir & "\Icons\cocbot.ico")
GUISetState(@SW_SHOW, $frmLogin)

Func readLoginConfig()
	If FileExists($config) Then
		GUICtrlSetData($txtUsername, IniRead($config, "login", "username", ""))

		If IniRead($config, "login", "saveUsername", 0) = 1 Then
			GUICtrlSetState($chkSaveUsername, $GUI_CHECKED)
			If GUICtrlRead($txtUsername) <> "" Then GUICtrlSetState($txtPassword, $GUI_FOCUS)
		Else
			GUICtrlSetState($chkSaveUsername, $GUI_UNCHECKED)
		EndIf
	EndIf
EndFunc

Func saveLoginConfig()
	If GUICtrlRead($chkSaveUsername) = $GUI_CHECKED Then
		IniWrite($config, "login", "saveUsername", 1)
		IniWrite($config, "login", "username", GUICtrlRead($txtUsername))
	Else
		IniWrite($config, "login", "saveUsername", 0)
		IniWrite($config, "login", "username", "")
	EndIf
EndFunc

readLoginConfig()

While 1
	$msg = GUIGetMsg()

	Select
		Case $msg = $GUI_EVENT_CLOSE
			Exit
		Case $msg = $btnLogin
			saveLoginConfig()
			LoginButton_Click()

			If $LoggedIn Then
				GUIDelete($frmLogin)
				DisplayGUI()
				ExitLoop
			EndIf
	EndSelect
WEnd
