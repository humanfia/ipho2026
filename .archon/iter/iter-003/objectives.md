# Objectives — iter 003 dispatch

Stage: autoformalize. Both lanes mode `physics-formalize` (stage default).
Full preservation constraints live in `PROGRESS.md ## Current Objectives`; the
canonical file-level record is this iter's plan sidecar.

## O1 — `IPhO2026Problems/problem_IPhO_2026_1_B_1.lean` (REDRAFT #3, reviews 2/3)
Make the bound branch a hard `CoulombPairData` structure constraint (`bound_branch : D.E < 0` or turning-discriminant positivity), re-derive `boundMu_isBound` from it (or drop the duplicate predicate), so lawful non-bound instances can no longer satisfy the hypotheses while falsifying the maximum. Preserve: `certified_factorization`, `turning_root_cases` (proved), `AnchoredValues`, `orbit_support`, both conclusion-side bridges, `1600/9` conclusion-side only, all 5 sorries as `by sorry`.

## O2 — `IPhO2026Problems/problem_IPhO_2026_4_C_6.lean` (REDRAFT #2, reviews 1/3)
Quarantine the numerically-false `official_sample_value` (delete + documented comment: official `1.17 ± 0.03` requires `c₀·m ≈ 1903 J/K` vs stated 2302.3 — printed sample microdata inconsistent, no honest Lean theorem can witness it). Preserve: `wall_thermal_resistance_from_C5`, `uncertainty_propagates_to_resistance`, all 6 targeted Physlib imports, sorry bodies intact.

## Not dispatched (recorded for the loop)
- 26 review-ready/review-retry targets — no prover review lane exists in autoformalize; they re-enter at the next formalization-review gate pass with the doctor now clean.
- Helper-blueprint transcription (468) — starts next iter, per-problem-part batches.
