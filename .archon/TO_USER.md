# TO_USER — persistent notice board (non-blocking; the loop never waits)

## Standing (iters 003–012)
- **Venv doctor patch pinning** (iters 003/005/007/008): the Archon blueprint-doctor runs from a venv editable install carrying the import-policy exemption-NOTE patch. Pinning that patch upstream is a user-side action; unpinning risk is that the stale `missing-physlib-import` finding series returns.
- **`1_B_1` gate-exhausted residual** (iters 005/007): formalization gate exhausted at 3 semantic attempts; reopen ONLY via prover-stage proof-Review redraft with the frozen spec (iter/iter-005 O1 true-`q<0` restatement + iter/iter-006 O2 consumer decision tree). Its 5–6 sorries are the accepted autoformalize residual if reopen never fires.

## Iter-012 updates
- **`4_C_7` repaired and off the provenance hook**: the two false contracts (sign convention; frozen-inputs numeric falsity) are redrafted on disk iter-012 (formula: physical drive `T_OC < T_IC`, `0 < R_Th`, `0 < lam`; sample: `0.2629 ≤ h·R_Th → |λ−0.25| ≤ 0.01` over abstract positive inputs). Arithmetic settled first-hand from the official E1 solution PDF (see below): `λ = 0.25` needs `h·R_Th ≈ 0.2050`, not the frozen `0.117`; which recorded input the official sample used is under-determined, so the repaired contract asserts only the sound direction.
- **Official solution set found outside the checkout**: full IPhO 2026 official solutions (E1/T1/T2/T3, PDF + txt) live at `/root/proposal_for_physic/hf-IPHO2026-upload/ipho_2026_source/` (also `science-mango/ipho_2026_source/`). The project checkout still has no `raw/` directory. **Decision for you**: vendor `raw/E1_solution.pdf` (and siblings) into the checkout — this is the sole provenance blocker on `4_C_6` (exhausted at 3/3; a vendored PDF plus a provenance note would ground a one-time redraft of its sample theorem). Read-only use of the sibling copy is already being made by agents.
- **`4_C_6`** stays provenance-blocked (2/3 → exhausted): its sample microdata (`a=(2.28±0.06)·10⁻³ 1/s`, `m=(89±1) g`) are unverifiable in-checkout; the sibling-path solution text does record them (C.6 entry), but the loop's provenance gate wants the artifact in the project tree.

## Loop-side notes (no action)
- Stage advance to prover waits only on the iter-012/013 re-gate of `3_B_2`/`4_C_7` (repairs landed iter-012, compile-verified); first proof batch (12 lanes) is already dispatched in PROGRESS.md.
