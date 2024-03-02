$currentdir = (Get-Item -Path ".\").FullName
Set-Location $PSScriptRoot
$out = ".\Suwayomi Launcher.bat"
Start-Process $out -NoNewWindow
Set-Location $currentdir
