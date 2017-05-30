if(!$env:scoop_home) { $env:scoop_home = resolve-path (split-path (split-path (scoop which scoop))) }
$checkver = "$env:scoop_home/bin/checkver.ps1"
$dir = "$psscriptroot/.." # checks the parent dir
iex -command "$checkver -dir $dir $($args |% { "$_ " })"
