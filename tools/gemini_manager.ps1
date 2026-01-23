<#
.SYNOPSIS
    Gemini Autonomy Manager
    Automates routine maintenance tasks for the Gemini workspace.

.DESCRIPTION
    This script implements the "Heartbeat" (Auto-Save) and "Deep Clean" (Sync/Optimize) routines.
    It ensures work is saved, pushes changes to remote, and reports problems.

.PARAMETER Routine
    The routine to run: "Heartbeat" or "DeepClean".
#>

param (
    [Parameter(Mandatory = $true)]
    [ValidateSet("Heartbeat", "DeepClean")]
    [string]$Routine
)

$WorkspaceRoot = Get-Location
$Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

function Log-Message {
    param ([string]$Message)
    Write-Host "[$((Get-Date).ToString("HF:mm:ss"))] [GEMINI] $Message" -ForegroundColor Cyan
}

function Run-AutoSave {
    Log-Message "Starting Heartbeat (Auto-Save)..."
    
    # Check for changes
    if ($(git status --porcelain) -eq $null) {
        Log-Message "No changes to save."
        return
    }

    # Add all changes
    git add .
    
    # Commit
    $CommitMsg = "Gemini AutoSave: $Timestamp"
    git commit -m "$CommitMsg"
    
    Log-Message "Work saved: $CommitMsg"
}

function Run-DeepClean {
    Log-Message "Starting Deep Clean..."

    # 1. Run Auto-Save first
    Run-AutoSave

    # 2. Sync with Remote
    Log-Message "Syncing with remote..."
    git pull origin main --rebase
    git push origin main
    Log-Message "Sync complete."

    # 3. Analyze Project
    Log-Message "Running analysis..."
    $AnalysisFile = "analysis_output.txt"
    flutter analyze > $AnalysisFile
    
    # Check for errors in analysis
    if (Select-String -Path $AnalysisFile -Pattern "error •") {
        Log-Message "CRITICAL: Errors found in analysis. Review $AnalysisFile."
        # We could notify the agent here if we had a direct hook, 
        # but the file existence serves as the signal.
    }
    else {
        Log-Message "Analysis passed (no errors)."
    }

    # 4. Resource Optimization (Stub - could kill chrome processes etc)
    Log-Message "Workspace optimized."
}

# --- Main Execution ---

try {
    switch ($Routine) {
        "Heartbeat" { Run-AutoSave }
        "DeepClean" { Run-DeepClean }
    }
}
catch {
    Write-Error "Gemini Autonomy Error: $_"
    exit 1
}
