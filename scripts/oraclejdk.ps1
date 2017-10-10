param($dir)

# Second extraction
$output = 7z x $dir\tools.zip "-o$dir"
rm $dir\tools.zip

# Convert .pack to .jar, and removes .pack
ls "$dir" -recurse | ? name -match '^[^_].*?\.(?i)pack$' | % {
    $name = $_.fullname -replace '\.(?i)pack$', ''
    $pack = "$name.pack"
    $jar = "$name.jar"
    & "$dir\bin\unpack200.exe" "-r" "$pack" "$jar"
}
