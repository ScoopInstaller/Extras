<#
.SYNOPSIS
    Creates a Discord Shortcut (.lnk) with a specific AppUserModelID, custom icon, and arguments.
#>

# Get the directory where this script is located (Discord installation directory)
$dir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Hardcoded parameters
$ShortcutPath = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Discord.lnk"
$TargetPath = "$dir\Update.exe"
$Arguments = "--processStart Discord.exe"
$IconPath = "$dir\app.ico"
$AppUserModelID = "com.squirrel.Discord.Discord"

# --- C# Definition for IPropertyStore & IShellLink ---
$code = @"
using System;
using System.Runtime.InteropServices;
using System.Runtime.InteropServices.ComTypes;

namespace ShellLinkHelper
{
    [ComImport]
    [Guid("00021401-0000-0000-C000-000000000046")]
    internal class ShellLink
    {
    }

    [ComImport]
    [InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
    [Guid("000214F9-0000-0000-C000-000000000046")]
    internal interface IShellLink
    {
        void GetPath([Out, MarshalAs(UnmanagedType.LPWStr)] System.Text.StringBuilder pszFile, int cch, IntPtr pfd, int fFlags);
        void GetIDList(out IntPtr ppidl);
        void SetIDList(IntPtr pidl);
        void GetDescription([Out, MarshalAs(UnmanagedType.LPWStr)] System.Text.StringBuilder pszName, int cch);
        void SetDescription([MarshalAs(UnmanagedType.LPWStr)] string pszName);
        void GetWorkingDirectory([Out, MarshalAs(UnmanagedType.LPWStr)] System.Text.StringBuilder pszDir, int cch);
        void SetWorkingDirectory([MarshalAs(UnmanagedType.LPWStr)] string pszDir);
        void GetArguments([Out, MarshalAs(UnmanagedType.LPWStr)] System.Text.StringBuilder pszArgs, int cch);
        void SetArguments([MarshalAs(UnmanagedType.LPWStr)] string pszArgs);
        void GetHotkey(out short pwHotkey);
        void SetHotkey(short wHotkey);
        void GetShowCmd(out int piShowCmd);
        void SetShowCmd(int iShowCmd);
        void GetIconLocation([Out, MarshalAs(UnmanagedType.LPWStr)] System.Text.StringBuilder pszIconPath, int cch, out int piIcon);
        void SetIconLocation([MarshalAs(UnmanagedType.LPWStr)] string pszIconPath, int iIcon);
        void SetRelativePath([MarshalAs(UnmanagedType.LPWStr)] string pszPathRel, int dwReserved);
        void Resolve(IntPtr hwnd, int fFlags);
        void SetPath([MarshalAs(UnmanagedType.LPWStr)] string pszFile);
    }

    [ComImport]
    [InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
    [Guid("886D8EEB-8CF2-4446-8D02-CDBA1DBDCF99")]
    internal interface IPropertyStore
    {
        uint GetCount();
        IntPtr GetAt(uint iProp);
        void GetValue([In] ref PropertyKey key, [Out] PropVariant pv);
        void SetValue([In] ref PropertyKey key, [In] PropVariant pv);
        void Commit();
    }

    [StructLayout(LayoutKind.Sequential, Pack = 4)]
    internal struct PropertyKey
    {
        public Guid fmtid;
        public uint pid;

        public PropertyKey(Guid guid, uint id)
        {
            fmtid = guid;
            pid = id;
        }
    }

    [StructLayout(LayoutKind.Explicit)]
    internal class PropVariant : IDisposable
    {
        [FieldOffset(0)] internal ushort vt;
        [FieldOffset(8)] internal IntPtr ptr;

        public PropVariant(string value)
        {
            // VT_LPWSTR = 31
            this.vt = 31;
            this.ptr = Marshal.StringToCoTaskMemUni(value);
        }

        public void Dispose()
        {
            if (this.vt == 31 && this.ptr != IntPtr.Zero)
            {
                Marshal.FreeCoTaskMem(this.ptr);
                this.ptr = IntPtr.Zero;
            }
            GC.SuppressFinalize(this);
        }

        ~PropVariant()
        {
            Dispose();
        }
    }

    public class ShortcutCreator
    {
        public static void Create(string shortcutPath, string targetPath, string arguments, string iconPath, string appId)
        {
            IShellLink link = (IShellLink)new ShellLink();

            // 1. Set standard properties
            link.SetPath(targetPath);
            link.SetArguments(arguments);

            if (!string.IsNullOrEmpty(iconPath))
            {
                link.SetIconLocation(iconPath, 0);
            }

            // 2. Load Property Store to set AppUserModelID
            IPropertyStore propStore = (IPropertyStore)link;

            // PKEY_AppUserModel_ID: {9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3}, 5
            PropertyKey appModelIdKey = new PropertyKey(new Guid("9F4C2855-9F79-4B39-A8D0-E1D42DE1D5F3"), 5);

            if (!string.IsNullOrEmpty(appId))
            {
                using (PropVariant pv = new PropVariant(appId))
                {
                    propStore.SetValue(ref appModelIdKey, pv);
                }
                propStore.Commit();
            }

            // 3. Save
            ((IPersistFile)link).Save(shortcutPath, false);
        }
    }
}
"@

# Add the C# type to the current session
try {
    Add-Type -TypeDefinition $code -Language CSharp -ErrorAction Stop
} catch {
    # Ignore error if type already exists (e.g. running script multiple times in same session)
    if ($_.Exception.GetType().Name -ne "TypeLoadException") {
        Write-Error "Definition error: $_"
    }
}

# --- Execution Logic ---

# Ensure destination directory exists
$destinationDir = Split-Path $ShortcutPath
if (-not (Test-Path $destinationDir)) {
    New-Item -ItemType Directory -Path $destinationDir | Out-Null
}

Write-Host "Creating Discord shortcut..." -ForegroundColor Cyan
Write-Host "Target: $TargetPath"
Write-Host "Arguments: $Arguments"
Write-Host "Icon: $IconPath"
Write-Host "AppUserModelID: $AppUserModelID"

try {
    [ShellLinkHelper.ShortcutCreator]::Create($ShortcutPath, $TargetPath, $Arguments, $IconPath, $AppUserModelID)
    Write-Host "Shortcut created successfully at: $ShortcutPath" -ForegroundColor Green
}
catch {
    Write-Error "Failed to create shortcut: $_"
}
