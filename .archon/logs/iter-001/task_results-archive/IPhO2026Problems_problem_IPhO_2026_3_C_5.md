# Task Result — IPhO2026Problems/problem_IPhO_2026_3_C_5.lean

- Stage: autoformalize (physics-formalize), Archon iteration 001.
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_5.tex`
  (confirmed `% archon:physics`).
- Source report: `reports/ipho_2026_k3/problem_IPhO_2026_3_C_5.source.json`.
- Official page image `T3_page-4.png` read: T3-C5 asks for the **overall
  COP = Q_c/W** of the T3-C4 refrigerator over all cycles until time `t`,
  answer in terms of `T_0`, `T_h`, `T`; T3-C4 gives `dQ_c/dQ_h = T_c/T_h`,
  `T_c = T_0` at `t = 0`, constant `P`, constant `T_h`, body heat capacity
  `C_c`; T3-C3 supplies the Carnot-cycle figure data `H1..H4`, the equation
  of state `T·M·V = n·K·H`, and potassium-chromate material constant K.
- Build: `lake env lean IPhO2026Problems/problem_IPhO_2026_3_C_5.lean`
  compiles with exactly the two expected `declaration uses sorry` warnings
  (lines 184, 198) and no errors.

## Assumption/target split

- Governing laws (encoded as `Prop`s `ConstantPowerWork`,
  `CooledBodyHeatBalance`, `AccumulatedCarnotHeatRelation`,
  `RefrigeratorEnergyBalance`, `ParamagneticEquationOfState`):
  - `W = P t` (constant input power, C.4 premise);
  - `Q_c = C_c (T_0 - T)` (constant-heat-capacity body);
  - accumulated Carnot quota `dQ_c/dQ_h = T_c/T_h` integrated over the
    cooling history: `Q_h = Q_c · T_h · ln(T_0/T) / (T_0 - T)`;
  - first law for the refrigerator: `Q_h = Q_c + W`;
  - paramagnetic equation of state `T·M·V = n·K·H` (context).
- Previous-part results:
  - C.4 elapsed time `t = (C_c T_h / P)(ln(T_0/T) − (T_0 − T)/T_h)`,
    policy `natural_language_prerequisite_only` → re-encoded locally as
    `C4ElapsedTimeLaw`; no import of other Lean files.
  - Per-cycle relation `dQ_c/dQ_h = T_c/T_h` (premise of C.4, quoted on the
    official page) → `AccumulatedCarnotHeatRelation`.
- Figure/data readouts: cycle 1→2→3→4→1 in the H–T plane (Figure 3b) with
  corner fields `H1..H4` (`CycleFields`); material constant `K`;
  torus volume `V`, amount `n`, working mass (`workingMass`); regime
  `0 < T < T_0 < T_h`, `C_c, P, t > 0` (`RegimeAssumptions`).
- Current target conclusions (theorem/lemma conclusions only):
  - `overall_coefficient_of_performance`:
    `COP = [(T_h/(T_0 − T))·ln(T_0/T) − 1]⁻¹` with the full C.5 hypothesis
    bundle (`OperatingHistory`, including the C.4 time law);
  - `coefficient_of_performance_via_energy_balance`: the same equation via
    the direct energy-balance route (no explicit time law).

## Goal-faithfulness audit

- The target equation `COP = [(T_h/(T_0 − T)) ln(T_0/T) − 1]⁻¹` appears only
  as a theorem conclusion. `coefficientOfPerformance` is defined as the raw
  ratio `Q_c / W` — that *is* the problem-given definition of COP
  ("COP = Q_c/W"), not the answer; its value is never fixed.
- `totalHeatCold`, `totalWork`, `tempFinal`, `tempHot`, `tempInitial`, etc.
  are `opaque` parameters — no defeq path to the answer exists, so the
  sorry-free core cannot be closed by `rfl`/unfolding.
- `AccumulatedCarnotHeatRelation` constrains `Q_h` from `Q_c` and the
  temperature data but says nothing about `W` or COP; combined with
  `RefrigeratorEnergyBalance` it determines `W = Q_h − Q_c`, which is exactly
  the physics derivation, not a definitional shortcut.
- The C.4 time law is only a hypothesis of the main theorem; the statement
  remains non-vacuous because `C_c, P` are free opaque parameters.

## Derivability and bridge obligations

| # | Source claim | Lean carrier | Status |
|---|--------------|--------------|--------|
| 1 | COP ≡ Q_c/W (given in question) | `coefficientOfPerformance` (def) | covered |
| 2 | `Q_c = C_c (T_0 − T)` (calorimetry at constant C_c) | `CooledBodyHeatBalance` | covered |
| 3 | per-cycle Carnot relation `dQ_c/dQ_h = T_c/T_h` integrated to `Q_h = Q_c T_h ln(T_0/T)/(T_0 − T)` | `AccumulatedCarnotHeatRelation` (integrated form assumed directly; the integration step is a proof obligation for the physics stage, not an assumption of the answer) | covered (integrated form assumed) |
| 4 | first law `Q_h = Q_c + W` | `RefrigeratorEnergyBalance` | covered |
| 5 | `W = P t` | `ConstantPowerWork` | covered |
| 6 | C.4 time `t = (C_c T_h/P)(ln(T_0/T) − (T_0 − T)/T_h)` | `C4ElapsedTimeLaw` | covered |
| 7 | algebra: bridges 2–4 ⇒ `W = Q_c[(T_h/(T_0−T)) ln(T_0/T) − 1]` ⇒ target | conclusion of `coefficient_of_performance_via_energy_balance` (`sorry`) | blocked (proof stage) |
| 8 | full contract incl. C.4 elapsed time | conclusion of `overall_coefficient_of_performance` (`sorry`) | blocked (proof stage) |
| 9 | equation of state `T·M·V = n·K·H` | `ParamagneticEquationOfState` (context only; not needed for C.5 algebra) | covered as context |

## Abstraction sufficiency and countermodel audit

- `ConstantPowerWork`, `CooledBodyHeatBalance`,
  `AccumulatedCarnotHeatRelation`, `RefrigeratorEnergyBalance`,
  `C4ElapsedTimeLaw`, `ParamagneticEquationOfState` are all equational
  predicates — each supplies a genuine equation usable by `rw`/`field_simp`
  in later proofs; none is a bare inhabited/witness assertion.
- `RegimeAssumptions` supplies the side conditions (`T₀ ≠ T`, `T₀/T > 0`,
  nonzero denominators) that make `Real.log`/division in the contracts
  meaningful and the algebra closable.
- Countermodel check: interpreting `totalHeatCold`, `totalWork`, `Qh`
  arbitrarily while satisfying the law predicates forces
  `COP = 1/((T_h/(T_0−T)) ln(T_0/T) − 1)` only if that real number equals
  `Q_c/W`; models where it is negative or zero violate the regime/law
  hypotheses (they constrain the sign through `Qc, Th, ln(T0/T) > 0`), so
  the contract is determined by the hypotheses, not by the conclusion.
- No PhysLean/Mathlib scalar type was aliased for a physical quantity; only
  genuinely scalar SI readouts (temperatures, heats, work, time, heat
  capacity, power, field values) are `ℝ`, each behind an `opaque` constant.

## Uncertainty and branch coverage

- Uncertainty: not applicable — the source states no `value ± uncertainty`
  for this subquestion (official answer is a closed-form expression).
- Branch/orientation: refrigeration direction (heat extracted from the cold
  body, dumped to the hot reservoir) is recorded by the signed-positivity
  content of `RegimeAssumptions` plus the role split `Q_c` vs `Q_h`; the
  decreasing-temperature branch `T < T₀` is explicit
  (`final_lt_initial`). Covered.
- Cycle-orientation data of Figure 3b (fields `H1..H4`) recorded in
  `CycleFields` for completeness; it is context, not needed by the C.5
  algebra.

## Declarations created → blueprint labels

- `coefficientOfPerformance`, `ConstantPowerWork`, `CooledBodyHeatBalance`,
  `AccumulatedCarnotHeatRelation`, `RefrigeratorEnergyBalance`,
  `C4ElapsedTimeLaw`, `ParamagneticEquationOfState`, `CycleFields`,
  `RegimeAssumptions`, `OperatingHistory`,
  `overall_coefficient_of_performance`,
  `coefficient_of_performance_via_energy_balance`
  → all under `thm:physics:IPhO_2026_3_C_5:target`.
- Ready for `\leanok` on `thm:physics:IPhO_2026_3_C_5:target` — flagged for
  the review agent (prover may not edit blueprint chapters).

## LeanExplore

- Query `Carnot cycle thermodynamics efficiency heat engine`
  (packages Mathlib, Physlib): only irrelevant hits (`Cycle.reverse`,
  `CanonicalEnsemble.heatCapacity`, `Constants.kB`, `stereographic_target`,
  `Path.target`, `semiformal_result`). None applicable to macroscopic
  Carnot-cycle COP bookkeeping; local faithful abstractions used instead.
- Grounded library names actually used: `Real.log` (Mathlib); division /
  inverse `⁻¹` on `ℝ` (Mathlib).

## Grounding gaps

- PhysLean currently exposes no macroscopic heat-engine/Carnot-cycle or
  coefficient-of-performance API; recorded as a gap. The local
  law-abstractions above preserve the physical meaning in the interim.

## Notes / redraft requests

- `AccumulatedCarnotHeatRelation` assumes the *integrated* heat relation.
  If the physics stage wants the differential relation
  `dQ_c/dQ_h = T_c/T_h` as the primitive, a redraft with an explicit
  `T_c(t)` trajectory and derivatives is possible; for C.5 (which only needs
  totals) the integrated form is the faithful minimal contract.
- The file does not import any other problem file, honoring
  `previous-part-policy: natural_language_prerequisite_only`.
