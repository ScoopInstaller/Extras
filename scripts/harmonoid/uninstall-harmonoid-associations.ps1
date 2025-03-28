$formats = @(
    'ogg',
    'oga',
    'ogx',
    'aac',
    'm4a',
    'mp3',
    'wma',
    'wav',
    'flac',
    'opus',
    'aiff',
    'ac3',
    'adt',
    'adts',
    'amr',
    'ec3',
    'm3u',
    'm4r',
    'wpl',
    'zpl'
)

Remove-Item 'HKCU:\SOFTWARE\Classes\Applications\harmonoid.exe' -Recurse -Force
Remove-Item 'HKCU:\Software\Harmonoid\Harmonoid' -Recurse -Force

$formats | ForEach-Object {
    Remove-Item "HKCU:\SOFTWARE\Classes\Harmonoid.$_" -Recurse -Force
    Remove-ItemProperty "HKCU:\SOFTWARE\Classes\.$_\OpenWithProgids" -Name "Harmonoid.$_" -Force
}
