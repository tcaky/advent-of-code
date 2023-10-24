$InData = Get-Content -Path C:\Temp\aoc-2022-02-input-data.txt -Encoding Default

#$InData = @("A Y","B X","C Z")

Enum P1
{
    A = 1 # rock
    B = 2 # paper
    C = 3 # scissors
}
Enum P2
{
    Y = 2 # paper
    X = 1 # rock
    Z = 3 # scissors
}

Enum ScoreType
{
    Win = 6
    Draw = 3
    Loss = 0
}


Function Get-LossValue
{
    Param(
        [P1]$P1
    )
    $RetVal = If($P1 -eq 'A'){[P2]::Z.value__}
    ElseIf($P1 -eq 'B'){[P2]::X.value__}
    ElseIf($P1 -eq 'C'){[P2]::Y.value__}
    $RetVal
}

Function Get-TieValue
{
    Param(
        [P1]$P1
    )
    $RetVal = If($P1 -eq 'A'){[P2]::X.value__}
    ElseIf($P1 -eq 'B'){[P2]::Y.value__}
    ElseIf($P1 -eq 'C'){[P2]::Z.value__}
    $RetVal
}

Function Get-WinValue
{
    Param(
        [P1]$P1
    )
    $RetVal = If($P1 -eq 'A'){[P2]::Y.value__}
    ElseIf($P1 -eq 'B'){[P2]::Z.value__}
    ElseIf($P1 -eq 'C'){[P2]::X.value__}
    $RetVal
}



$Result = 0

ForEach($Item in $InData){
    $out = $Item -split ' '

    Switch($out[1])
    {
        # must lose
        'X' 
        {
            $Result += [ScoreType]::Loss.value__ + (Get-LossValue -P1 $out[0])
            continue
        }

        # must draw
        'Y'
        {
            $Result += [ScoreType]::Draw.value__ + (Get-TieValue -P1 $out[0])
            continue
        }
        # must win
        'Z'
        {
            $Result += [ScoreType]::Win.value__ + (Get-WinValue -P1 $out[0])
            continue
        }
    }
}

$Result