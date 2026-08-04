# Project Progress

## Current Stage

autoformalize

## Stages
- [x] init
- [ ] autoformalize — User-authorized mixed-start lifecycle on 2026-08-03: `1_B_1` and `1_B_2` continue from formalization, while formalization-Review-passed `1_C_1` enters directly at proving. The three targets run as independent lifecycles under the shared concurrency cap.
- [ ] prover
- [ ] polish

## Current Objectives

1. **`IPhO2026Problems/problem_IPhO_2026_1_B_1.lean`** — User-authorized redraft after correcting the reversed radial allowed-region inequality. Preserve `Q(r) >= 0` on realized motion and `Q(r) < 0` beyond the energy threshold; complete the remaining bridges. Formalization Review budget: 3/6 used. [prover-mode: physics-formalize]
2. **`IPhO2026Problems/problem_IPhO_2026_1_B_2.lean`** — User-authorized redraft for the missing Kepler/Binet and `Filter.Tendsto` asymptotic-velocity bridges. Preserve `eps^2 = 49/4` and signed deflection `-arctan(2/sqrt 45)`; never restore the refuted `67/4` contract. Formalization Review budget: 3/6 used. [prover-mode: physics-formalize]
3. **`IPhO2026Problems/problem_IPhO_2026_1_C_1.lean`** — Formalization Review already passed; continue the interrupted proof attempt directly, repair the two tactic-level failures in `quadratic_characterization_of_threshold`, and close the forward/backward threshold theorems. Proof Review budget: 1/3 used. [prover-mode: physics]

## Explicitly not dispatched

- `IPhO2026Problems/problem_IPhO_2026_4_C_6.lean` — provenance-blocked: `raw/E1_solution.pdf` absent in this checkout (full official set located iter-012 at sibling `/root/proposal_for_physic/hf-IPHO2026-upload/ipho_2026_source/`; vendor-or-not is a user decision, TO_USER).

## Iter-014 landed work (this phase — full record in iter/iter-014/plan.md + objectives.md)

- **`3_B_2` mandatory redraft LANDED + all 3 sorries closed** (refactor lane `3-b-2-redraft-invariant-fix`, 2642 s, COMPLETE; planner-verified fresh `lake env lean`: 0 errors, 0 warnings, grep-sorry 0): `IsAdiabaticPath` sign fix (`Cm·Ṫ = +w`, official quote "For adiabatic processes, the first law yields to dU = dW"), `adiabaticInvariant` invariant fix (`(λ + μ₀KH²)/T²`, matching the official integrated identity `λ/T_i² − λ/T_f² = μ₀K(H_f²/T_f² − H_i²/T_i²)`), `endpoint_relation` bracket placement corrected (`Tf²(λ+μ₀K Hi²) = Ti²(λ+μ₀K Hf²)`), main-theorem statement byte-identical. Bridge lemma 1 closed via the directed zero-combination of (cleared first law) + (differentiated EOS) + (EOS value) — the pre-redraft context without the EOS value was genuinely insufficient, matching the review countermodel analysis. Blueprint chapter re-keyed this iter (invariant def, first-law sign, bridge proof, endpoint relation, target proof).
- **`1_B_2` recovered from destruction and restored green by-sorry**: the iter-011 redrafted working tree (0-errors/5-sorries gate state incl. `signed_deflection_certificate`) had been accidentally reverted to HEAD (false 67/4/√63 chain, 6 sorries) by a `git apply -R` accident inside refactor lane `1-b-2-tactical-residue`; the lane had captured the full working diff at `/tmp/b2.diff` first, which the planner re-applied byte-verbatim (recovering 454 insertions / 129 deletions), retaining the lane's own three verified tactic fixes (`hu0s`/`huvs` `simp [sq_abs]`; `hratio_sq` `rw [div_pow]; field_simp [ha_norm.ne', hu_norm.ne']; exact hL`) and landing the lane's fourth verified fix (L929 `.trans ?_` → `(by rw [hangle])`, one bullet). Fresh `lake env lean`: 0 errors, 3 documented Kepler-bridge sorries. Blueprint chapter statements re-keyed to the official chain (`eps² = 49/4`, periapsis-referenced `angleBetween = arctan(1/√(eps²-1))`, signed `-arctan(2/√45)`, asymptote factor `2/√45`) and the three proved helper lemmas transcribed (`arctan_poly_squeeze`, `arctan_deg_band`, `signed_deflection_certificate`) — coverage debt: these three were scan-invisible `lean_aux` nodes.
- **Blueprint `3_B_2` chapter re-aligned** (planner-direct, per the refactor report's transcription note): official separated form `nλ dT/T³ = μ₀V²M dM/(nK)`, integration route, and the "derivative of the candidate invariant vanishes by direct substitution" step (first-law/dEOS/EOS-value zero-combination).
- **`2_B_2` chapter broken-cref repair** (blueprint-doctor iter-013 finding): both references to the deleted one-sided `collectedWidth_eq_radius` repointed to `collectedWidth_eq_two_mul_yOff` (+`yOff_eq_R_sin_thetaMax`); grep-verified no remaining occurrence.
- **Collected + archived** `refactor-3-b-2-redraft-invariant-fix.md` and `refactor-1-b-2-tactical-residue.md` from `task_results/` (copies at `logs/iter-014/`); the 28 `physics-grounding-*.md` registers + witness probes preserved per standing rule.

## Review gate queue (post-iter-014 state)

Current targeted gate override: `1_B_1` and `1_B_2` are both `retry` at 3/6 formalization Reviews used. `1_B_1` has a fresh proof record at 0/6; `1_B_2` remains `needs_redraft` at its historical proof attempt 1 and will use the normal post-redraft reset to 0/6 after formalization Review passes. Other historical gate records remain untouched; `4_C_6` is still provenance-exhausted.

## Clean by-sorry (planner audit iter-014 — fresh `lake env lean` per file)

Targeted fresh preflight: `1_B_1` now has 0 errors / 5 sorries after the sign repair; `1_B_2` has 0 errors / 3 documented Kepler-layer sorries. Historical audit for unrelated targets remains in iter-014 artifacts.

## Bookkeeping owed (in flight, planner-side)

- Coverage debt `unmatched` 42 live (39 `1_B_1`-family + `hello` + 2 `2_C_2` defs + `PartA1.circulation`; the 3 new `1_B_2` helpers transcribed + wired this iter, writer lane `1-b-2-helper-entries` COMPLETE 215 s — positions normalized and `\uses` edges added for the two main theorems). The `1_B_1` chapter must follow the repaired `quadratic_nonneg_of_orbit` / `quadratic_neg_of_large` contract and must never restore the false `quadratic_pos_of_large`; other coverage debt remains deferred to its next proof lane.
- `2_B_2` chapter drift (recorded for the 2_B_2 prover lane + next writer pass): `AbsorbedRays` block narration lines 158–163 still describe the iter-009 one-sided quantifier `$(0, R)$`; the frozen Lean substrate is the iter-011 two-sided band. Narration-only; labels/blocks correct.
- Escalations pending (unchanged): user confirmation of the upstream Archon doctor-patch pinning (venv editable install; TO_USER iters 003/005/007/008); vendor-or-not `raw/E1_solution.pdf` into the checkout (unblocks `4_C_6`); session_7 R5/R6 grounding-preflight loop items.
- Refactor-lane hazard ledger (new iter-014, mirrored to ARCHON_MEMORY): refactor agents can destroy uncommitted working-tree content via `git apply -R`; future refactor directives MUST instruct "never run `git apply`/`git checkout`/`git reset`/`sed -i` on any path outside the two verified one-liners in this directive"; the loop should snapshot `git diff` before each subagent dispatch.
