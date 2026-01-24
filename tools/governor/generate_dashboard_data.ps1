
<#
.SYNOPSIS
    Governor Cognitive Sync
    Generates the "Memory Palace" state file for the Dashboard.

.DESCRIPTION
    Scans the workspace, parses task.md, and outputs a JSON file
    containing the project topology and cognitive state.
#>

$WorkspaceRoot = Get-Location
$TaskFile = Join-Path "C:\Users\veris\.gemini\antigravity\brain\1c648865-be7f-412d-918d-ac6318548178" "task.md"
$OutputFile = Join-Path $WorkspaceRoot "deploy\governor\state.json"
$DeployGovernorDir = Join-Path $WorkspaceRoot "deploy\governor"

# Ensure output directory exists
if (-not (Test-Path $DeployGovernorDir)) {
    New-Item -ItemType Directory -Path $DeployGovernorDir -Force | Out-Null
}

function Get-ProjectTopology {
    # Generate tree structure
    # We'll use a simplified depth-limited scan to avoid huge JSONs
    
    $Tree = @()
    $Items = Get-ChildItem -Path $WorkspaceRoot -Recurse -Depth 3 | Where-Object { 
        $_.FullName -notmatch "\\.git" -and 
        $_.FullName -notmatch "node_modules" -and
        $_.FullName -notmatch "build" -and
        $_.FullName -notmatch "deploy"
    }

    foreach ($Item in $Items) {
        $Node = @{
            name  = $Item.Name
            path  = $Item.FullName.Replace($WorkspaceRoot.Path, "").Replace("\", "/")
            type  = if ($Item.PSIsContainer) { "folder" } else { "file" }
            depth = ($Item.FullName.Split("\").Count - $WorkspaceRoot.Path.Split("\").Count)
        }
        $Tree += $Node
    }
    return $Tree
}

function Get-CognitiveState {
    $Content = ""
    if (Test-Path $TaskFile) {
        $Content = Get-Content $TaskFile -Raw
    }
    return $Content
}

return $Content
}

function Measure-CognitiveMetrics {
    # Heuristics Engine (Low-Token Optimization)
    
    # 1. Entropy (Clutter Index)
    # Count tmp/bak files
    $ClutterCount = (Get-ChildItem -Path $WorkspaceRoot -Recurse -Include "*.bak", "*.tmp", "*.log" -ErrorAction SilentlyContinue).Count
    $TotalFiles = (Get-ChildItem -Path $WorkspaceRoot -Recurse -File -ErrorAction SilentlyContinue).Count
    $EntropyScore = if ($TotalFiles -gt 0) { [math]::Round(($ClutterCount / $TotalFiles) * 100, 1) } else { 0 }

    # 2. Autonomy (Governor Interaction)
    # Estimate based on 'task.md' completion ratio
    $TasksTotal = 0
    $TasksDone = 0
    if (Test-Path $TaskFile) {
        $TaskContent = Get-Content $TaskFile
        $TasksTotal = ($TaskContent | Select-String "- \[ \]").Count + ($TaskContent | Select-String "- \[x\]").Count
        $TasksDone = ($TaskContent | Select-String "- \[x\]").Count
    }
    $AutonomyScore = if ($TasksTotal -gt 0) { [math]::Round(($TasksDone / $TasksTotal) * 100, 1) } else { 0 }

    # 3. Strategy (Value Stream)
    # Prompt 192 (Regression to Mean): Are we stabilizing?
    # Simple heuristic: Low entropy + High autonomy = High Strategy
    $StrategyScore = [math]::Round(($AutonomyScore - $EntropyScore), 1)
    if ($StrategyScore -lt 0) { $StrategyScore = 0 }
    
    # 4. Epistemic Confidence (Prompt 134)
    # Based on depth of documentation relative to code
    $DocFiles = (Get-ChildItem -Path $WorkspaceRoot -Recurse -Include "*.md", "*.txt" -ErrorAction SilentlyContinue).Count
    $CodeFiles = (Get-ChildItem -Path $WorkspaceRoot -Recurse -Include "*.dart", "*.py", "*.js" -ErrorAction SilentlyContinue).Count
    $ConfidenceMode = if ($CodeFiles -gt 0 -and ($DocFiles / $CodeFiles) -ge 0.1) { "Confident" } else { "Learning" }

    return @{
        entropy    = $EntropyScore
        autonomy   = $AutonomyScore
        strategy   = $StrategyScore
        confidence = $ConfidenceMode
    }
}

Write-Host "Syncing Cognitive State..." -ForegroundColor Cyan

$Topology = Get-ProjectTopology
$Cognition = Get-CognitiveState
$Metrics = Measure-CognitiveMetrics
$Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

$State = @{
    timestamp = $Timestamp
    topology  = $Topology
    cognition = $Cognition
    metrics   = $Metrics
    status    = "Active"
}

$State | ConvertTo-Json -Depth 5 | Set-Content $OutputFile -Encoding UTF8
Write-Host "Memory Palace Updated: $OutputFile" -ForegroundColor Green
