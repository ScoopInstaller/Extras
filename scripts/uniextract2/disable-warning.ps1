# This is to disable the warning popup when the app/command is executed for the first time.
$cont = Get-Content "$dir\UniExtract.ini"
if ($cont -match 'warnexecute=1') {
    $cont = $cont.Replace('warnexecute=1', 'warnexecute=0')
    $cont | Set-Content "$dir\UniExtract.ini"
}
