$InData = Get-Content -Path C:\Temp\aoc-01.txt -Encoding Default
$Accumulator = @{}
$AccumulatorIdx = 0
For($x = 0; $X -le $InData.Count;$x++)
{
    If([string]::IsNullOrWhiteSpace($InData[$x]))
    {
        #Write-Host "blank line"
        $AccumulatorIdx++
        Continue
    }
    $Accumulator[$AccumulatorIdx] += [Int]::Parse($InData[$x])
}

# part 1
$Accumulator.Values | Measure-Object -Maximum | Select Maximum

# part 2
$Accumulator.Values | Sort-Object -Descending | Select-Object -First 3 | Measure-Object -Sum