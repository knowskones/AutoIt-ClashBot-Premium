#include <GUIConstantsEx.au3>
#include <EditConstants.au3>

; @author Explicit

#NoTrayIcon
Opt('WinTitleMatchMode', 2)
Opt('GUIOnEventMode', 1)
Opt('GUICloseOnESC', 0)
HotKeySet("{ENTER}", "LoginButton_Click")

Global $MainForm = GUICreate("Login", 220, 112)
Global $UsernameLabel = GUICtrlCreateLabel("Username", 5, 10, 80, 22)
Global $UsernameInput = GUICtrlCreateInput("", 90, 8, 121, 26)
Global $PasswordLabel = GUICtrlCreateLabel("Password", 5, 45, 78, 22)
Global $PasswordInput = GUICtrlCreateInput("", 90, 43, 121, 26, $ES_PASSWORD)
Global $LoginButton = GUICtrlCreateButton("Login", 5, 78, 207, 25)

Global $LoggedIn = False

GUISetFont(12, 400, 0, "Arial")
GUICtrlSetCursor(-1, 0)
GUISetState(@SW_SHOW)

While 1
    $msg = GUIGetMsg()

    Select
     Case $msg = $GUI_EVENT_CLOSE
		Exit
     Case $msg = $LoginButton
		LoginButton_Click()

		If $LoggedIn Then
			ExitLoop
		EndIf
    EndSelect
WEnd

Func LoginButton_Click()
	GUICtrlSetState($LoginButton, 128)
	GUICtrlSetData($LoginButton, "Authenticating...")

	If Login(StringStripWS(GUICtrlRead($UsernameInput), 3), StringStripWS(GUICtrlRead($PasswordInput), 3)) Then
		HotKeySet("{ENTER}")
		$LoggedIn = True
	Else
		MsgBox(262160, "Error", "Invalid username and/or password.")
	EndIf

	GUICtrlSetState($LoginButton, 64)
	GUICtrlSetData($LoginButton, "Login")
	GUICtrlSetState($UsernameInput, 256)
EndFunc

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

	if $oHTTP.Status <> 200 Then
		MsgBox(262160, "Error", "Unable to contact the login server.")
		Return False
	EndIf

	Return $oHTTP.ResponseText == "1"
EndFunc

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
EndFunc
