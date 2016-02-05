param($dir, $fname, $installer, $inst)

echo $fname
echo $installer
$unpack = Start-Process ".\$inst.exe" -Wait -ea Stop -PassThru -arg "/extract"
if($unpack.ExitCode -eq 0)
{
    mkdir "$pwd\app"
    iex "msiexec /a $inst.msi /qb TARGETDIR=$pwd\app"
}