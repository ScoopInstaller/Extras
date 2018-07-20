if(!$env:SCOOP_HOME) { $env:SCOOP_HOME = resolve-path (split-path (split-path (scoop which scoop))) }
$formatjson = "$env:SCOOP_HOME/bin/formatjson.ps1"
$path = "$psscriptroot/.." # checks the parent dir
iex -command "$formatjson -path $path $($args |% { "$_ " })"
