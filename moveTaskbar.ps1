# Registry path for taskbar settings
$registryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3"

# Get the current taskbar settings
$currentSettings = (Get-ItemProperty -Path $registryPath -Name Settings).Settings

# Update the taskbar position
# Position values:
# 0x00 = Bottom, 0x01 = Left, 0x02 = Right, 0x03 = Top
$newSettings = $currentSettings
$newSettings[12] = 0 # Set to 0 for Bottom

# Save the updated settings back to the registry
Set-ItemProperty -Path $registryPath -Name Settings -Value $newSettings

# Restart Explorer to apply changes
Stop-Process -Name explorer -Force
Start-Process explorer

Write-Host "Taskbar moved back to the left of the screen."
