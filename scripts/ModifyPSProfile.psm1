#Requires -Version 5.1

function AppendtoProfile {
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

    if (!(test-path $profile)) {
        New-Item -Path $profile -Value "$content" -ItemType File -Force | Out-Null
    } else {
        Add-Content -Path $profile -Value "`n$content" -NoNewLine
    }
}

function RemovefromProfile {
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

    ((Get-Content -Path $profile -raw) -replace "[\r\n]*$content",'').trim() | Set-Content $profile -NoNewLine
}

Export-ModuleMember `
    -Function `
        AppendtoProfile, RemovefromProfile
