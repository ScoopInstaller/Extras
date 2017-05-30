param(
    # overwrite upstream param
    [String]$upstream = "lukesampson/scoop-extras:master"
)

if(!$env:scoop_home) { $env:scoop_home = resolve-path (split-path (split-path (scoop which scoop))) }
$autopr = "$env:scoop_home/bin/auto-pr.ps1"
$dir = "$psscriptroot/.." # checks the parent dir
iex -command "$autopr -dir $dir -upstream $upstream $($args |% { "$_ " })"
