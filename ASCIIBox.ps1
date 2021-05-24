$HorizontalBoxChar = [string][char]9552
$VerticalBoxChar = [string][char]9553
$TopLeftBoxChar = [string][char]9556
$TopRightBoxChar = [string][char]9559
$BottomLeftBoxChar = [string][char]9562
$BottomRightBoxChar = [string][char]9565
$HorizontalJoinCharLeft = [string][char]9568
$HorizontalJoinCharRight = [string][char]9571 #(╣)

Function CreateBoxText() {

    param
    (
        [string[]]$text
    )
        $maxLength = 0
        $lineCount = 0
        $_ -split "`r`n" | ForEach-Object {
            $text += $_
            If ($text[$lineCount].Length -gt $maxLength) {
                $maxLength = $text[$lineCount].Length
            }
            $lineCount++
        }
        
        # Title 
        $title = "This is a box title in the middle - yey!"
        $TopLeftBoxChar + ($HorizontalBoxChar * ($maxLength)) + $TopRightBoxChar
        
        Write-Host ("{0}{1}" -f ($VerticalBoxChar + ' ' * (([Math]::Max(0, $Host.UI.RawUI.BufferSize.Width / 2) - [Math]::Floor($title.Length / 2)))), $title)
        
        $HorizontalJoinCharLeft + ($HorizontalBoxChar * ($maxLength)) + $HorizontalJoinCharRight

        #$TopLeftBoxChar + ($HorizontalBoxChar * ($maxLength)) + $TopRightBoxChar
        For ($i = 0; $i -lt $lineCount; $i++) {           
            Write-Host($VerticalBoxChar + " " + $text[$i] + (" " * ($maxLength - $text[$i].Length - 1)) + $VerticalBoxChar)
            
        }
        $BottomLeftBoxChar + ($HorizontalBoxChar * ($maxLength)) + $BottomRightBoxChar
    }  

function Write-HostCenter { param($Message) Write-Host ("{0}{1}" -f (' ' * (([Math]::Max(0, $Host.UI.RawUI.BufferSize.Width / 2) - [Math]::Floor($Message.Length / 2)))), $Message) }