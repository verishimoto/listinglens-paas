window.GOVERNOR_STATE = {
  "status": "Active",
  "timestamp": "2026-01-25 18:20:14",
  "walkthrough": "# Dashboard & Trinity Enhancement Walkthrough\r\n\r\n## Objective\r\n\r\nRepair and enhance the cognitive artifacts for ListingLens PaaS to ensure proper dashboard, tree, and flowchart viewing, merging workflows and trinity logic.\r\n\r\n## Changes\r\n\r\n### 1. New Trinity Agentic Map\r\n\r\n- **File**: `lib/governor/trinity_map.html`\r\n- **Logic**: Visualizes the Shared Intelligence Core (Governor, Gemini, KB, Credit) and the Three Protocol Timelines (Alpha, Beta, Gamma).\r\n- **Tech**: Mermaid.js with custom dark-themed styling.\r\n\r\n### 2. Enhanced Memory Palace Dashboard\r\n\r\n- **File**: `lib/governor/dashboard.html`\r\n- **Tabs**:\r\n  - **Cortex**: Dynamic task list from `task.md`.\r\n  - **Workflow**: Agentic team structure from `WORKFLOW_VISUALIZATION.md`.\r\n  - **Trinity**: Interactive agentic map.\r\n  - **Walkthrough**: Integrated technical summaries.\r\n  - **Topology**: Improved project tree view with icons.\r\n  - **Flowchart**: System logic overview.\r\n- **Design**: High-density glassmorphism with liquid cyan/purple accents.\r\n\r\n### 3. Unified Sync Engine\r\n\r\n- **File**: `tools/governor/generate_dashboard_data.ps1`\r\n- **Updates**:\r\n  - Auto-discovers `task.md` across project and brain directories.\r\n  - Extracts Mermaid diagrams from HTML files.\r\n  - Bundles all markdown artifacts into `state.json` for zero-latency dashboard rendering.\r\n\r\n## Verification\r\n\r\n1. Run `pwsh -File tools/governor/generate_dashboard_data.ps1`.\r\n2. Open `lib/governor/dashboard.html` in a browser.\r\n3. Switch through all tabs to verify rendering.\r\n\r\n![Dashboard Preview](file:///c:/Users/veris/.gemini/antigravity/scratch/listing_lens_paas/lib/governor/dashboard.html)\r\n",
  "topology": [
    {
      "path": "/.agent",
      "depth": 1,
      "type": "folder",
      "name": ".agent"
    },
    {
      "path": "/.vscode",
      "depth": 1,
      "type": "folder",
      "name": ".vscode"
    },
    {
      "path": "/android",
      "depth": 1,
      "type": "folder",
      "name": "android"
    },
    {
      "path": "/backups",
      "depth": 1,
      "type": "folder",
      "name": "backups"
    },
    {
      "path": "/ios",
      "depth": 1,
      "type": "folder",
      "name": "ios"
    },
    {
      "path": "/lib",
      "depth": 1,
      "type": "folder",
      "name": "lib"
    },
    {
      "path": "/linux",
      "depth": 1,
      "type": "folder",
      "name": "linux"
    },
    {
      "path": "/macos",
      "depth": 1,
      "type": "folder",
      "name": "macos"
    },
    {
      "path": "/test",
      "depth": 1,
      "type": "folder",
      "name": "test"
    },
    {
      "path": "/tools",
      "depth": 1,
      "type": "folder",
      "name": "tools"
    },
    {
      "path": "/web",
      "depth": 1,
      "type": "folder",
      "name": "web"
    },
    {
      "path": "/windows",
      "depth": 1,
      "type": "folder",
      "name": "windows"
    },
    {
      "path": "/.flutter-plugins",
      "depth": 1,
      "type": "file",
      "name": ".flutter-plugins"
    },
    {
      "path": "/.flutter-plugins-dependencies",
      "depth": 1,
      "type": "file",
      "name": ".flutter-plugins-dependencies"
    },
    {
      "path": "/.gemini_state.json",
      "depth": 1,
      "type": "file",
      "name": ".gemini_state.json"
    },
    {
      "path": "/.metadata",
      "depth": 1,
      "type": "file",
      "name": ".metadata"
    },
    {
      "path": "/analysis_options.yaml",
      "depth": 1,
      "type": "file",
      "name": "analysis_options.yaml"
    },
    {
      "path": "/firebase.json",
      "depth": 1,
      "type": "file",
      "name": "firebase.json"
    },
    {
      "path": "/notebooklm_context_injection.md",
      "depth": 1,
      "type": "file",
      "name": "notebooklm_context_injection.md"
    },
    {
      "path": "/pubspec.lock",
      "depth": 1,
      "type": "file",
      "name": "pubspec.lock"
    },
    {
      "path": "/pubspec.yaml",
      "depth": 1,
      "type": "file",
      "name": "pubspec.yaml"
    },
    {
      "path": "/README.md",
      "depth": 1,
      "type": "file",
      "name": "README.md"
    },
    {
      "path": "/task.md",
      "depth": 1,
      "type": "file",
      "name": "task.md"
    },
    {
      "path": "/walkthrough.md",
      "depth": 1,
      "type": "file",
      "name": "walkthrough.md"
    },
    {
      "path": "/web_help.txt",
      "depth": 1,
      "type": "file",
      "name": "web_help.txt"
    },
    {
      "path": "/WORKFLOW_VISUALIZATION.md",
      "depth": 1,
      "type": "file",
      "name": "WORKFLOW_VISUALIZATION.md"
    },
    {
      "path": "/.agent/workflows",
      "depth": 2,
      "type": "folder",
      "name": "workflows"
    },
    {
      "path": "/.agent/workflows/gemini_autonomy.md",
      "depth": 3,
      "type": "file",
      "name": "gemini_autonomy.md"
    },
    {
      "path": "/.agent/workflows/notebooklm_injector.md",
      "depth": 3,
      "type": "file",
      "name": "notebooklm_injector.md"
    },
    {
      "path": "/.agent/workflows/opal_omni_workflow.md",
      "depth": 3,
      "type": "file",
      "name": "opal_omni_workflow.md"
    },
    {
      "path": "/.agent/workflows/socratic_iteration.md",
      "depth": 3,
      "type": "file",
      "name": "socratic_iteration.md"
    },
    {
      "path": "/.agent/workflows/ux_designer_agent.md",
      "depth": 3,
      "type": "file",
      "name": "ux_designer_agent.md"
    },
    {
      "path": "/.vscode/launch.json",
      "depth": 2,
      "type": "file",
      "name": "launch.json"
    },
    {
      "path": "/.vscode/settings.json",
      "depth": 2,
      "type": "file",
      "name": "settings.json"
    },
    {
      "path": "/android/.gradle",
      "depth": 2,
      "type": "folder",
      "name": ".gradle"
    },
    {
      "path": "/android/app",
      "depth": 2,
      "type": "folder",
      "name": "app"
    },
    {
      "path": "/android/gradle",
      "depth": 2,
      "type": "folder",
      "name": "gradle"
    },
    {
      "path": "/android/gradle.properties",
      "depth": 2,
      "type": "file",
      "name": "gradle.properties"
    },
    {
      "path": "/android/gradlew",
      "depth": 2,
      "type": "file",
      "name": "gradlew"
    },
    {
      "path": "/android/gradlew.bat",
      "depth": 2,
      "type": "file",
      "name": "gradlew.bat"
    },
    {
      "path": "/android/local.properties",
      "depth": 2,
      "type": "file",
      "name": "local.properties"
    },
    {
      "path": "/android/settings.gradle",
      "depth": 2,
      "type": "file",
      "name": "settings.gradle"
    },
    {
      "path": "/android/.gradle/7.6.3",
      "depth": 3,
      "type": "folder",
      "name": "7.6.3"
    },
    {
      "path": "/android/.gradle/vcs-1",
      "depth": 3,
      "type": "folder",
      "name": "vcs-1"
    },
    {
      "path": "/android/.gradle/7.6.3/checksums",
      "depth": 4,
      "type": "folder",
      "name": "checksums"
    },
    {
      "path": "/android/.gradle/7.6.3/dependencies-accessors",
      "depth": 4,
      "type": "folder",
      "name": "dependencies-accessors"
    },
    {
      "path": "/android/.gradle/7.6.3/fileChanges",
      "depth": 4,
      "type": "folder",
      "name": "fileChanges"
    },
    {
      "path": "/android/.gradle/7.6.3/fileHashes",
      "depth": 4,
      "type": "folder",
      "name": "fileHashes"
    },
    {
      "path": "/android/.gradle/7.6.3/vcsMetadata",
      "depth": 4,
      "type": "folder",
      "name": "vcsMetadata"
    },
    {
      "path": "/android/.gradle/7.6.3/gc.properties",
      "depth": 4,
      "type": "file",
      "name": "gc.properties"
    },
    {
      "path": "/android/.gradle/vcs-1/gc.properties",
      "depth": 4,
      "type": "file",
      "name": "gc.properties"
    },
    {
      "path": "/android/app/src",
      "depth": 3,
      "type": "folder",
      "name": "src"
    },
    {
      "path": "/android/app/google-services.json",
      "depth": 3,
      "type": "file",
      "name": "google-services.json"
    },
    {
      "path": "/android/app/src/debug",
      "depth": 4,
      "type": "folder",
      "name": "debug"
    },
    {
      "path": "/android/app/src/main",
      "depth": 4,
      "type": "folder",
      "name": "main"
    },
    {
      "path": "/android/app/src/profile",
      "depth": 4,
      "type": "folder",
      "name": "profile"
    },
    {
      "path": "/android/gradle/wrapper",
      "depth": 3,
      "type": "folder",
      "name": "wrapper"
    },
    {
      "path": "/android/gradle/wrapper/gradle-wrapper.jar",
      "depth": 4,
      "type": "file",
      "name": "gradle-wrapper.jar"
    },
    {
      "path": "/android/gradle/wrapper/gradle-wrapper.properties",
      "depth": 4,
      "type": "file",
      "name": "gradle-wrapper.properties"
    },
    {
      "path": "/backups/ListingLens_Artifacts_20260124_030531",
      "depth": 2,
      "type": "folder",
      "name": "ListingLens_Artifacts_20260124_030531"
    },
    {
      "path": "/backups/analysis_final.txt",
      "depth": 2,
      "type": "file",
      "name": "analysis_final.txt"
    },
    {
      "path": "/backups/analysis_log.txt",
      "depth": 2,
      "type": "file",
      "name": "analysis_log.txt"
    },
    {
      "path": "/backups/analysis.txt",
      "depth": 2,
      "type": "file",
      "name": "analysis.txt"
    },
    {
      "path": "/backups/ListingLens_Artifacts_20260124_030531/brain",
      "depth": 3,
      "type": "file",
      "name": "brain"
    },
    {
      "path": "/ios/Flutter",
      "depth": 2,
      "type": "folder",
      "name": "Flutter"
    },
    {
      "path": "/ios/Runner",
      "depth": 2,
      "type": "folder",
      "name": "Runner"
    },
    {
      "path": "/ios/Runner.xcodeproj",
      "depth": 2,
      "type": "folder",
      "name": "Runner.xcodeproj"
    },
    {
      "path": "/ios/Runner.xcworkspace",
      "depth": 2,
      "type": "folder",
      "name": "Runner.xcworkspace"
    },
    {
      "path": "/ios/RunnerTests",
      "depth": 2,
      "type": "folder",
      "name": "RunnerTests"
    },
    {
      "path": "/ios/Flutter/ephemeral",
      "depth": 3,
      "type": "folder",
      "name": "ephemeral"
    },
    {
      "path": "/ios/Flutter/AppFrameworkInfo.plist",
      "depth": 3,
      "type": "file",
      "name": "AppFrameworkInfo.plist"
    },
    {
      "path": "/ios/Flutter/Debug.xcconfig",
      "depth": 3,
      "type": "file",
      "name": "Debug.xcconfig"
    },
    {
      "path": "/ios/Flutter/flutter_export_environment.sh",
      "depth": 3,
      "type": "file",
      "name": "flutter_export_environment.sh"
    },
    {
      "path": "/ios/Flutter/Generated.xcconfig",
      "depth": 3,
      "type": "file",
      "name": "Generated.xcconfig"
    },
    {
      "path": "/ios/Flutter/Release.xcconfig",
      "depth": 3,
      "type": "file",
      "name": "Release.xcconfig"
    },
    {
      "path": "/ios/Flutter/ephemeral/flutter_lldb_helper.py",
      "depth": 4,
      "type": "file",
      "name": "flutter_lldb_helper.py"
    },
    {
      "path": "/ios/Flutter/ephemeral/flutter_lldbinit",
      "depth": 4,
      "type": "file",
      "name": "flutter_lldbinit"
    },
    {
      "path": "/ios/Runner/Assets.xcassets",
      "depth": 3,
      "type": "folder",
      "name": "Assets.xcassets"
    },
    {
      "path": "/ios/Runner/Base.lproj",
      "depth": 3,
      "type": "folder",
      "name": "Base.lproj"
    },
    {
      "path": "/ios/Runner/AppDelegate.swift",
      "depth": 3,
      "type": "file",
      "name": "AppDelegate.swift"
    },
    {
      "path": "/ios/Runner/GeneratedPluginRegistrant.h",
      "depth": 3,
      "type": "file",
      "name": "GeneratedPluginRegistrant.h"
    },
    {
      "path": "/ios/Runner/GeneratedPluginRegistrant.m",
      "depth": 3,
      "type": "file",
      "name": "GeneratedPluginRegistrant.m"
    },
    {
      "path": "/ios/Runner/Info.plist",
      "depth": 3,
      "type": "file",
      "name": "Info.plist"
    },
    {
      "path": "/ios/Runner/Runner-Bridging-Header.h",
      "depth": 3,
      "type": "file",
      "name": "Runner-Bridging-Header.h"
    },
    {
      "path": "/ios/Runner/Assets.xcassets/AppIcon.appiconset",
      "depth": 4,
      "type": "folder",
      "name": "AppIcon.appiconset"
    },
    {
      "path": "/ios/Runner/Assets.xcassets/LaunchImage.imageset",
      "depth": 4,
      "type": "folder",
      "name": "LaunchImage.imageset"
    },
    {
      "path": "/ios/Runner/Base.lproj/LaunchScreen.storyboard",
      "depth": 4,
      "type": "file",
      "name": "LaunchScreen.storyboard"
    },
    {
      "path": "/ios/Runner/Base.lproj/Main.storyboard",
      "depth": 4,
      "type": "file",
      "name": "Main.storyboard"
    },
    {
      "path": "/ios/Runner.xcodeproj/project.xcworkspace",
      "depth": 3,
      "type": "folder",
      "name": "project.xcworkspace"
    },
    {
      "path": "/ios/Runner.xcodeproj/xcshareddata",
      "depth": 3,
      "type": "folder",
      "name": "xcshareddata"
    },
    {
      "path": "/ios/Runner.xcodeproj/project.pbxproj",
      "depth": 3,
      "type": "file",
      "name": "project.pbxproj"
    },
    {
      "path": "/ios/Runner.xcodeproj/project.xcworkspace/xcshareddata",
      "depth": 4,
      "type": "folder",
      "name": "xcshareddata"
    },
    {
      "path": "/ios/Runner.xcodeproj/project.xcworkspace/contents.xcworkspacedata",
      "depth": 4,
      "type": "file",
      "name": "contents.xcworkspacedata"
    },
    {
      "path": "/ios/Runner.xcodeproj/xcshareddata/xcschemes",
      "depth": 4,
      "type": "folder",
      "name": "xcschemes"
    },
    {
      "path": "/ios/Runner.xcworkspace/xcshareddata",
      "depth": 3,
      "type": "folder",
      "name": "xcshareddata"
    },
    {
      "path": "/ios/Runner.xcworkspace/contents.xcworkspacedata",
      "depth": 3,
      "type": "file",
      "name": "contents.xcworkspacedata"
    },
    {
      "path": "/ios/Runner.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist",
      "depth": 4,
      "type": "file",
      "name": "IDEWorkspaceChecks.plist"
    },
    {
      "path": "/ios/Runner.xcworkspace/xcshareddata/WorkspaceSettings.xcsettings",
      "depth": 4,
      "type": "file",
      "name": "WorkspaceSettings.xcsettings"
    },
    {
      "path": "/ios/RunnerTests/RunnerTests.swift",
      "depth": 3,
      "type": "file",
      "name": "RunnerTests.swift"
    },
    {
      "path": "/lib/components",
      "depth": 2,
      "type": "folder",
      "name": "components"
    },
    {
      "path": "/lib/core",
      "depth": 2,
      "type": "folder",
      "name": "core"
    },
    {
      "path": "/lib/features",
      "depth": 2,
      "type": "folder",
      "name": "features"
    },
    {
      "path": "/lib/governor",
      "depth": 2,
      "type": "folder",
      "name": "governor"
    },
    {
      "path": "/lib/layout",
      "depth": 2,
      "type": "folder",
      "name": "layout"
    },
    {
      "path": "/lib/shared",
      "depth": 2,
      "type": "folder",
      "name": "shared"
    },
    {
      "path": "/lib/theme",
      "depth": 2,
      "type": "folder",
      "name": "theme"
    },
    {
      "path": "/lib/app.dart",
      "depth": 2,
      "type": "file",
      "name": "app.dart"
    },
    {
      "path": "/lib/firebase_options.dart",
      "depth": 2,
      "type": "file",
      "name": "firebase_options.dart"
    },
    {
      "path": "/lib/main_alpha.dart",
      "depth": 2,
      "type": "file",
      "name": "main_alpha.dart"
    },
    {
      "path": "/lib/main_beta.dart",
      "depth": 2,
      "type": "file",
      "name": "main_beta.dart"
    },
    {
      "path": "/lib/main_gamma.dart",
      "depth": 2,
      "type": "file",
      "name": "main_gamma.dart"
    },
    {
      "path": "/lib/main.dart",
      "depth": 2,
      "type": "file",
      "name": "main.dart"
    },
    {
      "path": "/lib/components/antigravity_background.dart",
      "depth": 3,
      "type": "file",
      "name": "antigravity_background.dart"
    },
    {
      "path": "/lib/components/cursor_follower.dart",
      "depth": 3,
      "type": "file",
      "name": "cursor_follower.dart"
    },
    {
      "path": "/lib/components/dark_mode_toggle.dart",
      "depth": 3,
      "type": "file",
      "name": "dark_mode_toggle.dart"
    },
    {
      "path": "/lib/components/glass_scaffold.dart",
      "depth": 3,
      "type": "file",
      "name": "glass_scaffold.dart"
    },
    {
      "path": "/lib/components/liquid_checkbox.dart",
      "depth": 3,
      "type": "file",
      "name": "liquid_checkbox.dart"
    },
    {
      "path": "/lib/components/liquid_glass.dart",
      "depth": 3,
      "type": "file",
      "name": "liquid_glass.dart"
    },
    {
      "path": "/lib/components/reflector_card.dart",
      "depth": 3,
      "type": "file",
      "name": "reflector_card.dart"
    },
    {
      "path": "/lib/components/repulsion_background.dart",
      "depth": 3,
      "type": "file",
      "name": "repulsion_background.dart"
    },
    {
      "path": "/lib/core/ai",
      "depth": 3,
      "type": "folder",
      "name": "ai"
    },
    {
      "path": "/lib/core/data",
      "depth": 3,
      "type": "folder",
      "name": "data"
    },
    {
      "path": "/lib/core/models",
      "depth": 3,
      "type": "folder",
      "name": "models"
    },
    {
      "path": "/lib/core/providers",
      "depth": 3,
      "type": "folder",
      "name": "providers"
    },
    {
      "path": "/lib/core/services",
      "depth": 3,
      "type": "folder",
      "name": "services"
    },
    {
      "path": "/lib/core/theme",
      "depth": 3,
      "type": "folder",
      "name": "theme"
    },
    {
      "path": "/lib/core/ai/gemini_service.dart",
      "depth": 4,
      "type": "file",
      "name": "gemini_service.dart"
    },
    {
      "path": "/lib/core/data/analysis_result.dart",
      "depth": 4,
      "type": "file",
      "name": "analysis_result.dart"
    },
    {
      "path": "/lib/core/data/knowledge_base.dart",
      "depth": 4,
      "type": "file",
      "name": "knowledge_base.dart"
    },
    {
      "path": "/lib/core/models/audit_model.dart",
      "depth": 4,
      "type": "file",
      "name": "audit_model.dart"
    },
    {
      "path": "/lib/core/models/listing.dart",
      "depth": 4,
      "type": "file",
      "name": "listing.dart"
    },
    {
      "path": "/lib/core/providers/analysis_provider.dart",
      "depth": 4,
      "type": "file",
      "name": "analysis_provider.dart"
    },
    {
      "path": "/lib/core/providers/history_provider.dart",
      "depth": 4,
      "type": "file",
      "name": "history_provider.dart"
    },
    {
      "path": "/lib/core/services/analysis_service.dart",
      "depth": 4,
      "type": "file",
      "name": "analysis_service.dart"
    },
    {
      "path": "/lib/core/services/auth_service.dart",
      "depth": 4,
      "type": "file",
      "name": "auth_service.dart"
    },
    {
      "path": "/lib/core/services/credit_service.dart",
      "depth": 4,
      "type": "file",
      "name": "credit_service.dart"
    },
    {
      "path": "/lib/core/services/firestore_service.dart",
      "depth": 4,
      "type": "file",
      "name": "firestore_service.dart"
    },
    {
      "path": "/lib/core/services/gemini_service.dart",
      "depth": 4,
      "type": "file",
      "name": "gemini_service.dart"
    },
    {
      "path": "/lib/core/services/history_service.dart",
      "depth": 4,
      "type": "file",
      "name": "history_service.dart"
    },
    {
      "path": "/lib/core/services/listing_service.dart",
      "depth": 4,
      "type": "file",
      "name": "listing_service.dart"
    },
    {
      "path": "/lib/core/theme/app_theme.dart",
      "depth": 4,
      "type": "file",
      "name": "app_theme.dart"
    },
    {
      "path": "/lib/features/alpha",
      "depth": 3,
      "type": "folder",
      "name": "alpha"
    },
    {
      "path": "/lib/features/auth",
      "depth": 3,
      "type": "folder",
      "name": "auth"
    },
    {
      "path": "/lib/features/beta",
      "depth": 3,
      "type": "folder",
      "name": "beta"
    },
    {
      "path": "/lib/features/gamma",
      "depth": 3,
      "type": "folder",
      "name": "gamma"
    },
    {
      "path": "/lib/features/hub",
      "depth": 3,
      "type": "folder",
      "name": "hub"
    },
    {
      "path": "/lib/features/lab",
      "depth": 3,
      "type": "folder",
      "name": "lab"
    },
    {
      "path": "/lib/features/trinity_dashboard.dart",
      "depth": 3,
      "type": "file",
      "name": "trinity_dashboard.dart"
    },
    {
      "path": "/lib/features/alpha/components",
      "depth": 4,
      "type": "folder",
      "name": "components"
    },
    {
      "path": "/lib/features/alpha/alpha_dashboard.dart",
      "depth": 4,
      "type": "file",
      "name": "alpha_dashboard.dart"
    },
    {
      "path": "/lib/features/auth/auth_gate.dart",
      "depth": 4,
      "type": "file",
      "name": "auth_gate.dart"
    },
    {
      "path": "/lib/features/beta/beta_flow.dart",
      "depth": 4,
      "type": "file",
      "name": "beta_flow.dart"
    },
    {
      "path": "/lib/features/beta/beta_time_stream.dart",
      "depth": 4,
      "type": "file",
      "name": "beta_time_stream.dart"
    },
    {
      "path": "/lib/features/gamma/gamma_input.dart",
      "depth": 4,
      "type": "file",
      "name": "gamma_input.dart"
    },
    {
      "path": "/lib/features/hub/auth_wrapper.dart",
      "depth": 4,
      "type": "file",
      "name": "auth_wrapper.dart"
    },
    {
      "path": "/lib/features/hub/hub_layout.dart",
      "depth": 4,
      "type": "file",
      "name": "hub_layout.dart"
    },
    {
      "path": "/lib/features/hub/hub_view.dart",
      "depth": 4,
      "type": "file",
      "name": "hub_view.dart"
    },
    {
      "path": "/lib/features/lab/audit_report_page.dart",
      "depth": 4,
      "type": "file",
      "name": "audit_report_page.dart"
    },
    {
      "path": "/lib/features/lab/drag_drop_zone.dart",
      "depth": 4,
      "type": "file",
      "name": "drag_drop_zone.dart"
    },
    {
      "path": "/lib/features/lab/lab_view.dart",
      "depth": 4,
      "type": "file",
      "name": "lab_view.dart"
    },
    {
      "path": "/lib/governor/dashboard.html",
      "depth": 3,
      "type": "file",
      "name": "dashboard.html"
    },
    {
      "path": "/lib/governor/state.js",
      "depth": 3,
      "type": "file",
      "name": "state.js"
    },
    {
      "path": "/lib/governor/state.json",
      "depth": 3,
      "type": "file",
      "name": "state.json"
    },
    {
      "path": "/lib/governor/trinity_map.html",
      "depth": 3,
      "type": "file",
      "name": "trinity_map.html"
    },
    {
      "path": "/lib/governor/visual_logic_tutorial.html",
      "depth": 3,
      "type": "file",
      "name": "visual_logic_tutorial.html"
    },
    {
      "path": "/lib/layout/glass_tab_bar.dart",
      "depth": 3,
      "type": "file",
      "name": "glass_tab_bar.dart"
    },
    {
      "path": "/lib/layout/liquid_tab_shell.dart",
      "depth": 3,
      "type": "file",
      "name": "liquid_tab_shell.dart"
    },
    {
      "path": "/lib/layout/meniscus_tab.dart",
      "depth": 3,
      "type": "file",
      "name": "meniscus_tab.dart"
    },
    {
      "path": "/lib/layout/solid_fusion_layout.dart",
      "depth": 3,
      "type": "file",
      "name": "solid_fusion_layout.dart"
    },
    {
      "path": "/lib/shared/theme",
      "depth": 3,
      "type": "folder",
      "name": "theme"
    },
    {
      "path": "/lib/shared/glass_container.dart",
      "depth": 3,
      "type": "file",
      "name": "glass_container.dart"
    },
    {
      "path": "/lib/shared/paywall_modal.dart",
      "depth": 3,
      "type": "file",
      "name": "paywall_modal.dart"
    },
    {
      "path": "/lib/shared/refractive_cursor.dart",
      "depth": 3,
      "type": "file",
      "name": "refractive_cursor.dart"
    },
    {
      "path": "/lib/shared/smooth_cursor.dart",
      "depth": 3,
      "type": "file",
      "name": "smooth_cursor.dart"
    },
    {
      "path": "/lib/shared/theme/obsidian_theme.dart",
      "depth": 4,
      "type": "file",
      "name": "obsidian_theme.dart"
    },
    {
      "path": "/lib/theme/app_colors.dart",
      "depth": 3,
      "type": "file",
      "name": "app_colors.dart"
    },
    {
      "path": "/lib/theme/app_theme.dart",
      "depth": 3,
      "type": "file",
      "name": "app_theme.dart"
    },
    {
      "path": "/lib/theme/fluid_background.dart",
      "depth": 3,
      "type": "file",
      "name": "fluid_background.dart"
    },
    {
      "path": "/linux/flutter",
      "depth": 2,
      "type": "folder",
      "name": "flutter"
    },
    {
      "path": "/linux/CMakeLists.txt",
      "depth": 2,
      "type": "file",
      "name": "CMakeLists.txt"
    },
    {
      "path": "/linux/main.cc",
      "depth": 2,
      "type": "file",
      "name": "main.cc"
    },
    {
      "path": "/linux/my_application.cc",
      "depth": 2,
      "type": "file",
      "name": "my_application.cc"
    },
    {
      "path": "/linux/my_application.h",
      "depth": 2,
      "type": "file",
      "name": "my_application.h"
    },
    {
      "path": "/linux/flutter/ephemeral",
      "depth": 3,
      "type": "folder",
      "name": "ephemeral"
    },
    {
      "path": "/linux/flutter/CMakeLists.txt",
      "depth": 3,
      "type": "file",
      "name": "CMakeLists.txt"
    },
    {
      "path": "/linux/flutter/generated_plugin_registrant.cc",
      "depth": 3,
      "type": "file",
      "name": "generated_plugin_registrant.cc"
    },
    {
      "path": "/linux/flutter/generated_plugin_registrant.h",
      "depth": 3,
      "type": "file",
      "name": "generated_plugin_registrant.h"
    },
    {
      "path": "/linux/flutter/generated_plugins.cmake",
      "depth": 3,
      "type": "file",
      "name": "generated_plugins.cmake"
    },
    {
      "path": "/linux/flutter/ephemeral/.plugin_symlinks",
      "depth": 4,
      "type": "folder",
      "name": ".plugin_symlinks"
    },
    {
      "path": "/macos/Flutter",
      "depth": 2,
      "type": "folder",
      "name": "Flutter"
    },
    {
      "path": "/macos/Runner",
      "depth": 2,
      "type": "folder",
      "name": "Runner"
    },
    {
      "path": "/macos/Runner.xcodeproj",
      "depth": 2,
      "type": "folder",
      "name": "Runner.xcodeproj"
    },
    {
      "path": "/macos/Runner.xcworkspace",
      "depth": 2,
      "type": "folder",
      "name": "Runner.xcworkspace"
    },
    {
      "path": "/macos/RunnerTests",
      "depth": 2,
      "type": "folder",
      "name": "RunnerTests"
    },
    {
      "path": "/macos/Flutter/ephemeral",
      "depth": 3,
      "type": "folder",
      "name": "ephemeral"
    },
    {
      "path": "/macos/Flutter/Flutter-Debug.xcconfig",
      "depth": 3,
      "type": "file",
      "name": "Flutter-Debug.xcconfig"
    },
    {
      "path": "/macos/Flutter/Flutter-Release.xcconfig",
      "depth": 3,
      "type": "file",
      "name": "Flutter-Release.xcconfig"
    },
    {
      "path": "/macos/Flutter/GeneratedPluginRegistrant.swift",
      "depth": 3,
      "type": "file",
      "name": "GeneratedPluginRegistrant.swift"
    },
    {
      "path": "/macos/Flutter/ephemeral/flutter_export_environment.sh",
      "depth": 4,
      "type": "file",
      "name": "flutter_export_environment.sh"
    },
    {
      "path": "/macos/Flutter/ephemeral/Flutter-Generated.xcconfig",
      "depth": 4,
      "type": "file",
      "name": "Flutter-Generated.xcconfig"
    },
    {
      "path": "/macos/Runner/Assets.xcassets",
      "depth": 3,
      "type": "folder",
      "name": "Assets.xcassets"
    },
    {
      "path": "/macos/Runner/Base.lproj",
      "depth": 3,
      "type": "folder",
      "name": "Base.lproj"
    },
    {
      "path": "/macos/Runner/Configs",
      "depth": 3,
      "type": "folder",
      "name": "Configs"
    },
    {
      "path": "/macos/Runner/AppDelegate.swift",
      "depth": 3,
      "type": "file",
      "name": "AppDelegate.swift"
    },
    {
      "path": "/macos/Runner/DebugProfile.entitlements",
      "depth": 3,
      "type": "file",
      "name": "DebugProfile.entitlements"
    },
    {
      "path": "/macos/Runner/Info.plist",
      "depth": 3,
      "type": "file",
      "name": "Info.plist"
    },
    {
      "path": "/macos/Runner/MainFlutterWindow.swift",
      "depth": 3,
      "type": "file",
      "name": "MainFlutterWindow.swift"
    },
    {
      "path": "/macos/Runner/Release.entitlements",
      "depth": 3,
      "type": "file",
      "name": "Release.entitlements"
    },
    {
      "path": "/macos/Runner/Assets.xcassets/AppIcon.appiconset",
      "depth": 4,
      "type": "folder",
      "name": "AppIcon.appiconset"
    },
    {
      "path": "/macos/Runner/Base.lproj/MainMenu.xib",
      "depth": 4,
      "type": "file",
      "name": "MainMenu.xib"
    },
    {
      "path": "/macos/Runner/Configs/AppInfo.xcconfig",
      "depth": 4,
      "type": "file",
      "name": "AppInfo.xcconfig"
    },
    {
      "path": "/macos/Runner/Configs/Debug.xcconfig",
      "depth": 4,
      "type": "file",
      "name": "Debug.xcconfig"
    },
    {
      "path": "/macos/Runner/Configs/Release.xcconfig",
      "depth": 4,
      "type": "file",
      "name": "Release.xcconfig"
    },
    {
      "path": "/macos/Runner/Configs/Warnings.xcconfig",
      "depth": 4,
      "type": "file",
      "name": "Warnings.xcconfig"
    },
    {
      "path": "/macos/Runner.xcodeproj/project.xcworkspace",
      "depth": 3,
      "type": "folder",
      "name": "project.xcworkspace"
    },
    {
      "path": "/macos/Runner.xcodeproj/xcshareddata",
      "depth": 3,
      "type": "folder",
      "name": "xcshareddata"
    },
    {
      "path": "/macos/Runner.xcodeproj/project.pbxproj",
      "depth": 3,
      "type": "file",
      "name": "project.pbxproj"
    },
    {
      "path": "/macos/Runner.xcodeproj/project.xcworkspace/xcshareddata",
      "depth": 4,
      "type": "folder",
      "name": "xcshareddata"
    },
    {
      "path": "/macos/Runner.xcodeproj/xcshareddata/xcschemes",
      "depth": 4,
      "type": "folder",
      "name": "xcschemes"
    },
    {
      "path": "/macos/Runner.xcworkspace/xcshareddata",
      "depth": 3,
      "type": "folder",
      "name": "xcshareddata"
    },
    {
      "path": "/macos/Runner.xcworkspace/contents.xcworkspacedata",
      "depth": 3,
      "type": "file",
      "name": "contents.xcworkspacedata"
    },
    {
      "path": "/macos/Runner.xcworkspace/xcshareddata/IDEWorkspaceChecks.plist",
      "depth": 4,
      "type": "file",
      "name": "IDEWorkspaceChecks.plist"
    },
    {
      "path": "/macos/RunnerTests/RunnerTests.swift",
      "depth": 3,
      "type": "file",
      "name": "RunnerTests.swift"
    },
    {
      "path": "/test/alpha_test.dart",
      "depth": 2,
      "type": "file",
      "name": "alpha_test.dart"
    },
    {
      "path": "/test/beta_test.dart",
      "depth": 2,
      "type": "file",
      "name": "beta_test.dart"
    },
    {
      "path": "/test/gamma_test.dart",
      "depth": 2,
      "type": "file",
      "name": "gamma_test.dart"
    },
    {
      "path": "/test/widget_test.dart",
      "depth": 2,
      "type": "file",
      "name": "widget_test.dart"
    },
    {
      "path": "/tools/governor",
      "depth": 2,
      "type": "folder",
      "name": "governor"
    },
    {
      "path": "/tools/gemini_manager.ps1",
      "depth": 2,
      "type": "file",
      "name": "gemini_manager.ps1"
    },
    {
      "path": "/tools/start_autonomy.ps1",
      "depth": 2,
      "type": "file",
      "name": "start_autonomy.ps1"
    },
    {
      "path": "/tools/governor/generate_dashboard_data.ps1",
      "depth": 3,
      "type": "file",
      "name": "generate_dashboard_data.ps1"
    },
    {
      "path": "/web/icons",
      "depth": 2,
      "type": "folder",
      "name": "icons"
    },
    {
      "path": "/web/favicon.png",
      "depth": 2,
      "type": "file",
      "name": "favicon.png"
    },
    {
      "path": "/web/index.html",
      "depth": 2,
      "type": "file",
      "name": "index.html"
    },
    {
      "path": "/web/manifest.json",
      "depth": 2,
      "type": "file",
      "name": "manifest.json"
    },
    {
      "path": "/web/icons/Icon-192.png",
      "depth": 3,
      "type": "file",
      "name": "Icon-192.png"
    },
    {
      "path": "/web/icons/Icon-512.png",
      "depth": 3,
      "type": "file",
      "name": "Icon-512.png"
    },
    {
      "path": "/web/icons/Icon-maskable-192.png",
      "depth": 3,
      "type": "file",
      "name": "Icon-maskable-192.png"
    },
    {
      "path": "/web/icons/Icon-maskable-512.png",
      "depth": 3,
      "type": "file",
      "name": "Icon-maskable-512.png"
    },
    {
      "path": "/windows/flutter",
      "depth": 2,
      "type": "folder",
      "name": "flutter"
    },
    {
      "path": "/windows/runner",
      "depth": 2,
      "type": "folder",
      "name": "runner"
    },
    {
      "path": "/windows/CMakeLists.txt",
      "depth": 2,
      "type": "file",
      "name": "CMakeLists.txt"
    },
    {
      "path": "/windows/flutter/ephemeral",
      "depth": 3,
      "type": "folder",
      "name": "ephemeral"
    },
    {
      "path": "/windows/flutter/CMakeLists.txt",
      "depth": 3,
      "type": "file",
      "name": "CMakeLists.txt"
    },
    {
      "path": "/windows/flutter/generated_plugin_registrant.cc",
      "depth": 3,
      "type": "file",
      "name": "generated_plugin_registrant.cc"
    },
    {
      "path": "/windows/flutter/generated_plugin_registrant.h",
      "depth": 3,
      "type": "file",
      "name": "generated_plugin_registrant.h"
    },
    {
      "path": "/windows/flutter/generated_plugins.cmake",
      "depth": 3,
      "type": "file",
      "name": "generated_plugins.cmake"
    },
    {
      "path": "/windows/flutter/ephemeral/.plugin_symlinks",
      "depth": 4,
      "type": "folder",
      "name": ".plugin_symlinks"
    },
    {
      "path": "/windows/runner/resources",
      "depth": 3,
      "type": "folder",
      "name": "resources"
    },
    {
      "path": "/windows/runner/CMakeLists.txt",
      "depth": 3,
      "type": "file",
      "name": "CMakeLists.txt"
    },
    {
      "path": "/windows/runner/flutter_window.cpp",
      "depth": 3,
      "type": "file",
      "name": "flutter_window.cpp"
    },
    {
      "path": "/windows/runner/flutter_window.h",
      "depth": 3,
      "type": "file",
      "name": "flutter_window.h"
    },
    {
      "path": "/windows/runner/main.cpp",
      "depth": 3,
      "type": "file",
      "name": "main.cpp"
    },
    {
      "path": "/windows/runner/resource.h",
      "depth": 3,
      "type": "file",
      "name": "resource.h"
    },
    {
      "path": "/windows/runner/runner.exe.manifest",
      "depth": 3,
      "type": "file",
      "name": "runner.exe.manifest"
    },
    {
      "path": "/windows/runner/Runner.rc",
      "depth": 3,
      "type": "file",
      "name": "Runner.rc"
    },
    {
      "path": "/windows/runner/utils.cpp",
      "depth": 3,
      "type": "file",
      "name": "utils.cpp"
    },
    {
      "path": "/windows/runner/utils.h",
      "depth": 3,
      "type": "file",
      "name": "utils.h"
    },
    {
      "path": "/windows/runner/win32_window.cpp",
      "depth": 3,
      "type": "file",
      "name": "win32_window.cpp"
    },
    {
      "path": "/windows/runner/win32_window.h",
      "depth": 3,
      "type": "file",
      "name": "win32_window.h"
    },
    {
      "path": "/windows/runner/resources/app_icon.ico",
      "depth": 4,
      "type": "file",
      "name": "app_icon.ico"
    }
  ],
  "workflow": "# Agentic Workflow Visualization\r\n\r\nThis document visualizes the \"Opal\" agentic team workflow for ListingLens PaaS.\r\n\r\n**Note:** This visualization is available as a standalone \"Control Room\" tool.\r\nTo launch the dashboard, run:\r\n`flutter run -t lib/main_dashboard.dart`\r\n\r\n## The Opal Team Structure\r\n\r\n```mermaid\r\ngraph TD\r\n    %% Styling\r\n    classDef user fill:#f9f,stroke:#333,stroke-width:2px;\r\n    classDef dev fill:#e1f5fe,stroke:#01579b,stroke-width:2px;\r\n    classDef detective fill:#e8f5e9,stroke:#1b5e20,stroke-width:2px;\r\n    classDef watcher fill:#f3e5f5,stroke:#4a148c,stroke-width:2px;\r\n    classDef storage fill:#fff3e0,stroke:#e65100,stroke-width:2px;\r\n\r\n    User((User)):::user\r\n    \r\n    subgraph \"The Opal Team\"\r\n        AG[Antigravity<br/>(The Developer)]:::dev\r\n        DT[NotebookLM<br/>(The Detective)]:::detective\r\n        IJ[Injector Agent<br/>(The Watcher/Reviewer)]:::watcher\r\n    end\r\n\r\n    Repo[(ListingLens Repo)]:::storage\r\n\r\n    %% Flows\r\n    User -->|\"/socratic_iteration\"| DT\r\n    User -->|Direct Code Reqs| AG\r\n    \r\n    DT -->|Strategic Insights<br/>(Report)| User\r\n    DT -->|New Tasks| AG\r\n    \r\n    AG -->|Writes Code| Repo\r\n    \r\n    Repo -->|Trigger Review| IJ\r\n    \r\n    IJ -- \"/notebooklm_injector\" -->|Clean & Commit| Repo\r\n    IJ -->|Context Injection| DT\r\n    \r\n    %% Loop\r\n    DT -.->|Socratic Feedback Loop| AG\r\n```\r\n\r\n## Slash Commands\r\n\r\nUse these commands in the chat to activate specific agent routines:\r\n\r\n| Command | Agent | Function |\r\n| :--- | :--- | :--- |\r\n| **/notebooklm_injector** | **The Watcher** | Runs the `clean -> commit -> save project > save > inject` pipeline. Ensures the codebase is stable and prepares context for NotebookLM. |\r\n| **/socratic_iteration** | **The Detective** | Synchronizes the \"Detective\" (NotebookLM) with the \"Developer\" (Antigravity). Use this when strategic adjustments are needed. |\r\n\r\n## Role Descriptions\r\n\r\n- **Antigravity (The Developer)**: Handles direct coding, implementation plans, and immediate problem-solving.\r\n- **NotebookLM (The Detective)**: External strategic intelligence. Analyzes the codebase context and user prompts to find logic gaps (\"missing points\").\r\n- **Injector (The Watcher)**: The \"Control Room\" agent. automates the hygiene of the repo (cleaning, committing) and ensures the Detective has the latest evidence (context injection).\r\n",
  "metrics": {
    "autonomy": 85.7,
    "strategy": 85.6,
    "confidence": "Confident",
    "entropy": 0.1
  },
  "cognition": "# Task: Dashboard & Trinity Logic Repair\r\n\r\n- [x] Research current `dashboard.html` and `trinity_agentic_map.html` <!-- id: 10 -->\r\n- [x] Create enhanced `lib/governor/trinity_map.html` with new logics <!-- id: 11 -->\r\n- [x] Update `lib/governor/dashboard.html` with Workflow, Walkthrough, and Trinity tabs <!-- id: 12 -->\r\n- [x] Refactor `tools/governor/generate_dashboard_data.ps1` for multi-artifact sync <!-- id: 13 -->\r\n- [x] Copy latest `walkthrough.md` and `task.md` to project root for dashboard visibility <!-- id: 14 -->\r\n- [x] Verify final dashboard rendering and metrics <!-- id: 15 -->\r\n- [ ] Final UI Polish (optional) <!-- id: 16 -->\r\n"
};
