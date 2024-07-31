$regPath = '{{registry_scope}}:\Software\Classes\powertoys'
New-Item -Path $regPath -Value 'URL:PowerToys custom internal URI protocol' -Force | Out-Null
New-ItemProperty -Path $regPath -Name 'InstallScope' -Value '{{install_scope}}' -Force | Out-Null
New-ItemProperty -Path $regPath -Name 'URL Protocol' -Value '' -Force | Out-Null

$regPath = '{{registry_scope}}:\Software\Classes\powertoys\components'
New-Item -Path $regPath -Force | Out-Null
New-ItemProperty -Path $regPath -Name 'BugReportTool_exe' -Value '' -Force | Out-Null
New-ItemProperty -Path $regPath -Name 'License_rtf' -Value '' -Force | Out-Null
New-ItemProperty -Path $regPath -Name 'Module_KeyboardManager_Editor' -Value '' -Force | Out-Null
New-ItemProperty -Path $regPath -Name 'Module_KeyboardManager_Engine' -Value '' -Force | Out-Null
New-ItemProperty -Path $regPath -Name 'Module_VideoConference' -Value '' -Force | Out-Null
New-ItemProperty -Path $regPath -Name 'Module_VideoConferenceIcons' -Value '' -Force | Out-Null
New-ItemProperty -Path $regPath -Name 'Notice_md' -Value '' -Force | Out-Null
New-ItemProperty -Path $regPath -Name 'StylesReportTool_exe' -Value '' -Force | Out-Null
New-ItemProperty -Path $regPath -Name 'WebcamReportTool_exe' -Value '' -Force | Out-Null
New-ItemProperty -Path $regPath -Name 'WinUI3AppsMicrosoftUIXamlAssets_NoiseAsset_256x256_PNG' -Value '' -Force | Out-Null

$regPath = '{{registry_scope}}:\Software\Classes\powertoys\DefaultIcon'
New-Item -Path $regPath -Value 'PowerToys.exe' -Force | Out-Null

$regPath = '{{registry_scope}}:\Software\Classes\powertoys\shell\open\command'
New-Item -Path $regPath -Value '"{{scoop_dir}}\PowerToys.exe" "%1"' -Force | Out-Null

$regPath = '{{registry_scope}}:\Software\Classes\CLSID\{0440049F-D1DC-4E46-B27B-98393D79486B}'
New-Item -Path $regPath -Value 'PowerRename Shell Extension' -Force | Out-Null
New-ItemProperty -Path $regPath -Name 'ContextMenuOptIn' -Value '' -Force | Out-Null

$regPath = '{{registry_scope}}:\Software\Classes\CLSID\{0440049F-D1DC-4E46-B27B-98393D79486B}\InprocServer32'
New-Item -Path $regPath -Value '{{scoop_dir}}\WinUI3Apps\PowerToys.PowerRenameExt.dll' -Force | Out-Null
New-ItemProperty -Path $regPath -Name 'ThreadingModel' -Value 'Apartment' -Force | Out-Null

$regPath = '{{registry_scope}}:\Software\Classes\AllFileSystemObjects\ShellEx\ContextMenuHandlers\PowerRenameExt'
New-Item -Path $regPath -Value '{0440049F-D1DC-4E46-B27B-98393D79486B}' -Force | Out-Null

$regPath = '{{registry_scope}}:\Software\Classes\Directory\background\ShellEx\ContextMenuHandlers\PowerRenameExt'
New-Item -Path $regPath -Value '{0440049F-D1DC-4E46-B27B-98393D79486B}' -Force | Out-Null

$regPath = '{{registry_scope}}:\Software\Classes\CLSID\{51B4D7E5-7568-4234-B4BB-47FB3C016A69}\InprocServer32'
New-Item -Path $regPath -Value '{{scoop_dir}}\PowerToys.ImageResizerExt.dll' -Force | Out-Null
New-ItemProperty -Path $regPath -Name 'ThreadingModel' -Value 'Apartment' -Force | Out-Null

$regPath = '{{registry_scope}}:\Software\Classes\Directory\ShellEx\DragDropHandlers\ImageResizer'
New-Item -Path $regPath -Value '{51B4D7E5-7568-4234-B4BB-47FB3C016A69}' -Force | Out-Null

$regPath = '{{registry_scope}}:\Software\Classes\SystemFileAssociations\.bmp\ShellEx\ContextMenuHandlers\ImageResizer'
New-Item -Path $regPath -Value '{51B4D7E5-7568-4234-B4BB-47FB3C016A69}' -Force | Out-Null

$regPath = '{{registry_scope}}:\Software\Classes\SystemFileAssociations\.dib\ShellEx\ContextMenuHandlers\ImageResizer'
New-Item -Path $regPath -Value '{51B4D7E5-7568-4234-B4BB-47FB3C016A69}' -Force | Out-Null

$regPath = '{{registry_scope}}:\Software\Classes\SystemFileAssociations\.gif\ShellEx\ContextMenuHandlers\ImageResizer'
New-Item -Path $regPath -Value '{51B4D7E5-7568-4234-B4BB-47FB3C016A69}' -Force | Out-Null

$regPath = '{{registry_scope}}:\Software\Classes\SystemFileAssociations\.jfif\ShellEx\ContextMenuHandlers\ImageResizer'
New-Item -Path $regPath -Value '{51B4D7E5-7568-4234-B4BB-47FB3C016A69}' -Force | Out-Null

$regPath = '{{registry_scope}}:\Software\Classes\SystemFileAssociations\.jpe\ShellEx\ContextMenuHandlers\ImageResizer'
New-Item -Path $regPath -Value '{51B4D7E5-7568-4234-B4BB-47FB3C016A69}' -Force | Out-Null

$regPath = '{{registry_scope}}:\Software\Classes\SystemFileAssociations\.jpeg\ShellEx\ContextMenuHandlers\ImageResizer'
New-Item -Path $regPath -Value '{51B4D7E5-7568-4234-B4BB-47FB3C016A69}' -Force | Out-Null

$regPath = '{{registry_scope}}:\Software\Classes\SystemFileAssociations\.jpg\ShellEx\ContextMenuHandlers\ImageResizer'
New-Item -Path $regPath -Value '{51B4D7E5-7568-4234-B4BB-47FB3C016A69}' -Force | Out-Null

$regPath = '{{registry_scope}}:\Software\Classes\SystemFileAssociations\.jxr\ShellEx\ContextMenuHandlers\ImageResizer'
New-Item -Path $regPath -Value '{51B4D7E5-7568-4234-B4BB-47FB3C016A69}' -Force | Out-Null

$regPath = '{{registry_scope}}:\Software\Classes\SystemFileAssociations\.png\ShellEx\ContextMenuHandlers\ImageResizer'
New-Item -Path $regPath -Value '{51B4D7E5-7568-4234-B4BB-47FB3C016A69}' -Force | Out-Null

$regPath = '{{registry_scope}}:\Software\Classes\SystemFileAssociations\.rle\ShellEx\ContextMenuHandlers\ImageResizer'
New-Item -Path $regPath -Value '{51B4D7E5-7568-4234-B4BB-47FB3C016A69}' -Force | Out-Null

$regPath = '{{registry_scope}}:\Software\Classes\SystemFileAssociations\.tif\ShellEx\ContextMenuHandlers\ImageResizer'
New-Item -Path $regPath -Value '{51B4D7E5-7568-4234-B4BB-47FB3C016A69}' -Force | Out-Null

$regPath = '{{registry_scope}}:\Software\Classes\SystemFileAssociations\.tiff\ShellEx\ContextMenuHandlers\ImageResizer'
New-Item -Path $regPath -Value '{51B4D7E5-7568-4234-B4BB-47FB3C016A69}' -Force | Out-Null

$regPath = '{{registry_scope}}:\Software\Classes\SystemFileAssociations\.wdp\ShellEx\ContextMenuHandlers\ImageResizer'
New-Item -Path $regPath -Value '{51B4D7E5-7568-4234-B4BB-47FB3C016A69}' -Force | Out-Null

$regPath = '{{registry_scope}}:\Software\Classes\CLSID\{84D68575-E186-46AD-B0CB-BAEB45EE29C0}'
New-Item -Path $regPath -Value 'File Locksmith Shell Extension' -Force | Out-Null
New-ItemProperty -Path $regPath -Name 'ContextMenuOptIn' -Value '' -Force | Out-Null

$regPath = '{{registry_scope}}:\Software\Classes\CLSID\{84D68575-E186-46AD-B0CB-BAEB45EE29C0}\InprocServer32'
New-Item -Path $regPath -Value '{{scoop_dir}}\WinUI3Apps\PowerToys.FileLocksmithExt.dll' -Force | Out-Null
New-ItemProperty -Path $regPath -Name 'ThreadingModel' -Value 'Apartment' -Force | Out-Null

$regPath = '{{registry_scope}}:\Software\Classes\AllFileSystemObjects\ShellEx\ContextMenuHandlers\FileLocksmithExt'
New-Item -Path $regPath -Value '{84D68575-E186-46AD-B0CB-BAEB45EE29C0}' -Force | Out-Null

$regPath = '{{registry_scope}}:\Software\Classes\Drive\ShellEx\ContextMenuHandlers\FileLocksmithExt'
New-Item -Path $regPath -Value '{84D68575-E186-46AD-B0CB-BAEB45EE29C0}' -Force | Out-Null

$regPath = '{{registry_scope}}:\Software\Classes\CLSID\{DD5CACDA-7C2E-4997-A62A-04A597B58F76}'
New-Item -Path $regPath -Value 'PowerToys Toast Notifications Background Activator' -Force | Out-Null

$regPath = '{{registry_scope}}:\Software\Classes\CLSID\{DD5CACDA-7C2E-4997-A62A-04A597B58F76}\LocalServer32'
New-Item -Path $regPath -Value '{{scoop_dir}}\PowerToys.exe -ToastActivated' -Force | Out-Null
New-ItemProperty -Path $regPath -Name 'ThreadingModel' -Value 'Apartment' -Force | Out-Null

if ($PSVersionTable.PSVersion.Major -ge 6) { Import-Module Appx -UseWindowsPowershell 3>$null }

Add-AppxPackage -Path '{{scoop_dir}}\ImageResizerContextMenuPackage.msix' -ExternalLocation '{{scoop_dir}}' | Out-Null

Add-AppxPackage -Path '{{scoop_dir}}\WinUI3Apps\PowerRenameContextMenuPackage.msix' -ExternalLocation '{{scoop_dir}}\WinUI3Apps' | Out-Null
