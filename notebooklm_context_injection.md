# PROJ: PROJECT GLASS - VISUAL STATE DOSSIER

**Agent**: UX Designer ("The Artisan")
**Date**: 2026-01-20
**Subject**: Heuristic Analysis of "Crystal UI" Prototype

## 1. Visual Physiology (Current State)

We have migrated from "Obsidian" (Dark) to "White Deep" (Iridescent Light).

### A. The "Solid Fusion" Layout

- **Max Width**: Constrained to 1400px (Centered). No longer edge-to-edge sprawl.
- **Background**: `FluidBackground` (Animated mesh) hidden behind a translucent `AppColors.structureColor`.
- **Header**:
  - **Type**: Unified `GlassTabBar` ("Piano Keys") for "The Lab" & "Hub".
  - **Interaction**: Keys press *down* into the surface (Active state merges).
  - **Logo**: "AGENCY FB" (Condensed) with `LiquidGlass` container.
  - **Pro Badge**: Neon Green (#1CFF00) indicator.

### B. The "Piano Key" Interaction

- **Metaphor**: Physical piano keys made of glass.
- **Locations**: Sidebar (Vertical) and Header (Horizontal).
- **Physics**:
  - **Idle**: Transparent, showing the "Rail" line beneath.
  - **Hover**: White (50% Opacity) glint. Cursor `SystemMouseCursors.click`.
  - **Active**: Deep White (#F5F5FA) - **Totally Opaque**.
  - **The Merge**: Active tab overlaps the border (-1.5px margin), creating a seamless connection.
- **Iridescence**:
  - **Animation**: `LiquidGlass` surfaces now "breathe" (4s loop) with shifting gradients.
  - **Shadow**: Solar glow (Orange/Cyan) on active states.

## 2. Heuristic Friction Points (For Detective Analysis)

*NotebookLM, please critique the following potential issues:*

1. **The "Agency FB" Legibility**: Is condensed type too hard to read for the main navigation? Does it feel "Premium" or "Dated 2010s Sci-Fi"?
2. **The "White Deep" Contrast**: Is the #F5F5FA background too close to the #FFFFFF cards? Is there enough depth separation without heavy drop shadows?
3. **The "Piano" Gap**: We have a 2px gap between keys. Does this break the "Liquid" feel? Should they be flush?

## 3. Deep Research Sources (For Detective Analysis)

*NotebookLM, please add this link as a Source and analyze it:*

- **Source**: [WWDC 2025 - Designing for visionOS](https://developer.apple.com/videos/play/wwdc2025/219/)
- **Extraction Goal**:
  1. What are the exact `blur` radius values for "Glass" materials?
  2. How does the "Luminance" border behave on interaction?
  3. What is the "focal scale" animation curve?

## 4. Socratic Prompt (Copy-Paste to NotebookLM)

> "Act as a Critical UX Researcher. precise and ruthless. Review the 'Visual State Dossier' and the 'Deep Research Sources'.
>
> 1. Evaluate the 'Piano Key' tab metaphor. Does the 'Seamless Merge' logic hold up in a glass UI?
> 2. Critique the color palette (Peach/Lavender/Sky). Is it too 'Pastel/Childish' for a 'Pro PaaS'?
> 3. Based on the WWDC video source, give me 3 specific CSS/Flutter changes to make 'LiquidGlass' match the official specs."
