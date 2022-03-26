$language_pack_urls = @(
    "https://www.alcpu.com/CoreTemp/languages/hy-AM.lng",
    "https://www.alcpu.com/CoreTemp/languages/bg-BG.lng",
    "https://www.alcpu.com/CoreTemp/languages/zh-CN.lng",
    "https://www.alcpu.com/CoreTemp/languages/zh-TW.lng",
    "https://www.alcpu.com/CoreTemp/languages/ca.lng",
    "https://www.alcpu.com/CoreTemp/languages/cs.lng",
    "https://www.alcpu.com/CoreTemp/languages/da-DK.lng",
    "https://www.alcpu.com/CoreTemp/languages/nl-NL.lng",
    "https://www.alcpu.com/CoreTemp/languages/fi-Fi.lng",
    "https://www.alcpu.com/CoreTemp/languages/fr-FR.lng",
    "https://www.alcpu.com/CoreTemp/languages/de-DE.lng",
    "https://www.alcpu.com/CoreTemp/languages/el-GR.lng",
    "https://www.alcpu.com/CoreTemp/languages/he-IL.lng",
    "https://www.alcpu.com/CoreTemp/languages/hu-HU.lng",
    "https://www.alcpu.com/CoreTemp/languages/it-IT.lng",
    "https://www.alcpu.com/CoreTemp/languages/ja-JP.lng",
    "https://www.alcpu.com/CoreTemp/languages/ko-KR.lng",
    "https://www.alcpu.com/CoreTemp/languages/nb-NO.lng",
    "https://www.alcpu.com/CoreTemp/languages/pl-PL.lng",
    "https://www.alcpu.com/CoreTemp/languages/pt-BR.lng",
    "https://www.alcpu.com/CoreTemp/languages/ro-RO.lng",
    "https://www.alcpu.com/CoreTemp/languages/ru-RU.lng",
    "https://www.alcpu.com/CoreTemp/languages/sk.lng",
    "https://www.alcpu.com/CoreTemp/languages/es.lng",
    "https://www.alcpu.com/CoreTemp/languages/sv-SV.lng",
    "https://www.alcpu.com/CoreTemp/languages/tr-TR.lng",
    "https://www.alcpu.com/CoreTemp/languages/ua-UA.lng",
    "https://www.alcpu.com/CoreTemp/languages/vi-VN.lng"
)

if(!(Test-Path "$PSScriptRoot\languages\")) {
    New-Item "$PSScriptRoot\languages\" -ItemType Directory | Out-Null
}

$i = 0
$language_pack_urls | ForEach-Object {
    $i += 1
    Write-Host "($i/$($language_pack_urls.Length)) Downloading $_......" -NoNewline
    Invoke-WebRequest -Uri $_ -OutFile "$PSScriptRoot\languages\$($_.Split("/")[-1])"
    Write-Host "OK"
}
