if (!$env:SCOOP_HOME) { $env:SCOOP_HOME = Convert-Path (scoop prefix scoop) }
$missing_checkver = "$env:SCOOP_HOME/bin/missing-checkver.ps1"
$dir = "$PSScriptRoot/../bucket" # checks the parent dir
& $missing_checkver -Dir $dir @Args
