# Recommendations — session 3 (iter-003 review)

## R1 (route: review-retry, fix-first compile) — `problem_IPhO_2026_1_B_1.lean`
Repair the 3 `linarith` errors in `CoulombPairData.quadratic_pos_of_large`
(L401, L419, L427). Suggested discharge shapes (all goal-level, no statement
changes beyond proof bodies):
- L401: replace the `nlinarith [hmul]` at the `hkey` step with an explicit
  product certificate, e.g.
  `have hmul2 : 0 <= r * (-D.total_energy) - coulombK * elementaryCharge ^ 2 := sub_nonneg.mpr hmul`
  then `nlinarith [hcast, hmul2]` (or `linarith [hcast, hmul2]` after rewriting
  `hcast`); the failed attempt fed `nlinarith` the raw `hmul` div-form.
- L419: the L=0-vs-`turning_100` contradiction — after `hL0` and
  `simp only [sub_zero] at hturn`, use
  `nlinarith [hturn, hterm, hcoul]` or expand `hturn` to
  `E*r0^2 + k*e^2*r0 = 0` and close with `linarith [hterm, hcoul]`
  (both summands strictly signed, sum cannot be 0).
- L427: final combination `0 < r*(E*r + k e^2) - L^2/(2 mu)` from `hL` and
  `hnonneg` — this is linear over the atom `r*(E*r+k*e^2)`; if linarith still
  fails, introduce `set A := r * (D.total_energy * r + coulombK * elementaryCharge ^ 2)`
  or rewrite via `hexpand` then `exact sub_pos.mpr (lt_of_lt_of_le hL hnonneg)`
  with the inequality orientation fixed explicitly.
Alternative leaner route (if the above keeps fighting): keep only
`attainedSeparations_lt_energy_threshold` by a direct contrapositive from
`turning_100`-normalized constants, but do NOT drop the boundedness exposure
altogether — it is the field's usable consequence required by the
abstraction_sufficiency gate.

## R2 (route: planner directive, statement-tightening pass) — answer-in-formula
Move the certified root identities out of proved theorem *hypotheses*:
- Restate `turning_root_cases` with the coefficient tuple existentially
  quantified (or read off `turningQuadratic_normalized_eq`'s `rho`), so no
  hypothesis formula literally contains `1600/9`.
- Keep the numeric factorisation use *inside the proof terms* of
  `orbitBound_T1_B1` / `apogee_attained_T1_B1` (term-level `have`), preserving
  conclusion-side-only discipline for the recorded answer.
This is a faithfulness tightening, not a soundness fix: nothing currently
proved is false; the change removes the derivable-at-sorry-gap answer leak.

## R3 (route: director-side, one patch) — doctor↔exemption reconciliation
Patch blueprint-doctor to honor the planner-recorded
`% NOTE: PhysLean-coverage exemption` chapters: forgive ONLY the
`missing-physlib-import` kind for a chapter carrying the NOTE (all 19
`physics_modeling_problems` this iter are that single kind, and the grounding
log for the reviewed file documents genuine near-miss PhysLean coverage).
Do not keep making files oscillate on this check (iters 001–003 repeat it).
Until patched, review agents will keep recording this as a doctor blocker
with the exemption context quoted.

## R4 (route: planner decision for next redraft of 1_B_1) — sign carrier
Decide explicitly whether `orbit_support` / `attainedSeparations` should flip
the sign carrier from `Q r <= 0` to `Q r >= 0` (physical orbit band between
turning points) — the prover's own last_message flags this, and the
`bound_branch` docstring already argues in the >=-convention. If flipped,
update: `attainedSeparations`, `orbit_support`, `quadratic_nonpos_of_orbit`
(rename), `attainedSeparations_subset_Icc_abstract`'s hypothesis direction,
and the abstraction docs. If kept, record why the tail-set model is
acceptable for THIS target (both turning points on its boundary, greatest
element semantics still line-true).

## R5 (route: do NOT do) 
- Do not re-derive `boundMu_isBound` from `bound_branch`: the field lives on
  `CoulombPairData D` while `IsBoundMu boundMu` is a constant-level Prop;
  the prover's analysis is correct that these are different bound criteria
  (one per system instance, one for the mu=4 parameter). Keep both.
- Do not remove the `AnchoredValues` hypothesis interface; it carries the
  anchoring equations the normalization certificate needs.
- Do not spend the last review-retry on the sign-carrier flip (R4) if R1
  alone restores the gate; R4 is a statement-semantics improvement, R1 is
  the blocker.

## Routing summary for next plan agent
- `problem_IPhO_2026_1_B_1.lean`: review-retry (attempt 3/3) with R1 as the
  mandatory fix; fold in R2 only if cheap; R4 is planner-decision.
- `problem_IPhO_2026_4_C_6.lean`: iter-003 O2 (official_sample_value
  quarantine) was recorded in session_2 as failed and remains outstanding;
  the sample instance at L409 is still on disk and still numerically false
  (1/(4186*0.55*7.3e-4) = 0.595 not in 1.17+/-0.03). It was not in this
  iter's deterministic target set; re-dispatch per iter-003 plan sidecar.
