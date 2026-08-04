# Review — IPhO2026Problems/problem_IPhO_2026_1_B_2.lean (iter-010, attempt-1)

Status: **blocked** | Route: **needs_redraft** (`wrong_or_weakened_target`)

- File compiles (preflight rc=0) with 6 sorries: `eccentricity_sq_eq`, `orbit_eq_conic`,
  `exists_asymptoticRelativeVelocity`, `signed_deflection_eq_formula`,
  `signed_deflection_angle_T1_B2`, `unsigned_deflection_angle_in_degrees_T1_B2`.
- No axiom/admit laundering; signatures preserved; official `-16.60°` is conclusion-side only;
  orientation and rounding-band semantics are faithful. `total_energy_pos` was honestly closed
  (E = 1/80 in `ℏ²/(m a₀²)`, consistent with eps² = 49/4).
- Semantic failure: the two main targets assert the closed form `∓(π − 2·arctan(2/√63))`
  (≈ ∓151.71°), which their own bands [−16.605,−16.595) / [16.595,16.615) exclude — the proof
  bodies themselves contain machine-checked `¬ roundsToOfficialDegrees(Abs)` witnesses
  (`≤ −90°` / `≥ 90°`). Upstream, `eccentricity_sq_eq` claims 67/4 vs. the fields' 49/4.
- Prover trace and iter-010 task result agree and documented all of this; the correct
  physical value is `arctan(2/√45) ≈ 16.6015°`, inside the official band.
- Repair: redraft conclusion layer only — eps² = 49/4, acute formula `arctan(1/√(eps²−1))`,
  main target `−arctan(2/√45)`, re-based `asymptote_factor_certificate` (2/√45), blueprint
  ledger sync; banked band-membership machinery is ready. Kepler-layer sorries remain the
  downstream gap after redraft.
