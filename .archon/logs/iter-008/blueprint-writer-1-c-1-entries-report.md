# Blueprint Writer Report: 1-c-1-entries
**Status:** COMPLETE

## Changes
- Skeleton kept verbatim (source paragraphs, `thm:physics:IPhO_2026_1_C_1:target`, iter-002 exemption NOTE). Only skeleton edit: added directive-mandated `\uses{...minimum_angular_frequency_T1_C1, ...hbarOmegaMin_pi_sub}` to the physics target theorem.
- Appended `% --- Archon named-quantities coverage (blueprint-writer 1-c-1-entries) ---` + import-policy NOTE mirror, then 4 ledger subsections:
  - `Quantities and data`: `dissociationEnergyGap`, `ConstantRegime`.
  - `Reaction geometry`: `ReactionPlane`, `PhotonLine`, `IsScatteringAngle`, `IsAngularRange`, `IsForwardBranch`.
  - `Governing-law structures`: `IsTwoBodyDissociation`, `momentum_q_sq_of_vector_balance` (lem), `ReachableFrequency`, `IsDissociationThreshold`.
  - `Threshold candidate and derivation bridges`: `hbarOmegaMin`, `two_sin_sq_add_one_eq` (lem), `quadratic_characterization_of_threshold` (lem).
  - `Value and target theorems`: `minimum_angular_frequency_T1_C1`, `minimum_angular_frequency_backward_branch_T1_C1`, `hbarOmegaMin_pi_sub`.

## Verification
- Pins: 17/17 ledger `\lean{}` names grep-match exact disk decls in namespace `IPhO2026.Problem1.C1` (underscores escaped per sibling-ledgers convention; 6 opaque scalars stay unpinned by design — covered via `dissociationEnergyGap`/`ConstantRegime` blocks).
- `\uses`: 0 unknown in-chapter (scripted label/uses cross-check; `leandag` not on PATH).
- begin/end balanced: 11 def / 3 lem / 4 thm (incl. physics target) / 18 proof, 36/36.
- Official closed-form value (3 m c^2 (1 - sqrt(...)) / (hbar (2 sin^2+1)), pi/2 freeze) confined to the two `minimum_angular_frequency_*` target theorems (+ skeleton recorded-answer paragraph, verbatim); `hbarOmegaMin` block names the expression structurally without numerics beyond it; law predicates carry no value.
- No tactic names; markers (`\leanok`/`\mathlibok`) untouched/absent; no other file modified.

## Deviations
- None (opaque-constant family noted above is intended grouping, matching sibling-ledger practice).
