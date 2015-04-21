#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
Global $frmOptions
Func OptionsDialog()
Opt("GUICloseOnESC", 0)
#Region ### START Koda GUI section ### Form=Options Form.kxf
$frmOptions = GUICreate("Options", 268, 293, -1, -1, BitOR($DS_MODALFRAME,$DS_SETFOREGROUND), BitOR($WS_EX_TOPMOST,$WS_EX_WINDOWEDGE), $frmBot)
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
	GUICtrlSetOnEvent($cmbOptTheme, "btnTheme")

;	While 1

;	WEnd
EndFunc

Func btnOptOK()
	OptClose()
EndFunc

Func OptApply()
	OptClose()
EndFunc

Func OptClose()
	Opt("GUICloseOnESC", 1)
	GUIDelete($frmOptions)
	GUISetState(@SW_ENABLE, $frmBot)
EndFunc
