$language_pack_filenames = @(
    "hy-AM.lng",
    "bg-BG.lng",
    "zh-CN.lng",
    "zh-TW.lng",
    "ca.lng",
    "cs.lng",
    "da-DK.lng",
    "nl-NL.lng",
    "fi-Fi.lng",
    "fr-FR.lng",
    "de-DE.lng",
    "el-GR.lng",
    "he-IL.lng",
    "hu-HU.lng",
    "it-IT.lng",
    "ja-JP.lng",
    "ko-KR.lng",
    "nb-NO.lng",
    "pl-PL.lng",
    "pt-BR.lng",
    "ro-RO.lng",
    "ru-RU.lng",
    "sk.lng",
    "es.lng",
    "sv-SV.lng",
    "tr-TR.lng",
    "ua-UA.lng",
    "vi-VN.lng"
)

if(!(Test-Path "$PSScriptRoot\languages\")) {
    New-Item "$PSScriptRoot\languages\" -ItemType Directory | Out-Null
}

$i = 0
$language_pack_filenames | ForEach-Object {
    $i += 1
    Write-Host "($i/$($language_pack_filenames.Length)) Downloading $_......" -NoNewline
    Invoke-WebRequest -Uri "https://www.alcpu.com/CoreTemp/languages/$_" -OutFile "$PSScriptRoot\languages\$_"
    Write-Host "OK"
}
