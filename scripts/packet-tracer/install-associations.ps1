$version = 'VERSION_HERE'
$majorVersion = $version.Split('.')[0]

New-Item 'HKCU:\SOFTWARE\Classes\.pkt' -Value "PacketTracer$majorVersion" -Force | Out-Null
New-Item 'HKCU:\SOFTWARE\Classes\.pka' -Value "PacketTracer$majorVersion.Activity" -Force | Out-Null
New-Item 'HKCU:\SOFTWARE\Classes\.pkz' -Value "PacketTracer$majorVersion.PKZ" -Force | Out-Null
New-Item 'HKCU:\SOFTWARE\Classes\.pks' -Value "PacketTracer$majorVersion.ActivitySequence" -Force | Out-Null
New-Item 'HKCU:\SOFTWARE\Classes\.pksz' -Value "PacketTracer$majorVersion.ActivitySequencePackage" -Force | Out-Null

"PacketTracer$majorVersion", "PacketTracer$majorVersion.Activity", "PacketTracer$majorVersion.PKZ", "PacketTracer$majorVersion.ActivitySequence", "PacketTracer$majorVersion.ActivitySequencePackage" | ForEach-Object {
    New-Item "HKCU:\SOFTWARE\Classes\$_\shell\open\command" -Value '"REPLACE_HERE\bin\PacketTracer.exe" "%1"' -Force | Out-Null
    New-Item "HKCU:\SOFTWARE\Classes\$_\DefaultIcon" -Value 'REPLACE_HERE\art\pkt.ico' -Force | Out-Null
}
