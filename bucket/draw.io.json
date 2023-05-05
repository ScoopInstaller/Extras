{
    "version": "21.2.8",
    "description": "Professional diagramming",
    "homepage": "https://www.diagrams.net",
    "license": "Apache-2.0",
    "architecture": {
        "64bit": {
            "url": "https://github.com/jgraph/drawio-desktop/releases/download/v21.2.8/draw.io-21.2.8-windows-installer.exe#/dl.7z",
            "hash": "d58264f5c8509beda6fe49989eb25fdd41b72cd2b4ae3aa7deee5b27c3194a30",
            "pre_install": [
                "Expand-7zipArchive \"$dir\\`$PLUGINSDIR\\app-64.7z\" \"$dir\"",
                "Remove-Item \"$dir\\`$*\", \"$dir\\Uninstall*\" -Recurse"
            ]
        },
        "32bit": {
            "url": "https://github.com/jgraph/drawio-desktop/releases/download/v21.2.8/draw.io-ia32-21.2.8-windows-32bit-installer.exe#/dl.7z",
            "hash": "8181ff1568445bd7091d9aa6690074100f22bd76091eb7eaa70782ef0f889c28",
            "pre_install": [
                "Expand-7zipArchive \"$dir\\`$PLUGINSDIR\\app-32.7z\" \"$dir\"",
                "Remove-Item \"$dir\\`$*\", \"$dir\\Uninstall*\" -Recurse"
            ]
        }
    },
    "bin": "draw.io.exe",
    "shortcuts": [
        [
            "draw.io.exe",
            "draw.io"
        ]
    ],
    "checkver": {
        "github": "https://github.com/jgraph/drawio-desktop"
    },
    "autoupdate": {
        "architecture": {
            "64bit": {
                "url": "https://github.com/jgraph/drawio-desktop/releases/download/v$version/draw.io-$version-windows-installer.exe#/dl.7z"
            },
            "32bit": {
                "url": "https://github.com/jgraph/drawio-desktop/releases/download/v$version/draw.io-ia32-$version-windows-32bit-installer.exe#/dl.7z"
            }
        },
        "hash": {
            "url": "$baseurl/Files-SHA256-Hashes.txt",
            "regex": "$basename\\s*?$sha256"
        }
    }
}
