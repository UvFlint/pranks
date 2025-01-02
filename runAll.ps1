# This script dynamically fetches and executes all .ps1 scripts in the repo.

# GitHub API URL for the repository
$apiUrl = "https://api.github.com/repos/UvFlint/pranks/contents"

# Get the list of files
$response = Invoke-RestMethod -Uri $apiUrl

# Filter for PowerShell scripts (except this file itself, if it’s also in the root)
$scripts = $response | Where-Object {
    $_.name -like "*.ps1" -and $_.name -ne "runAll.ps1"
} | Select-Object -ExpandProperty download_url

# Execute each script
foreach ($scriptUrl in $scripts) {
    Write-Host "Fetching and executing script: $scriptUrl"

    try {
        # Download the script content
        $scriptContent = Invoke-WebRequest -Uri $scriptUrl -UseBasicParsing | Select-Object -ExpandProperty Content
        
        # Execute the script content
        Invoke-Expression $scriptContent
    }
    catch {
        Write-Host (
            "Error executing script from {0}: {1}" -f $scriptUrl, $Error[0].Exception.Message
        ) -ForegroundColor Red
    }
}

Write-Host "All scripts executed."
