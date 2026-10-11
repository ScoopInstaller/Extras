# Ensure the current ExecutionPolicy

Set-ExecutionPolicy -Scope Process ByPass

# Ensure the LocalAppData with SymbolicLink

$current_dir = scoop prefix supercollider

if (Test-Path "$env:localappdata\SuperCollider") {
    Write-Host "Copying old '$env:localappdata\SuperCollider' to '$current_dir\LocalAppData\SuperCollider'" -ForegroundColor DarkGray

    if (-not (Test-Path "$current_dir\LocalAppData\SuperCollider")) {
        New-Item -ItemType Directory -Path "$current_dir\LocalAppData\SuperCollider" -Force | Out-Null
    }
    Copy-Item "$env:localappdata\SuperCollider\*" "$current_dir\LocalAppData\SuperCollider" -Recurse -Force
    Remove-Item -Path "$env:localappdata\SuperCollider" -Force -Recurse -ErrorAction SilentlyContinue
    New-Item -ItemType SymbolicLink -Path "$env:localappdata\SuperCollider" -Target "$current_dir\LocalAppData\SuperCollider" | Out-Null
    Write-Host "Done."
} else {
    New-Item -ItemType SymbolicLink -Path "$env:localappdata\SuperCollider" -Target "$current_dir\LocalAppData\SuperCollider" | Out-Null
    Write-Host "Done."
}

# Reset the current ExecutionPolicy

Set-ExecutionPolicy -Scope Process Undefined