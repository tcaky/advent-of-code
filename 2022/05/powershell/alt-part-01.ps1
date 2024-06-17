Function Move-StackValues {
    Param(
        [int]$NumberToMove,
        [ref]$FromStack,
        [ref]$ToStack
    )
    For ($i = 0; $i -lt $NumberToMove; $i++) {
        $Val = $FromStack.Value.Pop()
        $ToStack.Value.Push($Val)
    }
}

# Example data
$TestMoveAra = @(
    'move 3 from 1 to 2',
    'move 2 from 3 to 1'
)

# Initialize stacks for demonstration
$AraOfStacks = @(
    [System.Collections.Stack]::new(),
    [System.Collections.Stack]::new(),
    [System.Collections.Stack]::new()
)

# Populate the stacks for testing
$AraOfStacks[0].Push('A')
$AraOfStacks[0].Push('B')
$AraOfStacks[0].Push('C')

$AraOfStacks[1].Push('D')
$AraOfStacks[1].Push('E')
$AraOfStacks[1].Push('F')

$AraOfStacks[2].Push('G')
$AraOfStacks[2].Push('H')
$AraOfStacks[2].Push('I')

# Process each move command
ForEach ($Row in $TestMoveAra) {
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

# Output the final state of the stacks
For ($i = 0; $i -lt $AraOfStacks.Count; $i++) {
    Write-Host "Stack $($i + 1): $($AraOfStacks[$i] -join ', ')"
}
