#Requires -Modules @{ ModuleName = 'Pester'; RequiredVersion = '4.10.1' }

if (!$env:SCOOP_HOME) { $env:SCOOP_HOME = Resolve-Path (scoop prefix scoop) }
Invoke-Pester @{ Path = "$env:SCOOP_HOME\test\Import-Bucket-Tests.ps1"; Arguments = "$PSScriptRoot/.." }
