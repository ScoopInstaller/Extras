if(!$env:SCOOP_HOME) { $env:SCOOP_HOME = Resolve-Path (scoop prefix scoop) }
$checkver = "$env:SCOOP_HOME/bin/checkver.ps1"
$dir = "$PSScriptRoot/../bucket" # checks the parent dir
Invoke-Expression -command "& '$checkver' -dir '$dir' $($args | ForEach-Object { "$_ " })"
