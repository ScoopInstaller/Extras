. "$env:scoop_home\test\Scoop-TestLib.ps1"
. "$env:scoop_home\lib\core.ps1"
. "$env:scoop_home\lib\manifest.ps1"

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
