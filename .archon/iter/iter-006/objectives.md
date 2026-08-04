# Objectives — iter 006 dispatch (2 repair lanes — last 2 broken files)

Stage: autoformalize. Mode: `physics-formalize` (stage default for both; both chapters are `% archon:physics`; both edits are surgical repairs inside the mode's editing domain — no redrafts).

## O1 — `IPhO2026Problems/problem_IPhO_2026_4_A_5.lean` (REPAIR, comment terminator; reviews 0/3 — dispatchable)

**Defect (verified iter-006 by direct `lake env lean`):** 1 error, `351:0: unterminated comment`. The doc-comment opener at L320 (`/-- Component of `main`: uncertainty propagation...`) never closes, so the entire tail — the `beta0_uncertainty_bound` theorem AND the file's two `end` lines (`end` at L348, `end IPhO2026_4_A_5` at L350) — is comment-swallowed. Stripped-comment view (`awk` removing `/-…-/` spans) confirms everything up to `beta0_eq_ideal_of_linear` (statement ends L318, `sorry` body) is intact; the missing surface is exactly the last theorem + terminators. The iter-002-era "benign tail" note (task_pending known-minor) is stale — this is a real compile error, promoted to top objective.

**Missing theorem (to be restored verbatim-modulo source re-anchoring).** On-disk swallowed text, L320–L346:
```
/-- Component of `main`: uncertainty propagation. If the two-readout
pressure increment deviates from the ideal-gas increment
`P0 * Delta T / T0` by at most `P0 * |Delta T| * sigma`, then the measured
coefficient satisfies the propagated bound `|beta0 - 1 / T0| <= sigma`.
Formalizes the official sample statement `beta0 = 0.0034 +/- 0.0007 K^-1`
covering the ideal-gas reference `0.0037 K^-1`. -/
theorem beta0_uncertainty_bound
    (proc : IsochoricProcess) (law : IsIdealGasLaw proc)
    (linear : IsIsochoricLinear proc) (ref : IsReferenceState proc)
    (T₀ β₀ : ℝ) (hT₀ : T₀ = IsReferenceState.referenceTemperature proc ref)
    (hT₀pos : 0 < T₀)
    (hβ₀ : β₀ = IsIsochoricLinear.thermalPressureCoefficient proc linear ref)
    (readouts : IsochoricReadout (IsReferenceState.referencePressure proc ref) T₀ β₀)
    (σ : ℝ) (hσ : 0 < σ)
    (hdev : |(readouts.measuredPressure readouts.T₂ (Or.inr rfl)) -
        (readouts.measuredPressure readouts.T₁ (Or.inl rfl)) -
      IsReferenceState.referencePressure proc ref * (readouts.T₂ - readouts.T₁) / T₀|
      ≤ IsReferenceState.referencePressure proc ref * |readouts.T₂ - readouts.T₁| * σ) :
    |β₀ - 1 / T₀| ≤ σ := by
  sorry
```
(reindented above for readability; restore with the original 4-space continuation style). Before restoring, **re-anchor against the source**: `reports/ipho_2026_k3/problem_IPhO_2026_4_A_5.source.json` and the E1 reference in `references/` — the hypotheses, deviation carrier (`P₀·|ΔT|·σ`), conclusion (`|β₀ − 1/T₀| ≤ σ`), and band values (`3.4e-3 ± 7e-4 K⁻¹` covering `1/273.15 ≈ 3.664e-3`) were iter-001-review-clean; if the source disagrees with any piece, follow the source and note the correction in the task result.

**Repair steps:**
1. Insert the closing `-/` at the right end of the doc comment (after the `0.0037 K^-1` line, before `theorem beta0_uncertainty_bound`).
2. Confirm the theorem text + `sorry` body and the trailing blank line + `end` + `end IPhO2026_4_A_5` are present below the comment; if the terminator was the ONLY missing piece, nothing else needs restoration. Do NOT rewrite earlier content; do NOT change any signature.
3. PRESERVE exactly: all imports, `namespace IPhO2026_4_A_5`, every structure/def/theorem before L320 (incl. `main` at L259 and `beta0_close_to_ideal` at L289), all 11 contracted `sorry` bodies, the chapter's `% NOTE: PhysLean grounding reconciliation` (targeted Physlib thermodynamics imports — do not touch).
4. Per-file gate: `lake env lean IPhO2026Problems/problem_IPhO_2026_4_A_5.lean` → **0 errors**; sorry-count warning lines = exactly the 11 contracted sites; the file now ends with the two `end` lines. Report the clean compile explicitly.

## O2 — `IPhO2026Problems/problem_IPhO_2026_1_B_1.lean` (REPAIR, verbatim iter-005 O1; reviews 3/3 `review_exhausted` — lane EXPECTED to be gate-dropped; keeping the directive on record is the file's endgame, see iter/iter-005+006 plan.md `## Decision made`)

**Defect (verified iter-006, identical to iter-003/004/005 audits):** 3 `linarith failed to find a contradiction` errors at L401/L419/L427, all inside the lane-added `CoulombPairData.quadratic_pos_of_large` (L385–L431). Root cause is a sign-flipped key step: `hkey : 0 ≤ D.total_energy * r + coulombK * elementaryCharge ^ 2`. From `hr : coulombK * elementaryCharge^2 / (-D.total_energy) ≤ r` with `0 < -D.total_energy` one derives `k e² ≤ r·(−E)`, i.e. `E·r + k e² ≤ 0` — the claimed direction is FALSE in general, which is exactly why `linarith` fails.

**Repair (do not redraft):**
1. Fix the sign derivation: keep the correct `hmul : coulombK * elementaryCharge ^ 2 ≤ r * (-D.total_energy)` (`mul_le_mul_of_nonneg_right hr` + `div_mul_cancel₀`), then conclude `D.total_energy * r + coulombK * elementaryCharge ^ 2 ≤ 0` (via `D.total_energy * r = -(r * (-D.total_energy))` by ring, then `linarith [hmul]`).
2. Restate the lemma to the mathematically true form. With `bound_branch : E < 0` the turning quadratic is a DOWNWARD parabola in `r`: writing `q(r) = r * (E*r + k e²) − L²/(2μ)` (existing `hexpand`), for `r ≥ k e²/(−E)` the first term is `≤ 0` and `hL : 0 < L²/(2μ)` (existing by-contra block — keep it), so the true conclusion is `D.turningQuadratic r < 0`, NOT `0 < D.turningQuadratic r`. Close with explicit `have` steps: `r * (E*r + k e²) ≤ 0` (`mul_nonpos_of_nonneg_of_nonpos`, `r > 0` available as `hr_pos`), then `linarith [hL, hnonpos]` (subtracting a strictly positive term). Rename the theorem if the name misleads (e.g. `turningQuadratic_neg_of_large`); a false-but-compiling lemma is worse than none.
3. Audit the consumer `attainedSeparations_lt_energy_threshold` (L436–L444): with the corrected lemma (threshold ⇒ `q < 0`) the corollary still closes — attained member has `q ≤ 0`... recheck: `hrQ : turningQuadratic r ≤ 0` (attained membership) vs `hpos < 0` — if the corrected lemma gives `q r < 0` there is NO contradiction with `q r ≤ 0`; the consumer's contradiction must instead use strictness: `q r < 0` contradicts `q r = 0`-flavored refinement only if attained membership strengthens to `q r ≤ 0` AND the threshold forces `q r < 0` — this does NOT close. RE-AUDIT: the consumer's actual logic is `by_contra ⇒ threshold ⇒ quadratic_pos_of_large gives 0 < q`, contradicting `hrQ : q ≤ 0`. With the sign flip the honest corollary is the CONTRAPOSITIVE form: attained member ⇒ `q r ≤ 0`, and for `r ≥ threshold` the downward parabola gives `q r < 0` — consistent, no contradiction, so the original corollary statement `r < threshold` becomes FALSE under the corrected lemma. The lane MUST re-derive the correct boundedness statement from scratch: on the bound branch the lawful region `{r : q r ≤ 0}` is a COMPACT interval `[r₋, r₊]` because the parabola opens downward; attained set ⊆ `{q ≤ 0}` ⊆ bounded interval; hence there EXISTS a bound (the conclusion-side `orbitBound_T1_B1` consumes the sharp value `(1600/9)·a₀` from the certified factorization). Restate `attainedSeparations_lt_energy_threshold` accordingly (e.g. attained set is bounded above by the larger turning root `r₊`, with the threshold `k e²/(−E)` serving as a LOWER bound on `r₊`, or any honestly-true weakening) — the review-verified invariant is only that the boundedness BRIDGE exists and is true. If nothing true and useful closes quickly, delete the two lane-added lemmas wholesale (`quadratic_pos_of_large`, `attainedSeparations_lt_energy_threshold`, and their doc block) and leave the file with its 5 contracted sorries: deletion re-tears a hole the lane was right to want, but a resident false lemma is worse, and `orbitBound_T1_B1` remains a sorry either way. Update the OR case (whichever of restate / weaken / delete) in the task result with the audit trail.
4. PRESERVE exactly: `bound_branch` structure field, `AnchoredValues`, `certified_factorization`, `turning_root_cases`, `turningQuadratic_eq_zero_iff`, `turningQuadratic_normalized_eq`, `orbit_support`, `initial_separation_attained`, all conclusion-side bridges (`orbitBound_T1_B1`, `apogee_attained_T1_B1`, `maximum_separation_T1_B1`, `maximum_separation_in_bohr_radii_T1_B1`), `1600/9` strictly conclusion-side, all 5 contracted `by sorry` bodies, the `import Mathlib` baseline (chapter carries the `% NOTE: PhysLean-coverage exemption`).
5. Per-file gate: `lake env lean IPhO2026Problems/problem_IPhO_2026_1_B_1.lean` → 0 errors; sorry warnings = exactly the 5 contracted sites. Report the clean compile explicitly — this is the planner evidence on record for the file's endgame (TO_USER iter-005 stands).

## Not dispatched (recorded for the loop)
- 26 gate-enrolled review-queue targets — deterministic review pass audits them from gate state next phase (doctor clean: 15 at 1/3 + 11 eager at 0/3); no statement change warranted.
- Helper-blueprint transcription (472-debt) + umbrella-node `\lean{}`/`\uses{}` wiring — planner-side bookkeeping, largest batches first (P3_C3 42, P1_B1/P1_B2 32 each, P4_C6 31, P1_A1 28); starts after the two repair lanes land so moving signatures settle.
- `4_C_6` — defect closed iter-004 (recovered microdata, arithmetically true restatement, provenance caveat a TO_USER item).
