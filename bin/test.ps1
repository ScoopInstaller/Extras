if(!$env:scoop_home) { $env:scoop_home = resolve-path (split-path (split-path (scoop which scoop))) }
Invoke-Pester "$psscriptroot/.."
