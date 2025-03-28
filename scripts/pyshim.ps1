param($dir)

ls "$dir" | ? name -match '^[^_].*?\.py$' | % {
    $n = $_.name -replace '\.py$', ''
    $ps = "$dir\$n.ps1"
    "& python `"`$PSScriptRoot\$n.py`" @args" > $ps
}
