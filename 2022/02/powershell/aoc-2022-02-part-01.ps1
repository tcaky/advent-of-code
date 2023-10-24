$InData = Get-Content -Path C:\Temp\aoc-2022-02-input-data.txt -Encoding Default

#$Data = @("A Y","B X","C Z")

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

$Result = 0

ForEach($Item in $InData){
    $out = $Item -split ' '
    
    If(
        ($out[0] -eq 'A' -and $out[1] -eq 'Y') -or # paper (Y) beats rock (A) 
        ($out[0] -eq 'B' -and $out[1] -eq 'Z') -or # scissors (Z) beats paper (B)
        ($out[0] -eq 'C' -and $out[1] -eq 'X')     # rock (X) beats scissors (C)
    )
    {
        #Write-Host "WIN {$($out[0]) - $($out[1])} Result: $([ScoreType]::Win.value__) + $([P2]::$($out[1]).value__)"
        
        $Result += [ScoreType]::Win.value__ + [P2]::$($out[1]).value__
    }
    ElseIf(
        ($out[0] -eq 'A' -and $out[1] -eq 'X') -or # rock (X) ties rock (A)
        ($out[0] -eq 'B' -and $out[1] -eq 'Y') -or # paper (Y) ties paper (B)
        ($out[0] -eq 'C' -and $out[1] -eq 'Z')     # scissors (Z) ties scissors (C)
    )
    {
        $Result += [ScoreType]::Draw.value__ + [P2]::$($out[1]).value__
        #Write-Host "DRAW {$($out[0]) - $($out[1])} Result: $([ScoreType]::Draw.value__) + $([P2]::$($out[1]).value__)"
    }
    ElseIf(
        ($out[0] -eq 'A' -and $out[1] -eq 'Z') -or # scissors (Z) loses to rock (A)
        ($out[0] -eq 'B' -and $out[1] -eq 'X') -or # rock (X) loses to paper (B)
        ($out[0] -eq 'C' -and $out[1] -eq 'Y')     # paper (Z) loses to scissors (C)
    )
    {
        $Result += [ScoreType]::Loss.value__ + [P2]::$($out[1]).value__
        #Write-Host "LOSS {$($out[0]) - $($out[1])} Result: $([ScoreType]::Loss.value__) + $([P2]::$($out[1]).value__)"
    }
}
$Result