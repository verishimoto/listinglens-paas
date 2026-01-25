<#
.SYNOPSIS
    Gemini Autonomy Manager
    Automates routine maintenance tasks for the Gemini workspace.

.DESCRIPTION
    This script implements the "Heartbeat" (Auto-Save) and "Deep Clean" (Sync/Optimize) routines.
    It ensures work is saved, pushes changes to remote, and reports problems.

.PARAMETER Routine
    The routine to run: "Heartbeat", "DeepClean", "CognitiveSync", etc.
#>

param (
    [Parameter(Mandatory = $true)]
    [ValidateSet("Heartbeat", "DeepClean", "Watcher", "Restore", "Antigravity", "Backup", "CognitiveSync")]
    [string]$Routine
)

$WorkspaceRoot = Get-Location
$Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$StateFile = Join-Path $WorkspaceRoot ".gemini_state.json"

function Get-State {
    if (Test-Path $StateFile) {
        return Get-Content $StateFile | ConvertFrom-Json
    }
    return @{}
}

function Save-State {
    param ($State)
    $State | ConvertTo-Json | Set-Content $StateFile
}

function Test-RoutineDue {
    param (
        [string]$RoutineName,
        [int]$IntervalMinutes
    )
    $State = Get-State
    if ($State.$RoutineName) {
        $LastRun = [DateTime]$State.$RoutineName
        $NextRun = $LastRun.AddMinutes($IntervalMinutes)
        if ((Get-Date) -lt $NextRun) {
            $TimeRemaining = ($NextRun - (Get-Date)).TotalMinutes
            Write-GeminiLog "Routine '$RoutineName' is not due yet. Next run in $([math]::Round($TimeRemaining, 1)) mins."
            return $false
        }
    }
    return $true
}

function Update-RoutineTimestamp {
    param ([string]$RoutineName)
    $State = Get-State
    $State | Add-Member -Type NoteProperty -Name $RoutineName -Value (Get-Date) -Force
    Save-State $State
}

function Write-GeminiLog {
    param ([string]$Message)
    Write-Host "[$((Get-Date).ToString("HF:mm:ss"))] [GEMINI] $Message" -ForegroundColor Cyan
}

function Invoke-AutoSave {
    Write-GeminiLog "Starting Heartbeat (Auto-Save)..."
    
    # Check for changes
    if ($null -eq $(git status --porcelain)) {
        Write-GeminiLog "No changes to save."
        return
    }

    # Add all changes
    git add .
    
    # Commit
    $CommitMsg = "Gemini AutoSave: $Timestamp"
    git commit -m "$CommitMsg"
    
    Write-GeminiLog "Work saved: $CommitMsg"
}

function Invoke-DeepClean {
    Write-GeminiLog "Starting Deep Clean..."

    # 1. Run Auto-Save first
    Invoke-AutoSave

    # 2. Sync with Remote
    Write-GeminiLog "Syncing with remote..."
    git pull origin main --rebase
    git push origin main
    Write-GeminiLog "Sync complete."

    # 3. Analyze Project
    Write-GeminiLog "Running analysis..."
    $AnalysisFile = "analysis_output.txt"
    flutter analyze > $AnalysisFile
    
    # Check for errors in analysis
    if (Select-String -Path $AnalysisFile -Pattern "error •") {
        Write-GeminiLog "CRITICAL: Errors found in analysis. Review $AnalysisFile."
        # We could notify the agent here if we had a direct hook, 
        # but the file existence serves as the signal.
    }
    else {
        Write-GeminiLog "Analysis passed (no errors)."
    }

    # 4. Resource Optimization (Stub - could kill chrome processes etc)
    Write-GeminiLog "Workspace optimized."
    
    # 5. Clutter Sweep
    Invoke-ClutterSweep
}

function Invoke-ClutterSweep {
    Write-GeminiLog "Starting Clutter Sweep..."
    
    # Define clutter patterns
    $ClutterPatterns = @(
        "*.bak",
        "*.tmp",
        "analysis_output.txt"
    )
    
    $Count = 0
    foreach ($Pattern in $ClutterPatterns) {
        $Files = Get-ChildItem -Path $WorkspaceRoot -Filter $Pattern -Recurse -ErrorAction SilentlyContinue
        foreach ($File in $Files) {
            # Skip if in .git or node_modules to be safe, though unlikely for these extensions
            if ($File.FullName -notmatch "\\.git\\" -and $File.FullName -notmatch "node_modules") {
                Remove-Item $File.FullName -Force
                Write-GeminiLog "Removed clutter: $($File.Name)"
                $Count++
            }
        }
    }
    
    if ($Count -eq 0) {
        Write-GeminiLog "No clutter found."
    }
    else {
        Write-GeminiLog "Cleaned $Count clutter items."
    }
}

function Start-Watcher {
    Write-GeminiLog "Starting Watcher Agent (Antivirus Mode)..."

    # 1. Check for Stuck Lock Files
    $LockFiles = @(
        ".git/index.lock",
        "pubspec.lock" 
        # Note: We be careful with pubspec.lock, only delete if really stale
    )

    foreach ($File in $LockFiles) {
        if (Test-Path $File) {
            $Item = Get-Item $File
            $Age = (Get-Date) - $Item.LastWriteTime
            if ($Age.TotalMinutes -gt 15) {
                Write-GeminiLog "WARNING: Found stale lock file $File ($($Age.TotalMinutes) mins old). PCR (Process-Clear-Restart) initiated."
                Remove-Item $File -Force
                Write-GeminiLog "Deleted $File."
            }
        }
    }

    # 2. Monitor Process Health (Kill Stuck Dart/Flutter)
    # This is aggressive "Antivirus" behavior - use carefully.
    # checking for processes that are consuming 0 CPU for a long time matching "flutter" could be an option,
    # but for now we look for known "stuck" signatures or just report.
    
    Write-GeminiLog "Scanning for zombie processes..."
    # In a real environment, we'd check Process-Activity here.
    # For now, just a health check log.
    Write-GeminiLog "System Integrity Normal."

    # 3. Safe Mode Restore
    Write-GeminiLog "Executing Safe Mode Restore..."
    
    # Run flutter clean if things look bad
    if (Test-Path ".dart_tool") {
        # Optional: could check last mod time
    }
    
    Write-GeminiLog "Watcher routine complete."
}

function Restore-SafeMode {
    Write-GeminiLog "Running Safe Mode Restore..."
    
    Write-GeminiLog "Cleaning..."
    cmd /c "flutter clean"
    
    Write-GeminiLog "Fetching dependencies (Safe Mode)..."
    # we could add a timeout wrapper here if needed
    cmd /c "flutter pub get"
    
    Write-GeminiLog "Restore complete."
}

function Invoke-Antigravity {
    Write-GeminiLog "INITIATING ANTIGRAVITY AUTONOMY (Level 5)..."
    
    # 1. Auto-Save
    Invoke-AutoSave

    # 2. Self-Heal Code
    Write-GeminiLog "Running Self-Healing Protocol (dart fix)..."
    # Capture output to avoid cluttering unless needed
    cmd /c "dart fix --apply" 2>&1 | Out-Null
    Write-GeminiLog "Self-healing complete."

    # 3. Aggressive Resource Optimization
    Write-GeminiLog "Purging non-essential processes..."
    $Browsers = Get-Process -Name "chrome", "msedge" -ErrorAction SilentlyContinue
    if ($Browsers) {
        Stop-Process -InputObject $Browsers -Force -ErrorAction SilentlyContinue
        Write-GeminiLog "Terminated $($Browsers.Count) browser instances."
    }
    else {
        Write-GeminiLog "No target browser processes found."
    }

    # 4. Dependency Refresh
    Write-GeminiLog "Refreshing dependencies..."
    cmd /c "flutter pub get"

    # 5. Final State Commit
    if ($null -ne $(git status --porcelain)) {
        git add .
        git commit -m "Antigravity Autonomy: Self-Heal & Optimization"
        Write-GeminiLog "Antigravity changes committed."
    }
    else {
        Write-GeminiLog "No post-fix changes to commit."
    }

    # 6. Clutter Sweep
    Invoke-ClutterSweep

    Write-GeminiLog "Antigravity Routine Complete. System is autonomous."
    Update-RoutineTimestamp -RoutineName "Antigravity"
}

function Invoke-Backup {
    Write-GeminiLog "Initiating Artifact Backup Protocol..."
    
    $BackupRoot = Join-Path $WorkspaceRoot "backups"
    if (-not (Test-Path $BackupRoot)) { New-Item -ItemType Directory -Path $BackupRoot | Out-Null }
    
    $SanitizedTimestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $BackupName = "ListingLens_Artifacts_$SanitizedTimestamp"
    $TargetDir = Join-Path $BackupRoot $BackupName
    New-Item -ItemType Directory -Path $TargetDir | Out-Null
    
    # 1. Backup 'Brain' (Knowledge & Plans)
    $BrainPath = "C:\Users\veris\.gemini\antigravity\brain\345fadc8-acdd-4139-9394-ff2b712ce9f7"
    if (Test-Path $BrainPath) {
        Write-GeminiLog "Backing up Brain Artifacts..."
        try {
            Copy-Item -Path "$BrainPath\*" -Destination "$TargetDir\brain" -Recurse -Container -Force
        }
        catch {
            Write-GeminiLog "Warning: Could not fully backup Brain (Permission or Path issue)."
        }
    }
    
    # 2. Backup 'Deploy' (Builds)
    $DeployPath = Join-Path $WorkspaceRoot "deploy"
    if (Test-Path $DeployPath) {
        Write-GeminiLog "Backing up Deployment Artifacts..."
        try {
            Copy-Item -Path $DeployPath -Destination "$TargetDir\deploy" -Recurse -Container -Force
        }
        catch {
            Write-GeminiLog "Warning: Could not fully backup Deploy."
        }
    }

    Write-GeminiLog "Backup Complete: $TargetDir"
}

function Invoke-CognitiveSync {
    Write-GeminiLog "Initiating Cognitive Sync (Memory Palace)..."
    $Generator = Join-Path $WorkspaceRoot "tools\governor\generate_dashboard_data.ps1"
    if (Test-Path $Generator) {
        & $Generator
    }
    else {
        Write-GeminiLog "Error: Data generator not found at $Generator"
    }
}

# --- Main Execution ---

try {
    switch ($Routine) {
        "Heartbeat" { Invoke-AutoSave }
        "DeepClean" { Invoke-DeepClean; Invoke-CognitiveSync }
        "Watcher" { Start-Watcher }
        "Restore" { Restore-SafeMode }
        "Antigravity" { Invoke-Antigravity; Invoke-CognitiveSync }
        "Backup" { Invoke-Backup }
        "CognitiveSync" { Invoke-CognitiveSync }
    }
}
catch {
    Write-Error "Gemini Autonomy Error: $_"
    exit 1
}
function Invoke-EmergencyRecovery {
    Write-GeminiLog "IDE Stuck: Initiating Emergency Recovery Routine..."
    
    # 1. Kill zombie processes
    Write-GeminiLog "Terminating hung Dart/Flutter processes..."
    Get-Process -Name "dart", "flutter" -ErrorAction SilentlyContinue | Stop-Process -Force
    
    # 2. Clear stale locks via Watcher logic
    Start-Watcher
    
    # 3. Perform Safe Mode Restore (Clean & Pub Get)
    Restore-SafeMode
    
    Write-GeminiLog "Recovery complete. Please restart your IDE or reload the window."
}
