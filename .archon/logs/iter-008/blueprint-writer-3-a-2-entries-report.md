# Blueprint Writer Report: 3-a-2-entries
**Status:** COMPLETE

## Changes
- Chapter `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_A_2.tex` only (134 ins, 0 del). Skeleton verbatim: source paragraphs, `thm:physics:IPhO_2026_3_A_2:target`, iter-003 exemption NOTE; `% ...source end ---` marker untouched (ledger appended after it, matching 1-a-1/3-b-1 sibling placement).
- Umbrella wired: `\uses{thm:IPhO2026Problems_problem_IPhO_2026_3_A_2:work_emf_eq_V_mul_H_mul_dB}` added inside the target theorem.
- Ledger header `% --- Archon named-quantities coverage (blueprint-writer 3-a-2-entries) ---` + import-policy NOTE mirrored from the exemption (one targeted Physlib import `Physlib.Electromagnetism.Dynamics.Basic` + Mathlib baseline).
- 8 blocks, dependency order, 4 `\subsection*` groups:
  - quantities/geometry: `def:...:IsPositive` (packaging), `def:...:ToroidData` (geometric law: ring-volume `V = 2*pi*R*A`, bundled assumption);
  - governing-law structures: `def:...:UniformToroidOperatingPoint` (constitutive law + Ampere law fields), `def:...:InducedEMFChange` (Faraday's law `emf*dt = N*A*dB` field), `def:...:WorkOnSource` (packaging readout), `def:...:sourceWork` (source power law `P = emf*I`);
  - bridges: `lem:...:fieldStrength_eq_N_mul_I_mul_A_div_V` (A.1 `H = NIA/V` derivable from Ampere + volume law);
  - value theorem: `thm:...:work_emf_eq_V_mul_H_mul_dB` (official answer `dW_emf = V*H*dB`, conclusion-side only, informal chain emf*I*dt -> N*A*dB*I -> V*H*dB, no tactic names).

## Verification (scripted)
- Pins 8/8: every `\lean{IPhO2026_3_A_2.<name>}` grep-matches an exact on-disk decl (flat namespace `IPhO2026_3_A_2` verified first-hand); 0 unpinned disk decls.
- `\uses`: 8 targets, 0 unknown in-chapter; 10 labels, dup-free; begin/end environments balanced.
- Official value `V*H*dB` confined to the target theorem block (+ pre-existing recorded-answer skeleton paragraph); assumption-side blocks carry no answer content.
- `leandag` CLI not on PATH in this worker; edges checked by extraction script (matches sibling-writer fallback). `.leandag/dag.json` confirms the 8 unmatched `lean:IPhO2026_3_A_2.*` nodes this ledger now pins.
- Markers: 0 `\leanok`/`\mathlibok` added or removed; no other file modified by this writer (other dirty chapters are sibling iter-008 workers).

## Deviations
- Ledger placed after the `% --- Archon physics formalization source end ---` delimiter to keep the marker line intact, matching the landed 3-b-1-entries / 1-a-1-entries chapters; sibling 2-b-2 used in-markers placement. Convention is split across siblings; chose the keep-prior-content-verbatim option.
