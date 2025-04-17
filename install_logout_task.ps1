# Configuration
$taskName = "RunWSLCleanupOnLogout"
$scriptPath = "C:\run_wsl_cleanup.cmd"

# Check if the script exists
if (-not (Test-Path $scriptPath)) {
    Write-Host "ERROR: Script not found at $scriptPath"
    exit 1
}

# Define the action: execute the .cmd file
$action = New-ScheduledTaskAction -Execute $scriptPath

# Trigger: run at logoff for any user
$trigger = New-ScheduledTaskTrigger -AtLogOff

# Principal: all users, highest privileges
$principal = New-ScheduledTaskPrincipal -GroupId "Users" -RunLevel Highest

# Settings: allow on battery, don't stop, run when available
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable

# Register the task
Register-ScheduledTask `
    -TaskName $taskName `
    -Action $action `
    -Trigger $trigger `
    -Principal $principal `
    -Settings $settings `
    -Force

Write-Host "Task '$taskName' has been installed."
Write-Host "It will run '$scriptPath' at logoff for any user."

