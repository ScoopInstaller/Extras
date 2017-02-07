$bin = split-path (scoop which scoop)
$checkver = "$bin\checkver.ps1"
$dir = "$psscriptroot\.." # checks the parent dir
iex -command "$checkver -dir $dir $($args |% { "$_ " })"
