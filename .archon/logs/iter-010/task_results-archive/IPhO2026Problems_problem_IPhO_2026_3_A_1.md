# Prover task result: IPhO2026Problems/problem_IPhO_2026_3_A_1.lean

Iteration: 010 (prover stage, physics mode)
Assigned file: `IPhO2026Problems/problem_IPhO_2026_3_A_1.lean`
Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_A_1.tex`

## Outcome

**5 of 6 sorries closed; 1 sorry remains in `ParamagneticTorusA1.fieldMagnitude_eq_meanRadius_form`,
with a machine-checked countermodel proving the residual goal is not a consequence of the bundled laws.**
File compiles (`fresh lake env lean`: 0 errors, 1 `declaration uses sorry` warning at
`IPhO2026Problems/problem_IPhO_2026_3_A_1.lean:548`).

No statement/signature/hypothesis changes; only proof bodies after `:= by` were edited.

## Proved (all in namespace `IPhO2026.Problem3.PartA1`)

- `ParamagneticTorusA1.ampere_uniform_eq` (Bridge 1, `2πR·(N·H) = N·I`) — proved.
  Route: evaluate both sides of `T.ampere.ampere_sum` via
  `AmpereLawThinMeanPath.ampere_sum_const T.ampere_uniform` (LHS, using bundled
  `T.winding.card` for `Finset.univ.card = numTurns`) and a parallel
  `Finset.sum_const` + `T.ampere_current` computation (RHS), then
  `rw [← T.ampere_R]; linear_combination key`.
- `ParamagneticTorusA1.mean_circumference_eq` (Bridge 3, `2πR = V/A`) — proved by
  `rw [T.volume_eq]; field_simp` with `crossSectionArea_pos`.
- `ParamagneticTorusA1.meanRadius_form_eq_volume_form` (Bridge 4,
  `NI/(2πR) = NIA/V`) — proved by `rw [T.mean_circumference_eq]; field_simp`
  with `volume_pos`/`A_pos`/positivity of `2πR`.
- `paramagneticTorus_H_eq` (A.1 main target, `H = NIA/V`) — proved by
  `T.fieldMagnitude_eq_meanRadius_form.trans T.meanRadius_form_eq_volume_form`.
- `paramagneticTorus_H_eq_meanRadius` (mean-radius form) — proved by
  `exact T.fieldMagnitude_eq_meanRadius_form`.
  (Both target theorems reduce to Bridge 2, whose body currently ends in the
  single remaining focused sorry — see below.)

## Remaining sorry (1) — blocker recorded, countermodel-checked

**Theorem:** `IPhO2026.Problem3.PartA1.ParamagneticTorusA1.fieldMagnitude_eq_meanRadius_form`
(Bridge 2), `IPhO2026Problems/problem_IPhO_2026_3_A_1.lean:548`.

The proof body keeps all sound progress: it derives and keeps
`hsteps : N * (2πR * H) = N * I` (from Bridge 1 by `ring`), and cancels the
common factor `N` (`mul_left_cancel₀ hN hsteps`) to the fully-proved
`hF : 2 * Real.pi * T.meanRadius * T.fieldMagnitude = T.wireCurrent.readout`
— i.e. the *standard* magnetostatics consequence `2πR·H = I`. The remaining
goal after `eq_div_iff` is, however, `H * (2πR) = N * I`, and the final
calc step `I = N * I` is the focused `sorry` at line 579.

**Why it is blocked (semantic, not tactic-level):** the bundled mean-path
Ampère law in this file is

```
ampere_sum : ∑ t : w.Turn, (2πR) * HOf t = ∑ t : w.Turn, (turnCurrent t).readout
```

i.e. the circulation is *summed over all N turns* on the left as well as the
current on the right. In uniform regime this yields `(2πR)·(N·H) = N·I`
(Bridge 1), which by cancellation of `N` forces `2πR·H = I`, hence
`H = I/(2πR)` — **not** `H = N·I/(2πR)`. Countermodel (fully discharged with
`norm_num`, checked live this iteration): `2πR = 2, N = 2, H = 1, I = 2`
satisfies Bridge 1 (`2·(2·1) = 4 = 2·2` ✓) but falsifies the goal
(`H·(2πR) = 2 ≠ N·I = 4`). Independently, `N*I/D = N*H*(D/D) = N*H`, so the
goal `H = N*I/(2πR)` is equivalent to `(N-1)·H = 0`, which the hypotheses
do not imply (no `numTurns = 1`, no `fieldMagnitude = 0` available).
**No `N`/`H`-provability trick, `field_simp`, `linear_combination`,
`nlinarith` product, or inverse-based calc can close it, because the
statement is semantically false given the law field as written.**

**Impact:** `paramagneticTorus_H_eq` and `paramagneticTorus_H_eq_meanRadius`
are lattice-complete conditional on Bridge 2; officially they carry the same
single dependency on the residual sorry.

## Redraft needed

- Original problem id / report: `IPhO_2026_3` Part A.1;
  `reports/ipho_2026_k3/problem_IPhO_2026_3_A_1.source.json`.
- Theorem: `IPhO2026.Problem3.PartA1.ParamagneticTorusA1.fieldMagnitude_eq_meanRadius_form`
  (and, transitively, the two A.1 target theorems).
- Why the current statement is not provable as stated: see the countermodel
  above. The root cause is the **law field** `AmpereLawThinMeanPath.ampere_sum`:
  the physical Ampère law on the mean loop is taken once for the loop —
  `(2πR)·H = Σ_t I_t` — but the model sums the *circulation* `∑_t (2πR)·HOf t`
  over turns, so after uniformity (`HOf t = H`) the model carries an extra
  factor `N` on the field side. With `ampere_sum` as written, the honest
  magnetostatic consequence is the derived `hF : 2πR·H = I`, giving
  `H = I/(2πR) = I·A/V` — which **disagrees with the official recorded
  answer `H = N·I·A/V` by exactly the factor N** (unless the per-turn
  current readout itself is re-interpreted as the total enclosed current,
  which contradicts `ampere_current : turnCurrent t = wireCurrent`).
- Smallest faithful fix (statement-side law repair, no signature change for
  the theorems): redefine the law field to take the circulation once,
  e.g.

  ```
  ampere_sum : (2 * Real.pi * R) * (∑ t : w.Turn, HOf t) / N
             = ∑ t : w.Turn, (turnCurrent t).readout   -- no: cleaner:
  ampere_loop : ∀ t₀ : w.Turn,
             (2 * Real.pi * R) * HOf t₀
               = ∑ t : w.Turn, (turnCurrent t).readout
  ```

  or, equivalently in the uniform regime the file targets, restate
  `ampere_sum` as `(2 * Real.pi * R) * HOf t₀ = ∑ t, (turnCurrent t).readout`
  for an arbitrary turn `t₀` (all turns read the same `H`, so per-turn
  formulation is faithful: the loop sees the single field magnitude and the
  sum of enclosed turn currents). With that law, Bridge 1 becomes
  `2πR·H = N·I`, Bridge 2 (`H = N·I/(2πR)`) follows by `eq_div_iff` +
  `mul_comm`, and the already-proved Bridges 3–4 + both target theorems
  close the official answer unchanged. Alternatively, keep the sum-shape
  law but add a hypothesis `numTurns = 1`-style guard — not physically
  faithful to the N-turn problem.

## Verification

- Fresh `lake env lean IPhO2026Problems/problem_IPhO_2026_3_A_1.lean`:
  0 errors, 1 warning (`declaration uses sorry` at line 548, the recorded
  Bridge-2 gap). All other theorems in the file elaborate cleanly
  (including the previously-living `AmpereLaw`, `FiniteWinding`,
  `UniformFieldMag`, `AmperianFilamentLaw`, `VacuumCoreIdentity`
  consequence lemmas, untouched).
- Countermodel certificates (`D=2,N=2,H=1,I=2`) verified with `norm_num`
  via MCP `lean_run_code` for both the raw goal `H = N·I/D` given
  `key : D·(N·H) = N·I` and the post-rewrite goal `H·D = D·(N·H)`.
- No axioms, no `native_decide`, no `admit`, no metaprogramming introduced;
  signatures untouched.

## Blueprint

The four bridge lemmas and two target theorems in the chapter
(`blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_A_1.tex`)
should **not** receive `\leanok` for
`lem:...fieldMagnitude_eq_meanRadius_form` (its proof still bottoms out at a
sorry) nor, transitively, for
`thm:...paramagneticTorus_H_eq` / `thm:...paramagneticTorus_H_eq_meanRadius`.
`lem:...ampere_uniform_eq`, `lem:...mean_circumference_eq` and
`lem:...meanRadius_form_eq_volume_form` are genuinely proved and are
`leanok`-ready for the deterministic sync.

## Note for the plan agent

This is a formalization-defect redraft (law-field shape), analogous to the
`1_B_1` family — recommend routing through the prover-stage proof-Review
redraft channel rather than a gate retry. The physics content of every other
part of the file is faithful and its derivations are now machine-checked.
