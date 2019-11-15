$identity = [Security.Principal.WindowsIdentity]::GetCurrent()
$principal = New-Object Security.Principal.WindowsPrincipal -ArgumentList $identity
if (principal.IsInRole( [Security.Principal.WindowsBuiltInRole]::Administrator )){
  Write-Host 'You have Admin privilege. Continue for installation...'
} else {
  throw 'Check privilege fail. Please run installation under admin privilege...'
}
