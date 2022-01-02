$currentdir = (Get-Item -Path ".\").FullName
Set-Location $PSScriptRoot
$out = ".\Tachidesk Browser Launcher.bat"
Start-Process $out -NoNewWindow
Set-Location $currentdir
