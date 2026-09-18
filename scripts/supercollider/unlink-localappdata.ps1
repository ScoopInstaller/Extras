# Ensure the current ExecutionPolicy

Set-ExecutionPolicy -Scope Process ByPass

#Remove the LocalAppdata SymbolicLink

Write-Host "Removing LocalAppData SymbolicLink." -ForegroundColor Yellow
if (Test-Path "$env:localappdata\SuperCollider") {
    Remove-Item -Path "$env:localappdata\SuperCollider" -Force -ErrorAction SilentlyContinue
}

# Reset the current ExecutionPolicy

Set-ExecutionPolicy -Scope Process Undefined