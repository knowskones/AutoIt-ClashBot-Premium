#include <Crypt.au3>
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
Global $frmOptions, $txtOptUsername, $txtOptPassword, $chkOptSaveLogin, $cmbOptTheme, $cmbOptLanguage
Func OptionsDialog()
#Region ### START Koda GUI section ### Form=Options Form.kxf
$frmOptions = GUICreate("Options", 268, 293, -1, -1, BitOR($DS_MODALFRAME,$DS_SETFOREGROUND), -1, $frmBot)
$groupOptLogin = GUICtrlCreateGroup("", 8, 1, 249, 137)
$txtOptUsername = GUICtrlCreateInput("", 88, 56, 150, 21)
$lblOptUsername = GUICtrlCreateLabel("Username:", 24, 57, 55, 17)
$txtOptPassword = GUICtrlCreateInput("", 88, 86, 150, 21, BitOR($GUI_SS_DEFAULT_INPUT,$ES_PASSWORD))
$lblOptPassword = GUICtrlCreateLabel("Password:", 24, 87, 53, 17)
$lblOptLogin = GUICtrlCreateLabel("Enter in credentials for a VIP account", 42, 15, 180, 17, $SS_CENTER)
$lblOptLogin1 = GUICtrlCreateLabel("to unlock premium features.", 65, 33, 134, 17, $SS_CENTER)
$chkOptSaveLogin = GUICtrlCreateCheckbox("Save Username/Password", 60, 113, 150, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$btnOptOK = GUICtrlCreateButton("&OK", 15, 231, 75, 25)
$btnOptCancel = GUICtrlCreateButton("&Cancel", 95, 231, 75, 25)
$btnOptApply = GUICtrlCreateButton("&Apply", 175, 231, 75, 25)
$groupOptSettings = GUICtrlCreateGroup("", 8, 142, 249, 78)
$lblOptTheme = GUICtrlCreateLabel("Theme:", 24, 163, 40, 17)
$cmbOptTheme = GUICtrlCreateCombo("", 88, 157, 150, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "None|Default|Iron|Steel|Gray|Dark|Black|Alloy|Hex|Core|Fresco|Soft|Green|Teal|Orange|Red", "Default")
$cmbOptLanguage = GUICtrlCreateCombo("", 88, 187, 150, 25, BitOR($CBS_DROPDOWN,$CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "Arabic|Deutsch|English|Filipino|French|Portuguese|Spanish|Turkish|Vietnamese", "English")
GUICtrlSetState(-1, $GUI_DISABLE)
$lblOptLanguage = GUICtrlCreateLabel("Language:", 24, 188, 55, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

	GUICtrlSetState($btnOptOK, $GUI_DEFBUTTON)
	GUICtrlSetOnEvent($btnOptOK, "btnOptOK")
	GUICtrlSetOnEvent($btnOptApply, "OptApply")
	GUICtrlSetOnEvent($btnOptCancel, "OptClose")

	GUICtrlSetData($txtOptUsername, $sUsername)
	GUICtrlSetData($txtOptPassword, $sPassword)

	If $bSaveLogin = 1 Then
		GUICtrlSetState($chkOptSaveLogin, $GUI_CHECKED)
	Else
		GUICtrlSetState($chkOptSaveLogin, $GUI_UNCHECKED)
	EndIf

	_GUICtrlComboBox_SetCurSel($cmbOptTheme, $iTheme)
EndFunc

Func btnOptOK()
	OptApply()
	OptClose()
EndFunc

Func OptApply()
	$sUsername = GUICtrlRead($txtOptUsername)
	$sPassword = GUICtrlRead($txtOptPassword)

	If GUICtrlRead($chkOptSaveLogin) = $GUI_CHECKED Then
		$bSaveLogin = 1
		IniWrite($config, "login", "savelogin", 1)
		IniWrite($config, "login", "username", $sUsername)

		_Crypt_Startup()
		Local $sEncrypted = _Crypt_EncryptData($sPassword, @ComputerName, $CALG_AES_256)
		IniWrite($config, "login", "password", $sEncrypted)
		_Crypt_Shutdown()
	Else
		$bSaveLogin = 0
		IniWrite($config, "login", "savelogin", 0)
		IniWrite($config, "login", "username", "")
		IniWrite($config, "login", "password", "")
	EndIf

	$unregPopup = False
	AuthCheck()

	OptTheme()
EndFunc

Func OptClose()
	GUIDelete($frmOptions)
	GUISetState(@SW_ENABLE, $frmBot)
	WinActivate($frmBot)
EndFunc

Func OptTheme()
	$iTheme = _GUICtrlComboBox_GetCurSel($cmbOptTheme)
	Switch $iTheme
		Case 0
			$themePath = ""
		Case 1
			$themePath = @ScriptDir & "\Images\Skins\orange.msstyles"
		Case 2
			$themePath = @ScriptDir & "\Images\Skins\gray0.msstyles"
		Case 3
			$themePath = @ScriptDir & "\Images\Skins\blue1.msstyles"
		Case 4
			$themePath = @ScriptDir & "\Images\Skins\gray5.msstyles"
		Case 5
			$themePath = @ScriptDir & "\Images\Skins\gray2.msstyles"
		Case 6
			$themePath = @ScriptDir & "\Images\Skins\dark0.msstyles"
		Case 7
			$themePath = @ScriptDir & "\Images\Skins\aa.msstyles"
		Case 8
			$themePath = @ScriptDir & "\Images\Skins\hex.msstyles"
		Case 9
			$themePath = @ScriptDir & "\Images\Skins\core.msstyles"
		Case 10
			$themePath = @ScriptDir & "\Images\Skins\fresco.msstyles"
		Case 11
			$themePath = @ScriptDir & "\Images\Skins\gray4.msstyles"
		Case 12
			$themePath = @ScriptDir & "\Images\Skins\green.msstyles"
		Case 13
			$themePath = @ScriptDir & "\Images\Skins\blue.msstyles"
		Case 14
			$themePath = @ScriptDir & "\Images\Skins\orange2.msstyles"
		Case 15
			$themePath = @ScriptDir & "\Images\Skins\red.msstyles"
		Case Else
			SetLog("Unknown Theme", $COLOR_RED)
			Return
	EndSwitch

	ApplyTheme($themePath)
EndFunc   ;==>btnTheme
