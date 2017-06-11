param($dir)

# First extraction (until extract_to supports 7zip)
mkdir -p "$dir\_tmp" >$null
$output = 7z x "$dir\dl.exe" "-o$dir\_tmp"

# Java Source (src.zip)
$output = 7z x "$dir\_tmp\.rsrc\1033\JAVA_CAB9\110" "-o$dir"
# JDK (tools.zip)
$output = 7z x "$dir\_tmp\.rsrc\1033\JAVA_CAB10\111" "-o$dir"
$output = 7z x "$dir\tools.zip" "-o$dir"
rm "$dir\tools.zip"
# Copyright (COPYRIGHT)
$output = 7z x "$dir\_tmp\.rsrc\1033\JAVA_CAB11\112" "-o$dir"

# Convert .pack to .jar, and removes .pack
ls "$dir" -recurse | ? name -match '^[^_].*?\.(?i)pack$' | % {
    $name = $_.fullname -replace '\.(?i)pack$', ''
    $pack = "$name.pack"
    $jar = "$name.jar"
    & "$dir\bin\unpack200.exe" "-r" "$pack" "$jar"
}

rm -r "$dir\_tmp"
