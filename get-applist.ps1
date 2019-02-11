#       _            _
#    __| |_ __ _ _ _| |
#   (_-<  _/ _` | '_|  _|
#   /__/\__\__,_|_|  \__|
# 

$E = [char]27 # Escape char
$DATETIME = [datetime]::now.tostring("o")
$SPINNER = "-","\","|","/"

Push-Location
Set-Location bucket
Set-Content -Path "../APPLIST.md" -Value " "
Add-Content -Path "../APPLIST.md" -Value "### List of apps`n---`r`n`r`n" -NoNewline
	
Add-Content -Path "../APPLIST.md" -Value "| Name | Version | Homepage |`r`n" -NoNewline
Add-Content -Path "../APPLIST.md" -Value "| ---- | ------- | -------- |`r`n" -NoNewline

$i = 0
Get-ChildItem .\*.json | Foreach-Object {
	write-host "`r[ $($SPINNER[$i % ($SPINNER.Count)]) ] Processing app $E[38;2;90;90;200m$E[4m$($_.BaseName)$E[24m$E[0m...                  " -nonewline
	$appname = $_.BaseName
	$appdata = Get-Content $_ | ConvertFrom-JSON
	$homepage = $appdata.homepage
	$version = $appdata.version
	Add-Content -Path "../APPLIST.md" -Value "| $appname | $version | [$homepage]($homepage) |`r`n" -NoNewline
	$i++
}
	
Add-Content -Path "../APPLIST.md" -Value "`nThis section was last generated on **${DATETIME}**."

""

git add ../APPLIST.md
git commit -q -m "Updated APPLIST.md"

Pop-Location
Write-Output "Finished updating app manifests"
