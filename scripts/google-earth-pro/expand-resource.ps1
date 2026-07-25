param (
    [Parameter(Mandatory = $true)]
    [string]$filePath,

    [Parameter(Mandatory = $true)]
    [string]$resourceType,

    [Parameter(Mandatory = $true)]
    [string]$resourceName,

    [Parameter(Mandatory = $true)]
    [string]$outputFilePath,

    [Parameter(Mandatory = $false)]
    [switch]$Removal
)

Add-Type @"
using System;
using System.Runtime.InteropServices;

public class Win32 {
    [DllImport("kernel32.dll", SetLastError = true)]
    public static extern IntPtr FindResource(IntPtr hModule, string lpName, string lpType);

    [DllImport("kernel32.dll", SetLastError = true)]
    public static extern IntPtr LoadResource(IntPtr hModule, IntPtr hResInfo);

    [DllImport("kernel32.dll", SetLastError = true)]
    public static extern IntPtr LockResource(IntPtr hResData);

    [DllImport("kernel32.dll", SetLastError = true)]
    public static extern uint SizeofResource(IntPtr hModule, IntPtr hResInfo);

    [DllImport("kernel32.dll", SetLastError = true)]
    public static extern IntPtr LoadLibraryEx(string lpFileName, IntPtr hFile, uint dwFlags);

    [DllImport("kernel32.dll", SetLastError = true)]
    public static extern bool FreeLibrary(IntPtr hModule);

    public const uint LOAD_LIBRARY_AS_DATAFILE = 0x00000002;
}
"@

try {
    $hModule = [Win32]::LoadLibraryEx($filePath, [IntPtr]::Zero, [Win32]::LOAD_LIBRARY_AS_DATAFILE)
    if ($hModule -eq [IntPtr]::Zero) {
        throw "Failed to load PE file: $filePath"
    }

    $hResInfo = [Win32]::FindResource($hModule, $resourceName, $resourceType)
    if ($hResInfo -eq [IntPtr]::Zero) {
        throw "Failed to find the specified resource: $resourceType, $resourceName"
    }

    $hResData = [Win32]::LoadResource($hModule, $hResInfo)
    if ($hResData -eq [IntPtr]::Zero) {
        throw "Failed to load the specified resource."
    }

    $pResourceData = [Win32]::LockResource($hResData)
    if ($pResourceData -eq [IntPtr]::Zero) {
        throw "Failed to lock the specified resource."
    }

    $resourceSize = [Win32]::SizeofResource($hModule, $hResInfo)
    if ($resourceSize -eq 0) {
        throw "Failed to get the size of the specified resource."
    }

    $buffer = New-Object byte[] $resourceSize
    [Runtime.InteropServices.Marshal]::Copy($pResourceData, $buffer, 0, $resourceSize)

    [System.IO.File]::WriteAllBytes($outputFilePath, $buffer)

    if ($Removal) {
        Remove-Item -Path $filePath -Force
    }
} catch {
    abort $_.Exception.Message
} finally {
    if ($hModule -ne [IntPtr]::Zero) {
        [Win32]::FreeLibrary($hModule) | Out-Null
    }
}
