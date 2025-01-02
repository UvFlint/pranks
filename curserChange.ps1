# URL of the custom cursor
$cursorUrl = "https://raw.githubusercontent.com/UvFlint/pranks/refs/heads/main/Me%20Huey%20Gurt%20Selfie.cur"

# Path to save the cursor locally
$cursorPath = "$env:TEMP\MeHueyGurtSelfie.cur"

# Download the custom cursor
try {
    Invoke-WebRequest -Uri $cursorUrl -OutFile $cursorPath
    Write-Host "Cursor downloaded to $cursorPath"
}
catch {
    Write-Host "Failed to download the cursor. Please check the URL and try again."
    exit
}

# Ensure the file was downloaded successfully
if (-Not (Test-Path -Path $cursorPath)) {
    Write-Host "Downloaded cursor file not found. Exiting."
    exit
}

# Registry path for cursor settings
$registryPath = "HKCU:\Control Panel\Cursors"

# Set the custom cursor for the normal select pointer
Set-ItemProperty -Path $registryPath -Name "Arrow" -Value $cursorPath

# Apply the cursor changes by invoking the system to reload settings
Add-Type @"
using System.Runtime.InteropServices;
public class CursorChanger {
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern bool SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@

# SPI_SETCURSORS = 0x57, SPIF_UPDATEINIFILE = 0x01, SPIF_SENDCHANGE = 0x02
[CursorChanger]::SystemParametersInfo(0x57, 0, $null, 0x01 -bor 0x02)

Write-Host "Mouse pointer changed to the custom cursor: $cursorPath"
