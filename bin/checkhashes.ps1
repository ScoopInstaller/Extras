if(!$env:SCOOP_HOME) { $env:SCOOP_HOME = Resolve-Path (scoop prefix scoop) }
$checkhashes = "$env:SCOOP_HOME/bin/checkhashes.ps1"
$dir = "$PSScriptRoot/../bucket" # checks the parent dir
Invoke-Expression -Command "& '$checkhashes' -Dir '$dir' $($args | ForEach-Object { "$_ " })"
