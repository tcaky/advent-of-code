
$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$DataFilePath = Split-Path $ScriptPath 
$InputData = Get-Content -Path (Join-Path $DataFilePath 'aoc-2022-06-puzzle-input.txt') -Encoding Default


# $InputData = @(
#     'mjqjpqmgbljsphdztnvjfqwrcgsmlb', # 7
#     'bvwbjplbgvbhsrlpgdmjqwftvncz', # 5
#     'nppdvjthqldpwncqszvftbrmjlhg', # 6
#     'nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg', # 10
#     'zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw' # 11
# )

$Hash = New-Object System.Collections.Hashtable

Function Get-CharacterCountToStartOfPacketMarker
{
    Param(
        [string]$InStr
    )
    For($i = 3; $i -lt $InStr.Length; $i++)
    {
        $Hash.Clear()
        $Hash[$InStr[$i-3]]++
        $Hash[$InStr[$i-2]]++
        $Hash[$InStr[$i-1]]++
        $Hash[$InStr[$i]]++

        # Write-Output ("i: {0} str: '{1}{2}{3}{4}' hash count: {5}" -f $i, $InStr[$i-3],$InStr[$i-2],$InStr[$i-1],$InStr[$i], $Hash.Count)
        If($Hash.Count -eq 4)
        {
            # this is the place.
            Write-Host "For the input the count is: $($i+1)"
            break
        }

    }
}
# $Ara | ForEach-Object {Get-CharacterCountToStartOfPacketMarker -InStr $_}
Get-CharacterCountToStartOfPacketMarker -InStr $InputData