# Deletes the contents of: .\Powershell, and copy pastes everything under the Powershell $profile to ScriptPackage

$profileDir = "$env:USERPROFILE\Documents\Powershell"
$scriptDir = ".\Powershell"

Get-ChildItem -Path $scriptDir -Recurse | ForEach-Object {
    $_.Delete()
    Write-Host "Deleted File: $_" -ForegroundColor Red
    Start-Sleep -Milliseconds 25
}

Copy-Item -Path "$profileDir\*" -Destination $scriptDir -Recurse
Write-Host "`$Profile Contents COPY-PASTED to: $scriptDir" -ForegroundColor Green
Start-Sleep -Milliseconds 1850


for ($i = 1; $i -le 6; $i++) {
    Start-Sleep -Milliseconds 5
    [console]::SetCursorPosition(0, [console]::CursorTop - 1)
    Write-Host (" " * [console]::WindowWidth)
    [console]::SetCursorPosition(0, [console]::CursorTop - 1)
}