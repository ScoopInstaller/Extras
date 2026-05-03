@(
    '{{registry_hive}}:\Software\Classes\powertoys\shell'
    '{{registry_hive}}:\Software\Classes\powertoys\components'
    '{{registry_hive}}:\Software\Classes\powertoys\DefaultIcon'
    '{{registry_hive}}:\Software\Classes\CLSID\{0440049F-D1DC-4E46-B27B-98393D79486B}'
    '{{registry_hive}}:\Software\Classes\CLSID\{51B4D7E5-7568-4234-B4BB-47FB3C016A69}'
    '{{registry_hive}}:\Software\Classes\CLSID\{84D68575-E186-46AD-B0CB-BAEB45EE29C0}'
    '{{registry_hive}}:\Software\Classes\CLSID\{DD5CACDA-7C2E-4997-A62A-04A597B58F76}'
    '{{registry_hive}}:\Software\Classes\AllFileSystemObjects\ShellEx\ContextMenuHandlers\PowerRenameExt'
    '{{registry_hive}}:\Software\Classes\AllFileSystemObjects\ShellEx\ContextMenuHandlers\FileLocksmithExt'
    '{{registry_hive}}:\Software\Classes\Directory\background\ShellEx\ContextMenuHandlers\PowerRenameExt'
    '{{registry_hive}}:\Software\Classes\Directory\ShellEx\DragDropHandlers\ImageResizer'
    '{{registry_hive}}:\Software\Classes\Drive\ShellEx\ContextMenuHandlers\FileLocksmithExt'
    '{{registry_hive}}:\Software\Classes\SystemFileAssociations\.bmp\ShellEx\ContextMenuHandlers\ImageResizer'
    '{{registry_hive}}:\Software\Classes\SystemFileAssociations\.dib\ShellEx\ContextMenuHandlers\ImageResizer'
    '{{registry_hive}}:\Software\Classes\SystemFileAssociations\.gif\ShellEx\ContextMenuHandlers\ImageResizer'
    '{{registry_hive}}:\Software\Classes\SystemFileAssociations\.jfif\ShellEx\ContextMenuHandlers\ImageResizer'
    '{{registry_hive}}:\Software\Classes\SystemFileAssociations\.jpe\ShellEx\ContextMenuHandlers\ImageResizer'
    '{{registry_hive}}:\Software\Classes\SystemFileAssociations\.jpeg\ShellEx\ContextMenuHandlers\ImageResizer'
    '{{registry_hive}}:\Software\Classes\SystemFileAssociations\.jpg\ShellEx\ContextMenuHandlers\ImageResizer'
    '{{registry_hive}}:\Software\Classes\SystemFileAssociations\.jxr\ShellEx\ContextMenuHandlers\ImageResizer'
    '{{registry_hive}}:\Software\Classes\SystemFileAssociations\.png\ShellEx\ContextMenuHandlers\ImageResizer'
    '{{registry_hive}}:\Software\Classes\SystemFileAssociations\.rle\ShellEx\ContextMenuHandlers\ImageResizer'
    '{{registry_hive}}:\Software\Classes\SystemFileAssociations\.tif\ShellEx\ContextMenuHandlers\ImageResizer'
    '{{registry_hive}}:\Software\Classes\SystemFileAssociations\.tiff\ShellEx\ContextMenuHandlers\ImageResizer'
    '{{registry_hive}}:\Software\Classes\SystemFileAssociations\.wdp\ShellEx\ContextMenuHandlers\ImageResizer'
) | ForEach-Object {
    if (Test-Path -Path $_) {
        Remove-Item -Path $_ -Recurse -Force -ErrorAction SilentlyContinue
    }
}

if ($PSVersionTable.PSVersion.Major -ge 6) { Import-Module Appx -UseWindowsPowershell *> $null }

@('CommandPalette', 'PowerRenameContextMenu', 'ImageResizerContextMenu') | ForEach-Object {
    $name_filter = $_
    Get-AppxPackage | Where-Object { $_.PackageFullName -like "*$name_filter*" } | Remove-AppxPackage | Out-Null
}
