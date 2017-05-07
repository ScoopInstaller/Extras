. "$env:scoop_home\test\Scoop-TestLib.ps1"
. "$env:scoop_home\lib\core.ps1"
. "$env:scoop_home\lib\manifest.ps1"

$repo_dir = (Get-Item $MyInvocation.MyCommand.Path).directory.FullName

$repo_files = @(Get-ChildItem $repo_dir -file -recurse)

$project_file_exclusions = @(
    $([regex]::Escape($repo_dir)+'\\.git\\.*$'),
    '.sublime-workspace$'
)

describe 'Style constraints for non-binary project files' {

    $files = @(
        # gather all files except '*.exe', '*.zip', or any .git repository files
        $repo_files |
            where-object { $_.fullname -inotmatch $($project_file_exclusions -join '|') } |
            where-object { $_.fullname -inotmatch '(.exe|.zip|.dll)$' }
    )

    $files_exist = ($files.Count -gt 0)

    it $('non-binary project files exist ({0} found)' -f $files.Count) -skip:$(-not $files_exist) {
        if (-not ($files.Count -gt 0))
        {
            throw "No non-binary project were found"
        }
    }

    it 'files do not contain leading utf-8 BOM' -skip:$(-not $files_exist) {
        # utf-8 BOM == 0xEF 0xBB 0xBF
        # see http://www.powershellmagazine.com/2012/12/17/pscxtip-how-to-determine-the-byte-order-mark-of-a-text-file @@ https://archive.is/RgT42
        # ref: http://poshcode.org/2153 @@ https://archive.is/sGnnu
        $badFiles = @(
            foreach ($file in $files)
            {
                $content = ([char[]](Get-Content $file.FullName -encoding byte -totalcount 3) -join '')
                if ([regex]::match($content, '(?ms)^\xEF\xBB\xBF').success)
                {
                    $file.FullName
                }
            }
        )

        if ($badFiles.Count -gt 0)
        {
            throw "The following files have utf-8 BOM: `r`n`r`n$($badFiles -join "`r`n")"
        }
    }

    it 'files end with a newline' -skip:$(-not $files_exist) {
        $badFiles = @(
            foreach ($file in $files)
            {
                $string = [System.IO.File]::ReadAllText($file.FullName)
                if ($string.Length -gt 0 -and $string[-1] -ne "`n")
                {
                    $file.FullName
                }
            }
        )

        if ($badFiles.Count -gt 0)
        {
            throw "The following files do not end with a newline: `r`n`r`n$($badFiles -join "`r`n")"
        }
    }

    it 'file newlines are CRLF' -skip:$(-not $files_exist) {
        $badFiles = @(
            foreach ($file in $files)
            {
                $content = Get-Content -raw $file.FullName
                if(!$content) {
                    throw "File contents are null: $($file.FullName)"
                }
                $lines = [regex]::split($content, '\r\n')
                $lineCount = $lines.Count

                for ($i = 0; $i -lt $lineCount; $i++)
                {
                    if ( [regex]::match($lines[$i], '\r|\n').success )
                    {
                        $file.FullName
                        break
                    }
                }
            }
        )

        if ($badFiles.Count -gt 0)
        {
            throw "The following files have non-CRLF line endings: `r`n`r`n$($badFiles -join "`r`n")"
        }
    }

    it 'files have no lines containing trailing whitespace' -skip:$(-not $files_exist) {
        $badLines = @(
            foreach ($file in $files)
            {
                $lines = [System.IO.File]::ReadAllLines($file.FullName)
                $lineCount = $lines.Count

                for ($i = 0; $i -lt $lineCount; $i++)
                {
                    if ($lines[$i] -match '\s+$')
                    {
                        'File: {0}, Line: {1}' -f $file.FullName, ($i + 1)
                    }
                }
            }
        )

        if ($badLines.Count -gt 0)
        {
            throw "The following $($badLines.Count) lines contain trailing whitespace: `r`n`r`n$($badLines -join "`r`n")"
        }
    }

    it 'any leading whitespace consists only of spaces (excepting makefiles)' -skip:$(-not $files_exist) {
        $badLines = @(
            foreach ($file in $files)
            {
                if ($file.fullname -inotmatch '(^|.)makefile$')
                {
                    $lines = [System.IO.File]::ReadAllLines($file.FullName)
                    $lineCount = $lines.Count

                    for ($i = 0; $i -lt $lineCount; $i++)
                    {
                        if ($lines[$i] -notmatch '^[ ]*(\S|$)')
                        {
                            'File: {0}, Line: {1}' -f $file.FullName, ($i + 1)
                        }
                    }
                }
            }
        )

        if ($badLines.Count -gt 0)
        {
            throw "The following $($badLines.Count) lines contain TABs within leading whitespace: `r`n`r`n$($badLines -join "`r`n")"
        }
    }

}

describe "manifest-validation" {
    beforeall {
        $working_dir = setup_working "manifest"
        $schema = "$env:scoop_home\schema.json"
        Add-Type -Path "$env:scoop_home\supporting\validator\Newtonsoft.Json.dll"
        Add-Type -Path "$env:scoop_home\supporting\validator\Newtonsoft.Json.Schema.dll"
        Add-Type -Path "$env:scoop_home\supporting\validator\Scoop.Validator.dll"
    }

    it "Scoop.Validator is available" {
        ([System.Management.Automation.PSTypeName]'Scoop.Validator').Type | should be 'Scoop.Validator'
    }

    context "manifest validates against the schema" {
        beforeall {
            $bucketdir = "$psscriptroot"
            $manifest_files = gci $bucketdir *.json
            $validator = new-object Scoop.Validator($schema, $true)
        }
        $manifest_files | % {
            it "$_" {
                $validator.Validate($_.fullname)
                if ($validator.Errors.Count -gt 0) {
                    write-host -f yellow $validator.ErrorsAsString
                }
                $validator.Errors.Count | should be 0

                $manifest = parse_json $_.fullname
                $url = arch_specific "url" $manifest "32bit"
                $url64 = arch_specific "url" $manifest "64bit"
                if(!$url) {
                    $url = $url64
                }
                $url | should not benullorempty
            }
        }
    }
}
