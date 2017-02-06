. "$env:scoop_home\lib\manifest.ps1"

describe "manifest-validation" {
    $bucketdir = "$psscriptroot"
    $manifest_files = gci $bucketdir *.json

    $manifest_files | % {
        it "test validity of $_" {
            $manifest = parse_json $_.fullname

            $url = arch_specific "url" $manifest "32bit"
            $url | should not match "\$"
            $url64 = arch_specific "url" $manifest "64bit"
            $url64 | should not match "\$"
            if(!$url) {
                $url = $url64
            }
            $url | should not benullorempty

            $extract_dir32 = arch_specific "extract_dir" $manifest "32bit"
            $extract_dir32 | should not match "\$"
            $extract_dir64 = arch_specific "extract_dir" $manifest "64bit"
            $extract_dir64 | should not match "\$"

            $manifest | should not benullorempty
            $manifest.version | should not benullorempty
        }
    }
}
