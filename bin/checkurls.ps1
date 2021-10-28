if(!$env:SCOOP_HOME) { $env:SCOOP_HOME = resolve-path (split-path (split-path (scoop which scoop))) }
$checkurls = "$env:SCOOP_HOME/bin/checkurls.ps1"
$dir = "$psscriptroot/../bucket" # checks the parent dir
Invoke-Expression -command "& '$checkurls' -dir '$dir' $($args | ForEach-Object { "$_ " })"
