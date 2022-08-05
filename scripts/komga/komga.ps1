$currentdir = (Get-Item -Path ".\").FullName
Set-Location $PSScriptRoot
javaw -jar komga.jar --komga.config-dir="$($PSScriptRoot)\config"
