param($dir, $sourcetreeIns)

echo $dir
echo $sourcetreeIns
# Unpack the installer to expose the MSI
$unpack = Start-Process "$dir\$sourcetreeIns.exe" -Wait -ea Stop -PassThru -arg "/extract"
if($unpack.ExitCode -eq 0)
{
    iex "msiexec /a $sourcetreeIns.msi /qb TARGETDIR=$dir"
}