<!--
USER_HINTS.md — two sections with different lifecycles.

## Temporary hints
  Consumed by the next plan phase and then cleared. Use for one-shot
  steering: "try route X this iter", "skip Lane F this round".

## Persistent hints
  NEVER auto-cleared. These are standing directives that survive every
  iteration reset. The plan agent treats them as HIGHER PRIORITY than
  any conflicting instruction in its own prompt or in
  .humanizephysics/prompts/plan.md. Use for project-wide constraints:
    - "never accept axiom X"
    - "don't touch theorem Y until I say so"
    - "always run mathlib-build mode on Lane I"

Format for both sections (one bullet per hint, timestamped):
  - [YYYY-MM-DDTHH:MM:SSZ] hint text

Hints are written by 'humanizephysics discuss' or directly by you. In discuss,
the agent will ask which section to target; in a direct edit, place your
bullet under the appropriate heading.

File-specific hints (one .lean file only) belong as /- USER: ... -/
comments inside that file — NOT here.
-->

## Temporary hints


## Persistent hints
- [2026-07-27T16:17:34Z] Skip all six IPhO 2026 experimental E1 targets until explicitly resumed: 4_A_1, 4_A_5, 4_B_4, 4_B_6, 4_C_6, 4_C_7. The active theory scope is now all 23 theory targets, explicitly including IPhO_2026_3_C_1. C_1 must be autoformalized from Figure 3b, pass formalization Review, be proved without sorry, pass proof Review, and compile in the full build. Do not mark the project complete or remove C_1 from objectives before all of those checks pass.

