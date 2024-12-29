@(
    '{{registry_scope}}:\Software\Classes\powertoys\shell\open\command'
    '{{registry_scope}}:\Software\Classes\powertoys\DefaultIcon'
    '{{registry_scope}}:\Software\Classes\powertoys\components'
    '{{registry_scope}}:\Software\Classes\powertoys'
    '{{registry_scope}}:\Software\Classes\CLSID\{0440049F-D1DC-4E46-B27B-98393D79486B}\InprocServer32'
    '{{registry_scope}}:\Software\Classes\CLSID\{0440049F-D1DC-4E46-B27B-98393D79486B}'
    '{{registry_scope}}:\Software\Classes\AllFileSystemObjects\ShellEx\ContextMenuHandlers\PowerRenameExt'
    '{{registry_scope}}:\Software\Classes\Directory\background\ShellEx\ContextMenuHandlers\PowerRenameExt'
    '{{registry_scope}}:\Software\Classes\CLSID\{51B4D7E5-7568-4234-B4BB-47FB3C016A69}\InprocServer32'
    '{{registry_scope}}:\Software\Classes\Directory\ShellEx\DragDropHandlers\ImageResizer'
    '{{registry_scope}}:\Software\Classes\SystemFileAssociations\.bmp\ShellEx\ContextMenuHandlers\ImageResizer'
    '{{registry_scope}}:\Software\Classes\SystemFileAssociations\.dib\ShellEx\ContextMenuHandlers\ImageResizer'
    '{{registry_scope}}:\Software\Classes\SystemFileAssociations\.gif\ShellEx\ContextMenuHandlers\ImageResizer'
    '{{registry_scope}}:\Software\Classes\SystemFileAssociations\.jfif\ShellEx\ContextMenuHandlers\ImageResizer'
    '{{registry_scope}}:\Software\Classes\SystemFileAssociations\.jpe\ShellEx\ContextMenuHandlers\ImageResizer'
    '{{registry_scope}}:\Software\Classes\SystemFileAssociations\.jpeg\ShellEx\ContextMenuHandlers\ImageResizer'
    '{{registry_scope}}:\Software\Classes\SystemFileAssociations\.jpg\ShellEx\ContextMenuHandlers\ImageResizer'
    '{{registry_scope}}:\Software\Classes\SystemFileAssociations\.jxr\ShellEx\ContextMenuHandlers\ImageResizer'
    '{{registry_scope}}:\Software\Classes\SystemFileAssociations\.png\ShellEx\ContextMenuHandlers\ImageResizer'
    '{{registry_scope}}:\Software\Classes\SystemFileAssociations\.rle\ShellEx\ContextMenuHandlers\ImageResizer'
    '{{registry_scope}}:\Software\Classes\SystemFileAssociations\.tif\ShellEx\ContextMenuHandlers\ImageResizer'
    '{{registry_scope}}:\Software\Classes\SystemFileAssociations\.tiff\ShellEx\ContextMenuHandlers\ImageResizer'
    '{{registry_scope}}:\Software\Classes\SystemFileAssociations\.wdp\ShellEx\ContextMenuHandlers\ImageResizer'
    '{{registry_scope}}:\Software\Classes\CLSID\{84D68575-E186-46AD-B0CB-BAEB45EE29C0}\InprocServer32'
    '{{registry_scope}}:\Software\Classes\CLSID\{84D68575-E186-46AD-B0CB-BAEB45EE29C0}'
    '{{registry_scope}}:\Software\Classes\AllFileSystemObjects\ShellEx\ContextMenuHandlers\FileLocksmithExt'
    '{{registry_scope}}:\Software\Classes\Drive\ShellEx\ContextMenuHandlers\FileLocksmithExt'
    '{{registry_scope}}:\Software\Classes\CLSID\{DD5CACDA-7C2E-4997-A62A-04A597B58F76}\LocalServer32'
    '{{registry_scope}}:\Software\Classes\CLSID\{DD5CACDA-7C2E-4997-A62A-04A597B58F76}'
) | ForEach-Object {
    Remove-Item $_ -Recurse -Force | Out-Null
}

if ($PSVersionTable.PSVersion.Major -ge 6) { Import-Module Appx -UseWindowsPowershell 3>$null }

@(
    'ImageResizerContextMenu'
    'PowerRenameContextMenu'
) | ForEach-Object {
    $likeName = $_
    Get-AppxPackage |
    Where-Object { $_.PackageFullName -like "*$likeName*" } |
    Remove-AppxPackage | Out-Null
}
