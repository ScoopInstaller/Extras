# Ensure the current ExecutionPolicy

Set-ExecutionPolicy -Scope Process ByPass

# Check Admin

if (-Not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "You NEED ADMIN permisson to remove the programdata symlink." -ForegroundColor DarkRed
    Exit
}

#Remove the ProgramData SymbolicLink

Write-Host "Removing ProgramData SymbolicLink." -ForegroundColor Yellow
if (Test-Path "$env:programdata\SuperCollider") {
    Remove-Item -Path "$env:programdata\SuperCollider" -Force -ErrorAction SilentlyContinue
}

# Reset the current ExecutionPolicy

Set-ExecutionPolicy -Scope Process Undefined