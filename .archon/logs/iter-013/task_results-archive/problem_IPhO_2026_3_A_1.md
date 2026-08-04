# Prover task result: problem_IPhO_2026_3_A_1.lean (iter-013, lane 7)

## Verdict
closed, sorry-free. `lake env lean IPhO2026Problems/problem_IPhO_2026_3_A_1.lean`
gives 0 errors, 0 warnings, 0 sorries (exit 0, empty log).

## What happened this lane
At lane start the working tree held the pre-redraft HEAD snapshot of the file:
the old summed Ampere field side `sum_t 2piR*H_t = sum_t I_t` with one `sorry`
at old line 579, the machine-verified underdetermined-contract gap (countermodel
2piR=2, N=2, H=1, I=2). The iter-011 mandatory law redraft had landed in a
sibling/later tree but was absent from this checkout.

I restored the exact iter-013 baseline contract (`.archon/logs/iter-013/snapshots/IPhO2026Problems_problem_IPhO_2026_3_A_1/baseline.lean`),
i.e. the iter-011 redraft of `AmpereLawThinMeanPath.ampere_sum` to the
once-traversed circulation `(2piR)*HPerimeter = sum_t I_t`, plus the
`fieldMagnitudePerimeter`, `ampere_HPerimeter` and `perimeter_eq_interior`
embedding fields. The file is now byte-identical to that snapshot and matches
the blueprint chapter ledger for `ParamagneticTorusA1`. The direction is the
review agent's own repair suggestion (iter-010 review summary for this file):
circulation taken once along the mean loop, then Bridges 2-4 and both target
theorems close unchanged.

The diff vs HEAD is large but it is exactly the reviewed law repair; no
conclusion was weakened. `paramagneticTorus_H_eq` still derives
`T.fieldMagnitude = (T.numTurns : R) * T.wireCurrent.readout * T.crossSectionArea / T.volume`
from law fields only (fieldMagnitude is never defined as the target
expression).

## Proof status (all 34 declarations have complete bodies)
- Bridge 1 `ampere_uniform_eq`: `2piR*H = N*I` from `T.ampere.circulation`
  (law field), `ampere_current` (series wire) and
  `ampere_HPerimeter`/`perimeter_eq_interior` (uniformity).
- Bridge 2 `fieldMagnitude_eq_meanRadius_form`: `H = N*I/(2piR)` via
  `eq_div_iff`, `2piR != 0` from `meanRadius_pos` and `Real.pi_pos`. The
  former `sorry` is closed.
- Bridge 3 `mean_circumference_eq`: `2piR = V/A` via `volume_eq` + field_simp.
- Bridge 4 `meanRadius_form_eq_volume_form`: `N*I/(2piR) = N*I*A/V` via
  Bridge 3 + field_simp.
- Targets `paramagneticTorus_H_eq` and `paramagneticTorus_H_eq_meanRadius`:
  transitivity of Bridges 2+4, resp. restatement of Bridge 2.
- Structures (FreeSpace, InstantaneousCurrent, AmperianFilament, AmpereLaw,
  FiniteWinding, AmpereLawThinMeanPath, UniformFieldMag, AmperianFilamentLaw,
  VacuumCoreIdentity, ParamagneticTorusA1) and their consequence theorems are
  law/data only; no field states the target relation.

## Axiom check
`#print axioms` on all 34 fully-qualified declarations reports only the
Mathlib-standard `[propext, Classical.choice, Quot.sound]`. No `sorryAx`,
no `axiom`, no `native_decide`, no `admit` anywhere in the file.

## Blueprint markers
The chapter `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_A_1.tex`
already documents exactly this repaired contract (its dep graph matches the
compiled dependencies; e.g. `paramagneticTorus_H_eq` uses Bridges 2+4).
All ledger environments are ready for the leanok marker, left to the
deterministic sync phase per role rules (I did not edit the chapter):
defs FreeSpace, RadialProfile, AmperianFilament, AmpereLaw, FiniteWinding,
AmpereLawThinMeanPath, UniformFieldMag, AmperianFilamentLaw,
VacuumCoreIdentity, ParamagneticTorusA1; lemmas ampere_uniform_eq,
fieldMagnitude_eq_meanRadius_form, mean_circumference_eq,
meanRadius_form_eq_volume_form; theorems paramagneticTorus_H_eq and
paramagneticTorus_H_eq_meanRadius.

## Redraft needed
None. The iter-010 underdetermined-contract redraft request is resolved by the
restored contract; both target theorems are honest consequences of the bundled
laws. For the proof-Review re-gate (retry 0 of 3): the reviewed failure was
the stale pre-redraft snapshot left in the tree at lane start, not a
regression in the repaired contract.
