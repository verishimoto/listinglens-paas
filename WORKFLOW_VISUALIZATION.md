# Agentic Workflow Visualization

This document visualizes the "Opal" agentic team workflow for ListingLens PaaS.

**Note:** This visualization is available as a standalone "Control Room" tool.
To launch the dashboard, run:
`flutter run -t lib/main_dashboard.dart`

## The Opal Team Structure

```mermaid
graph TD
    %% Styling
    classDef user fill:#f9f,stroke:#333,stroke-width:2px;
    classDef dev fill:#e1f5fe,stroke:#01579b,stroke-width:2px;
    classDef detective fill:#e8f5e9,stroke:#1b5e20,stroke-width:2px;
    classDef watcher fill:#f3e5f5,stroke:#4a148c,stroke-width:2px;
    classDef storage fill:#fff3e0,stroke:#e65100,stroke-width:2px;

    User((User)):::user
    
    subgraph "The Opal Team"
        AG[Antigravity<br/>(The Developer)]:::dev
        DT[NotebookLM<br/>(The Detective)]:::detective
        IJ[Injector Agent<br/>(The Watcher/Reviewer)]:::watcher
    end

    Repo[(ListingLens Repo)]:::storage

    %% Flows
    User -->|"/socratic_iteration"| DT
    User -->|Direct Code Reqs| AG
    
    DT -->|Strategic Insights<br/>(Report)| User
    DT -->|New Tasks| AG
    
    AG -->|Writes Code| Repo
    
    Repo -->|Trigger Review| IJ
    
    IJ -- "/notebooklm_injector" -->|Clean & Commit| Repo
    IJ -->|Context Injection| DT
    
    %% Loop
    DT -.->|Socratic Feedback Loop| AG
```

## Slash Commands

Use these commands in the chat to activate specific agent routines:

| Command | Agent | Function |
| :--- | :--- | :--- |
| **/notebooklm_injector** | **The Watcher** | Runs the `clean -> commit -> inject` pipeline. Ensures the codebase is stable and prepares context for NotebookLM. |
| **/socratic_iteration** | **The Detective** | Synchronizes the "Detective" (NotebookLM) with the "Developer" (Antigravity). Use this when strategic adjustments are needed. |

## Role Descriptions

- **Antigravity (The Developer)**: Handles direct coding, implementation plans, and immediate problem-solving.
- **NotebookLM (The Detective)**: External strategic intelligence. Analyzes the codebase context and user prompts to find logic gaps ("missing points").
- **Injector (The Watcher)**: The "Control Room" agent. automates the hygiene of the repo (cleaning, committing) and ensures the Detective has the latest evidence (context injection).
