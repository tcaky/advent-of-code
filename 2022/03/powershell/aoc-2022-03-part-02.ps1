
$InData = @"
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
"@
$InData = $InData -split "\r\n"

$InData = Get-Content -Path C:\Temp\aoc-2022-03-puzzle-input.txt -Encoding Default


# a-z in ascii is 97 - 122
# A-Z in ascii is 65 - 90
$AlphaMap = @{}

# add lower case
ForEach($Val in 97..122)
{
    $Key = ([char]$Val)
    $AlphaMap[$Key] = $Val - 96
}
# add upper case
ForEach($Val in 65..90)
{
    $Key = ([char]$Val)
    $AlphaMap[$Key] = $Val - 38
}


$Sum = 0
For($RuckCtr = 0; $RuckCtr -lt $InData.Count; $RuckCtr+=3)
{
    
    $Ruck1 = [System.Collections.ArrayList]($InData[$RuckCtr] -split '' | Sort-Object -Unique -CaseSensitive)
    $Ruck1.AddRange([System.Collections.ArrayList]($InData[$RuckCtr + 1] -split '' | Sort-Object -Unique -CaseSensitive))
    $Ruck1.AddRange([System.Collections.ArrayList]($InData[$RuckCtr + 2] -split '' | Sort-Object -Unique -CaseSensitive))

    $Selected =  ($Ruck1 | Where-Object {$_ -ne ''} `
        | Group-Object -CaseSensitive -NoElement `
        | Where-Object -Property Count -EQ 3 | `
        Select -ExpandProperty Name) -join ''

    $Sum += $AlphaMap[([char]$Selected)]
}


$Sum


