if(!$env:scoop_home) { $env:scoop_home = resolve-path (split-path (split-path (scoop which scoop))) }
$missing_checkver = "$env:scoop_home/bin/missing-checkver.ps1"
$dir = "$psscriptroot/.." # checks the parent dir
iex -command "$missing_checkver -dir $dir $($args |% { "$_ " })"
