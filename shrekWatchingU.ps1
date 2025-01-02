# URL of the image
$imageUrl = "https://raw.githubusercontent.com/UvFlint/pranks/refs/heads/main/shrekWatchingU.jpg"

# Path to save the downloaded image
$imagePath = "$env:TEMP\shrekWatchingU.jpg"

# Download the image
try {
    Invoke-WebRequest -Uri $imageUrl -OutFile $imagePath
    Write-Host "Image downloaded to $imagePath"
}
catch {
    Write-Host "Failed to download the image. Please check the URL and try again."
    exit
}

# Check if the image was downloaded successfully
if (-Not (Test-Path -Path $imagePath)) {
    Write-Host "Downloaded image file not found. Exiting."
    exit
}

# Registry path for wallpaper settings
$registryPath = "HKCU:\Control Panel\Desktop"

# Configure wallpaper style
# WallpaperStyle: 0 = Centered, 2 = Stretched, 6 = Fit, 10 = Fill
Set-ItemProperty -Path $registryPath -Name WallpaperStyle -Value 10
Set-ItemProperty -Path $registryPath -Name TileWallpaper -Value 0

# Set the downloaded image as the wallpaper
Add-Type -TypeDefinition @"
using System.Runtime.InteropServices;
public class Wallpaper {
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@

[Wallpaper]::SystemParametersInfo(20, 0, $imagePath, 0x01 -bor 0x02)

Write-Host "Wallpaper successfully set to the image at $imagePath"
