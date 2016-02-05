param($dir, $sourcetreeIns)

# This script follows the some steps described here to make the app portable:
# 
# https://github.com/cosmomill/SourceTreePortable
#
# Unpack the installer to expose the MSI
$unpack = Start-Process "$dir\$sourcetreeIns.exe" -Wait -ea Stop -PassThru -arg "/extract"
if($unpack.ExitCode -eq 0)
{
    # The extracted MSI doesn't seem to like being installed in $dir, so we put it in subditectory
    mkdir $dir\app
    $install = Start-Process msiexec -Wait -ea stop -PassThru -arg "/a $dir\$sourcetreeIns.msi /qb TARGETDIR=$dir\app"
    if($install.ExitCode -ne 0)
    {
        Write-Host "Installer failed."
    }
}