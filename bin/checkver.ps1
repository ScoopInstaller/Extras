param(
    [String]$app, #optionally pass an app name to just check one app
    [Switch]$update = $false
)

$bin = split-path (scoop which scoop)
$checkver = "$bin\checkver.ps1"
$dir = "$psscriptroot\.." # checks the parent dir

if($update) {
    & $checkver -app $app -dir $dir -u
} else {
    & $checkver -app $app -dir $dir
}
