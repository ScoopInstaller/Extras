<#
    To enable USBPcap, Wireshark requires `USBPcapCMD.exe` to be copied to `wireshark/Data/extcap/`.
    This script will try its best to find the file, then create a symlink in the required dir.
#>
$dst_dir = "$PSScriptRoot\Data\extcap"
$exe_name = "USBPcapCMD.exe"

# The USBPCap dir should've been added to the user's PATH by its installer.
$src_exe = (Get-Command $exe_name -ErrorAction Ignore).Source

# If for any reason it wasn't (e.g. installed by a different user), try looking in some common locations.
if (-not $src_exe) {
    try {
        $src_dir = ((Get-ItemPropertyValue 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\USBPcap' -Name 'UninstallString').Replace('"', '') | Get-Item).DirectoryName 2>$null
        $src_exe = "$src_dir\$exe_name"
    } catch {}
}
if (-not $src_exe) {
    $src_exe = "$env:ProgramFiles\USBPcap\$exe_name"
}

if (Test-Path $src_exe) {
    $dst_exe = "$dst_dir\$exe_name"
    if ( -not (Test-Path $dst_exe) -or ((Get-Item $dst_exe).Target -ne $src_exe)) {
        New-Item -Force -ItemType Directory -Path $dst_dir | Out-Null
        New-Item -Force -ItemType SymbolicLink -Path $dst_exe -Value $src_exe | Out-Null
        Write-Output "Linking $(Resolve-Path $dst_exe -Relative -RelativeBasePath $PSScriptRoot) => $src_exe"
    }
} else {
    Write-Error "'$exe_name' not found. Please ensure USBPcap is installed, and the computer has been restarted after installation.
If it still fails, you need to manually copy USBPCapCMD.exe from the USBPcap install location to '$dst_dir'"
}
