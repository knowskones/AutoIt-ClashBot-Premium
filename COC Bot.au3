#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Run_Au3Stripper=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#pragma compile(Icon, "Icons\cocbot.ico")
#pragma compile(FileDescription, Premium Clash of Clans Bot - http://clashbot.org)
#pragma compile(ProductName, ClashBot)
#pragma compile(ProductVersion, 6.1)
#pragma compile(FileVersion, 6.1)
#pragma compile(LegalCopyright, 2015 © Application Automation LLC)

$sBotVersion = "6.1 Beta" ;Edit version in compile option above aswell
$sBotTitle = "AutoIt ClashBot v" & $sBotVersion

If _Singleton($sBotTitle, 1) = 0 Then
	MsgBox(0, "", "Bot is already running.")
	Exit
EndIf

If @AutoItX64 = 1 Then
	MsgBox(0, "", "Don't Run/Compile Script (x64)! try to Run/Compile Script (x86) to getting this bot work." & @CRLF & _
			"If this message still appear, try to re-install your AutoIt with newer version.")
	Exit
EndIf

;If Not FileExists(@ScriptDir & "\License.txt") Then
	;FileCreate(@ScriptDir & "\License.txt", "Copyright 2015 Application Automation LLC")
;EndIf

#include "_UskinLibrary.au3"
_Uskin_LoadDLL()
_USkin_Init(@ScriptDir & "\skins\orange.msstyles")
#include "COCBot\Global Variables.au3"
#include "COCBot\Functions.au3"
#include "COCBot\forms\GUI Form.au3"
#include "COCBot\Login.au3"
#include "COCBot\GUI Control.au3"
#include-once

DirCreate($dirLogs)
DirCreate($dirLoots)
DirCreate($dirAllTowns)
DirCreate($dirDarkStorages)

While 1
	Switch TrayGetMsg()
		Case $tiAbout
			MsgBox(64 + $MB_APPLMODAL + $MB_TOPMOST, $sBotTitle, "Clash of Clans Bot" & @CRLF & @CRLF & _
					"Version: " & $sBotVersion & @CRLF & _
					"Copyright 2015 Application Automation LLC.", 0, $frmBot)
		Case $tiExit
			ExitLoop
	EndSwitch
WEnd

Func runBot() ;Bot that runs everything in order
	While 1
		SaveConfig()
		readConfig()
		applyConfig()
		If GUICtrlRead($chkKeepLogs) = $GUI_CHECKED Then
			log_cleanup(GUICtrlRead($txtKeepLogs))
		EndIf
		chkNoAttack()
		$Restart = False
		$fullArmy = False
		If _Sleep(1000) Then Return
		checkMainScreen()
		If _Sleep(1000) Then Return
		If ZoomOut() = False Then ContinueLoop
		If _Sleep(1000) Then Return
		checkMainScreen(False)
		If $Restart = True Then ContinueLoop
		If BotCommand() Then btnStop()
		If _Sleep(1000) Then Return
		checkMainScreen(False)
		VillageReport() ; populate resource stats and gather info required for upgrades
		If _Sleep(1000) Then Return
		checkMainScreen(False)
		If _Sleep(1000) Then Return
		CheckCostPerSearch()
		If _Sleep(1000) Then Return
		If $Checkrearm = True Then
			ReArm()
			If _Sleep(2000) Then Return
			checkMainScreen(False)
			$Checkrearm = False
		EndIf
		DonateCC()
		If _Sleep(1000) Then Return
		checkMainScreen(False)
		If $CommandStop <> 0 And $CommandStop <> 3 Then
			If ZoomOut() = False Then ContinueLoop
			CheckArmyCamp()
			If _Sleep(1000) Then Return
			checkMainScreen(False)
		EndIf
		If $DCattack = 1 And $CommandStop <> 0 And $CommandStop <> 3 And $fullArmy Then
			If ZoomOut() = False Then ContinueLoop
			If _Sleep(1000) Then Return
			checkMainScreen(False)
			AttackMain()
			If _Sleep(1000) Then Return
			checkMainScreen(False)
			$fullArmy = False
		EndIf
		If $CommandStop <> 0 And $CommandStop <> 3 Then
			If ZoomOut() = False Then ContinueLoop
			If _Sleep(1000) Then Return
			checkMainScreen(False)
			TrainTroop()
			If _Sleep(1000) Then Return
			checkMainScreen(False)
			TrainDark()
			If _Sleep(1000) Then Return
			checkMainScreen(False)
			CreateSpell()
			If _Sleep(1000) Then Return
			checkMainScreen(False)
		EndIf
		checkMainScreen(False)
		If ZoomOut() = False Then ContinueLoop
		If _Sleep(1000) Then Return
		checkMainScreen(False)
		BoostAllBuilding()
		If _Sleep(1000) Then Return
		checkMainScreen(False)
		RequestCC()
		If _Sleep(1000) Then Return
		checkMainScreen(False)
		Collect()
		If _Sleep(1000) Then Return
		checkMainScreen(False)
		UpgradeWall()
		If _Sleep(1000) Then Return
		checkMainScreen(False)
		UpgradeBuilding()
		If _Sleep(1000) Then Return
		checkMainScreen(False)
		Idle()
		If _Sleep(1000) Then Return
		If $CommandStop <> 0 And $CommandStop <> 3 Then
			If ZoomOut() = False Then ContinueLoop
			If _Sleep(1000) Then Return
			checkMainScreen(False)
			AttackMain()
			If _Sleep(1000) Then Return
			checkMainScreen(False)
		EndIf
	WEnd
EndFunc   ;==>runBot

Func Idle() ;Sequence that runs until Full Army
	Local $TimeIdle = 0 ;In Seconds
	While $fullArmy = False
		If $CommandStop = -1 Then SetLog("~~~Waiting for full army~~~", $COLOR_PURPLE)
		Local $hTimer = TimerInit(), $x = 30000
		If $CommandStop = 3 Then $x = 15000
		If _Sleep($x) Then ExitLoop
		checkMainScreen()
		If _Sleep(1000) Then ExitLoop
		If ZoomOut() = False Then ContinueLoop
		If _Sleep(1000) Then ExitLoop
		If $iCollectCounter > $COLLECTATCOUNT Then ; This is prevent from collecting all the time which isn't needed anyway
			Collect()
			If _Sleep(1000) Or $RunState = False Then ExitLoop
			$iCollectCounter = 0
		EndIf
		$iCollectCounter = $iCollectCounter + 1
		If $CommandStop <> 3 Then
			CheckArmyCamp()
			If _Sleep(1000) Then ExitLoop
			TrainTroop()
			If _Sleep(1000) Then Return
			TrainDark()
			If _Sleep(1000) Then ExitLoop
		EndIf
		If $CommandStop = 0 And $fullArmy Then
			SetLog("Army Camp is Full, Stop Training...", $COLOR_ORANGE)
			$CommandStop = 3
			$fullArmy = False
		EndIf
		If $CommandStop = -1 Then
			If $fullArmy Then ExitLoop
			DropTrophy()
			If _Sleep(1000) Then ExitLoop
		EndIf
		DonateCC()
		$TimeIdle += Round(TimerDiff($hTimer) / 1000, 2) ;In Seconds
		SetLog("Time Idle: " & Floor(Floor($TimeIdle / 60) / 60) & " hours " & Floor(Mod(Floor($TimeIdle / 60), 60)) & " minutes " & Floor(Mod($TimeIdle, 60)) & " seconds", $COLOR_ORANGE)
	WEnd
EndFunc   ;==>Idle

Func AttackMain() ;Main control for attack functions
	$DCattack = 1
	PrepareSearch()
	If _Sleep(1000, False) Then Return
	VillageSearch()
	If $CommandStop = 0 Then Return
	If _Sleep(1000, False) Or $Restart = True Then Return
	PrepareAttack()
	If _Sleep(1000, False) Then Return
	Attack()
	$DCattack = 0
	If _Sleep(1000) Then Return
	ReturnHome($TakeLootSnapShot)
	If _Sleep(1000) Then Return
	$FirstStart = True ;Ensure camps get recalculated after battle
EndFunc   ;==>AttackMain

Func Attack() ;Selects which algorithm
	SetLog("======Beginning Attack======")
	;	Switch $attackpattern
	;		Case 0 ; v5.5
	;			SetLog("Attacking with v5.5 attacking Algorithm")
	;			algorithm_Troops()
	;		Case 1 ; v5.6
	;			SetLog("Attacking with v5.6 attacking Algorithm")
	algorithm_AllTroops()
	;	EndSwitch
EndFunc   ;==>Attack

Func TrainTroop()
   If _GUICtrlComboBox_GetCurSel($cmbTroopComp) = 10 Then
	  TrainCustom()
   Else
	  Train()
   EndIf
EndFunc

Func log_cleanup($no_rotator)
	local $dir_list[3] = ["Loots", "logs", "AllTowns"]
	For $l = 0 To UBound($dir_list) - 1
		local $dir = @ScriptDir & "\" & $dir_list[$l]
		if FileExists($dir) == 0 then
			SetLog("Dir Not Found !!!" & $dir, $COLOR_RED)
			continueloop
		endif
		local $fArray = _FileListToArrayRec($dir, "*", $FLTAR_FILESFOLDERS, $FLTAR_RECUR, $FLTAR_SORT, $FLTAR_FULLPATH )
		if UBound($fArray) == 0 Then continueloop
			local $data_size = $fArray[0]
			if $data_size > $no_rotator Then
				For $i = 1 To Number($data_size - $no_rotator)
					local $file_path = $fArray[$i]
					If Not FileDelete($file_path) Then
						SetLog("Failed to delete " & $file_path, $COLOR_RED)
					EndIf
				Next
			endif
	Next
EndFunc
