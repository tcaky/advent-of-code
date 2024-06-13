$InData = Get-Content -Path C:\Temp\aoc-2022-04-puzzle-input.txt -Encoding Default
$Ctr = 0
# 14-28,13-28
# 72-81,82-91
# 18-18,18-55
# 7-98,7-98
# 1-20,2-19
# 3-17,1-2

ForEach($Row in $Indata)
{
    # $Row -match '^(\d{1,2})-(\d{1,2}),(\d{1,2})-(\d{1,2})$' | Out-Null
    $Split = $Row -split ','
    $Left = $Split[0] -split '-'
    $Right = $Split[1] -split '-'
    If(
        ([int]$Left[0] -ge [int]$Right[0] -and [int]$Left[1] -le [int]$Right[1] ) -or
        ([int]$Right[0] -ge [int]$Left[0] -and [int]$Right[1] -le [int]$Left[1] )
    )
    {
        Write-Host "$Row"
        $Ctr++
    }
}

$Ctr


