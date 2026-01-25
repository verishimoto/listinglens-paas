
<#
.SYNOPSIS
    Governor Cognitive Sync v2.0
    Generates the "Memory Palace" state file for the Dashboard.
#>

$WorkspaceRoot = (Get-Location).Path
$OutputFile = Join-Path $WorkspaceRoot "lib\governor\state.json"

# Discover Task File
$TaskFileCandidates = @(
    "$(Join-Path $WorkspaceRoot 'task.md')",
    "C:\Users\veris\.gemini\antigravity\brain\1ef74bf9-7d27-42d0-b57f-e45a2a5a4940\task.md",
    "C:\Users\veris\.gemini\antigravity\brain\95b8877a-c087-4ac8-b52f-d66b91d98313\task.md"
)
$TaskFile = ""
foreach ($f in $TaskFileCandidates) {
    if (Test-Path $f) { $TaskFile = $f; break }
}

# Other Artifacts
$WalkthroughFile = Join-Path $WorkspaceRoot "walkthrough.md"
$WorkflowFile = Join-Path $WorkspaceRoot "WORKFLOW_VISUALIZATION.md"
$TrinityFile = Join-Path $WorkspaceRoot "lib\governor\trinity_map.html"

function Get-ProjectTopology {
    $Tree = @()
    $Items = Get-ChildItem -Path $WorkspaceRoot -Recurse -Depth 3 | Where-Object { 
        $_.FullName -notmatch "\\.git" -and 
        $_.FullName -notmatch "node_modules" -and
        $_.FullName -notmatch "build" -and
        $_.FullName -notmatch "deploy" -and
        $_.FullName -notmatch "\\.dart_tool"
    }

    foreach ($Item in $Items) {
        $Node = @{
            name  = $Item.Name
            path  = $Item.FullName.Replace($WorkspaceRoot, "").Replace("\", "/")
            type  = if ($Item.PSIsContainer) { "folder" } else { "file" }
            depth = ($Item.FullName.Split("\").Count - $WorkspaceRoot.Split("\").Count)
        }
        $Tree += $Node
    }
    return $Tree
}

function Measure-CognitiveMetrics {
    # 1. Entropy
    $ClutterCount = (Get-ChildItem -Path $WorkspaceRoot -Recurse -Include "*.bak", "*.tmp", "*.log" -ErrorAction SilentlyContinue).Count
    $TotalFiles = (Get-ChildItem -Path $WorkspaceRoot -Recurse -File -ErrorAction SilentlyContinue).Count
    $EntropyScore = if ($TotalFiles -gt 0) { [math]::Round(($ClutterCount / $TotalFiles) * 100, 1) } else { 0 }

    # 2. Autonomy
    $TasksTotal = 0
    $TasksDone = 0
    if (Test-Path $TaskFile) {
        $TaskContent = Get-Content $TaskFile
        $TasksTotal = ($TaskContent | Select-String "- \[ \]").Count + ($TaskContent | Select-String "- \[x\]").Count
        $TasksDone = ($TaskContent | Select-String "- \[x\]").Count
    }
    $AutonomyScore = if ($TasksTotal -gt 0) { [math]::Round(($TasksDone / $TasksTotal) * 100, 1) } else { 0 }

    # 3. Strategy
    $StrategyScore = [math]::Round(($AutonomyScore - $EntropyScore), 1)
    if ($StrategyScore -lt 0) { $StrategyScore = 0 }
    
    # 4. Modality
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

$State = @{
    timestamp   = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    topology    = Get-ProjectTopology
    cognition   = if (Test-Path $TaskFile) { Get-Content $TaskFile -Raw } else { "# No Task File Found" }
    walkthrough = if (Test-Path $WalkthroughFile) { Get-Content $WalkthroughFile -Raw } else { "" }
    workflow    = if (Test-Path $WorkflowFile) { Get-Content $WorkflowFile -Raw } else { "" }
    metrics     = Measure-CognitiveMetrics
    status      = "Active"
}

# Extract Trinity Mermaid (simple regex approach)
if (Test-Path $TrinityFile) {
    $TrinityContent = Get-Content $TrinityFile -Raw
    if ($TrinityContent -match '<div class="mermaid">([\s\S]*?)</div>') {
        $State.trinity_mermaid = $matches[1].Trim()
    }
}

$State | ConvertTo-Json -Depth 5 | Set-Content $OutputFile -Encoding UTF8
Write-Host "Memory Palace Updated: $OutputFile" -ForegroundColor Green
