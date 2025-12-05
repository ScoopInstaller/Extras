Remove-Item -Path '{{startup_dir}}\SmartTaskbar.lnk' -Force -ErrorAction SilentlyContinue
Write-Host "SmartTaskbar has been removed from the startup programs." -ForegroundColor Green
