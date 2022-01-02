$path = "$Env:appdata/discord/settings.json"
$settings = Get-Content $path | ConvertFrom-Json
if (Get-Member -inputobject $settings -name 'SKIP_HOST_UPDATE' -Membertype Properties) {
    $settings.SKIP_HOST_UPDATE=$True
}
else {
    $settings | Add-Member -MemberType NoteProperty -Name 'SKIP_HOST_UPDATE' -Value $True
}
$settings | ConvertTo-Json | Set-Content -Path $path
