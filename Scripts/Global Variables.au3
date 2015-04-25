#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <FileConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <GUIEdit.au3>
#include <GUIComboBox.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <WindowsConstants.au3>
#include <WinAPIProc.au3>
#include <ScreenCapture.au3>
#include <Date.au3>
#include <Misc.au3>
#include <File.au3>
#include <TrayConstants.au3>
#include <GUIMenu.au3>
#include <ColorConstants.au3>
#include <GDIPlus.au3>
#include <GuiRichEdit.au3>
#include <GuiTab.au3>

Global Const $COLOR_ORANGE = 0xFFA500

Global $Compiled
If @Compiled Then
	$Compiled = "Executable"
Else
	$Compiled = "Au3 Script"
EndIf

Global $hBitmap; Image for pixel functions
Global $hHBitmap; Handle Image for pixel functions
Global $hAttackBitmap
Global $Buffer

Global $Title = "BlueStacks App Player" ; Name of the Window
Global $HWnD = WinGetHandle($Title) ;Handle for Bluestacks window
Global $statLog, $tiAbout, $tiExit
Global $unregPopup = True
Global $LoginType = 0 ; 0-unregistered, 1-registered, 2-vip
Global $bSaveLogin, $sUsername, $sPassword
Global $vipControls[1]

Global $config = @ScriptDir & "\Profile\Config.ini"
Global $dirLogs = @ScriptDir & "\Profile\Logs\"
Global $dirLoots = @ScriptDir & "\Profile\Loots\"
Global $dirAllTowns = @ScriptDir & "\Profile\AllTowns\"
Global $dirDarkStorages = @ScriptDir & "\Profile\DarkStorages\"
Global $dirScreenCapture = @ScriptDir & "\Profile\ScreenCapture\"
Global $sLogPath ; `Will create a new log file every time the start button is pressed
Global $hLogFileHandle
Global $Restart = False
Global $RunState = False
Global $AttackNow = False
Global $AllowPause = True
Global $AlertBaseFound = 0
Global $TakeLootSnapShot = 1
Global $TakeAllTownSnapShot = 0
Global $ichkWideEdge
Global $ichkRedLine
Global $ReqText

Global $iCollectCounter = 0 ; Collect counter, when reaches $COLLECTATCOUNT, it will collect
Global $COLLECTATCOUNT = 8 ; Run Collect() after this amount of times before actually collect
;---------------------------------------------------------------------------------------------------
Global $BSpos[2] ; Inside BlueStacks positions relative to the screen
;---------------------------------------------------------------------------------------------------
;Search Settings
Global $searchGold, $searchElixir, $searchDark, $searchTrophy, $searchDead, $searchTH ; Resources of bases when searching
Global $MinDeadGold, $MinDeadElixir, $MinDeadDark, $MinDeadTrophy, $MaxDeadTH, $MinGold, $MinElixir, $MinDark, $MinTrophy, $MaxTH ; Minimum Resources conditions
Global $chkConditions[10] ;Conditions (meet gold...)
Global $icmbTH, $icmbDeadTH, $icmbAny, $icmbDead
Global $THLocation
Global $THLevel
Global $Tolerance1 = 80
Global $THx = 0, $THy = 0
Global $THText[5] ; Text of each Townhall level
$THText[0] = "4-6"
$THText[1] = "7"
$THText[2] = "8"
$THText[3] = "9"
$THText[4] = "10"
Global $barracksError[4]
$barracksError[0] = False
$barracksError[1] = False
$barracksError[2] = False
$barracksError[3] = False
Global $SearchCount = 0 ;Number of searches
Global $THaddtiles, $THside, $THi

;Advance Search Settings
Global $ichkredDead, $itxtGoldRedDead, $itxtElixRedDead, $itxtDERedDead, $itxtTroRedDead, $itxtRedSearchDead, $itxtGoldElixRedDead
Global $ichkredAny, $itxtGoldRedAny, $itxtElixRedAny, $itxtDERedAny, $itxtTroRedAny, $itxtRedSearchAny, $itxtGoldElixRedAny

;Troop types
Global Enum $eBarbarian, $eArcher, $eGiant, $eGoblin, $eWallbreaker, $eBalloon, $eWizard, $eMinion, $eHog, $eValkyrie, $eKing, $eQueen, $eCastle, $eLSpell

;Attack Settings
; Shift outer corners 1 pixel for more random drop space
Global $TopLeft[5][2] = [[78, 280], [169, 204], [233, 161], [295, 114], [367, 65]]
Global $TopRight[5][2] = [[481, 62], [541, 103], [590, 145], [656, 189], [780, 277]]
Global $BottomLeft[5][2] = [[78, 343], [141, 390], [209, 447], [275, 493], [338, 540]]
Global $BottomRight[5][2] = [[524, 538], [596, 485], [655, 441], [716, 394], [780, 345]]
Global $FurthestTopLeft[5][2] = [[28, 314], [0, 0], [0, 0], [0, 0], [430, 9]]
Global $FurthestTopRight[5][2] = [[430, 9], [0, 0], [0, 0], [0, 0], [820, 313]]
Global $FurthestBottomLeft[5][2] = [[28, 314], [0, 0], [0, 0], [0, 0], [440, 612]]
Global $FurthestBottomRight[5][2] = [[440, 612], [0, 0], [0, 0], [0, 0], [820, 313]]
Global $Edges[4] = [$BottomRight, $TopLeft, $BottomLeft, $TopRight]

;Red border finding
Global $numEdges = 81
Global $EdgeColors[81][3] = [[218, 116, 44], [207, 97, 37], [199, 104, 41], [201, 119, 45], [193, 130, 47], _
		[203, 134, 55], [208, 138, 55], [211, 143, 59], [196, 128, 50], [195, 159, 38], [199, 143, 57], _
		[173, 124, 50], [214, 108, 40], [193, 101, 38], [211, 111, 44], [203, 112, 42], [123, 73, 26], _
		[143, 89, 31], [157, 100, 41], [180, 116, 45], [133, 82, 32], [125, 65, 20], [172, 117, 48], _
		[120, 92, 36], [106, 76, 30], [159, 105, 42], [172, 103, 40], [193, 124, 44], [189, 119, 46], _
		[206, 155, 64], [190, 137, 46], [187, 138, 56], [192, 155, 58], [203, 131, 47], [196, 147, 52], _
		[199, 140, 53], [193, 135, 52], [195, 159, 58], [196, 128, 50], [193, 136, 53], [211, 143, 59], _
		[203, 131, 47], [215, 142, 50], [205, 145, 53], [187, 129, 53], [151, 85, 34], [154, 75, 26], _
		[168, 80, 32], [105, 68, 20], [172, 117, 46], [193, 119, 47], [192, 111, 45], [126, 88, 34], _
		[165, 88, 29], [158, 71, 25], [166, 91, 34], [127, 59, 23], [212, 119, 47], [206, 119, 42], _
		[211, 119, 45], [200, 112, 41], [202, 108, 40], [180, 113, 39], [211, 119, 45], [202, 127, 49], _
		[168, 126, 46], [126, 50, 16], [165, 81, 27], [163, 74, 26], [207, 129, 53], [183, 129, 44], _
		[196, 139, 52], [180, 126, 48], [156, 81, 31], [142, 77, 28], [160, 104, 37], _
		[157, 83, 29], [128, 71, 25], [157, 80, 37], [158, 93, 33], [198, 115, 43]]
Global $Grid[43][43][3]
$Grid[0][0][0] = 35
$Grid[0][0][1] = 314
$Grid[42][0][0] = 429
$Grid[42][0][1] = 610
$Grid[0][42][0] = 429
$Grid[0][42][1] = 18
$Grid[42][42][0] = 824
$Grid[42][42][1] = 314
For $i = 1 To 41
	$Grid[$i][0][0] = ($Grid[$i - 1][0][0] + (($Grid[42][0][0] - $Grid[0][0][0]) / 42))
	$Grid[$i][0][1] = ($Grid[$i - 1][0][1] + (($Grid[42][0][1] - $Grid[0][0][1]) / 42))
	$Grid[$i][42][0] = ($Grid[$i - 1][42][0] + (($Grid[42][42][0] - $Grid[0][42][0]) / 42))
	$Grid[$i][42][1] = ($Grid[$i - 1][42][1] + (($Grid[42][42][1] - $Grid[0][42][1]) / 42))
Next
For $i = 0 To 42
	For $j = 1 To 41
		$Grid[$i][$j][0] = ($Grid[$i][0][0] + $j * (($Grid[$i][42][0] - $Grid[$i][0][0]) / 42))
		$Grid[$i][$j][1] = ($Grid[$i][0][1] + $j * (($Grid[$i][42][1] - $Grid[$i][0][1]) / 42))
	Next
Next
For $j = 0 To 42
	For $i = 0 To 42
		$Grid[$j][$i][0] = Round($Grid[$j][$i][0])
		$Grid[$j][$i][1] = Round($Grid[$j][$i][1])
	Next
Next
$EdgeLevel = 1
$AimCenter = 1
$AimTH = 2

Global $Unitdrop
Global $SlowDeploy, $DeploySpeed
Global $THquadrant

Global $atkTroops[9][2] ;9 Slots of troops -  Name, Amount
Global $fullArmy ;Check for full army or not

Global $deployDeadSettings ;Method of deploy found in attack settings
Global $icmbDeadAlgorithm ;Algorithm to use when attacking
Global $checkDeadUseKing ;King attack settings
Global $checkDeadUseQueen ;Queen attack settings
Global $checkDeadUseClanCastle ; Use Clan Castle settings
Global $icmbDeadAttackTH ; Attack Outside Townhall settings

Global $deploySettings ;Method of deploy found in attack settings
Global $icmbAlgorithm ;Algorithm to use when attacking
Global $checkUseKing ;King attack settings
Global $checkUseQueen ;Queen attack settings
Global $checkUseClanCastle ; Use Clan Castle settings
Global $icmbAttackTH ; Attack Outside Townhall settings
Global $icmbUnitDelay, $icmbWaveDelay, $iRandomspeedatk

Global $THLoc
Global $THquadrant
Global $ichkAvoidEdge, $chkAvoidEdge

Global $King, $Queen, $CC, $Barb, $Arch, $Balloon, $Wizard, $Minion, $Hog, $Valkyrie
Global $LeftTHx, $RightTHx, $BottomTHy, $TopTHy
Global $AtkTroopTH
Global $GetTHLoc

;Misc Settings
Global $itxtReconnect
Global $itxtReturnh
Global $itxtSearchsp
Global $itxtwhitecloud
Global $ichkTrap
Global $ichkCollect
Global $ichkRaxRestart
Global $itxtKingSkill ;Delay before activating King Skill
Global $itxtQueenSkill ;Delay before activating Queen Skill
Global $iSkillActivateCond ; Heroes ability timed or auto activated
Global $itxtSpellDarkStorage
Global $SpellDarkStorage
Global $ichkMultiLight
Global $DELocation, $DElixx = 0, $DElixy = 0
Global $LSpell
Global $CreateSpell = True
Global $ichkBoostRax1, $ichkBoostRax2, $ichkBoostRax3, $ichkBoostRax4, $ichkBoostDark1, $ichkBoostDark2, $ichkBoostKing, $ichkBoostQueen, $ichkBoostSpell
Global $DeBattleEnd
Global $ichkKeepLogs, $itxtKeepLogs

;Boosts Settings
Global $BoostAll
Global $remainingBoosts = 0 ;  remaining boost to active during session
Global $boostsEnabled = 1 ; is this function enabled

;Donate Settings
Global $CCPos[2] = [-1, -1] ;Position of clan castle
Global $CastleFull = False

Global $ichkRequest = 0 ;Checkbox for Request box
Global $itxtRequest = "" ;Request textbox

Global $ichkDonateAllBarbarians = 0
Global $ichkDonateBarbarians = 0
Global $itxtDonateBarbarians = ""

Global $ichkDonateAllArchers = 0
Global $ichkDonateArchers = 0
Global $itxtDonateArchers = ""

Global $ichkDonateAllGiants = 0
Global $ichkDonateGiants = 0
Global $itxtDonateGiants = ""

Global $itxtNotDonate = ""
Global $ichkBlacklist

;Troop Settings
Global $icmbRaidcap
Global $icmbTroopComp ;Troop Composition
Global $itxtcampCap
Global $ichkDarkTroop
Global $BarbariansComp
Global $ArchersComp
Global $GiantsComp
Global $GoblinsComp
Global $WBComp
Global $CurBarb, $CurArch, $CurGiant, $CurGoblin, $CurWB, $CurBalloon, $CurWizard, $CurMinion, $CurHog, $CurValkyrie
Global $ArmyComp
Global $WorkingBarracks = 0
Global $BarAvailable[4] = [True, True, True, True]
Global $TroopCount = 0
Global $TownHallPos[2] = [-1, -1] ;Position of TownHall
Global $barrackPos[4][2] ;Positions of each barracks
Global $barrackTroop[4] ;Barrack troop set
Global $DarkBarrackPos[2][2]
Global $DarkBarrackTroop[2]
Global $itxtDarkBarrack1, $itxtDarkBarrack2
Global $CustomTroopF[4]
Global $CustomTroopS[4]
Global $itxtFirstTroop[4]

Global $ArmyPos[2]
Global $KingPos[2]
Global $QueenPos[2]
Global $SFactoryPos[2]
Global $BuildPos1[2]
Global $BuildPos2[2]
Global $BuildPos3[2]

;Other Settings
Global $ichkWalls
Global $icmbWalls
Global $iUseStorage
Global $itxtWallMinGold, $itxtWallMinElixir
Global $itxtBldgMinGold, $itxtBldgMinElixir
Global $icmbTolerance
Global $itxtReconnect
Global $ichkUpgrade1, $ichkUpgrade2, $ichkUpgrade3
Global $itxtUpgradeX1, $itxtUpgradeY1, $itxtUpgradeX2, $itxtUpgradeY2, $itxtUpgradeX3, $itxtUpgradeY3
Global $iTimeTroops = 0
Global $iTimeGiant = 120
Global $iTimeWall = 120
Global $iTimeArch = 25
Global $iTimeGoblin = 35
Global $iTimeBarba = 20

;General Settings
Global $botPos[2] ; Position of bot used for Hide function
Global $frmBotPosX ; Position X of the GUI
Global $frmBotPosY ; Position Y of the GUI
Global $Hide = False ; If hidden or not
Global $themePath = @ScriptDir & "\Images\Skins\orange.msstyles" ; Path to load theme from
Global $iTheme

Global $ichkBotStop, $icmbBotCommand, $icmbBotCond, $icmbHoursStop
Global $CommandStop = -1
Global $MeetCondStop = False
Global $UseTimeStop = -1
Global $TimeToStop = -1

Global $itxtMinTrophy ; Trophy after drop
Global $itxtMaxTrophy ; Max trophy before drop trophy
Global $ichkBackground ; Background mode enabled disabled
Global $ichkForceBS = 0
Global $ichkNoAttack = 0, $ichkDonateOnly = 0
Global $collectorPos[17][2] ;Positions of each collectors

Global $break = @ScriptDir & "\images\break.bmp"
Global $device = @ScriptDir & "\images\device.bmp"

Global $GoldCount = 0, $ElixirCount = 0, $DarkCount = 0, $GemCount = 0, $FreeBuilder = 0
Global $resArmy = 0
Global $FirstAttack = 0
Global $CurTrophy = 0
Global $sTimer, $hour, $min, $sec
Global $CurCamp, $TotalCamp = 0
Global $NoLeague
Global $FirstStart = True
Global $FirstDarkTrain = True
Global $FirstTrain = True
Global $DCattack = False
Global $Checkrearm = True
Global $CheckDupGold1 = 0, $CheckDupElixir1 = 0, $CheckDupGold2 = 0, $CheckDupElixir2 = 0

;PushBullet
Global $GoldGained = 0, $ElixirGained = 0, $DarkGained = 0, $TrophyGained = 0
Global $GoldCountOld = 0, $ElixirCountOld = 0, $DarkCountOld = 0, $TrophyOld = 0
Global $PushBulletEnabled = 0
Global $PushBullettoken = ""
Global $PushBullettype = 0
Global $FileName = ""
Global $PushBulletvillagereport = 0
Global $PushBulletmatchfound = 0
Global $PushBulletlastraid = 0
Global $PushBullettotalraid = 0
Global $PushBulletdebug = 0
Global $PushBulletremote = 0
Global $PushBulletdelete = 0
Global $PushBulletbuilder = 0
Global $PushBulleterror = 0
Global $sLogFileName
Global $Raid = 0
Global $PushBulletinterval = 10
Global $PushBulletmessages = 100
Global $PBdevice = ""
Global $PushBulletDevice

;GoldCostPerSearch
Global $SearchCost = 0
Global $BuilderCountStart = 0

;Remote Control
Global $PauseBot = False

;Last Raid
Global $LastRaidGold = 0
Global $LastRaidElixir = 0
Global $LastRaidDarkElixir = 0
Global $LastRaidTrophy = 0

;Waitforpixel Control
Global $DonateTimeout = 1000
Global $DonateDelay = 100
Global $TrainTimeout = 800
Global $TrainDelay = 50

;Defense
Global $DefenseLoc, $Defensex = 0, $Defensey = 0