'Registers Floorp with Default Programs or Default Apps in Windows
'floorp-set-default.vbs - created by Ramesh Srinivasan for Winhelponline.com
'Edited by rootBrz (https://github.com/Floorp-Projects/Floorp/discussions/639)
'v1.0 17-July-2022 - Initial release. Tested on Mozilla Floorp 102.0.1.0.
'v1.1 23-July-2022 - Minor bug fixes.
'v1.2 27-July-2022 - Minor revision. Cleaned up the code.
'Suitable for all Windows versions, including Windows 10/11.
'Tutorial: https://www.winhelponline.com/blog/register-Floorp-portable-with-default-apps/

Option Explicit
Dim sAction, sAppPath, sExecPath, sIconPath, objFile, sbaseKey, sbaseKey2, sAppDesc
Dim sClsKey, ArrKeys, regkey
Dim WshShell : Set WshShell = CreateObject("WScript.Shell")
Dim oFSO : Set oFSO = CreateObject("Scripting.FileSystemObject")

Set objFile = oFSO.GetFile(WScript.ScriptFullName)
sAppPath = oFSO.GetParentFolderName(objFile)
sExecPath = sAppPath & "\floorp.exe"
sIconPath = sAppPath & "\floorp.exe"
sAppDesc = "Floorp delivers safe, easy web browsing. " & _
"A familiar user interface, enhanced security features including " & _
"protection from online identity theft, and integrated search let " & _
"you get the most out of the web."

'Quit if floorp.exe is missing in the current folder!
If Not oFSO.FileExists (sExecPath) Then
   MsgBox "Please run this script from Floorp folder. The script will now quit.", _
   vbOKOnly + vbInformation, "Register Floorp with Default Apps"
   WScript.Quit
End If

If InStr(sExecPath, " ") > 0 Then
   sExecPath = """" & sExecPath & """"
   sIconPath = """" & sIconPath & """"
End If

sbaseKey = "HKCU\Software\"
sbaseKey2 = sbaseKey & "Clients\StartmenuInternet\Floorp\"
sClsKey = sbaseKey & "Classes\"

If WScript.Arguments.Count > 0 Then
   If UCase(Trim(WScript.Arguments(0))) = "-REG" Then Call RegisterFloorpPortable
   If UCase(Trim(WScript.Arguments(0))) = "-UNREG" Then Call UnRegisterFloorpPortable
Else
   sAction = InputBox ("Type REGISTER to add Floorp to Default Apps. " & _
   "Type UNREGISTER To remove.", "Floorp Registration", "REGISTER")
   If UCase(Trim(sAction)) = "REGISTER" Then Call RegisterFloorpPortable
   If UCase(Trim(sAction)) = "UNREGISTER" Then Call UnRegisterFloorpPortable
End If

Sub RegisterFloorpPortable
   WshShell.RegWrite sbaseKey & "RegisteredApplications\Floorp", _
   "Software\Clients\StartMenuInternet\Floorp\Capabilities", "REG_SZ"

   'FloorpHTML registration
   WshShell.RegWrite sClsKey & "FloorpHTML2\", "Floorp HTML Document", "REG_SZ"
   WshShell.RegWrite sClsKey & "FloorpHTML2\EditFlags", 2, "REG_DWORD"
   WshShell.RegWrite sClsKey & "FloorpHTML2\FriendlyTypeName", "Floorp HTML Document", "REG_SZ"
   WshShell.RegWrite sClsKey & "FloorpHTML2\DefaultIcon\", sIconPath & ",1", "REG_SZ"
   WshShell.RegWrite sClsKey & "FloorpHTML2\shell\", "open", "REG_SZ"
   WshShell.RegWrite sClsKey & "FloorpHTML2\shell\open\command\", sExecPath & _
   " -url " & """" & "%1" & """", "REG_SZ"
   WshShell.RegWrite sClsKey & "FloorpHTML2\shell\open\ddeexec\", "", "REG_SZ"

   'FloorpPDF registration
   WshShell.RegWrite sClsKey & "FloorpPDF2\", "Floorp PDF Document", "REG_SZ"
   WshShell.RegWrite sClsKey & "FloorpPDF2\EditFlags", 2, "REG_DWORD"
   WshShell.RegWrite sClsKey & "FloorpPDF2\FriendlyTypeName", "Floorp PDF Document", "REG_SZ"
   WshShell.RegWrite sClsKey & "FloorpPDF2\DefaultIcon\", sIconPath & ",5", "REG_SZ"
   WshShell.RegWrite sClsKey & "FloorpPDF2\shell\open\", "open", "REG_SZ"
   WshShell.RegWrite sClsKey & "FloorpPDF2\shell\open\command\", sExecPath & _
   " -url " & """" & "%1" & """", "REG_SZ"

   'FloorpURL registration
   WshShell.RegWrite sClsKey & "FloorpURL2\", "Floorp URL", "REG_SZ"
   WshShell.RegWrite sClsKey & "FloorpURL2\EditFlags", 2, "REG_DWORD"
   WshShell.RegWrite sClsKey & "FloorpURL2\FriendlyTypeName", "Floorp URL", "REG_SZ"
   WshShell.RegWrite sClsKey & "FloorpURL2\URL Protocol", "", "REG_SZ"
   WshShell.RegWrite sClsKey & "FloorpURL2\DefaultIcon\", sIconPath & ",1", "REG_SZ"
   WshShell.RegWrite sClsKey & "FloorpURL2\shell\open\", "open", "REG_SZ"
   WshShell.RegWrite sClsKey & "FloorpURL2\shell\open\command\", sExecPath & _
   " -url " & """" & "%1" & """", "REG_SZ"
   WshShell.RegWrite sClsKey & "FloorpURL2\shell\open\ddeexec\", "", "REG_SZ"

   'Default Apps Registration/Capabilities
   WshShell.RegWrite sbaseKey2, "Floorp", "REG_SZ"
   WshShell.RegWrite sbaseKey2 & "Capabilities\ApplicationDescription", sAppDesc, "REG_SZ"
   WshShell.RegWrite sbaseKey2 & "Capabilities\ApplicationIcon", sIconPath & ",0", "REG_SZ"
   WshShell.RegWrite sbaseKey2 & "Capabilities\ApplicationName", "Floorp", "REG_SZ"
   WshShell.RegWrite sbaseKey2 & "Capabilities\FileAssociations\.pdf", "FloorpPDF2", "REG_SZ"
   WshShell.RegWrite sbaseKey2 & "Capabilities\StartMenu", "Floorp", "REG_SZ"
   WshShell.RegWrite sbaseKey2 & "DefaultIcon\", sIconPath & ",0", "REG_SZ"
   WshShell.RegWrite sbaseKey2 & "shell\open\command\", sExecPath, "REG_SZ"
   WshShell.RegWrite sbaseKey2 & "shell\properties\", "Floorp &Options", "REG_SZ"
   WshShell.RegWrite sbaseKey2 & "shell\properties\command\", sExecPath & " -preferences", "REG_SZ"
   WshShell.RegWrite sbaseKey2 & "shell\safemode\", "Floorp &Safe Mode", "REG_SZ"
   WshShell.RegWrite sbaseKey2 & "shell\safemode\command\", sExecPath & " -safe-mode", "REG_SZ"

   ArrKeys = Array ( _
   "FileAssociations\.avif", _
   "FileAssociations\.htm", _
   "FileAssociations\.html", _
   "FileAssociations\.shtml", _
   "FileAssociations\.svg", _
   "FileAssociations\.webp", _
   "FileAssociations\.xht", _
   "FileAssociations\.xhtml", _
   "URLAssociations\http", _
   "URLAssociations\https", _
   "URLAssociations\mailto" _
   )

   For Each regkey In ArrKeys
      WshShell.RegWrite sbaseKey2 & "Capabilities\" & regkey, "FloorpHTML2", "REG_SZ"
   Next

   'Override the default app name by which the program appears in Default Apps  (*Optional*)
   '(i.e., -- "Mozilla Floorp, Portable Edition" Vs. "Floorp")
   'The official Mozilla Floorp setup doesn't add this registry key.
   WshShell.RegWrite sClsKey & "FloorpHTML2\Application\ApplicationIcon", sIconPath & ",0", "REG_SZ"
   WshShell.RegWrite sClsKey & "FloorpHTML2\Application\ApplicationName", "Floorp", "REG_SZ"

   'Launch Default Programs or Default Apps after registering Floorp
   WshShell.Run "control /name Microsoft.DefaultPrograms /page pageDefaultProgram"
End Sub


Sub UnRegisterFloorpPortable
   sbaseKey = "HKCU\Software\"
   sbaseKey2 = "HKCU\Software\Clients\StartmenuInternet\Floorp"

   On Error Resume Next
   WshShell.RegDelete sbaseKey & "RegisteredApplications\Floorp"
   On Error GoTo 0

   WshShell.Run "reg.exe delete " & sClsKey & "FloorpHTML2" & " /f", 0
   WshShell.Run "reg.exe delete " & sClsKey & "FloorpPDF2" & " /f", 0
   WshShell.Run "reg.exe delete " & sClsKey & "FloorpURL2" & " /f", 0
   WshShell.Run "reg.exe delete " & chr(34) & sbaseKey2 & chr(34) & " /f", 0

   'Launch Default Apps after unregistering Floorp
   WshShell.Run "control /name Microsoft.DefaultPrograms /page pageDefaultProgram"
End Sub
