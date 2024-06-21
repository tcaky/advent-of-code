$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Definition
$DataFilePath = Split-Path $ScriptPath 
$InputData = Get-Content -Path (Join-Path $DataFilePath 'aoc-2022-07-puzzle-input.txt') -Encoding Default

$InputData = @(
    '$ cd /',
    '$ ls',
    'dir a',
    '14848514 b.txt',
    '8504156 c.dat',
    'dir d',
    '$ cd a',
    '$ ls',
    'dir e',
    '29116 f',
    '2557 g',
    '62596 h.lst',
    '$ cd e',
    '$ ls',
    '584 i',
    '$ cd ..',
    '$ cd ..',
    '$ cd d',
    '$ ls',
    '4060174 j',
    '8033020 d.log',
    '5626152 d.ext',
    '7214296 k'
)

class Dir 
{
    [string]$Name
    [System.Collections.ArrayList]$SubDirs
    [System.Collections.ArrayList]$Files
    
    Dir($Name)
    {
        $this.Name = $Name

    }
}
class File
{
    [string]$FileName
    [int]$FileSize
    File($Name, $Size)
    {
        $this.FileName = $Name
        $this.FileSize = $Size
    }
}

# $FirstDir = [Dir]::new('/')
# $FirstDir.Name
$CurrDir = ''

$DirStack = [System.Collections.Stack]::new()

For($i = 0; $i -lt $InputData.Count;)
{
    # Write-Host ("String we are matching: {0}" -f $InputData[$i]) -BackgroundColor Cyan
    # Write-Host " "
    Switch -Regex ($InputData[$i])
    {
        '^\$ cd' {
            $DirName = ($InputData[$i] -split ' ')[2]
            $CurrDir = $DirName
            Write-Host ('directory match. changing to directory: "{0}"' -f $DirName)
            If($DirName -eq '..')
            {
                $DirStack.Pop() | Out-Null
            }
            else {
                $DirStack.Push($DirName)
            }
            Write-Host $DirStack
            $i++
            break
        }
        '^\$ ls' {
            # do nothing???

            # once we get to an ls, we start accumulating and looking ahead to ensure 
            # we don't increment too far.

            # handle case where there is literally no files or subdirectories
            If($InputData[$i+1] -match '^\$') {break}
            Do
            {
                $i++
                Switch -Regex ($InputData[$i])
                {
                    '^dir' {
                        Write-Host ('directory match: "{0}"' -f $InputData[$i])
                        break
                    }
                    '^\d' {
                        Write-Host ('file match: "{0}"' -f $InputData[$i])
                        break
                    }
                        
                }
                #If($InputData[$i] -ge $InputData.Count){break}

            }
            Until($InputData[$i+1] -match '^\$' -or $i -ge $InputData.Count)
            $i++
            # While($true)
            # {
            #     Switch -Regex ($InputData[++$i])
            #     {
            #         '^dir' {
            #             Write-Host ('directory match: "{0}"' -f $InputData[$i])
            #             break
            #         }
            #         '^\d' {
            #             Write-Host ('file match: "{0}"' -f $InputData[$i])
            #             break
            #         }
                        
            #     }
            #     If($InputData[$i] -ge $InputData.Count){break}
            # }
            break
        }
        # '^dir' {
        #     Write-Host ('directory match: "{0}"' -f $InputData[$i])
        #     break
        # }
        # '^\d' {
        #     Write-Host ('file match: "{0}"' -f $InputData[$i])
        #     break
        # }

        default {
            # Write-Host "NO MATCH"
        }
    }
}

