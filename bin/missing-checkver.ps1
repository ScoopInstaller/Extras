$bin = split-path (scoop which scoop)
$missing_checkver = "$bin\missing-checkver.ps1"
$dir = "$psscriptroot\.." # checks the parent dir
iex -command "$missing_checkver -dir $dir $($args |% { "$_ " })"
