$ws_shell = New-Object -ComObject WScript.Shell
$shortcut = $ws_shell.CreateShortcut('{{startup_dir}}\SmartTaskbar.lnk')
$shortcut.TargetPath = '{{current_dir}}\SmartTaskbar.exe'
$shortcut.WorkingDirectory = '{{current_dir}}'
$shortcut.Save()
Write-Host "SmartTaskbar has been added to the startup programs." -ForegroundColor Green
