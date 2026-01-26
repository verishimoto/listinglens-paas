window.GOVERNOR_STATE = {
  "timestamp": "2026-01-26 18:05:22",
  "workflow": "# Agentic Workflow Visualization\r\n\r\nThis document visualizes the \"Opal\" agentic team workflow for ListingLens PaaS.\r\n\r\n**Note:** This visualization is available as a standalone \"Control Room\" tool.\r\nTo launch the dashboard, run:\r\n`flutter run -t lib/main_dashboard.dart`\r\n\r\n## The Opal Team Structure\r\n\r\n```mermaid\r\ngraph TD\r\n    %% Styling\r\n    classDef user fill:#f9f,stroke:#333,stroke-width:2px;\r\n    classDef dev fill:#e1f5fe,stroke:#01579b,stroke-width:2px;\r\n    classDef detective fill:#e8f5e9,stroke:#1b5e20,stroke-width:2px;\r\n    classDef watcher fill:#f3e5f5,stroke:#4a148c,stroke-width:2px;\r\n    classDef storage fill:#fff3e0,stroke:#e65100,stroke-width:2px;\r\n\r\n    User((User)):::user\r\n    \r\n    subgraph \"The Opal Team\"\r\n        AG[Antigravity<br/>(The Developer)]:::dev\r\n        DT[NotebookLM<br/>(The Detective)]:::detective\r\n        IJ[Injector Agent<br/>(The Watcher/Reviewer)]:::watcher\r\n    end\r\n\r\n    Repo[(ListingLens Repo)]:::storage\r\n\r\n    %% Flows\r\n    User -->|\"/socratic_iteration\"| DT\r\n    User -->|Direct Code Reqs| AG\r\n    \r\n    DT -->|Strategic Insights<br/>(Report)| User\r\n    DT -->|New Tasks| AG\r\n    \r\n    AG -->|Writes Code| Repo\r\n    \r\n    Repo -->|Trigger Review| IJ\r\n    \r\n    IJ -- \"/notebooklm_injector\" -->|Clean & Commit| Repo\r\n    IJ -->|Context Injection| DT\r\n    \r\n    %% Loop\r\n    DT -.->|Socratic Feedback Loop| AG\r\n```\r\n\r\n## Slash Commands\r\n\r\nUse these commands in the chat to activate specific agent routines:\r\n\r\n| Command | Agent | Function |\r\n| :--- | :--- | :--- |\r\n| **/notebooklm_injector** | **The Watcher** | Runs the `clean -> commit -> save project > save > inject` pipeline. Ensures the codebase is stable and prepares context for NotebookLM. |\r\n| **/socratic_iteration** | **The Detective** | Synchronizes the \"Detective\" (NotebookLM) with the \"Developer\" (Antigravity). Use this when strategic adjustments are needed. |\r\n\r\n## Role Descriptions\r\n\r\n- **Antigravity (The Developer)**: Handles direct coding, implementation plans, and immediate problem-solving.\r\n- **NotebookLM (The Detective)**: External strategic intelligence. Analyzes the codebase context and user prompts to find logic gaps (\"missing points\").\r\n- **Injector (The Watcher)**: The \"Control Room\" agent. automates the hygiene of the repo (cleaning, committing) and ensures the Detective has the latest evidence (context injection).\r\n",
  "walkthrough": "# Dashboard & Trinity Enhancement Walkthrough\r\n\r\n## Objective\r\n\r\nRepair and enhance the cognitive artifacts for ListingLens PaaS to ensure proper dashboard, tree, and flowchart viewing, merging workflows and trinity logic.\r\n\r\n## Changes\r\n\r\n### 1. New Trinity Agentic Map\r\n\r\n- **File**: `lib/governor/trinity_map.html`\r\n- **Logic**: Visualizes the Shared Intelligence Core (Governor, Gemini, KB, Credit) and the Three Protocol Timelines (Alpha, Beta, Gamma).\r\n- **Tech**: Mermaid.js with custom dark-themed styling.\r\n\r\n### 2. Enhanced Memory Palace Dashboard\r\n\r\n- **File**: `lib/governor/dashboard.html`\r\n- **Tabs**:\r\n  - **Cortex**: Dynamic task list from `task.md`.\r\n  - **Workflow**: Agentic team structure from `WORKFLOW_VISUALIZATION.md`.\r\n  - **Trinity**: Interactive agentic map.\r\n  - **Walkthrough**: Integrated technical summaries.\r\n  - **Topology**: Improved project tree view with icons.\r\n  - **Flowchart**: System logic overview.\r\n- **Design**: High-density glassmorphism with liquid cyan/purple accents.\r\n\r\n### 3. Unified Sync Engine\r\n\r\n- **File**: `tools/governor/generate_dashboard_data.ps1`\r\n- **Updates**:\r\n  - Auto-discovers `task.md` across project and brain directories.\r\n  - Extracts Mermaid diagrams from HTML files.\r\n  - Bundles all markdown artifacts into `state.json` for zero-latency dashboard rendering.\r\n\r\n## Verification\r\n\r\n1. Run `pwsh -File tools/governor/generate_dashboard_data.ps1`.\r\n2. Open `lib/governor/dashboard.html` in a browser.\r\n3. Switch through all tabs to verify rendering.\r\n\r\n![Dashboard Preview](file:///c:/Users/veris/.gemini/antigravity/scratch/listing_lens_paas/lib/governor/dashboard.html)\r\n",
  "metrics": {
    "strategy": 83.9,
    "entropy": 1.8,
    "autonomy": 85.7,
    "confidence": "Confident"
  },
  "cognition": "# Task: Dashboard & Trinity Logic Repair\r\n\r\n- [x] Research current `dashboard.html` and `trinity_agentic_map.html` <!-- id: 10 -->\r\n- [x] Create enhanced `lib/governor/trinity_map.html` with new logics <!-- id: 11 -->\r\n- [x] Update `lib/governor/dashboard.html` with Workflow, Walkthrough, and Trinity tabs <!-- id: 12 -->\r\n- [x] Refactor `tools/governor/generate_dashboard_data.ps1` for multi-artifact sync <!-- id: 13 -->\r\n- [x] Copy latest `walkthrough.md` and `task.md` to project root for dashboard visibility <!-- id: 14 -->\r\n- [x] Verify final dashboard rendering and metrics <!-- id: 15 -->\r\n- [ ] Final UI Polish (optional) <!-- id: 16 -->\r\n",
  "topology": [
    {
      "depth": 1,
      "path": "/.agent",
      "name": ".agent",
      "type": "folder"
    },
    {
      "depth": 1,
      "path": "/.vscode",
      "name": ".vscode",
      "type": "folder"
    },
    {
      "depth": 1,
      "path": "/android",
      "name": "android",
      "type": "folder"
    },
    {
      "depth": 1,
      "path": "/backups",
      "name": "backups",
      "type": "folder"
    },
    {
      "depth": 1,
      "path": "/ios",
      "name": "ios",
      "type": "folder"
    },
    {
      "depth": 1,
      "path": "/lib",
      "name": "lib",
      "type": "folder"
    },
    {
      "depth": 1,
      "path": "/linux",
      "name": "linux",
      "type": "folder"
    },
    {
      "depth": 1,
      "path": "/macos",
      "name": "macos",
      "type": "folder"
    },
    {
      "depth": 1,
      "path": "/test",
      "name": "test",
      "type": "folder"
    },
    {
      "depth": 1,
      "path": "/tools",
      "name": "tools",
      "type": "folder"
    },
    {
      "depth": 1,
      "path": "/web",
      "name": "web",
      "type": "folder"
    },
    {
      "depth": 1,
      "path": "/windows",
      "name": "windows",
      "type": "folder"
    },
    {
      "depth": 1,
      "path": "/.flutter-plugins-dependencies",
      "name": ".flutter-plugins-dependencies",
      "type": "file"
    },
    {
      "depth": 1,
      "path": "/.gemini_state.json",
      "name": ".gemini_state.json",
      "type": "file"
    },
    {
      "depth": 1,
      "path": "/.metadata",
      "name": ".metadata",
      "type": "file"
    },
    {
      "depth": 1,
      "path": "/analysis_options.yaml",
      "name": "analysis_options.yaml",
      "type": "file"
    },
    {
      "depth": 1,
      "path": "/firebase.json",
      "name": "firebase.json",
      "type": "file"
    },
    {
      "depth": 1,
      "path": "/notebooklm_context_injection.md",
      "name": "notebooklm_context_injection.md",
      "type": "file"
    },
    {
      "depth": 1,
      "path": "/pubspec.lock",
      "name": "pubspec.lock",
      "type": "file"
    },
    {
      "depth": 1,
      "path": "/pubspec.yaml",
      "name": "pubspec.yaml",
      "type": "file"
    },
    {
      "depth": 1,
      "path": "/README.md",
      "name": "README.md",
      "type": "file"
    },
    {
      "depth": 1,
      "path": "/task.md",
      "name": "task.md",
      "type": "file"
    },
    {
      "depth": 1,
      "path": "/walkthrough.md",
      "name": "walkthrough.md",
      "type": "file"
    },
    {
      "depth": 1,
      "path": "/web_help.txt",
      "name": "web_help.txt",
      "type": "file"
    },
    {
      "depth": 1,
      "path": "/WORKFLOW_VISUALIZATION.md",
      "name": "WORKFLOW_VISUALIZATION.md",
      "type": "file"
    },
    {
      "depth": 2,
      "path": "/.agent/workflows",
      "name": "workflows",
      "type": "folder"
    },
    {
      "depth": 3,
      "path": "/.agent/workflows/gemini_autonomy.md",
      "name": "gemini_autonomy.md",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/.agent/workflows/notebooklm_injector.md",
      "name": "notebooklm_injector.md",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/.agent/workflows/opal_omni_workflow.md",
      "name": "opal_omni_workflow.md",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/.agent/workflows/socratic_iteration.md",
      "name": "socratic_iteration.md",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/.agent/workflows/ux_designer_agent.md",
      "name": "ux_designer_agent.md",
      "type": "file"
    },
    {
      "depth": 2,
      "path": "/.vscode/launch.json",
      "name": "launch.json",
      "type": "file"
    },
    {
      "depth": 2,
      "path": "/.vscode/settings.json",
      "name": "settings.json",
      "type": "file"
    },
    {
      "depth": 2,
      "path": "/android/app",
      "name": "app",
      "type": "folder"
    },
    {
      "depth": 2,
      "path": "/android/gradle",
      "name": "gradle",
      "type": "folder"
    },
    {
      "depth": 2,
      "path": "/android/gradle.properties",
      "name": "gradle.properties",
      "type": "file"
    },
    {
      "depth": 2,
      "path": "/android/local.properties",
      "name": "local.properties",
      "type": "file"
    },
    {
      "depth": 2,
      "path": "/android/settings.gradle",
      "name": "settings.gradle",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/android/app/src",
      "name": "src",
      "type": "folder"
    },
    {
      "depth": 3,
      "path": "/android/app/google-services.json",
      "name": "google-services.json",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/android/app/src/debug",
      "name": "debug",
      "type": "folder"
    },
    {
      "depth": 4,
      "path": "/android/app/src/main",
      "name": "main",
      "type": "folder"
    },
    {
      "depth": 4,
      "path": "/android/app/src/profile",
      "name": "profile",
      "type": "folder"
    },
    {
      "depth": 3,
      "path": "/android/gradle/wrapper",
      "name": "wrapper",
      "type": "folder"
    },
    {
      "depth": 4,
      "path": "/android/gradle/wrapper/gradle-wrapper.properties",
      "name": "gradle-wrapper.properties",
      "type": "file"
    },
    {
      "depth": 2,
      "path": "/backups/ListingLens_Artifacts_20260124_030531",
      "name": "ListingLens_Artifacts_20260124_030531",
      "type": "folder"
    },
    {
      "depth": 2,
      "path": "/backups/analysis_final.txt",
      "name": "analysis_final.txt",
      "type": "file"
    },
    {
      "depth": 2,
      "path": "/backups/analysis_log.txt",
      "name": "analysis_log.txt",
      "type": "file"
    },
    {
      "depth": 2,
      "path": "/backups/analysis.txt",
      "name": "analysis.txt",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/backups/ListingLens_Artifacts_20260124_030531/brain",
      "name": "brain",
      "type": "file"
    },
    {
      "depth": 2,
      "path": "/ios/Flutter",
      "name": "Flutter",
      "type": "folder"
    },
    {
      "depth": 2,
      "path": "/ios/Runner",
      "name": "Runner",
      "type": "folder"
    },
    {
      "depth": 2,
      "path": "/ios/Runner.xcodeproj",
      "name": "Runner.xcodeproj",
      "type": "folder"
    },
    {
      "depth": 2,
      "path": "/ios/Runner.xcworkspace",
      "name": "Runner.xcworkspace",
      "type": "folder"
    },
    {
      "depth": 2,
      "path": "/ios/RunnerTests",
      "name": "RunnerTests",
      "type": "folder"
    },
    {
      "depth": 3,
      "path": "/ios/Flutter/ephemeral",
      "name": "ephemeral",
      "type": "folder"
    },
    {
      "depth": 3,
      "path": "/ios/Flutter/AppFrameworkInfo.plist",
      "name": "AppFrameworkInfo.plist",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/ios/Flutter/Debug.xcconfig",
      "name": "Debug.xcconfig",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/ios/Flutter/flutter_export_environment.sh",
      "name": "flutter_export_environment.sh",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/ios/Flutter/Generated.xcconfig",
      "name": "Generated.xcconfig",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/ios/Flutter/Release.xcconfig",
      "name": "Release.xcconfig",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/ios/Flutter/ephemeral/flutter_lldb_helper.py",
      "name": "flutter_lldb_helper.py",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/ios/Flutter/ephemeral/flutter_lldbinit",
      "name": "flutter_lldbinit",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/ios/Runner/Assets.xcassets",
      "name": "Assets.xcassets",
      "type": "folder"
    },
    {
      "depth": 3,
      "path": "/ios/Runner/Base.lproj",
      "name": "Base.lproj",
      "type": "folder"
    },
    {
      "depth": 3,
      "path": "/ios/Runner/AppDelegate.swift",
      "name": "AppDelegate.swift",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/ios/Runner/GeneratedPluginRegistrant.h",
      "name": "GeneratedPluginRegistrant.h",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/ios/Runner/GeneratedPluginRegistrant.m",
      "name": "GeneratedPluginRegistrant.m",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/ios/Runner/Info.plist",
      "name": "Info.plist",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/ios/Runner/Runner-Bridging-Header.h",
      "name": "Runner-Bridging-Header.h",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/ios/Runner/Assets.xcassets/AppIcon.appiconset",
      "name": "AppIcon.appiconset",
      "type": "folder"
    },
    {
      "depth": 4,
      "path": "/ios/Runner/Assets.xcassets/LaunchImage.imageset",
      "name": "LaunchImage.imageset",
      "type": "folder"
    },
    {
      "depth": 4,
      "path": "/ios/Runner/Base.lproj/LaunchScreen.storyboard",
      "name": "LaunchScreen.storyboard",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/ios/Runner/Base.lproj/Main.storyboard",
      "name": "Main.storyboard",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/ios/Runner.xcodeproj/project.xcworkspace",
      "name": "project.xcworkspace",
      "type": "folder"
    },
    {
      "depth": 3,
      "path": "/ios/Runner.xcodeproj/xcshareddata",
      "name": "xcshareddata",
      "type": "folder"
    },
    {
      "depth": 3,
      "path": "/ios/Runner.xcodeproj/project.pbxproj",
      "name": "project.pbxproj",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/ios/Runner.xcodeproj/project.xcworkspace/xcshareddata",
      "name": "xcshareddata",
      "type": "folder"
    },
    {
      "depth": 4,
      "path": "/ios/Runner.xcodeproj/project.xcworkspace/contents.xcworkspacedata",
      "name": "contents.xcworkspacedata",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/ios/Runner.xcodeproj/xcshareddata/xcschemes",
      "name": "xcschemes",
      "type": "folder"
    },
    {
      "depth": 3,
      "path": "/ios/Runner.xcworkspace/xcshareddata",
      "name": "xcshareddata",
      "type": "folder"
    },
    {
      "depth": 3,
      "path": "/ios/Runner.xcworkspace/contents.xcworkspacedata",
      "name": "contents.xcworkspacedata",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/ios/Runner.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist",
      "name": "IDEWorkspaceChecks.plist",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/ios/Runner.xcworkspace/xcshareddata/WorkspaceSettings.xcsettings",
      "name": "WorkspaceSettings.xcsettings",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/ios/RunnerTests/RunnerTests.swift",
      "name": "RunnerTests.swift",
      "type": "file"
    },
    {
      "depth": 2,
      "path": "/lib/components",
      "name": "components",
      "type": "folder"
    },
    {
      "depth": 2,
      "path": "/lib/core",
      "name": "core",
      "type": "folder"
    },
    {
      "depth": 2,
      "path": "/lib/features",
      "name": "features",
      "type": "folder"
    },
    {
      "depth": 2,
      "path": "/lib/governor",
      "name": "governor",
      "type": "folder"
    },
    {
      "depth": 2,
      "path": "/lib/layout",
      "name": "layout",
      "type": "folder"
    },
    {
      "depth": 2,
      "path": "/lib/shared",
      "name": "shared",
      "type": "folder"
    },
    {
      "depth": 2,
      "path": "/lib/theme",
      "name": "theme",
      "type": "folder"
    },
    {
      "depth": 2,
      "path": "/lib/app.dart",
      "name": "app.dart",
      "type": "file"
    },
    {
      "depth": 2,
      "path": "/lib/firebase_options.dart",
      "name": "firebase_options.dart",
      "type": "file"
    },
    {
      "depth": 2,
      "path": "/lib/main_alpha.dart",
      "name": "main_alpha.dart",
      "type": "file"
    },
    {
      "depth": 2,
      "path": "/lib/main_beta.dart",
      "name": "main_beta.dart",
      "type": "file"
    },
    {
      "depth": 2,
      "path": "/lib/main_gamma.dart",
      "name": "main_gamma.dart",
      "type": "file"
    },
    {
      "depth": 2,
      "path": "/lib/main.dart",
      "name": "main.dart",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/lib/components/antigravity_background.dart",
      "name": "antigravity_background.dart",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/lib/components/cursor_follower.dart",
      "name": "cursor_follower.dart",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/lib/components/dark_mode_toggle.dart",
      "name": "dark_mode_toggle.dart",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/lib/components/glass_scaffold.dart",
      "name": "glass_scaffold.dart",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/lib/components/liquid_background.dart",
      "name": "liquid_background.dart",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/lib/components/liquid_checkbox.dart",
      "name": "liquid_checkbox.dart",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/lib/components/liquid_glass.dart",
      "name": "liquid_glass.dart",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/lib/components/reflector_card.dart",
      "name": "reflector_card.dart",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/lib/components/repulsion_background.dart",
      "name": "repulsion_background.dart",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/lib/core/ai",
      "name": "ai",
      "type": "folder"
    },
    {
      "depth": 3,
      "path": "/lib/core/data",
      "name": "data",
      "type": "folder"
    },
    {
      "depth": 3,
      "path": "/lib/core/models",
      "name": "models",
      "type": "folder"
    },
    {
      "depth": 3,
      "path": "/lib/core/providers",
      "name": "providers",
      "type": "folder"
    },
    {
      "depth": 3,
      "path": "/lib/core/services",
      "name": "services",
      "type": "folder"
    },
    {
      "depth": 3,
      "path": "/lib/core/theme",
      "name": "theme",
      "type": "folder"
    },
    {
      "depth": 4,
      "path": "/lib/core/ai/gemini_service.dart",
      "name": "gemini_service.dart",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/lib/core/data/analysis_result.dart",
      "name": "analysis_result.dart",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/lib/core/data/knowledge_base.dart",
      "name": "knowledge_base.dart",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/lib/core/models/audit_model.dart",
      "name": "audit_model.dart",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/lib/core/models/listing.dart",
      "name": "listing.dart",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/lib/core/providers/analysis_provider.dart",
      "name": "analysis_provider.dart",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/lib/core/providers/history_provider.dart",
      "name": "history_provider.dart",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/lib/core/services/analysis_service.dart",
      "name": "analysis_service.dart",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/lib/core/services/auth_service.dart",
      "name": "auth_service.dart",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/lib/core/services/credit_service.dart",
      "name": "credit_service.dart",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/lib/core/services/firestore_service.dart",
      "name": "firestore_service.dart",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/lib/core/services/gemini_service.dart",
      "name": "gemini_service.dart",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/lib/core/services/history_service.dart",
      "name": "history_service.dart",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/lib/core/services/listing_service.dart",
      "name": "listing_service.dart",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/lib/core/theme/app_theme.dart",
      "name": "app_theme.dart",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/lib/features/alpha",
      "name": "alpha",
      "type": "folder"
    },
    {
      "depth": 3,
      "path": "/lib/features/archives",
      "name": "archives",
      "type": "folder"
    },
    {
      "depth": 3,
      "path": "/lib/features/auth",
      "name": "auth",
      "type": "folder"
    },
    {
      "depth": 3,
      "path": "/lib/features/beta",
      "name": "beta",
      "type": "folder"
    },
    {
      "depth": 3,
      "path": "/lib/features/delta",
      "name": "delta",
      "type": "folder"
    },
    {
      "depth": 3,
      "path": "/lib/features/gamma",
      "name": "gamma",
      "type": "folder"
    },
    {
      "depth": 3,
      "path": "/lib/features/hub",
      "name": "hub",
      "type": "folder"
    },
    {
      "depth": 3,
      "path": "/lib/features/lab",
      "name": "lab",
      "type": "folder"
    },
    {
      "depth": 3,
      "path": "/lib/features/epsilon_shell.dart",
      "name": "epsilon_shell.dart",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/lib/features/trinity_dashboard.dart",
      "name": "trinity_dashboard.dart",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/lib/features/alpha/components",
      "name": "components",
      "type": "folder"
    },
    {
      "depth": 4,
      "path": "/lib/features/alpha/alpha_dashboard.dart",
      "name": "alpha_dashboard.dart",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/lib/features/archives/archives.dart",
      "name": "archives.dart",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/lib/features/auth/auth_gate.dart",
      "name": "auth_gate.dart",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/lib/features/beta/beta_flow.dart",
      "name": "beta_flow.dart",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/lib/features/beta/beta_time_stream.dart",
      "name": "beta_time_stream.dart",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/lib/features/delta/delta_dashboard.dart",
      "name": "delta_dashboard.dart",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/lib/features/delta/delta_hub.dart",
      "name": "delta_hub.dart",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/lib/features/delta/delta_lab.dart",
      "name": "delta_lab.dart",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/lib/features/gamma/gamma_input.dart",
      "name": "gamma_input.dart",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/lib/features/hub/auth_wrapper.dart",
      "name": "auth_wrapper.dart",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/lib/features/hub/hub_layout.dart",
      "name": "hub_layout.dart",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/lib/features/hub/hub_view.dart",
      "name": "hub_view.dart",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/lib/features/hub/the_hub.dart",
      "name": "the_hub.dart",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/lib/features/lab/audit_report_page.dart",
      "name": "audit_report_page.dart",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/lib/features/lab/drag_drop_zone.dart",
      "name": "drag_drop_zone.dart",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/lib/features/lab/lab_view.dart",
      "name": "lab_view.dart",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/lib/features/lab/the_lab.dart",
      "name": "the_lab.dart",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/lib/governor/dashboard.html",
      "name": "dashboard.html",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/lib/governor/state.js",
      "name": "state.js",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/lib/governor/state.json",
      "name": "state.json",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/lib/governor/trinity_map.html",
      "name": "trinity_map.html",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/lib/governor/visual_logic_tutorial.html",
      "name": "visual_logic_tutorial.html",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/lib/layout/delta_layout.dart",
      "name": "delta_layout.dart",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/lib/layout/glass_tab_bar.dart",
      "name": "glass_tab_bar.dart",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/lib/layout/gluesystem.dart",
      "name": "gluesystem.dart",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/lib/layout/liquid_tab_shell.dart",
      "name": "liquid_tab_shell.dart",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/lib/layout/meniscus_tab.dart",
      "name": "meniscus_tab.dart",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/lib/layout/solid_fusion_layout.dart",
      "name": "solid_fusion_layout.dart",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/lib/shared/theme",
      "name": "theme",
      "type": "folder"
    },
    {
      "depth": 3,
      "path": "/lib/shared/glass_container.dart",
      "name": "glass_container.dart",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/lib/shared/paywall_modal.dart",
      "name": "paywall_modal.dart",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/lib/shared/refractive_cursor.dart",
      "name": "refractive_cursor.dart",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/lib/shared/smooth_cursor.dart",
      "name": "smooth_cursor.dart",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/lib/shared/theme/obsidian_theme.dart",
      "name": "obsidian_theme.dart",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/lib/theme/app_colors.dart",
      "name": "app_colors.dart",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/lib/theme/fluid_background.dart",
      "name": "fluid_background.dart",
      "type": "file"
    },
    {
      "depth": 2,
      "path": "/linux/flutter",
      "name": "flutter",
      "type": "folder"
    },
    {
      "depth": 2,
      "path": "/linux/CMakeLists.txt",
      "name": "CMakeLists.txt",
      "type": "file"
    },
    {
      "depth": 2,
      "path": "/linux/main.cc",
      "name": "main.cc",
      "type": "file"
    },
    {
      "depth": 2,
      "path": "/linux/my_application.cc",
      "name": "my_application.cc",
      "type": "file"
    },
    {
      "depth": 2,
      "path": "/linux/my_application.h",
      "name": "my_application.h",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/linux/flutter/ephemeral",
      "name": "ephemeral",
      "type": "folder"
    },
    {
      "depth": 3,
      "path": "/linux/flutter/CMakeLists.txt",
      "name": "CMakeLists.txt",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/linux/flutter/generated_plugin_registrant.cc",
      "name": "generated_plugin_registrant.cc",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/linux/flutter/generated_plugin_registrant.h",
      "name": "generated_plugin_registrant.h",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/linux/flutter/generated_plugins.cmake",
      "name": "generated_plugins.cmake",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/linux/flutter/ephemeral/.plugin_symlinks",
      "name": ".plugin_symlinks",
      "type": "folder"
    },
    {
      "depth": 2,
      "path": "/macos/Flutter",
      "name": "Flutter",
      "type": "folder"
    },
    {
      "depth": 2,
      "path": "/macos/Runner",
      "name": "Runner",
      "type": "folder"
    },
    {
      "depth": 2,
      "path": "/macos/Runner.xcodeproj",
      "name": "Runner.xcodeproj",
      "type": "folder"
    },
    {
      "depth": 2,
      "path": "/macos/Runner.xcworkspace",
      "name": "Runner.xcworkspace",
      "type": "folder"
    },
    {
      "depth": 2,
      "path": "/macos/RunnerTests",
      "name": "RunnerTests",
      "type": "folder"
    },
    {
      "depth": 3,
      "path": "/macos/Flutter/ephemeral",
      "name": "ephemeral",
      "type": "folder"
    },
    {
      "depth": 3,
      "path": "/macos/Flutter/Flutter-Debug.xcconfig",
      "name": "Flutter-Debug.xcconfig",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/macos/Flutter/Flutter-Release.xcconfig",
      "name": "Flutter-Release.xcconfig",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/macos/Flutter/GeneratedPluginRegistrant.swift",
      "name": "GeneratedPluginRegistrant.swift",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/macos/Flutter/ephemeral/flutter_export_environment.sh",
      "name": "flutter_export_environment.sh",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/macos/Flutter/ephemeral/Flutter-Generated.xcconfig",
      "name": "Flutter-Generated.xcconfig",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/macos/Runner/Assets.xcassets",
      "name": "Assets.xcassets",
      "type": "folder"
    },
    {
      "depth": 3,
      "path": "/macos/Runner/Base.lproj",
      "name": "Base.lproj",
      "type": "folder"
    },
    {
      "depth": 3,
      "path": "/macos/Runner/Configs",
      "name": "Configs",
      "type": "folder"
    },
    {
      "depth": 3,
      "path": "/macos/Runner/AppDelegate.swift",
      "name": "AppDelegate.swift",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/macos/Runner/DebugProfile.entitlements",
      "name": "DebugProfile.entitlements",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/macos/Runner/Info.plist",
      "name": "Info.plist",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/macos/Runner/MainFlutterWindow.swift",
      "name": "MainFlutterWindow.swift",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/macos/Runner/Release.entitlements",
      "name": "Release.entitlements",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/macos/Runner/Assets.xcassets/AppIcon.appiconset",
      "name": "AppIcon.appiconset",
      "type": "folder"
    },
    {
      "depth": 4,
      "path": "/macos/Runner/Base.lproj/MainMenu.xib",
      "name": "MainMenu.xib",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/macos/Runner/Configs/AppInfo.xcconfig",
      "name": "AppInfo.xcconfig",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/macos/Runner/Configs/Debug.xcconfig",
      "name": "Debug.xcconfig",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/macos/Runner/Configs/Release.xcconfig",
      "name": "Release.xcconfig",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/macos/Runner/Configs/Warnings.xcconfig",
      "name": "Warnings.xcconfig",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/macos/Runner.xcodeproj/project.xcworkspace",
      "name": "project.xcworkspace",
      "type": "folder"
    },
    {
      "depth": 3,
      "path": "/macos/Runner.xcodeproj/xcshareddata",
      "name": "xcshareddata",
      "type": "folder"
    },
    {
      "depth": 3,
      "path": "/macos/Runner.xcodeproj/project.pbxproj",
      "name": "project.pbxproj",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/macos/Runner.xcodeproj/project.xcworkspace/xcshareddata",
      "name": "xcshareddata",
      "type": "folder"
    },
    {
      "depth": 4,
      "path": "/macos/Runner.xcodeproj/xcshareddata/xcschemes",
      "name": "xcschemes",
      "type": "folder"
    },
    {
      "depth": 3,
      "path": "/macos/Runner.xcworkspace/xcshareddata",
      "name": "xcshareddata",
      "type": "folder"
    },
    {
      "depth": 3,
      "path": "/macos/Runner.xcworkspace/contents.xcworkspacedata",
      "name": "contents.xcworkspacedata",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/macos/Runner.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist",
      "name": "IDEWorkspaceChecks.plist",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/macos/RunnerTests/RunnerTests.swift",
      "name": "RunnerTests.swift",
      "type": "file"
    },
    {
      "depth": 2,
      "path": "/test/alpha_test.dart",
      "name": "alpha_test.dart",
      "type": "file"
    },
    {
      "depth": 2,
      "path": "/test/beta_test.dart",
      "name": "beta_test.dart",
      "type": "file"
    },
    {
      "depth": 2,
      "path": "/test/gamma_test.dart",
      "name": "gamma_test.dart",
      "type": "file"
    },
    {
      "depth": 2,
      "path": "/test/widget_test.dart",
      "name": "widget_test.dart",
      "type": "file"
    },
    {
      "depth": 2,
      "path": "/tools/governor",
      "name": "governor",
      "type": "folder"
    },
    {
      "depth": 2,
      "path": "/tools/gemini_manager.ps1",
      "name": "gemini_manager.ps1",
      "type": "file"
    },
    {
      "depth": 2,
      "path": "/tools/start_autonomy.ps1",
      "name": "start_autonomy.ps1",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/tools/governor/generate_dashboard_data.ps1",
      "name": "generate_dashboard_data.ps1",
      "type": "file"
    },
    {
      "depth": 2,
      "path": "/web/icons",
      "name": "icons",
      "type": "folder"
    },
    {
      "depth": 2,
      "path": "/web/favicon.png",
      "name": "favicon.png",
      "type": "file"
    },
    {
      "depth": 2,
      "path": "/web/index.html",
      "name": "index.html",
      "type": "file"
    },
    {
      "depth": 2,
      "path": "/web/manifest.json",
      "name": "manifest.json",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/web/icons/Icon-192.png",
      "name": "Icon-192.png",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/web/icons/Icon-512.png",
      "name": "Icon-512.png",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/web/icons/Icon-maskable-192.png",
      "name": "Icon-maskable-192.png",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/web/icons/Icon-maskable-512.png",
      "name": "Icon-maskable-512.png",
      "type": "file"
    },
    {
      "depth": 2,
      "path": "/windows/flutter",
      "name": "flutter",
      "type": "folder"
    },
    {
      "depth": 2,
      "path": "/windows/runner",
      "name": "runner",
      "type": "folder"
    },
    {
      "depth": 2,
      "path": "/windows/CMakeLists.txt",
      "name": "CMakeLists.txt",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/windows/flutter/ephemeral",
      "name": "ephemeral",
      "type": "folder"
    },
    {
      "depth": 3,
      "path": "/windows/flutter/CMakeLists.txt",
      "name": "CMakeLists.txt",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/windows/flutter/generated_plugin_registrant.cc",
      "name": "generated_plugin_registrant.cc",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/windows/flutter/generated_plugin_registrant.h",
      "name": "generated_plugin_registrant.h",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/windows/flutter/generated_plugins.cmake",
      "name": "generated_plugins.cmake",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/windows/flutter/ephemeral/.plugin_symlinks",
      "name": ".plugin_symlinks",
      "type": "folder"
    },
    {
      "depth": 4,
      "path": "/windows/flutter/ephemeral/generated_config.cmake",
      "name": "generated_config.cmake",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/windows/runner/resources",
      "name": "resources",
      "type": "folder"
    },
    {
      "depth": 3,
      "path": "/windows/runner/CMakeLists.txt",
      "name": "CMakeLists.txt",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/windows/runner/flutter_window.cpp",
      "name": "flutter_window.cpp",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/windows/runner/flutter_window.h",
      "name": "flutter_window.h",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/windows/runner/main.cpp",
      "name": "main.cpp",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/windows/runner/resource.h",
      "name": "resource.h",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/windows/runner/runner.exe.manifest",
      "name": "runner.exe.manifest",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/windows/runner/Runner.rc",
      "name": "Runner.rc",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/windows/runner/utils.cpp",
      "name": "utils.cpp",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/windows/runner/utils.h",
      "name": "utils.h",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/windows/runner/win32_window.cpp",
      "name": "win32_window.cpp",
      "type": "file"
    },
    {
      "depth": 3,
      "path": "/windows/runner/win32_window.h",
      "name": "win32_window.h",
      "type": "file"
    },
    {
      "depth": 4,
      "path": "/windows/runner/resources/app_icon.ico",
      "name": "app_icon.ico",
      "type": "file"
    }
  ],
  "status": "Active"
};
