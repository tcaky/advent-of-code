
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


$Matches = New-Object System.Collections.ArrayList
$Sum = 0
ForEach($Line in $InData)
{
    #Write-Host "The line is: '$Line'"
    $HalfIdx = $Line.Length/2
    $LeftAra = ($Line.Substring(0,$HalfIdx) -split '' | Sort-Object -Unique -CaseSensitive).ToCharArray()
    $RightAra = ($Line.Substring($HalfIdx) -split '' | Sort-Object -Unique -CaseSensitive).ToCharArray()

    ForEach($Letter in $LeftAra)
    {
        If($RightAra.Contains($Letter) -and $Letter -ne ''.ToCharArray())
        {
            #$Matches.Add($Letter)
            #Write-Host "match found for '$Letter' and the AlphaMap lookup is: '$($AlphaMap[$Letter])'"
            #Write-Host ("Original Line: '$Line'")
            #Write-Host ("Left String: {0} :: Right string {1}" -f ($Line.Substring(0,$HalfIdx)), ($Line.Substring($HalfIdx)))
            #Write-Host ("Left String: {0} :: Right string {1}" -f ($LeftAra -join ''), ($RightAra -join ''))
            $Sum += $AlphaMap[$Letter]
        }
    }
}
$Sum

