# Test the current ExecutionPolicy

$policy = Get-ExecutionPolicy -Scope Process

if (($policy) -ne "RemoteSigned") {
    Write-Host "Now the Process ExecutionPolicy is $policy" -ForegroundColor Red
    Write-Host "Now is requesting for changing the ExecutionPolicy of the current session." -ForegroundColor Yellow
    Set-ExecutionPolicy -Scope Process RemoteSigned -Confirm
} elseif (($policy) -eq "RemoteSigned") {
    Write-Host "Now the Process ExecutionPolicy is $policy" -ForegroundColor Green
}