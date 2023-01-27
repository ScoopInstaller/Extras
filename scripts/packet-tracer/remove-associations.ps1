$version = 'VERSION_HERE'
$majorVersion = $version.Split('.')[0]

'.pkt', '.pka', '.pkz', '.pks', '.pksz' | ForEach-Object {
    Remove-Item "HKCU:\SOFTWARE\Classes\$_" -Recurse -ErrorAction 'SilentlyContinue' -Force
    Remove-Item "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\$_" -Recurse -ErrorAction 'SilentlyContinue' -Force
}

"PacketTracer$majorVersion", "PacketTracer$majorVersion.Activity", "PacketTracer$majorVersion.PKZ", "PacketTracer$majorVersion.ActivitySequence", "PacketTracer$majorVersion.ActivitySequencePackage" | ForEach-Object {
    Remove-Item "HKCU:\SOFTWARE\Classes\$_" -Recurse -ErrorAction 'SilentlyContinue' -Force
}
