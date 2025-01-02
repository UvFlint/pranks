Function Set-MouseSpeed {
    [CmdletBinding()]
    param (
        [validateRange(1, 20)]
        [int] $Value
    )

    $winApi = add-type -name user32 -namespace tq84 -passThru -memberDefinition '
   [DllImport("user32.dll")]
    public static extern bool SystemParametersInfo(
       uint uiAction,
       uint uiParam ,
       uint pvParam ,
       uint fWinIni
    );
'

    $SPI_SETMOUSESPEED = 0x0071
    $MouseSpeedRegPath = 'hkcu:\Control Panel\Mouse'
    Write-Verbose "MouseSensitivity before WinAPI call:  $((get-itemProperty $MouseSpeedRegPath).MouseSensitivity)"

    $null = $winApi::SystemParametersInfo($SPI_SETMOUSESPEED, 0, $Value, 0)

    #
    #    Calling SystemParametersInfo() does not permanently store the modification
    #    of the mouse speed. It needs to be changed in the registry as well
    #

    set-itemProperty $MouseSpeedRegPath -name MouseSensitivity -value $Value

    Write-Verbose   "MouseSensitivity after WinAPI call:  $((get-itemProperty $MouseSpeedRegPath).MouseSensitivity)"
}

Set-MouseSpeed -Value 1 -Verbose