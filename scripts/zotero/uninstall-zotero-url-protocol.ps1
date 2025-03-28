Write-Host 'Unregistering the ''zotero://'' URL protocol...'
Remove-Item 'HKCU:\SOFTWARE\Classes\zotero' -Recurse -Force
Write-Host 'Done!'
