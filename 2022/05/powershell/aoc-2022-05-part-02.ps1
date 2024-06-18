# Read input
$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$DataFilePath = Split-Path $ScriptPath 
$InputData = Get-Content -Path (Join-Path $DataFilePath 'aoc-2022-05-puzzle-input.txt') -Encoding Default


# $InputData= @(
#     '    [D]    ',
#     '[N] [C]    ',
#     '[Z] [M] [P]',
#     ' 1   2   3 ',
#     '',
#     'move 1 from 2 to 1',
#     'move 3 from 1 to 3',
#     'move 2 from 2 to 1'
#     'move 1 from 1 to 2'
# )

# Initialize variables
$Header = @()
$AraOfStacks = New-Object System.Collections.ArrayList

ForEach($Row in $InputData)
{
    If([String]::IsNullOrEmpty($Row))
    {
        break
    }
    $Header += $Row
}

# Find the number of stacks
$NumberOfStacks = ($Header[-1] -split '\s+' | Where-Object { $_ -match '^\d+$' }).Count

# Initialize empty stacks
For ($i = 0; $i -lt $NumberOfStacks; $i++) 
{
    $AraOfStacks.Add([System.Collections.Stack]::new())
}

# Write-Host "There are $($AraOfStacks.Count) stacks."

If($AraOfStacks.Count -ne $NumberOfStacks)
{
    Write-Error "Array of stacks initalized incorrectly!" -ErrorAction Stop
}

Function Get-Letter
{
    Param(
        [string]$InStr
    )
    If($InStr -match '\[(\w)\]')
    {
        return $matches[1]
    }

}

# Populate stacks from bottom to top
For ($i = $Header.Length - 2; $i -ge 0; $i--) 
{
    $Row = $Header[$i]
    $Regex = '(.{3})\s?' * $NumberOfStacks

    If($Row -match $Regex)
    {
        For ($j = 0; $j -lt $NumberOfStacks; $j++) 
        {
            $item = $matches[$j + 1].Trim()
            #$item
            $Letter = Get-Letter -InStr $item
            
            If(-not [String]::IsNullOrEmpty($Letter))
            {
                $AraOfStacks[$j].Push($Letter)
            }
        }
    }
}





Function Move-StackValues
{
    Param(
        [int]$NumberToMove,
        [ref]$FromStack,
        [ref]$ToStack
    )
    $TmpStack = [System.Collections.Stack]::new()
    For($i = 0; $i -lt $NumberToMove; $i++)
    {
        $TmpStack.Push($FromStack.Value.Pop())
    }
    For($i = 0; $i -lt $NumberToMove; $i++)
    {
        $ToStack.Value.Push($TmpStack.Pop())
    }
}



# 'move 3 from 8 to 9' -match '^move (\d{1,2}) from (\d{1,2}) to (\d{1,2})$'

# InputData | Select-Object -Skip $NumberOfStacks -First 3
ForEach($Row in ($InputData | Select-Object -Skip $NumberOfStacks))
{
    if ($Row -match '^move (\d{1,2}) from (\d{1,2}) to (\d{1,2})$') {
        $NumberToMove = [int]$matches[1]
        $FromStackIndex = [int]$matches[2] - 1  # Adjust for 0-based index
        $ToStackIndex = [int]$matches[3] - 1    # Adjust for 0-based index

        $Splat = @{
            NumberToMove = $NumberToMove
            FromStack = [ref]$AraOfStacks[$FromStackIndex]
            ToStack = [ref]$AraOfStacks[$ToStackIndex]
        }
        Move-StackValues @Splat
    }
}

# Output stack contents
For ($i = 0; $i -lt $AraOfStacks.Count; $i++) {
    Write-Host "Stack $($i + 1): '$($AraOfStacks[$i] -join ', ')'"
}
