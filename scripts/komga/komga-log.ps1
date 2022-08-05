$currentdir = (Get-Item -Path ".\").FullName
Set-Location $PSScriptRoot
java -jar komga.jar --komga.config-dir="$($PSScriptRoot)\config"
