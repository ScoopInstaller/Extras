if(!$env:SCOOP_HOME) { $env:SCOOP_HOME = resolve-path (split-path (split-path (scoop which scoop))) }
. "$env:SCOOP_HOME\test\Import-Bucket-Tests.ps1"
