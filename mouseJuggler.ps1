Start-Job -ScriptBlock {
    Add-Type -AssemblyName System.Windows.Forms

    # Get the screen dimensions
    $screenWidth = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Width
    $screenHeight = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Height

    while ($true) {
        # Generate random X and Y coordinates within screen bounds
        $x = Get-Random -Minimum 0 -Maximum $screenWidth
        $y = Get-Random -Minimum 0 -Maximum $screenHeight

        # Move the cursor to the random position
        [Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($x, $y)

        Start-Sleep -Seconds 1
    }
}
