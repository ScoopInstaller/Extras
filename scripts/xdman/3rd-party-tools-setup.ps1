$appdir = $PSScriptRoot
$tools = "ffmpeg.exe", 'youtube-dl.exe'

foreach ($tool in $tools) {
  $gc = Get-Command $tool -ErrorAction SilentlyContinue -ErrorVariable gcerr
  if ($gcerr) {
    Write-Host "Unable to find tool: $tool"
    exit
  }
  $exe = $gc.Source
  $shim = $exe.TrimEnd('.exe') + '.shim'
  Invoke-Expression "cmd /c 'mklink `"$appdir\$tool`" `"$exe`" >nul 2>&1'"
  Invoke-Expression "cmd /c 'mklink `"$appdir\$tool.shim`" `"$shim`" >nul 2>&1'"
}

Write-Host "Additional setup completed."
