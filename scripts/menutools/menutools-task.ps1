function is_admin {
    $admin = [Security.Principal.WindowsBuiltInRole]::Administrator
    $id = [Security.Principal.WindowsIdentity]::GetCurrent()
    ([Security.Principal.WindowsPrincipal]($id)).IsInRole($admin)
}

$subCommand = $args[0]

if (is_admin) {
    if ($subCommand -eq 'add') {
        $actions = New-ScheduledTaskAction -Execute "REPLACE_HERE\MenuTools.exe"
        $triggers = New-ScheduledTaskTrigger -AtStartup -RandomDelay 2
        $principal = New-ScheduledTaskPrincipal -RunLevel 'Highest' -LogonType 'Interactive' -ProcessTokenSidType 'Default' -UserId $env:USERNAME
        $settings = New-ScheduledTaskSettingsSet -Compatibility 'Win8' -MultipleInstances 'IgnoreNew'
        $task = New-ScheduledTask -Description 'Launches MenuTools at startup' -Action $actions -Trigger $triggers -Principal $principal -Settings $settings
        Register-ScheduledTask -TaskName 'MenuTools' -TaskPath '\' -InputObject $task

    } elseif ($subCommand -eq 'remove') {
        schtasks.exe /delete /tn 'MenuTools' /f
    } elseif ($subCommand -in @('help', $null)) {
        $message = @("Command usage:`n", "`n`thelp`t`tOpens this help menu.", "`n`tadd`t`tAdds MenuTools as a startup task.", "`n`tremove`t`tRemoves the MenuTools startup task.")
        Write-Host $message
    }
} elseif (!(is_admin)) {
    Write-Host "Please Run this Powershell script with Administrator privellages" -ForegroundColor 'Red'
}
