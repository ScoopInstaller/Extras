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

New-Item 'HKCU:\Software\Harmonoid\Harmonoid\Capability\FileAssociations' -Force | Out-Null
New-Item 'HKCU:\SOFTWARE\Classes\Applications\harmonoid.exe\SupportedTypes' -Force | Out-Null
New-ItemProperty 'HKCU:\Software\Harmonoid\Harmonoid\Capability' -Name 'ApplicationDescription' -Value 'Plays & manages your music library. Looks beautiful & juicy.' -Force | Out-Null
New-ItemProperty 'HKCU:\Software\Harmonoid\Harmonoid\Capability' -Name 'ApplicationName' -Value 'Harmonoid' -Force | Out-Null

$formats | ForEach-Object {
    New-ItemProperty 'HKCU:\Software\Harmonoid\Harmonoid\Capability\FileAssociations' -Name ".$_" -Value "Harmonoid.$_" -Force | Out-Null
    New-Item "HKCU:\SOFTWARE\Classes\Harmonoid.$_" -Value "$(($_).ToUpper()) File" -Force | Out-Null
    New-Item "HKCU:\SOFTWARE\Classes\Harmonoid.$_\DefaultIcon" -Value "CURRENT_DIRECTORY\harmonoid.exe,0" -Force | Out-Null
    New-Item "HKCU:\SOFTWARE\Classes\Harmonoid.$_\shell\open\command" -Value "CURRENT_DIRECTORY\harmonoid.exe ""%1""" -Force | Out-Null
    New-ItemProperty 'HKCU:\SOFTWARE\Classes\Applications\harmonoid.exe\SupportedTypes' -Name ".$_" -Value '' -Force | Out-Null
    New-Item "HKCU:\SOFTWARE\Classes\.$_\OpenWithProgids" -Force | Out-Null
    New-ItemProperty "HKCU:\SOFTWARE\Classes\.$_\OpenWithProgids" -Name "Harmonoid.$_" -Value '' -Force | Out-Null
}
