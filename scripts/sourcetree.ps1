param($dir, $sourcetreeIns)

echo $dir
echo $sourcetreeIns
# Unpack the installer to expose the MSI
$unpack = Start-Process "$dir\$sourcetreeIns.exe" -Wait -ea Stop -PassThru -arg "/extract"
if($unpack.ExitCode -eq 0)
{
    mkdir $dir\app
    $install = Start-Process msiexec -Wait -ea stop -PassThru -arg "/a $sourcetreeIns.msi /qb TARGETDIR=$dir\app"
    if($install.ExitCode -ne 0)
    {
        Write-Host "Installer failed."
    }
}