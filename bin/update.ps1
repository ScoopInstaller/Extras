param($appName = "project-graph")

$latestVersion = (.\checkver.ps1 $appName | Select-String -Pattern "Latest Version: (\d+\.\d+\.\d+)").Matches.Groups[1].Value
if (-not $latestVersion) { throw "Failed to fetch latest version" }

$manifestPath = "$PSScriptRoot/../bucket/$appName.json"
$manifest = Get-Content $manifestPath | ConvertFrom-Json

if ($manifest.version -eq $latestVersion) { exit 0 }

$manifest.version = $latestVersion
$manifest.url = $manifest.autoupdate.url -replace '\$version', $latestVersion

$tempFile = "$env:TEMP\$appName.exe"
try {
    Invoke-WebRequest $manifest.url -OutFile $tempFile -ErrorAction Stop
    $manifest.hash = (Get-FileHash $tempFile -Algorithm SHA256).Hash.ToLower()
} catch {
    Write-Error "Failed to download or calculate hash: $_"
    exit 1
}

$manifest | ConvertTo-Json -Depth 10 | Out-File $manifestPath -Encoding utf8
