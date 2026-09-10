#Requires -Version 5.1

function New-ProfileModifier {
    <#
    .SYNOPSIS
        Generate scripts from template.

    .PARAMETER Behavior
        Type of scripts to generate.

    .PARAMETER AppName
        Name of the manifest.

    .PARAMETER BucketDir
        Path of bucket root directory.

    .PARAMETER ModuleName
        Use this parameter if module name differs from app name.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [Alias("Type")]
        [string] $Behavior,
        [Parameter(Mandatory = $true, Position = 1)]
        [Alias("Name")]
        [string] $AppName,
        [Parameter(Mandatory = $true, Position = 2)]
        [string] $BucketDir,
        [Parameter(Mandatory = $false, Position = 3)]
        [string] $ModuleName
    )

    if (-not ($ModuleName)) { $ModuleName = $AppName }

    Write-Host "Generating $Behavior script for $ModuleName..." -NoNewline

    $SupportedBehavior = @("ImportModule", "RemoveModule")

    if ($SupportedBehavior -notcontains $Behavior) {
        Write-Host "failed." -ForegroundColor Red
        Write-Host "ERROR  Unsupported behavior type: $Behavior" -ForegroundColor DarkRed
        return
    }

    $UtilsPath = $BucketDir | Join-Path -ChildPath "\scripts\ModifyPSProfile.psm1"
    $ScoopDir = Split-Path $BucketDir | Split-Path
    $AppDir = $ScoopDir | Join-Path -ChildPath "\apps\$AppName\current\"

    $EscapedUtilsPath = $UtilsPath -replace "'", "''"
    $ImportUtilsCommand = "Import-Module '$EscapedUtilsPath' -ErrorAction Stop"
    $RemoveUtilsCommand = "Remove-Module -Name ModifyPSProfile -ErrorAction SilentlyContinue"

    $ImportModuleCommand = ("Add-ProfileContent 'Import-Module ", $ModuleName, "'") -Join ("")
    $RemoveModuleCommand = ("Remove-ProfileContent 'Import-Module ", $ModuleName, "'") -Join ("")

    $NewLine = [Environment]::NewLine

    switch ($Behavior) {
        "ImportModule" {
            $GenerateContent = ($ImportUtilsCommand, $RemoveModuleCommand, $ImportModuleCommand, $RemoveUtilsCommand) -Join ($NewLine)
            $OutputPath = "$AppDir\add-profile-content.ps1"
        }
        "RemoveModule" {
            $GenerateContent = ($ImportUtilsCommand, $RemoveModuleCommand, $RemoveUtilsCommand) -Join ($NewLine)
            $OutputPath = "$AppDir\remove-profile-content.ps1"
        }
    }

    try {
        $GenerateContent | Out-File -FilePath $OutputPath -Encoding UTF8 -ErrorAction Stop
        Write-Host "success." -ForegroundColor Green
    } catch {
        Write-Host "failed." -ForegroundColor Red
        Write-Host "ERROR  $($_.Exception.Message)" -ForegroundColor DarkRed
    }
}

function Add-ProfileContent {
    <#
    .SYNOPSIS
        Add certain content to PSProfile.

    .PARAMETER Content
        Content to be added.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string] $Content
    )

    Write-Host "Modifying PowerShell profile..." -NoNewline

    if (Test-Path $PROFILE) {
        $NewLine = [Environment]::NewLine
        try {
            Add-Content -Path $PROFILE -Value "$NewLine$Content" -Encoding UTF8 -NoNewLine -ErrorAction Stop
            Write-Host "success." -ForegroundColor Green
        } catch {
            Write-Host "failed." -ForegroundColor Red
            Write-Host "ERROR  $($_.Exception.Message)" -ForegroundColor DarkRed
        }
    } else {
        $ProfileParentDir = Split-Path -Path $PROFILE -Parent
        if (-not (Test-Path $ProfileParentDir)) {
            try {
                New-Item -Path $ProfileParentDir -ItemType Directory -Force -ErrorAction Stop | Out-Null
            } catch {
                Write-Host "failed." -ForegroundColor Red
                Write-Host "ERROR  $($_.Exception.Message)" -ForegroundColor DarkRed
                return
            }
        }
        try {
            $Content | Out-File -FilePath $PROFILE -Encoding UTF8 -Force -ErrorAction Stop
            Write-Host "success." -ForegroundColor Green
        } catch {
            Write-Host "failed." -ForegroundColor Red
            Write-Host "ERROR  $($_.Exception.Message)" -ForegroundColor DarkRed
        }
    }
}

function Remove-ProfileContent {
    <#
    .SYNOPSIS
        Remove certain content from PSProfile.

    .PARAMETER Content
        Content to be removed.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string] $Content
    )

    Write-Host "Cleaning up PowerShell profile..." -NoNewline

    if (-not (Test-Path $PROFILE)) {
        Write-Host "abort." -ForegroundColor Yellow
        Write-Host "INFO  PowerShell profile not found." -ForegroundColor DarkGray
        return
    }

    try {
        $RawProfile = Get-Content -Path $PROFILE -Encoding UTF8 -Raw -ErrorAction Stop
    } catch {
        Write-Host "failed." -ForegroundColor Red
        Write-Host "ERROR  $($_.Exception.Message)" -ForegroundColor DarkRed
        return
    }

    if ($null -eq $RawProfile) {
        Write-Host "abort." -ForegroundColor Yellow
        Write-Host "INFO  PowerShell profile is empty." -ForegroundColor DarkGray
        return
    }

    $escapedContent = [Regex]::Escape($Content)
    $ProfileLinePattern = "(?m)^[ \t]*$escapedContent[ \t]*(?:\r?\n|$)"

    if ($RawProfile -match $ProfileLinePattern) {
        $modifiedProfile = $RawProfile -replace $ProfileLinePattern, ''
        try {
            $modifiedProfile | Out-File -FilePath $PROFILE -Encoding UTF8 -NoNewLine -ErrorAction Stop
            Write-Host "success." -ForegroundColor Green
        } catch {
            Write-Host "failed." -ForegroundColor Red
            Write-Host "ERROR  $($_.Exception.Message)" -ForegroundColor DarkRed
        }
    } else {
        Write-Host "abort." -ForegroundColor Yellow
        Write-Host "INFO  Content not found in PowerShell profile." -ForegroundColor DarkGray
        return
    }
}

Export-ModuleMember -Function New-ProfileModifier, Add-ProfileContent, Remove-ProfileContent
