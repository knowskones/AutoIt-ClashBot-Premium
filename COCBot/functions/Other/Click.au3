Func Click($x, $y, $times = 1, $speed = 0, $CenteredOn = 0)
	If $CenteredOn = 0 Then
	If $times <> 1 Then
		For $i = 0 To ($times - 1)
			ControlClick($Title, "", "", "primary", "1", $x, $y)
			If _Sleep($speed) Then ExitLoop
		Next
	Else
			ControlClick($Title, "", "", "primary", "1", $x, $y)
		EndIf
	Else
		If $ichkAvoidEdge = 1 Then
			If $CenteredOn = $AimCenter Then
				$AimX = Round((($Grid[42][42][0] - $Grid[0][0][0]) / 2) + $Grid[0][0][0])
				$AimY = Round((($Grid[42][42][1] - $Grid[0][0][1]) / 2) + $Grid[0][0][1])
			ElseIf $CenteredOn = $AimTH Then
				$AimX = $THx
				$AimY = $THy
			Else
				SetLog("Bad call, unknown where to center attack")
				Return
			EndIf
			For $i=0 to 41
				For $j=0 to 41
					If ($Grid[$i][$j][2]>0 and $Grid[$i][$j+1][2]>0) Then ; Up and to the right edges
						If (($x < $Grid[$i][$j+1][0]) and ($Grid[$i][$j][0] < $AimX)) Or (($x > $Grid[$i][$j][0]) and ($Grid[$i][$j+1][0] > $AimX)) Then
							If (($y < $Grid[$i][$j][1]) and ($Grid[$i][$j+1][1] < $AimY)) Or (($y > $Grid[$i][$j+1][1]) and ($Grid[$i][$j][1] > $AimY)) Then
								$A1 = $AimY - $y
								$B1 = $x - $AimX
								$C1 = ($A1 * $x) + ($B1 * $y)
								$A2 = $Grid[$i][$j+1][1] - $Grid[$i][$j][1]
								$B2 = $Grid[$i][$j][0] - $Grid[$i][$j+1][0]
								$C2 = ($A2 * $Grid[$i][$j][0]) + ($B2 * $Grid[$i][$j][1])
								If $A1*$B2 <> $A2*$B1 Then
									$IntX = ($B2 * $C1 - $B1 * $C2)/($A1 * $B2 - $A2 * $B1)
									If $Grid[$i][$j][0] < $IntX and $IntX < $Grid[$i][$j+1][0] Then
										; They cross, so lets make intersection the new aimed point
										$AimX = ($B2 * $C1 - $B1 * $C2)/($A1 * $B2 - $A2 * $B1)
										$AimY = ($A1 * $C2 - $A2 * $C1)/($A1 * $B2 - $A2 * $B1)
									EndIf
								EndIf
							EndIf
						EndIf
					EndIf
					If ($Grid[$i][$j][2]>0 and $Grid[$i+1][$j][2]>0) Then ; Down and to the right edges
						If (($x < $Grid[$i+1][$j][0]) and ($Grid[$i][$j][0] < $AimX)) Or (($x > $Grid[$i][$j][0]) and ($Grid[$i+1][$j][0] > $AimX)) Then
							If (($y < $Grid[$i+1][$j][1]) and ($Grid[$i][$j][1] < $AimY)) Or (($y > $Grid[$i][$j][1]) and ($Grid[$i+1][$j][1] > $AimY)) Then
								$A1 = $AimY - $y
								$B1 = $x - $AimX
								$C1 = ($A1 * $x) + ($B1 * $y)
								$A2 = $Grid[$i+1][$j][1] - $Grid[$i][$j][1]
								$B2 = $Grid[$i][$j][0] - $Grid[$i+1][$j][0]
								$C2 = ($A2 * $Grid[$i][$j][0]) + ($B2 * $Grid[$i][$j][1])
								If $A1*$B2 <> $A2*$B1 Then
									$IntX = ($B2 * $C1 - $B1 * $C2)/($A1 * $B2 - $A2 * $B1)
									If $Grid[$i][$j][0] < $IntX and $IntX < $Grid[$i+1][$j][0] Then
										; They cross, so lets make intersection the new aimed point
										$AimX = ($B2 * $C1 - $B1 * $C2)/($A1 * $B2 - $A2 * $B1)
										$AimY = ($A1 * $C2 - $A2 * $C1)/($A1 * $B2 - $A2 * $B1)
									EndIf
								EndIf
							EndIf
						EndIf
					EndIf
				Next
			Next
			$j=42
			For $i=0 to 41
				If ($Grid[$i][$j][2]>0 and $Grid[$i+1][$j][2]>0) Then ; Down and to the right edges
					If (($x < $Grid[$i+1][$j][0]) and ($Grid[$i][$j][0] < $AimX)) Or (($x > $Grid[$i][$j][0]) and ($Grid[$i+1][$j][0] > $AimX)) Then
						If (($y < $Grid[$i+1][$j][1]) and ($Grid[$i][$j][1] < $AimY)) Or (($y > $Grid[$i][$j][1]) and ($Grid[$i+1][$j][1] > $AimY)) Then
							$A1 = $AimY - $y
							$B1 = $x - $AimX
							$C1 = ($A1 * $x) + ($B1 * $y)
							$A2 = $Grid[$i+1][$j][1] - $Grid[$i][$j][1]
							$B2 = $Grid[$i][$j][0] - $Grid[$i+1][$j][0]
							$C2 = ($A2 * $Grid[$i][$j][0]) + ($B2 * $Grid[$i][$j][1])
							If $A1*$B2 <> $A2*$B1 Then
								$IntX = ($B2 * $C1 - $B1 * $C2)/($A1 * $B2 - $A2 * $B1)
								If $Grid[$i][$j][0] < $IntX and $IntX < $Grid[$i+1][$j][0] Then
									; They cross, so lets make intersection the new aimed point
									$AimX = ($B2 * $C1 - $B1 * $C2)/($A1 * $B2 - $A2 * $B1)
									$AimY = ($A1 * $C2 - $A2 * $C1)/($A1 * $B2 - $A2 * $B1)
								EndIf
							EndIf
						EndIf
					EndIf
				EndIf
			Next
			$i=42
			For $j=0 to 41
				If ($Grid[$i][$j][2]>0 and $Grid[$i][$j+1][2]>0) Then ; Up and to the right edges
					If (($x < $Grid[$i][$j+1][0]) and ($Grid[$i][$j][0] < $AimX)) Or (($x > $Grid[$i][$j][0]) and ($Grid[$i][$j+1][0] > $AimX)) Then
						If (($y < $Grid[$i][$j][1]) and ($Grid[$i][$j+1][1] < $AimY)) Or (($y > $Grid[$i][$j+1][1]) and ($Grid[$i][$j][1] > $AimY)) Then
							$A1 = $AimY - $y
							$B1 = $x - $AimX
							$C1 = ($A1 * $x) + ($B1 * $y)
							$A2 = $Grid[$i][$j+1][1] - $Grid[$i][$j][1]
							$B2 = $Grid[$i][$j][0] - $Grid[$i][$j+1][0]
							$C2 = ($A2 * $Grid[$i][$j][0]) + ($B2 * $Grid[$i][$j][1])
							If $A1*$B2 <> $A2*$B1 Then
								$IntX = ($B2 * $C1 - $B1 * $C2)/($A1 * $B2 - $A2 * $B1)
								If $Grid[$i][$j][0] < $IntX and $IntX < $Grid[$i][$j+1][0] Then
									; They cross, so lets make intersection the new aimed point
									$AimX = ($B2 * $C1 - $B1 * $C2)/($A1 * $B2 - $A2 * $B1)
									$AimY = ($A1 * $C2 - $A2 * $C1)/($A1 * $B2 - $A2 * $B1)
								EndIf
							EndIf
						EndIf
					EndIf
				EndIf
			Next
			; Now we are sitting right on top of the edge so let's move back a bit
			$m = ($AimY - $y)/($AimX - $x)
			$Dist = _Random_Gaussian(15,3)
			$deltaX = (($Dist^2)/(1+$m^2))^.5
			If $AimX > $x Then $deltaX=$deltaX*-1
			If Abs($x-$AimX) < Abs($deltaX) Then
				$AimX=Round($x)
				$AimY=Round($y)
			Else
				$AimX = Round($AimX + $deltaX)
				$AimY = Round($AimY + $m * $deltaX)
			EndIf
			If $times <> 1 Then
				For $i = 0 To ($times - 1)
					ControlClick($Title, "", "", "primary", "1", $AimX, $AimY)
					If _Sleep($speed, False) Then ExitLoop
				Next
			Else
				ControlClick($Title, "", "", "primary", "1", $AimX, $AimY)
			EndIf
		Else
			If $times <> 1 Then
				For $i = 0 To ($times - 1)
					ControlClick($Title, "", "", "primary", "1", $x, $y)
					If _Sleep($speed, False) Then ExitLoop
				Next
			Else
				ControlClick($Title, "", "", "primary", "1", $x, $y)
			EndIf
		EndIf
	EndIf
EndFunc   ;==>Click

; ClickP : takes an array[2] (or array[4]) as a parameter [x,y]
Func ClickP($point, $howMuch = 1, $speed = 0)
	Click($point[0], $point[1], $howMuch, $speed)
EndFunc   ;==>ClickP
