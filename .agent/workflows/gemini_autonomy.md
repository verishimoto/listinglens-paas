---
description: Run the Gemini Autonomy Routine (Heartbeat or Deep Clean)
---
// turbo-all

This workflow triggers the Gemini Autonomy Manager to perform self-maintenance tasks.

# Options

- **Heartbeat**: Runs a quick auto-save of current work. Recommended every 20 mins.
- **Deep Clean**: Runs a full sync (push), static analysis, and cleanup. Recommended after finishing a task.

# Routine Failure Protocol

If the routine fails, you must manually:

1. Check `git status`
2. Resolve any merge conflicts
3. Run `flutter analyze` to check for new errors

# Steps

1. Determines which routine to run based on user input or agent decision.
2. Executes `tools/gemini_manager.ps1`.

// turbo
3.  Execute the manager script:
    ```powershell
    ./tools/gemini_manager.ps1 -Routine DeepClean
    ```
    *(Note: Change 'DeepClean' to 'Heartbeat' if only saving is required)*
