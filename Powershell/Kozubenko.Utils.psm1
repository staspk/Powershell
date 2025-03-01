using module .\classes\FunctionRegistry.psm1

$WhiteRed = $PSStyle.Foreground.FromRgb(255, 196, 201);
$LiteRed = $PSStyle.Foreground.FromRgb(223, 96, 107);

function WriteWhiteRed($msg, $newLine = $true)  {  if($newLine) { Write-Host ${WhiteRed}$msg }      else { Write-Host ${WhiteRed}$msg -NoNewline }  }
function WriteLiteRed($msg, $newLine = $true)  {  if($newLine) { Write-Host ${LiteRed}$msg -ForegroundColor Red }      else { Write-Host ${LiteRed}$msg -ForegroundColor Red -NoNewline }  }
function WriteRed($msg, $newLine = $true)      {  if($newLine) { Write-Host $msg -ForegroundColor Red }      else { Write-Host $msg -ForegroundColor Red -NoNewline }        }
function WriteDarkRed($msg, $newLine = $true)  {  if($newLine) { Write-Host $msg -ForegroundColor DarkRed }   else { Write-Host $msg -ForegroundColor DarkRed -NoNewline }    }
function WriteYellow($msg, $newLine = $true)   {  if($newLine) { Write-Host $msg -ForegroundColor Yellow }    else { Write-Host $msg -ForegroundColor Yellow -NoNewline }     }
function WriteCyan($msg, $newLine = $true)     {  if($newLine) { Write-Host $msg -ForegroundColor Cyan }      else { Write-Host $msg -ForegroundColor Cyan -NoNewline }       }
function WriteDarkCyan($msg, $newLine = $true) {  if($newLine) { Write-Host $msg -ForegroundColor DarkCyan }    else { Write-Host $msg -ForegroundColor DarkCyan -NoNewline }      }
function WriteGreen($msg, $newLine = $true)    {  if($newLine) { Write-Host $msg -ForegroundColor Green }     else { Write-Host $msg -ForegroundColor Green -NoNewline }      }
function WriteDarkGreen($msg, $newLine = $true){  if($newLine) { Write-Host $msg -ForegroundColor DarkGreen } else { Write-Host $msg -ForegroundColor DarkGreen -NoNewline }  }
function WriteDarkGray($msg, $newLine = $true)    {  if($newLine) { Write-Host $msg -ForegroundColor DarkGray }    else { Write-Host $msg -ForegroundColor DarkGray -NoNewline }      }
function WriteGray($msg, $newLine = $true)     {  if($newLine) { Write-Host $msg -ForegroundColor Gray }      else { Write-Host $msg -ForegroundColor Gray -NoNewline }       }
function WriteWhite($msg, $newLine = $true)    {  if($newLine) { Write-Host $msg -ForegroundColor White }    else { Write-Host $msg -ForegroundColor White -NoNewline }      }



function TestPathSilently($dirPath, $returnPath = $false) { 
    $exists = Test-Path $dirPath -ErrorAction SilentlyContinue
    
    If (-not($returnPath)) { return $exists }
    if (-not($exists)) {  return $null  }
    
    return $dirPath
}
function IsFile($path) {
    if ([string]::IsNullOrEmpty($path) -OR -not(Test-Path $path -ErrorAction SilentlyContinue)) {
        # Write-Host "Kozubenko.Utils:IsFile(`$path) has hit sanity check. `$path: $path"
        return $false
    }

    if (Test-Path -Path $path -PathType Leaf) {  return $true;  }
    else {
        return $false
    }
}
function IsDirectory($path) {
    if ([string]::IsNullOrEmpty($path) -OR -not(Test-Path $path -ErrorAction SilentlyContinue)) {
        # Write-Host "Kozubenko.Utils:IsDirectory(`$path) has hit sanity check. `$path: $path"
        return $false
    }

    if (Test-Path -Path $path -PathType Container) {  return $true  }
    else {
        return $false
    }
}
function GetParentDir($path) {
    if(-not(TestPathSilently($path))) {  WriteDarkRed "Skipping GetParent(`$path) since `$path does not exist: $path";  RETURN;  }
    RETURN [System.IO.Path]::GetDirectoryName($path)
}

function WriteErrorExit([string]$errorMsg) {
    WriteDarkRed $errorMsg
    WriteDarkRed "Exiting Script..."
    exit
}

function SetAliases($function, [Array]$aliases) {   # Throws exception if you try to set an alias on a keyword you already set an alias on
    if ($function -eq $null -or $aliases -eq $null) {  RETURN  }

    foreach ($alias in $aliases) {
        Set-Alias -Name $alias -Value $function -Scope Global -Option Constant,AllScope -Force
    }
}

function WriteCustomColor($msg, $color, $newLine = $true) {     # 
    if($newLine) {  Write-Host "${color}$msg"  }    else {  Write-Host "${color}$msg" -NoNewline  }
}

function SetGlobal($varName, $value) {
    if($varName[0] -eq "$") {
        $varName = $varName.Substring(1, $name.Length - 1 )
    }
        
    Set-Variable -Name $varName -Value $value -Scope Global
}

function ClearTerminal {
    if(ConsoleInputTextLength gt 0) {
        ConsoleDeleteInput
    }
    Clear-Host
    ConsoleAcceptLine
    ConsoleDeletePreviousLine
}
function ConsoleInputTextLength() {
    $buffer = $null
    $cursor = 0
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$buffer, [ref]$cursor)
    return @($buffer, $cursor)
}
function ConsoleInsert($text) {  [Microsoft.PowerShell.PSConsoleReadLine]::Insert($text)  }
function ConsoleAcceptLine() {  [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()  }
function ConsoleMoveToStartofLine {  [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition(0)  }
function ConsoleMoveToEndofLine {
    $buffer = $null
    $cursor = 0
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$buffer, [ref]$cursor)
    [Microsoft.PowerShell.PSConsoleReadLine]::SetCursorPosition($buffer.Length)
}
function ConsoleDeleteInput {
    if ((ConsoleInputTextLength)[1] -gt 0) {
        [Microsoft.PowerShell.PSConsoleReadLine]::BackwardDeleteInput()
    }
}
function ConsoleDeletePreviousLine {
    [console]::SetCursorPosition(0, [console]::CursorTop - 1)
    Write-Host (" " * [console]::WindowWidth)
    [console]::SetCursorPosition(0, [console]::CursorTop - 1)
}



