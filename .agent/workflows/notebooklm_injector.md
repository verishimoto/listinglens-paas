---
description: NotebookLM Injector Agent - The Watcher and Reviewer
---
# NotebookLM Injector Agent Workflow

This workflow embodies the "NotebookLM Injector" agent, acting as a reviewer, doer, and control room watcher. It automates the "Clean -> Commit -> Inject" pipeline and handles Socratic iteration.

## 1. Clean & Verify
   // turbo
   - [ ] **Clean Project**: Run `flutter clean` to ensure a fresh state.
   - [ ] **Get Dependencies**: Run `flutter pub get`.
   - [ ] **Analyze**: Run `flutter analyze` to check for errors.

## 2. Review & Commit
   - [ ] **Git Status**: Check `git status` to see pending changes.
   - [ ] **Diff Review**: If there are changes, review them (Agent: Read the diffs).
   - [ ] **Commit**: If changes are approved, commit them with a descriptive message.
     - *Command*: `git add . && git commit -m "feat: [Agent] Automated update"` (User approval required for message).
   - [ ] **Push**: Ensure code is safely on GitHub.
     - *Command*: `git push origin [current_branch]`

## 3. Prismatic Routine (Context Injection)
   > **Note**: This section depends on the "250 prompts" CSV and "prismatic routine" definition.
   
   - [ ] **Select Prompt**: Choose an appropriate prompt from the "Knowledge/Strategy" CSV.
   - [ ] **Generate Injection Artifact**: Update `notebooklm_context_injection.md` with:
     - Current `implementation_plan.md`
     - Critical Source Code
     - Selected Prompt content
   - [ ] **User Action**: Inject into NotebookLM.
   - [ ] **Watch**: Monitor the output and prepare for the next cycle.

## 4. Deployment Validation (The Cove Analysis)
   > **Rule**: The Watcher must validate all major changes before deployment (or major task completion).

   - [ ] **Select Historical Prompts**: Identify key "Previous Prompts" that defined the project's requirements (e.g., "Liquid Glass", "Control Room Aesthetic").
   - [ ] **Context Check**: Ensure `notebooklm_context_injection.md` includes the latest code for these features.
   - [ ] **Validation Injection**: Ask NotebookLM: *"Based on our original goal for [Feature], does this implementation fulfill the promise? Perform a regression check."*
   - [ ] **20x Troublehoot**: If critical, run the "20x Troubleshoot Cove Analysis" routine.

## 4. Control Room Watcher
   - [ ] **Status Check**: If the system (Antigravity) is stuck, run this workflow to reset state and gain strategic clarity via NotebookLM.
