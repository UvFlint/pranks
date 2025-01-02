# Registry path for hiding desktop icons
$registryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"

# Set the 'HideIcons' value to 1 (1 = Hide, 0 = Show)
Set-ItemProperty -Path $registryPath -Name HideIcons -Value 1

# Refresh the desktop to apply changes
Stop-Process -Name explorer -Force

Write-Host "All desktop icons are now hidden."
