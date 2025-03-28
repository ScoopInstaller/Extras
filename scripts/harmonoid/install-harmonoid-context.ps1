New-Item 'HKCU:\Software\Classes\Directory\shell\HarmonoidAddToPlaylist' -Value 'Add to Harmonoid''s Playlist' -Force | Out-Null
New-Item 'HKCU:\Software\Classes\Directory\shell\HarmonoidAddToPlaylist\command' -Value """CURRENT_DIRECTORY\harmonoid.exe""  ""%1""" -Force | Out-Null
New-ItemProperty 'HKCU:\Software\Classes\Directory\shell\HarmonoidAddToPlaylist' -Name 'Icon' -Value "CURRENT_DIRECTORY\harmonoid.exe,0" -PropertyType 'String' -Force | Out-Null
