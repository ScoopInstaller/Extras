if ($args[0] -eq 'register') {
    Write-Host 'Registering ''URL:Telegram Link'' protocol handler...'
    New-Item 'HKCU:\SOFTWARE\Classes\tg\shell\open\command' -Value """REPLACE_HERE\Telegram.exe""  -- ""%1""" -Force | Out-Null
    New-Item 'HKCU:\SOFTWARE\Classes\tg\DefaultIcon' -Value "REPLACE_HERE\Telegram.exe,1" -Force | Out-Null
    New-ItemProperty 'HKCU:\SOFTWARE\Classes\tg' -Name 'URL Protocol' -Value '' -Force | Out-Null
    New-ItemProperty 'HKCU:\SOFTWARE\Classes\tg' -Name '(Default)' -Value 'URL:Telegram Link' -Force | Out-Null
    New-Item 'HKCU:\SOFTWARE\Classes\TelegramDesktop\Capabilities\UrlAssociations' -Name 'tg' -Value 'tdesktop.tg' -Force | Out-Null
    New-ItemProperty 'HKCU:\SOFTWARE\Classes\TelegramDesktop\Capabilities' -Name 'ApplicationName' -Value 'Telegram Desktop' -Force | Out-Null
    New-ItemProperty 'HKCU:\SOFTWARE\Classes\TelegramDesktop\Capabilities' -Name 'ApplicationDescription' -Value 'Telegram Desktop' -Force | Out-Null
    Write-Host 'Done!'
} elseif ($args[0] -eq 'unregister') {
    Write-Host 'Unregistering ''URL:Telegram Link'' protocol handler...'; Remove-Item 'HKCU:\SOFTWARE\Classes\tg', 'HKCU:\SOFTWARE\Classes\TelegramDesktop' -Force -Recurse
    Write-Host 'Done!'
} elseif ($args[0] -in @('help', $null)) {
    $message = (
        "Command usage:`n", "`n`t help`t`t`t Opens this help menu.",
        "`n`t register`t`t Registers the 'URL:Telegram Link' protocol.",
        "`n`t unregister`t`t Unregisters the 'URL:Telegram Link' protocol."
    )
    Write-Host $message
}
