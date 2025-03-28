Write-Host 'Registering the ''zotero://'' URL protocol...'
New-Item 'HKCU:\SOFTWARE\Classes\zotero' -Value 'Zotero Protocol' -Force | Out-Null
New-Item 'HKCU:\SOFTWARE\Classes\zotero\DefaultIcon' -Value "REPLACE_HERE\zotero.exe,1" -Force | Out-Null
New-Item 'HKCU:\SOFTWARE\Classes\zotero\shell\open\command' -Value """REPLACE_HERE\zotero.exe"" -url ""%1""" -Force | Out-Null
New-ItemProperty 'HKCU:\SOFTWARE\Classes\zotero' -Name 'FriendlyTypeName' -Value 'Zotero Protocol' -Force | Out-Null
New-ItemProperty 'HKCU:\SOFTWARE\Classes\zotero' -Name 'URL Protocol' -Value '' -Force | Out-Null
New-ItemProperty 'HKCU:\SOFTWARE\Classes\zotero' -Name 'EditFlags' -PropertyType 'DWord' -Value '2' -Force | Out-Null
Write-Host 'Done!'
