{
  "homepage": "https://justgetflux.com/",
  "description": "Makes the color of your computer's display adapt to the time of day, warm at night and like sunlight during the day",
  "version": "4.66",
  "url": "https://justgetflux.com/flux-setup.exe",
  "hash": "79fc802d9225d98ee15a288393bb2d4708575315b9edad33dbfcf29d1af578b1",
  "bin": "flux.exe",
  "installer": {
    "script": "cmd /c start /WAIT $dir\\flux-setup.exe /S /D=$dir"
  },
  "uninstaller": {
    "file": "uninstall.exe",
    "args": [
      "/S"
    ]
  },
  "checkver": "f.lux \\(v([\\d.]+)\\)",
  "autoupdate": {
    "url": "https://justgetflux.com/flux-setup.exe"
  }
}
