param($dir, $installer)

$installer.exe /extract
msiexec /a $installer2.msi /qb TARGETDIR="$dir"
