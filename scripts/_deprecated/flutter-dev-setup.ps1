#requires -version 2
<#
.SYNOPSIS
  This script assists in installing the required build-tools and platform SDKs to get started
  with Flutter development on an Android Phone.
.DESCRIPTION
  This script assists in installing the required build-tools and platform SDKs to get started
  with Flutter development on an Android Phone. It detects whether any SDKs are installed and
  prompts to install them if not.
.INPUTS
  None
.OUTPUTS
  None
.NOTES
  Version:        1.0
  Author:         Ardelean Călin
  Creation Date:  14 July 2018
  Purpose/Change: Initial script development
#>


# Gets the installed packages list from sdkmanager
function get-installed {
    param (
        [Object]$sdkmanager_output
    )

    $flag_start = 0
    $installed_items = @()

    ForEach ($line in $sdkmanager_output) {
        if ($flag_start -eq 1) {
            $match = [regex]::Match($line.Trim(), "^(\S*)\s+\|\s+\d+.*")
            if ($match.Success -eq $true) {
                $installed_items += $match.Groups[1].Value
            }
        }

        if ($line.ToLower().Contains("installed packages")) {
            $flag_start = 1
        }
        elseif ($line.ToLower().Contains("available packages")) {
            $flag_start = 0
            break
        }
    }

    $installed_items
}

# Finds the latest reference to 'build-tools' that is not a release canditate.
# This results in the latest released build-tools version.
function get-latest-buildtools {
    param (
        [Object]$sdkmanager_output
    )

    $latest_buildtools = ""

    ForEach ($line in $sdkmanager_output) {
        $build_tools = [regex]::Match($line.Trim(), "^(build-tools;\d+\.\d+\.\d)(?!-rc.*).*")
        if ($build_tools.Success -eq $true) {
            $latest_buildtools = $build_tools.Groups[1].Value
        }
    }

    $latest_buildtools
}

# Gets available platforms from sdkmanager
function get-platforms {
    param (
        [Object]$sdkmanager_output
    )

    $platforms = @()
    ForEach ($line in $sdkmanager_output) {
        $match = [regex]::Match($line.Trim(), "^(platforms;android-\d+).*")
        if ($match.Success -eq $true) {
            $platforms += $match.Groups[1].Value
        }
    }

    $platforms
}

# Check internet conenction first and only continue on success
$connection = Test-NetConnection

if ($connection.PingSucceeded -eq $false) {
    $scriptName = $MyInvocation.MyCommand.Name
    Write-Host "$scriptName could not connect to the internet. Please connect to the internet and try again, or install flutter requirements manually." -ForegroundColor Yellow
    exit 1
}

# Check if sdkmanager exists and in path. Program cannot continue without it
Get-Command "sdkmanager" -ErrorAction SilentlyContinue -ErrorVariable err | Out-Null
if ($err.Count -eq $true) {
    Write-Host "Could not find 'sdkmanager' in PATH. Make sure you have android-sdk installed." -ForegroundColor Red
    exit 2
}

# Runs sdkmanager with the --list argument to see what is installed on the system
# and what needs to be installed.
$sdkout = sdkmanager.bat --list


$installed_items = get-installed $sdkout
$latest_buildtools = get-latest-buildtools $sdkout
# Get the platforms and sort them by API Level (which is the number in eg. platforms;android-21)
$platforms = (get-platforms $sdkout) | Sort-Object -Property @{
    Expression = {
        $x = $_[($_.IndexOf("-") + 1)..$_.length] -Join ""
        [int]$x
    }
} | Get-Unique

# Check if we have at least one valid platform
$platform_installed = ($installed_items | % {$_.Contains("platforms;")}).Contains($true)
# Check if we have at least one valid version of buildtools
# TODO: Maybe in the future suggest installing the latest version
$buildtools_installed = ($installed_items | % {$_.Contains("build-tools;")}).Contains($true)


# No build-tools detected, so we install them
if ($buildtools_installed -eq $false) {
    Write-Host "No build-tools detected. Installing the latest version... ($latest_buildtools)" -ForegroundColor Yellow
    sdkmanager.bat "$latest_buildtools"
}

# No platform SDK detected, so we install one from the available ones
if ($platform_installed -eq $false) {
    Write-Host "Available platforms:"

    $i = 1
    Write-Host (($platforms | % {$platform = $platforms[$i - 1]; "[$i] $platform"; $i++}) -Join "`n")

    Write-Host "For a list of platforms and what they mean, see: https://developer.android.com/about/dashboards/" -ForegroundColor Yellow
    $i--
    Write-Host "No platform detected. Please select a platform to install [Default: $i]: " -ForegroundColor Yellow -NoNewline

    # Prompts the user to give a valid number and not try to break the program
    do {
        try {
            $numOk = $true
            $value = Read-host
            if ($value) {
                $api_level = [int]$value
            }
            else {
                $api_level = 22
                break
            }
        }
        catch {
            $numOK = $false
            Write-Host $"Invalid number format, please try again: " -NoNewline
        }
    }
    until (($api_level -ge 1 -and $api_level -lt $platforms.Length) -and $numOK)

    $platform = $platforms[$api_level - 1]
    Write-Host "Platform $platform selected. Installing..."

    sdkmanager.bat $platform
}

# Done. We should be able to develop for Android now.
Write-Host "All required dependencies for Android Development are installed." -ForegroundColor Green
