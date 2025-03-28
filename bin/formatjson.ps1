if(!$env:SCOOP_HOME) { $env:SCOOP_HOME = Resolve-Path (scoop prefix scoop) }
$formatjson = "$env:SCOOP_HOME/bin/formatjson.ps1"
$path = "$PSScriptRoot/../bucket" # checks the parent dir
Invoke-Expression -command "& '$formatjson' -dir '$path' $($args | ForEach-Object { "$_ " })"
