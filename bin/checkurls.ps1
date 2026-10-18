if (!$env:SCOOP_HOME) { $env:SCOOP_HOME = Convert-Path (scoop prefix scoop) }
$checkurls = "$env:SCOOP_HOME/bin/checkurls.ps1"
$dir = "$PSScriptRoot/../bucket" # checks the parent dir
& $checkurls -Dir $dir @Args
