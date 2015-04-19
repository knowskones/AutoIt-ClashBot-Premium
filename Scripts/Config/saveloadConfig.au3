Func btnLoadConfig($configfile)
	Local $sFileOpenDialog = FileOpenDialog("Open config", @ScriptDir & "\Profile\", "Config (*.ini;)", $FD_FILEMUSTEXIST)

	If @error Then
		MsgBox($MB_SYSTEMMODAL, "", "Error opening file!")
		FileChangeDir(@ScriptDir & "\Profile\")
	Else
		FileChangeDir(@ScriptDir & "\Profile\")
		$sFileOpenDialog = StringReplace($sFileOpenDialog, "|", @CRLF)
		$config = $sFileOpenDialog
		readConfig()
		applyConfig()
		$config = @ScriptDir & "\Profile\Config.ini"
		saveConfig()
		MsgBox($MB_SYSTEMMODAL, "", "Config loaded successfully!" & @CRLF & $sFileOpenDialog)
	EndIf
EndFunc   ;==>btnLoadConfig


Func btnSaveConfig($configfile)
	Local $sFileSaveDialog = FileSaveDialog("Save current config as..", @ScriptDir & "\Profile\", "Config (*.ini)", $FD_PATHMUSTEXIST)

	If @error Then
		MsgBox($MB_SYSTEMMODAL, "", "Config save failed!")
	Else
		Local $sFileName = StringTrimLeft($sFileSaveDialog, StringInStr($sFileSaveDialog, "\", $STR_NOCASESENSE, -1))
		Local $iExtension = StringInStr($sFileName, ".", $STR_NOCASESENSE)

		If $iExtension Then
			If Not (StringTrimLeft($sFileName, $iExtension - 1) = ".ini") Then $sFileSaveDialog &= ".ini"
		Else
			$sFileSaveDialog &= ".ini"
		EndIf

		Local $configUsername = IniRead($config, "login", "username", "")
		Local $configSaveUsername = IniRead($config, "login", "saveUsername", 0)
		$config = $sFileSaveDialog
		saveConfig()
		IniWrite($config, "login", "saveUsername", $configSaveUsername)
		IniWrite($config, "login", "username", $configUsername)
		$config = @ScriptDir & "\Profile\Config.ini"
		MsgBox($MB_SYSTEMMODAL, "", "Successfully saved the current configuration!" & @CRLF & $sFileSaveDialog)
	EndIf
EndFunc   ;==>btnSaveConfig


Func getfilename($psFilename)
	Local $szDrive, $szDir, $szFName, $szExt
	_PathSplit($psFilename, $szDrive, $szDir, $szFName, $szExt)
	Return $szFName & $szExt
EndFunc   ;==>getfilename
