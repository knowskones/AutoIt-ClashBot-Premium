#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
Global $frmAbout
Func AboutDialog()
#Region ### START Koda GUI section ### Form=About Form.kxf
$frmAbout = GUICreate("", 305, 316, -1, -1, BitOR($DS_MODALFRAME,$DS_SETFOREGROUND), -1, $frmBot)
$groupAbout = GUICtrlCreateGroup("", 8, 8, 281, 241)
$imgAbout = GUICtrlCreatePic("", 16, 24, 105, 97)
$lblAboutName = GUICtrlCreateLabel("Product Name", 16, 138, 260, 17)
$lblAboutVersion = GUICtrlCreateLabel("Version", 16, 163, 260, 17)
$lblAboutURL = GUICtrlCreateLabel("http://clashbot.org", 16, 213, 93, 17)
$lblAboutCopyright = GUICtrlCreateLabel("Copyright 2015 © Application Automation LLC", 16, 188, 220, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$btnAboutOK = GUICtrlCreateButton("OK", 115, 256, 75, 25)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

	GUICtrlSetState($btnAboutOK, $GUI_DEFBUTTON)
	GUICtrlSetOnEvent($btnAboutOK, "AbtClose")

	; Configure dynamic content
	GUICtrlSetData($lblAboutName, $sBotTitle)
	GUICtrlSetData($lblAboutVersion, "Version " & $sBotVersion)
	GUICtrlSetImage($imgAbout, @ScriptDir & "\Images\GUI\cocbot.jpg")
EndFunc

Func AbtClose()
	GUIDelete($frmAbout)
	GUISetState(@SW_ENABLE, $frmBot)
	WinActivate($frmBot)
EndFunc
