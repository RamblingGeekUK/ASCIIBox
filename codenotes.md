$HorizontalBoxChar = [string][char]9552
$VerticalBoxChar = [string][char]9553
$TopLeftBoxChar = [string][char]9556
$TopRightBoxChar = [string][char]9559
$BottomLeftBoxChar = [string][char]9562
$BottomRightBoxChar = [string][char]9565

Function CreateBoxText() {
    param(
        [string[]]$body
        )
    Begin {
        $lines = @()
        $lines = $body
    }
    Process {
        $maxLength = 0
        $lineCount = 0
        $_ -split "`r`n" | ForEach-Object {
            $lines += $_
            If ($lines[$lineCount].Length -gt $maxLength) {
                $maxLength = $lines[$lineCount].Length
            }
            $lineCount++
        }
    }
    End {
        $TopLeftBoxChar + ($HorizontalBoxChar * ($maxLength + 2)) + $TopRightBoxChar
        For ($i = 0; $i -lt $lineCount; $i++) {
            $VerticalBoxChar + " " + $lines[$i] + (" " * ($maxLength - $lines[$i].Length + 1)) + $VerticalBoxChar
        }
        $BottomLeftBoxChar + ($HorizontalBoxChar * ($maxLength + 2)) + $BottomRightBoxChar
    }   
}
CreateBoxText -msg @("Line 1", "Line 2","Line 3", "Line 4", "", "Line 6")

Function MenuMaker{
    param(
        [string]$Title = $null,
        [parameter(Mandatory=$true,
        ValueFromPipeline = $true)][String[]]$Selections
        )

    $Width = if($Title){$Length = $Title.Length;$Length2 = $Selections|%{$_.length}|Sort -Descending|Select -First 1;$Length2,$Length|Sort -Descending|Select -First 1}else{$Selections|%{$_.length}|Sort -Descending|Select -First 1}
    $Buffer = if(($Width*1.5) -gt 78){(78-$width)/2}else{$width/4}
    if($Buffer -gt 6){$Buffer = 6}
    $MaxWidth = $Buffer*2+$Width+$($Selections.count).length
    $Menu = @()
    $Menu += "╔"+"═"*$maxwidth+"╗"
    if($Title){
        $Menu += "║"+" "*[Math]::Floor(($maxwidth-$title.Length)/2)+$Title+" "*[Math]::Ceiling(($maxwidth-$title.Length)/2)+"║"
        $Menu += "╟"+"─"*$maxwidth+"╢"
    }
    For($i=1;$i -le $Selections.count;$i++){
        $Item = "$i`. "
        $Menu += "║"+" "*$Buffer+$Item+$Selections[$i-1]+" "*($MaxWidth-$Buffer-$Item.Length-$Selections[$i-1].Length)+"║"
    }
    $Menu += "╚"+"═"*$maxwidth+"╝"
    $menu
}