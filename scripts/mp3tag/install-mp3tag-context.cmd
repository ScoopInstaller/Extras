@echo off
reg add "HKCU\SOFTWARE\Classes\*\shell\&Mp3tag" /v "MUIVerb" /t REG_SZ /d "&Mp3tag" /f
reg add "HKCU\SOFTWARE\Classes\*\shell\&Mp3tag" /v "Icon" /t REG_SZ /d "REPLACE_HERE\Mp3tag.exe,0" /f
reg add "HKCU\SOFTWARE\Classes\*\shell\&Mp3tag\command" /ve /t REG_SZ /d "REPLACE_HERE\Mp3tag.exe  \"%%1\"" /f
reg add "HKCU\SOFTWARE\Classes\Directory\shell\&Mp3tag" /v "MUIVerb" /t REG_SZ /d "&Mp3tag" /f
reg add "HKCU\SOFTWARE\Classes\Directory\shell\&Mp3tag" /v "Icon" /t REG_SZ /d "REPLACE_HERE\Mp3tag.exe,0" /f
reg add "HKCU\SOFTWARE\Classes\Directory\shell\&Mp3tag\command" /ve /t REG_SZ /d "REPLACE_HERE\Mp3tag.exe  \"%%1\"" /f

