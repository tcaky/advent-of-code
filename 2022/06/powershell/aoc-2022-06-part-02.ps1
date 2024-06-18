
$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$DataFilePath = Split-Path $ScriptPath 
$InputData = Get-Content -Path (Join-Path $DataFilePath 'aoc-2022-06-puzzle-input.txt') -Encoding Default


# $InputData = @(
#     'mjqjpqmgbljsphdztnvjfqwrcgsmlb', # 19
#     'bvwbjplbgvbhsrlpgdmjqwftvncz', # 23
#     'nppdvjthqldpwncqszvftbrmjlhg', # 23
#     'nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg', # 29
#     'zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw' # 26
# )

$Hash = New-Object System.Collections.Hashtable

Function Get-CharacterCountToStartOfPacketMarker
{
    Param(
        [string]$InStr
    )
    For($i = 13; $i -lt $InStr.Length; $i++)
    {
        $Hash.Clear()
        For($j = 13; $j -ge 0; $j--)
        {
            $Hash[$InStr[$i-$j]]++
        }

        # Write-Output ("i: {0} str: '{1}{2}{3}{4}' hash count: {5}" -f $i, $InStr[$i-3],$InStr[$i-2],$InStr[$i-1],$InStr[$i], $Hash.Count)
        If($Hash.Count -eq 14)
        {
            # this is the place.
            Write-Host "For the input the count is: $($i+1)"
            break
        }

    }
}
$InputData | ForEach-Object {Get-CharacterCountToStartOfPacketMarker -InStr $_}
# Get-CharacterCountToStartOfPacketMarker -InStr $InputData