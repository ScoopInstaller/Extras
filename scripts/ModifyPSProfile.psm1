#Requires -Version 5.0

function New-ProfileModifier {
    <#
    .SYNOPSIS
        Generate scripts from template.

    .PARAMETER Type
        Type of scripts to generate.

    .PARAMETER Name
        Name of manifest.

    .PARAMETER BucketDir
        Path of bucket root directory.
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string] $Type,
        [Parameter(Mandatory = $true, Position = 0)]
        [string] $Name,
        [Parameter(Mandatory = $true, Position = 0)]
        [string] $BucketDir
    )

    $SupportedType = @("ImportModule", "RemoveModule")

    if ($SupportedType -notcontains $Type) {
        Write-Host "Error: Unsupported type." -ForegroundColor Red
        Return
    }

    $UtilsPath = $BucketDir | Join-Path -ChildPath "\scripts\ModifyPSProfile.psm1"
    $ScoopDir = Split-Path $BucketDir | Split-Path
    $AppDir = $ScoopDir | Join-Path -ChildPath "\apps\$Name\current\"

    $ImportUtilsCommand = ("Import-Module ", $UtilsPath) -Join("")
    $RemoveUtilsCommand = "Remove-Module -Name ModifyPSProfile"

    $ImportModuleCommand = ("Add-ProfileContent 'Import-Module ", $Name, "'") -Join("")
    $RemoveModuleCommand = ("Remove-ProfileContent 'Import-Module ", $Name, "'") -Join("")

    switch ($Type) {
        {$_ -eq "ImportModule"} {
            $GenerateContent = ($ImportUtilsCommand, $RemoveModuleCommand, $ImportModuleCommand, $RemoveUtilsCommand) -Join("`r`n")
            $GenerateContent | Set-Content -Path "$AppDir\add-profile-content.ps1"
        }
        {$_ -eq "RemoveModule"} {
            $GenerateContent = ($ImportUtilsCommand, $RemoveModuleCommand, $RemoveUtilsCommand) -Join("`r`n")
            $GenerateContent | Set-Content -Path "$AppDir\remove-profile-content.ps1"
        }
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

    if (!(test-path $PROFILE)) {
        New-Item -Path $PROFILE -Value "$Content" -ItemType File -Force | Out-Null
    }
    else {
        Add-Content -Path $PROFILE -Value "`r`n$Content" -NoNewLine
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

    ((Get-Content -Path $PROFILE -raw) -replace "[\r\n]*$Content",'').trim() | Set-Content $PROFILE -NoNewLine
}

Set-Alias AppendtoProfile Add-ProfileContent
Set-Alias RemovefromProfile Remove-ProfileContent
Export-ModuleMember -Alias *

Export-ModuleMember `
    -Function `
        New-ProfileModifier, `
        Add-ProfileContent, `
        Remove-ProfileContent
