# URL of the GIF
$gifUrl = "https://raw.githubusercontent.com/UvFlint/pranks/refs/heads/main/icegif-380.gif"

# Path to save the downloaded GIF locally
$gifPath = "$env:TEMP\icegif-380.gif"

# Download the GIF
try {
    Invoke-WebRequest -Uri $gifUrl -OutFile $gifPath
    Write-Host "GIF downloaded to $gifPath"
}
catch {
    Write-Host "Failed to download the GIF. Please check the URL and try again."
    exit
}

# Open the GIF with the default program
Start-Process $gifPath

Write-Host "GIF opened in the default program. You can close this PowerShell window safely."
