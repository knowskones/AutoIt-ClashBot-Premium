#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=Login Form.kxf
$frmLogin = GUICreate("Login", 221, 113, -1, -1)
GUISetFont(12, 400, 0, "Arial")
$lblUsername = GUICtrlCreateLabel("Username", 5, 10, 80, 22)
$txtUsername = GUICtrlCreateInput("", 90, 8, 121, 26)
$lblPassword = GUICtrlCreateLabel("Password", 5, 45, 78, 22)
$txtPassword = GUICtrlCreateInput("", 90, 43, 121, 26, BitOR($GUI_SS_DEFAULT_INPUT,$ES_PASSWORD))
$btnLogin = GUICtrlCreateButton("Login", 5, 78, 207, 25)
GUICtrlSetCursor (-1, 0)
#EndRegion ### END Koda GUI section ###

GUICtrlSetState($btnLogin, $GUI_DEFBUTTON)
GUISetIcon(@ScriptDir & "\Icons\cocbot.ico")
TraySetIcon(@ScriptDir & "\Icons\cocbot.ico")
GUISetState(@SW_SHOW, $frmLogin)

While 1
	$msg = GUIGetMsg()

	Select
		Case $msg = $GUI_EVENT_CLOSE
			Exit
		Case $msg = $btnLogin
			LoginButton_Click()

			If $LoggedIn Then
				GUIDelete($frmLogin)
				DisplayGUI()
				ExitLoop
			EndIf
	EndSelect
WEnd
