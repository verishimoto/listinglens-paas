---
description: Socratic Iteration Loop - Synchronizing Detective (NotebookLM) and Developer (Antigravity)
---

# Socratic Iteration Workflow

This workflow orchestrates the feedback loop between the "Detective" (Knowledge/Strategy) and the "Developer" (Execution).

## 1. Context Injection (The Detective)

- [ ] **Generate Injection Artifact**: Run the task to update `notebooklm_context_injection.md` with:
  - Latest `implementation_plan.md`
  - Current critical file snippets (`main.dart`, `solid_fusion_layout.dart`, etc.)
  - "Socratic Database" active principles.
- [ ] **User Action**: Paste the content of `notebooklm_context_injection.md` into NotebookLM.
- [ ] **User Action**: Prompt NotebookLM with the "Meta-Cognitive Prompt" (found in the injection artifact).
- [ ] **User Action**: Paste NotebookLM's "Report" and "Missing Points" back to Antigravity (via `notify_user` response or Chat).

## 2. Strategic Analysis (Antigravity)

- [ ] **Analyze Report**: Read the `notebooklm_report.md` (or user input).
- [ ] **Update Task List**: Modify `task.md` with new findings (e.g., "Fix missing micro-interaction identified by Detective").
- [ ] **Refine Plan**: Update `implementation_plan.md` if architecture changes are needed.

## 3. Execution (The Developer)

   // turbo

- [ ] **Test Current**: Ensure current build produces no errors.
- [ ] **Implement Changes**: Execute code edits based on the refined plan.
- [ ] **Verify**: Run verification commands (tests or manual check prompts).
- [ ] **Commit & Push**:
  - *Command*: `git add . && git commit -m "feat: [Socratic] Implemented feedback" && git push origin [current_branch]`

## 4. Validation (The Watcher)

- [ ] **Cove Analysis**: If the change was major, trigger the "20x Troubleshoot" routine in NotebookLM.

## 5. Loop

- [ ] **Restart**: Go back to Step 1 to synchronize the new state with NotebookLM.
