$InData = Get-Content -Path C:\Temp\aoc-2022-04-puzzle-input.txt -Encoding Default
$Ctr = 0


Function Unpack-Row
{
    Param(
        [string]$Row,
        [ref]$LeftLow,
        [ref]$LeftHigh,
        [ref]$RightLow,
        [ref]$RightHigh
    )
    $Split = $Row -split ','
    $Left = $Split[0] -split '-'
    $Right = $Split[1] -split '-'
    $LeftLow.Value = $Left[0]
    $LeftHigh.Value = $Left[1]
    $RightLow.Value = $Right[0]
    $RightHigh.Value = $Right[1]
}

[int]$LeftLow = 0
[int]$LeftHigh = 0
[int]$RightLow = 0
[int]$RightHigh = 0


$TestAra = @(
    '2-4,6-8',
    '2-3,4-5',
    '5-7,7-9',
    '2-8,3-7',
    '6-6,4-6',
    '2-6,4-8'
)


ForEach($Row in $InData)
{
    Unpack-Row -Row $Row -LeftLow ([ref]$LeftLow) -LeftHigh ([ref]$LeftHigh) -RightLow ([ref]$RightLow) -RightHigh ([ref]$RightHigh)
    If(
        ($LeftLow -ge $RightLow -and $LeftLow -le $RightHigh) -or
        ($LeftHigh -ge $RightLow -and $LeftHigh -le $RightHigh) -or
        ($RightLow -ge $LeftLow -and $RightLow -le $LeftHigh) -or
        ($RightHigh -ge $LeftLow -and $RightHigh -le $LeftHigh) 
    )
    {
        # Write-Host ("{0}-{1},{2}-{3}" -f $LeftLow, $LeftHigh, $RightLow, $RightHigh) -BackgroundColor DarkCyan
        $Ctr++
    }
}

$Ctr


