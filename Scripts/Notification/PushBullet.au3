#include <Array.au3>
#include <String.au3>

Func PushBulletEnabled()
	Return (GUICtrlRead($chkPushBulletEnabled_vip) = $GUI_CHECKED And $LoginType = 2)
EndFunc   ;==>PushBulletEnabled

Func _RemoteControl()
	$oHTTP = ObjCreate("WinHTTP.WinHTTPRequest.5.1")
	$access_token = $PushBullettoken
	$oHTTP.Open("Get", "https://api.pushbullet.com/v2/pushes?active=true", False)
	$oHTTP.SetCredentials($access_token, "", 0)
	$oHTTP.SetRequestHeader("Content-Type", "application/json")
	$oHTTP.Send()
	$Result = $oHTTP.ResponseText

	Local $title = _StringBetween($Result, '"title":"', '"', "", False)
	Local $iden = _StringBetween($Result, '"iden":"', '"', "", False)
	Local $findstr = StringRegExp(StringLower($Result), '"title":"bot')

	If IsArray($iden) = False Then Return

	If $findstr = 1 Then
		For $x = 0 To UBound($title) - 1
			If $title <> "" Or $iden <> "" Then
				$title[$x] = StringLower(StringStripWS($title[$x], $STR_STRIPLEADING + $STR_STRIPTRAILING + $STR_STRIPSPACES))
				$iden[$x] = StringStripWS($iden[$x], $STR_STRIPLEADING + $STR_STRIPTRAILING + $STR_STRIPSPACES)

				If $title[$x] = "bot help" Then
					_DeleteMessage($iden[$x])
					SetLog("Your request has been received. Help has been sent")
					_Push("Request for Help", "You can remotely control your bot using the following command format\n\nBot <command> where <command> is:\n\nPause - pause the bot\nResume - resume the bot\nStats - send bot current statistics\nLogs - send the current log file\nBoost1 - Boost 1 barrack\nBoost2 - Boost 2 barracks\nBoost3 - Boost 3 barracks\nBoostAll - Boost all barracks\nHelp - send this help message\nShutdownPC - shutdown your PC\nRestartPC - restart your PC\nSleepPC - sleep your PC\nScreenCapture - capture computer's screen\n\nEnter the command in the title of the message")
				ElseIf $title[$x] = "bot pause" Then
					_DeleteMessage($iden[$x])
					If $AllowPause Then
						If $PauseBot = False Then
							SetLog("Your request has been received. Bot is now paused")
							_Push("Request to Pause", "Your request has been received. Bot is now paused")
							$PauseBot = True
							GUICtrlSetData($btnPause, "Resume")
						Else
							SetLog("Your bot is currently paused, no action was taken")
							_Push("Request to Pause", "Your bot is currently paused, no action was taken")
						EndIf
					Else
						_Push("Request to Pause", "Sorry, pause function is disabled during attack, try again later")
					EndIf
				ElseIf $title[$x] = "bot resume" Then
					_DeleteMessage($iden[$x])
					If $PauseBot = True Then
						SetLog("Your request has been received. Bot is now resumed")
						_Push("Request to Resume", "Your request has been received. Bot is now resumed")
						$PauseBot = False
						GUICtrlSetData($btnPause, "Pause")
					Else
						SetLog("Your bot is currently running, no action was taken")
						_Push("Request to Resume", "Your bot is currently running, no action was taken")
					EndIf
				ElseIf $title[$x] = "bot stats" Then
					_DeleteMessage($iden[$x])
					SetLog("Your request has been received. Statistics sent")
					_Push("Request for Stats", "Resources at Start\n-Gold:  " & GUICtrlRead($lblresultgoldtstart) & "\n-Elixir:  " & GUICtrlRead($lblresultelixirstart) & "\n-DE:  " & GUICtrlRead($lblresultdestart) & "\n-Trophies:  " & GUICtrlRead($lblresulttrophystart) & "\n\nCurrent Resources \n-Gold:  " & GUICtrlRead($lblresultgoldnow) & "\n-Elixir:  " & GUICtrlRead($lblresultelixirnow) & "\n-DE:  " & GUICtrlRead($lblresultdenow) & "\n-Trophies:  " & GUICtrlRead($lblresulttrophynow) & "\n\nLast Raid\n-Gold:  " & GUICtrlRead($lblresultgoldlast) & "\n-Elixir:  " & GUICtrlRead($lblresultelixirlast) & "\n-DE:  " & GUICtrlRead($lblresultdelast) & "\n-Trophies:  " & GUICtrlRead($lblresulttrophylast) & "\n\nTotal Raid\n-Gold:  " & GUICtrlRead($lblresultgoldgain) & "\n-Elixir:  " & GUICtrlRead($lblresultelixirgain) & "\n-DE:  " & GUICtrlRead($lblresultdegain) & "\n-Trophies Won:  " & GUICtrlRead($lblresulttrophiesdropped) & "\n\nOther Stats\n-Search Cost:  " & GUICtrlRead($lblresultsearchcost) & "\n-Attacked:  " & GUICtrlRead($lblresultvillagesattacked) & "\n-Skipped:  " & GUICtrlRead($lblresultvillagesskipped) & "\n-Free Builders:  " & GUICtrlRead($lblresultbuilder) & "\n-Wall Upgrade:  " & GUICtrlRead($lblwallupgradecount) & "\n-Bot Run Time:  " & StringFormat("%02i:%02i:%02i", $hour, $min, $sec))
				ElseIf $title[$x] = "bot logs" Then
					_DeleteMessage($iden[$x])
					SetLog("Your request has been received. Log is now sent")
					_PushFile($sLogFileName, "Profile\Logs", "text/plain; charset=utf-8", "Current Logs", $sLogFileName)
				ElseIf $title[$x] = "bot boost1" Then
					_DeleteMessage($iden[$x])
					If GUICtrlRead($cmbBoostBarracks_vip) < 5 Then
						GUICtrlSetData($cmbBoostBarracks_vip, GUICtrlRead($cmbBoostBarracks_vip) + 1)
						GUICtrlSetState($chkBoostRax1_vip, $GUI_CHECKED)
						GUICtrlSetState($chkBoostRax2_vip, $GUI_UNCHECKED)
						GUICtrlSetState($chkBoostRax3_vip, $GUI_UNCHECKED)
						GUICtrlSetState($chkBoostRax4_vip, $GUI_UNCHECKED)
						SetLog("Your request has been received. Barrack 1 will be boosted on return to village.")
						_Push("Barrack Boost", "Barrack 1 will be boosted on return to village.")
					Else
						SetLog("You have already reached maximum barracks boost setting.")
						_Push("Barrack Boost", "You have already reached maximum barracks boost setting.")
					EndIf
				ElseIf $title[$x] = "bot boost2" Then
					_DeleteMessage($iden[$x])
					If GUICtrlRead($cmbBoostBarracks_vip) < 5 Then
						GUICtrlSetData($cmbBoostBarracks_vip, GUICtrlRead($cmbBoostBarracks_vip) + 1)
						GUICtrlSetState($chkBoostRax1_vip, $GUI_CHECKED)
						GUICtrlSetState($chkBoostRax2_vip, $GUI_CHECKED)
						GUICtrlSetState($chkBoostRax3_vip, $GUI_UNCHECKED)
						GUICtrlSetState($chkBoostRax4_vip, $GUI_UNCHECKED)
						SetLog("Your request has been received. Barrack 1 and 2 will be boosted on return to village.")
						_Push("Barrack Boost", "Barracks 1 and 2 will be boosted on return to village.")
					Else
						SetLog("You have already reached maximum barracks boost setting.")
						_Push("Barrack Boost", "You have already reached maximum barracks boost setting.")
					EndIf
				ElseIf $title[$x] = "bot boost3" Then
					_DeleteMessage($iden[$x])
					If GUICtrlRead($cmbBoostBarracks_vip) < 5 Then
						GUICtrlSetData($cmbBoostBarracks_vip, GUICtrlRead($cmbBoostBarracks_vip) + 1)
						GUICtrlSetState($chkBoostRax1_vip, $GUI_CHECKED)
						GUICtrlSetState($chkBoostRax2_vip, $GUI_CHECKED)
						GUICtrlSetState($chkBoostRax3_vip, $GUI_CHECKED)
						GUICtrlSetState($chkBoostRax4_vip, $GUI_UNCHECKED)
						SetLog("Your request has been received. Barracks 1, 2 and 3 will be boosted on return to village.")
						_Push("Barrack Boost", "Barracks 1, 2 and 3 will be boosted on return to village.")
					Else
						SetLog("You have already reached maximum barracks boost setting.")
						_Push("Barrack Boost", "You have already reached maximum barracks boost setting.")
					EndIf
				ElseIf $title[$x] = "bot boostall" Then
					_DeleteMessage($iden[$x])
					If GUICtrlRead($cmbBoostBarracks_vip) < 5 Then
						GUICtrlSetData($cmbBoostBarracks_vip, GUICtrlRead($cmbBoostBarracks_vip) + 1)
						GUICtrlSetState($chkBoostRax1_vip, $GUI_CHECKED)
						GUICtrlSetState($chkBoostRax2_vip, $GUI_CHECKED)
						GUICtrlSetState($chkBoostRax3_vip, $GUI_CHECKED)
						GUICtrlSetState($chkBoostRax4_vip, $GUI_CHECKED)
						SetLog("All barracks will be boosted on return to village.")
						_Push("Barrack Boost", "All barracks will be boosted on return to village.")
					Else
						SetLog("You have already reached maximum barracks boost setting.")
						_Push("Barrack Boost", "You have already reached maximum barracks boost setting")
					EndIf
				ElseIf $title[$x] = "bot shutdownpc" Then
					_DeleteMessage($iden[$x])
					SetLog("Your request has been received. Force shutdown your PC.", $COLOR_BLUE)
					_Push("Request to ShutdownPC", "Your request has been received. Force shutdown your PC.")
					If _Sleep(500) Then Return
					btnStop()
					Shutdown(5) ; Force Shutdown
				ElseIf $title[$x] = "bot sleeppc" Then
					_DeleteMessage($iden[$x])
					SetLog("Your request has been received. Sleep your PC.", $COLOR_BLUE)
					_Push("Request to SleepPC", "Your request has been received. Sleep your PC.")
					If _Sleep(500) Then Return
					btnStop()
					Shutdown(32) ; Sleep / Stand by
				ElseIf $title[$x] = "bot restartpc" Then
					_DeleteMessage($iden[$x])
					SetLog("Your request has been received. Restart your PC.", $COLOR_BLUE)
					_Push("Request to RestartPC", "Your request has been received. Restart your PC.")
					If _Sleep(500) Then Return
					btnStop()
					Shutdown(6) ; Force Restart
				ElseIf $title[$x] = "bot screencapture" Then
					_DeleteMessage($iden[$x])
					SetLog("Your request has been received. Take a screenshot on your computer.", $COLOR_BLUE)
					Local $screenfilename
					Local $Date = @MDAY & "." & @MON & "." & @YEAR
					Local $Time = @HOUR & "." & @MIN
					$screenfilename = "ScreenCapture(" & $Date & "_at_" & $Time & ")" & ".jpg"
					_ScreenCapture_Capture($dirScreenCapture & $screenfilename)
					_PushFile($screenfilename, "Profile\ScreenCapture", "image/jpeg", "Screen Capture", $screenfilename)
				EndIf
			EndIf
		Next
	EndIf
EndFunc   ;==>_RemoteControl

;Keep Messages
Func KeepMessages($int)
   if $PushBulletEnabled = 1 and $PushBullettoken <> "" Then
	   $oHTTP = ObjCreate("WinHTTP.WinHTTPRequest.5.1")
	   $access_token = $PushBullettoken
	   $oHTTP.Open("Get", "https://api.pushbullet.com/v2/pushes?active=true", False)
	   $oHTTP.SetCredentials($access_token, "", 0)
	   $oHTTP.SetRequestHeader("Content-Type", "application/json")
	   $oHTTP.Send()
	   $Result = $oHTTP.ResponseText

	   Local $iden = _StringBetween($Result, '"iden":"', '"', "", False)
	   If IsArray($iden) = False Then Return

	   If UBound($iden) > $int And $int <> 0 Then
		   For $x = $int To UBound($iden) - 1
			   $oHTTP.Open("Delete", "https://api.pushbullet.com/v2/pushes/" & $iden[$x], False)
			   $oHTTP.SetCredentials($access_token, "", 0)
			   $oHTTP.SetRequestHeader("Content-Type", "application/json")
			   $oHTTP.Send()
		   Next
		EndIf
    EndIf
EndFunc   ;==>_KeepMessages

;GetDevices
Func GetDevices()
   if $PushBullettoken <> "" Then
	   $oHTTP = ObjCreate("WinHTTP.WinHTTPRequest.5.1")
	   $access_token = $PushBullettoken
	   $oHTTP.Open("Get", "https://api.pushbullet.com/v2/devices?active=true", False)
	   $oHTTP.SetCredentials($access_token, "", 0)
	   $oHTTP.SetRequestHeader("Content-Type", "application/json")
	   $oHTTP.Send()
	   $Result = $oHTTP.ResponseText
	   Local $iden = _StringBetween($Result, '"iden":"', '"', "", False)
	   Local $nickname = _StringBetween($Result, '"nickname":"', '"', "", False)
	   If IsArray($iden) = False Then Return

	   For $x = 0 to Ubound($iden) - 1
			GUIctrlsetData($cmbPushDevice_vip, $nickname[$x], "All")
	   Next
   EndIf
EndFunc   ;==>_GetDevices

;FindDevice
Func FindDevice()
   if $PushBulletEnabled = 1 and $PushBullettoken <> "" and $cmbPushDevice_vip <> "" and $cmbPushDevice_vip <> "All" Then
	   $oHTTP = ObjCreate("WinHTTP.WinHTTPRequest.5.1")
	   $access_token = $PushBullettoken
	   $oHTTP.Open("Get", "https://api.pushbullet.com/v2/devices?active=true", False)
	   $oHTTP.SetCredentials($access_token, "", 0)
	   $oHTTP.SetRequestHeader("Content-Type", "application/json")
	   $oHTTP.Send()
	   $Result = $oHTTP.ResponseText
	   Local $iden = _StringBetween($Result, '"iden":"', '"', "", False)
	   Local $nickname = _StringBetween($Result, '"nickname":"', '"', "", False)
	   If IsArray($iden) = False Then Return

	   For $x = 0 to Ubound($iden) - 1
			if $nickname[$x] = GUICtrlRead($cmbPushDevice_vip) Then
				$PBdevice = $iden[$x]
			EndIf
	   Next
   EndIf
EndFunc   ;==>_FindDevice

Func _Push($pTitle, $pMessage)
	$oHTTP = ObjCreate("WinHTTP.WinHTTPRequest.5.1")
	$access_token = $PushBullettoken
	$oHTTP.Open("Post", "https://api.pushbullet.com/v2/pushes", False)
	$oHTTP.SetCredentials($access_token, "", 0)
	$oHTTP.SetRequestHeader("Content-Type", "application/json")
	Local $pPush = '{"type": "note", "title": "' & $pTitle & '", "body": "' & $pMessage & '", "device_iden": "' & $PBdevice & '"}'
	$oHTTP.Send($pPush)
	KeepMessages($PushBulletmessages)
EndFunc   ;==>_Push

Func _PushFile($File, $Folder, $FileType, $title, $body)
	$oHTTP = ObjCreate("WinHTTP.WinHTTPRequest.5.1")
	$access_token = $PushBullettoken
	$oHTTP.Open("Post", "https://api.pushbullet.com/v2/upload-request", False)
	$oHTTP.SetCredentials($access_token, "", 0)
	$oHTTP.SetRequestHeader("Content-Type", "application/json")

	Local $pPush = '{"file_name": "' & $File & '", "file_type": "' & $FileType & '"}'
	$oHTTP.Send($pPush)
	$Result = $oHTTP.ResponseText
	$Result1 = $Result
	Local $upload_url = _StringBetween($Result, 'upload_url":"', '"')
	Local $awsaccesskeyid = _StringBetween($Result, 'awsaccesskeyid":"', '"')
	Local $acl = _StringBetween($Result, 'acl":"', '"')
	Local $key = _StringBetween($Result, 'key":"', '"')
	Local $signature = _StringBetween($Result, 'signature":"', '"')
	Local $policy = _StringBetween($Result, 'policy":"', '"')
	Local $file_url = _StringBetween($Result, 'file_url":"', '"')

	If $upload_url[0] = "" Or $awsaccesskeyid[0] = "" Or $acl[0] = "" Or $key[0] = "" Or $signature[0] = "" Or $policy[0] = "" Or $file_url[0] = "" Then
		SetLog("Something went wrong during upload authorization")
		Return
	Else
		$Result = RunWait(@ScriptDir & "\Others\curl\curl.exe -i -X POST " & $upload_url[0] & ' -F awsaccesskeyid="' & $awsaccesskeyid[0] & '" -F acl="' & $acl[0] & '" -F key="' & $key[0] & '" -F signature="' & $signature[0] & '" -F policy="' & $policy[0] & '" -F content-type="' & $FileType & '" -F file=@"' & @ScriptDir & '\' & $Folder & '\' & $File & '" -o "' & @ScriptDir & '\Profile\Logs\curl.log"', "", @SW_HIDE)
	EndIf

	If GUICtrlRead($chkPushBulletDebug_vip) = $GUI_CHECKED Then
		SetLog('=========================================================================')
		SetLog($Result)
		SetLog($upload_url[0])
		SetLog($acl[0])
		SetLog($key[0])
		SetLog($signature[0])
		SetLog($policy[0])
		SetLog($awsaccesskeyid[0])
		SetLog($file_url[0])
		SetLog($Result1)
		SetLog(@ScriptDir & "\Others\curl\curl.exe -i -X POST " & $upload_url[0] & ' -F awsaccesskeyid="' & $awsaccesskeyid[0] & '" -F acl="' & $acl[0] & '" -F key="' & $key[0] & '" -F signature="' & $signature[0] & '" -F policy="' & $policy[0] & '" -F content-type="' & $FileType & '" -F file=@"' & @ScriptDir & '\' & $Folder & '\' & $File & '" -o "' & @ScriptDir & '\Profile\Logs\curl.log"')
	EndIf
	If _FileCountLines(@ScriptDir & '\Profile\Logs\curl.log') > 8 Then
		Local $hFileOpen = FileOpen(@ScriptDir & '\Profile\Logs\curl.log')
		Local $sFileRead = FileReadLine($hFileOpen, 8)
		Local $sFileRead1 = StringSplit($sFileRead, " ")
		Local $sLink = $sFileRead1[2]
		Local $findstr1 = StringRegExp($sLink, 'https://')
	Else
		SetLog("Problem encountered while uploading file.")
		Return
	EndIf

	If $findstr1 = 1 Then
		$oHTTP.Open("Post", "https://api.pushbullet.com/v2/pushes", False)
		$oHTTP.SetCredentials($access_token, "", 0)
		$oHTTP.SetRequestHeader("Content-Type", "application/json")
		;Local $pPush = '{"type": "file", "file_name": "' & $FileName & '", "file_type": "' & $FileType & '", "file_url": "' & $file_url[0] & '", "title": "' & $title & '", "body": "' & $body & '"}'
		Local $pPush = '{"type": "file", "file_name": "' & $File & '", "file_type": "' & $FileType & '", "file_url": "' & $sLink & '", "title": "' & $title & '", "body": "' & $body & '", "device_iden": "' & $PBdevice & '"}'
		$oHTTP.Send($pPush)
		$Result = $oHTTP.ResponseText
	Else
		If GUICtrlRead($chkPushBulletDebug_vip) = $GUI_CHECKED Then
			SetLog($hFileOpen)
			SetLog("There is an error and file was not uploaded")
		EndIf
	EndIf
	If GUICtrlRead($chkPushBulletDebug_vip) = $GUI_CHECKED Then
		SetLog($Result)
		SetLog("You can paste this in the forum so we can check whether it is PushBullet problem or mine")
		SetLog('=========================================================================')
	EndIf
	KeepMessages($PushBulletmessages)
EndFunc   ;==>_PushFile

Func _DeletePush()
	$oHTTP = ObjCreate("WinHTTP.WinHTTPRequest.5.1")
	$access_token = $PushBullettoken
	$oHTTP.Open("Delete", "https://api.pushbullet.com/v2/pushes", False)
	$oHTTP.SetCredentials($access_token, "", 0)
	$oHTTP.SetRequestHeader("Content-Type", "application/json")
	$oHTTP.Send()
EndFunc   ;==>_DeletePush

Func _DeleteMessage($iden)
	$oHTTP = ObjCreate("WinHTTP.WinHTTPRequest.5.1")
	$access_token = $PushBullettoken
	$oHTTP.Open("Delete", "https://api.pushbullet.com/v2/pushes/" & $iden, False)
	$oHTTP.SetCredentials($access_token, "", 0)
	$oHTTP.SetRequestHeader("Content-Type", "application/json")
	$oHTTP.Send()
EndFunc   ;==>_DeleteMessage
