
<#
.SYNOPSIS
    Governor Autonomy Loop
    Runs the Gemini Manager in a continuous background loop.
    
.DESCRIPTION
    This script acts as the "Engine" for the autonomy routine.
    It wakes up every X minutes to run the Heartbeat.
    It keeps the workspace alive and clean.
#>

$IntervalSeconds = 600 # 10 Minutes
$ScriptPath = Join-Path (Get-Location) "tools\gemini_manager.ps1"

Write-Host "Starting Governor Autonomy Loop..." -ForegroundColor Green
Write-Host "Press Ctrl+C to stop." -ForegroundColor Yellow

while ($true) {
    $Timestamp = Get-Date -Format "HH:mm:ss"
    Write-Host "[$Timestamp] Governor: Initiating Heartbeat..." -ForegroundColor DarkGray
    
    try {
        & $ScriptPath -Routine Heartbeat
        
        # Every 3rd run (30 mins), do a light sweep? Or just stick to heartbeat.
        # Let's keep it simple: Heartbeat is safe.
    }
    catch {
        Write-Error "Governor Error: $_"
    }
    
    Write-Host "[$Timestamp] Governor: Sleeping for $($IntervalSeconds/60) minutes..." -ForegroundColor DarkGray
    Start-Sleep -Seconds $IntervalSeconds
}
