$currentdir = (Get-Item -Path ".\").FullName
Set-Location $PSScriptRoot
$out = ".\Tachidesk Debug Launcher.bat"
Start-Process $out -NoNewWindow
Set-Location $currentdir
