if(!$env:SCOOP_HOME) { $env:SCOOP_HOME = resolve-path (split-path (split-path (scoop which scoop))) }
$missing_checkver = "$env:SCOOP_HOME/bin/missing-checkver.ps1"
$dir = "$psscriptroot/../bucket" # checks the parent dir
Invoke-Expression -command "& '$missing_checkver' -dir '$dir' $($args | ForEach-Object { "$_ " })"
