# Ensure the current ExecutionPolicy

Set-ExecutionPolicy -Scope Process ByPass

# Ensure the ProgramData with SymbolicLink

$current_dir = scoop prefix supercollider

if (Test-Path "$env:programdata\SuperCollider") {
    Write-Host "Copying old '$env:programdata\SuperCollider' to '$current_dir\ProgramData\SuperCollider'" -ForegroundColor DarkGray

    if (-not (Test-Path "$current_dir\ProgramData\SuperCollider")) {
        New-Item -ItemType Directory -Path "$current_dir\ProgramData\SuperCollider" -Force | Out-Null
    }
    Copy-Item "$env:programdata\SuperCollider\*" "$current_dir\ProgramData\SuperCollider" -Recurse -Force
    Remove-Item -Path "$env:programdata\SuperCollider" -Force -Recurse -ErrorAction SilentlyContinue
    New-Item -ItemType SymbolicLink -Path "$env:programdata\SuperCollider" -Target "$current_dir\ProgramData\SuperCollider" | Out-Null
    Write-Host "Done."
} else {
    New-Item -ItemType SymbolicLink -Path "$env:programdata\SuperCollider" -Target "$current_dir\ProgramData\SuperCollider" | Out-Null
    Write-Host "Done."
}

# Reset the current ExecutionPolicy

Set-ExecutionPolicy -Scope Process Undefined