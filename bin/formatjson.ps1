if(!$env:SCOOP_HOME) { $env:SCOOP_HOME = resolve-path (split-path (split-path (scoop which scoop))) }
$formatjson = "$env:SCOOP_HOME/bin/formatjson.ps1"
$path = "$psscriptroot/../bucket" # checks the parent dir
Invoke-Expression -command "& '$formatjson' -dir '$path' $($args | ForEach-Object { "$_ " })"
