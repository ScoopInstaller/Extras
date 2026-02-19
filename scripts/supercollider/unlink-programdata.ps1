# Ensure the current ExecutionPolicy

Set-ExecutionPolicy -Scope Process ByPass

#Remove the ProgramData SymbolicLink

Write-Host "Removing ProgramData SymbolicLink." -ForegroundColor Yellow
if (Test-Path "$env:programdata\SuperCollider") {
    Remove-Item -Path "$env:programdata\SuperCollider" -Force -ErrorAction SilentlyContinue
}

# Reset the current ExecutionPolicy

Set-ExecutionPolicy -Scope Process Undefined