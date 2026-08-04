# Blueprint Writer Report: 2-b-1-entries
**Status:** COMPLETE

## Changes
- `IPhO2026Problems_problem_IPhO_2026_2_B_1.tex` only (250 ins, 0 del); skeleton (source paragraphs, iter-002 PhysLean exemption NOTE) kept verbatim; umbrella `thm:physics:IPhO_2026_2_B_1:target` wired via `\uses{thm:...:alpha_beta_in_terms_of_R}`.
- Appended `% --- Archon named-quantities coverage (blueprint-writer 2-b-1-entries) ---` + import-policy NOTE, then 3 ledger sections holding 15 blocks in dependency order for the flat `IPhO2026_2_B_1.*` namespace:
  - Geometry/data (11 def): `Vec`, `vnorm`, `Line2D`, `distToLine`, `CookerParams`, `CookerB1` (specular law, absorption, aperture branch, no-gap recorded as bundled laws), `incidenceAngle`, `IsThetaMax`, `ExtremalRaySpec` (off-axis + tangency distance), `CoeffSpec` (family ansatz, non-evaluating), `SecondExtremalConfig`. Packaging proofs "Definition; no claim."
  - Derivation bridges (2 lem + 1 thm): `impactParam_eq_sin` (arcsin-inverse on open aperture), `sin_two_pos` (sine positive on (0,π)), `container_radius_at_extremal_angle` (B.1 identity a = R sinθ − (R/2) sin2θ via 2×2 specular solve b = −R²/(2√(R²−x²)) + tangency distance evaluation, no sign branch lost).
  - Target value theorem: `alpha_beta_in_terms_of_R` (α = R, β = −R/2) — official values conclusion-side, confined here; proof = identity at two distinct extremal angles − ansatz subtraction → 2×2 system, det 2 sinθ sinθ′(cosθ′−cosθ) ≠ 0.
- No tactic names; no `\leanok`/`\mathlibok` added.

## Verification
- Pins 15/15: every ledger `\lean{}` (underscores escaped) grep-matches an exact disk decl (`abbrev|def|structure|lemma|theorem` + base name, flat namespace `IPhO2026_2_B_1`); every disk nonprivate decl pinned, none left over.
- `\uses`: 36 refs, all resolve in-chapter (0 unknown); 17 labels, no dupes; `\begin`/`\end` balanced 32/32.
- Official values: `α = R`, `β = −R/2` appear only inside the target theorem block; source paragraphs retain "Recorded answer/context" prose from the frozen skeleton (verbatim, untouched).
- `leandag` CLI absent under codex harness; label/uses/balance check done via python parse of the tex.
- No other file modified by me (other dirty chapters are sibling iter-008 writers).

## Deviations
- None.
