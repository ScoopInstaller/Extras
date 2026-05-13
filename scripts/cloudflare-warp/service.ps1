# Check for admin rights
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Error "Cloudflare WARP Service setup requires administrator rights."
    Write-Host "Please run this script as administrator." -ForegroundColor Yellow
    exit 1
}

# Get current directory
$dir = $PSScriptRoot

Write-Host "Setting up Cloudflare WARP Service..." -ForegroundColor Cyan
Write-Host "Directory: $dir"

# Create the service
$servicePath = "$dir\warp-svc.exe"
if (-not (Test-Path $servicePath)) {
    Write-Error "warp-svc.exe not found at: $servicePath"
    exit 1
}

# Remove existing service if it exists
$existingService = Get-Service -Name "Cloudflare WARP" -ErrorAction SilentlyContinue
if ($existingService) {
    Write-Host "Removing existing Cloudflare WARP Service..."
    Stop-Service -Name "Cloudflare WARP" -Force -ErrorAction SilentlyContinue
    sc.exe delete "Cloudflare WARP" | Out-Null
    Start-Sleep -Seconds 2
}

# Create new service
Write-Host "Creating Cloudflare WARP Service..."
try {
    New-Service -Name "Cloudflare WARP" -BinaryPathName "$servicePath" -DependsOn 'WlanSvc' -DisplayName "Cloudflare WARP" -ErrorAction Stop | Out-Null
    Write-Host "Service created successfully." -ForegroundColor Green
} catch {
    Write-Error "Failed to create service: $_"
    exit 1
}

# Start the service
Write-Host "Starting Cloudflare WARP Service..."
try {
    Start-Service -Name "Cloudflare WARP" -ErrorAction Stop
    Write-Host "Service started successfully." -ForegroundColor Green
} catch {
    Write-Warning "Failed to start service: $_"
    Write-Host "You can manually start the service later." -ForegroundColor Yellow
}

Write-Host "`nCloudflare WARP Service setup completed successfully!" -ForegroundColor Green
