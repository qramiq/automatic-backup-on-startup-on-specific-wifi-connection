# Specify the Wi-Fi SSID (network name) you want to trigger on
$expectedWifi = "Your Wifi Name"  # Replace with your Wi-Fi network name

# Define the path to the log file on the desktop
$desktopPath = [System.Environment]::GetFolderPath("Desktop")
$logFile = Join-Path -Path $desktopPath -ChildPath "wifi_connection_log.txt"

# Define the source and destination for the backup
$sourcePath = "C:\Your\Prefferd\Storage\Path"  # Source path (C drive)
$destinationPath = "D:\Your\path\where\backup\is\stored"  # Destination path (external drive)

# Continuously check for the Wi-Fi connection
while ($true) {
    # Get current Wi-Fi connection details
    $wifiConnection = (netsh wlan show interfaces) | Select-String "SSID"

    # Get current timestamp for logging
    $currentDateTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    # Check if the connected Wi-Fi matches the expected SSID
    if ($wifiConnection -match $expectedWifi) {
        # If connected to the expected Wi-Fi, log success
        $logMessage = "$currentDateTime - Connected to the expected Wi-Fi network: $expectedWifi"
        Write-Host $logMessage
    } else {
        # If not connected to the expected Wi-Fi, log failure
        $logMessage = "$currentDateTime - Not connected to the expected Wi-Fi network."
        Write-Host $logMessage
    }

    # Append log message to the log file
    $logMessage | Out-File -Append -FilePath $logFile

    # Perform the backup with robocopy (if connected to Wi-Fi)
    if ($wifiConnection -match $expectedWifi) {
        $robocopyCommand = "robocopy $sourcePath $destinationPath /E /COPY:DATSO >> $logFile"
        Write-Host "Starting backup with robocopy..."
        
        # Run the robocopy command
        Invoke-Expression $robocopyCommand

        Write-Host "Backup completed."
    }

    # Wait for 60 seconds before checking again
    Start-Sleep -Seconds 60
}
