# Task Result: IPhO2026Problems/problem_IPhO_2026_3_C_2.lean (autoformalize re-audit, iter-009)

- Mode: physics-formalize (by-sorry autoformalization, planner-frozen re-audit lane; review gate retry 2/3).
- Fresh check: `lake env lean IPhO2026Problems/problem_IPhO_2026_3_C_2.lean` → exit 0, **0 errors**, exactly the 10 contracted sorry warnings
  (L213 `vertex_T_pos`, L227 `heat_isothermal_via_q`, L236 `Qh_eq`, L242 `Qc_eq`, L251 `q_relation`, L265 `q4_eq_adiabatic_41`,
  L273 `q3_eq`, L281 `m1_sq`, L290 `m1_eq_sqrt`, L296 `m1_sq_arg_nonneg`). No other warnings.
- Blueprint chapter `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_2.tex` starts with `% archon:physics` ✔.
- Chapter ↔ Lean coverage: all 25 `\lean{...}` pins in the chapter resolve to existing declarations (name-for-name match verified).
- **No edits to the .lean file this iter** — statements are planner-frozen and the file already compiles clean by-sorry;
  the lane's next consumer is the deterministic review re-pass.

## Assumption/target split

**Governing laws (assumed, conclusion-side-clean):**
- Equation of state of the ideal paramagnet `EquationOfStateParamagnet`: $T\,M\,V = n\,K\,H$ (governing-law `Prop`, instant equation).
- Isothermal heat relation from part B.1 `IsothermalHeatIntoTorus`:
  $Q = -(\mu_0 n K/(2T))(H_f^2 - H_i^2)$ (previous-part result, natural-language prerequisite; signed heat *into* the torus).
- Carnot heat ratio `CarnotHeatRatio`: $Q_h T_c = Q_c T_h$ (reversible cycle / second law; magnitude form, no sign).

**Figure/data readouts:**
- `Figure3bAssignment` (part C.1 conclusion, natural-language prerequisite): vertices 1,4 at $T_h$; 2,3 at $T_c$;
  legs $1{\to}2$ isothermal $H$ decreasing, $2{\to}3$ adiabatic $H$ decreasing, $3{\to}4$ isothermal $H$ increasing,
  $4{\to}1$ adiabatic $H$ increasing (branch/orientation info preserved via `ProcessKind` + `isFieldDecreasing`).
- `TorusParams` ($\mu_0, n, K, V > 0$); `CarnotMagnetizationModel` fields `Th_pos`, `Tc_pos`, `Tc_lt_Th`, `Qh_nonneg`,
  `Qc_nonneg`, `H_nonneg`, `M_nonneg`; equation of state at every vertex (`eos`); B.1 law on the two isothermal legs
  (`heat_34` at $T_h$ with heat $-Q_h$; `heat_12` at $T_c$ with heat $+Q_c$); `carnot_ratio`.

**Current target conclusions (conclusion side only):**
- `m1_sq`: $M_1^2 = M_2^2 - M_3^2 + M_4^2$.
- `m1_eq_sqrt`: $M_1 = \sqrt{M_2^2 - M_3^2 + M_4^2}$ — the recorded official C.2 answer.
- `m1_sq_arg_nonneg`: $0 \le M_2^2 - M_3^2 + M_4^2$ (consistency consequence of the target, phrased as a theorem requiring proof).

## Goal-faithfulness audit

- No hypothesis, structure field, premise, `Valid...`/`Satisfies...` predicate, or local definition mentions the C.2 combination
  $M_2^2 - M_3^2 + M_4^2$ or equates $M_1$ to anything derived from it: verified by inspecting every field of
  `TorusParams`, `CarnotCycle`, `ParamagnetState`, `CarnotMagnetizationModel` and every def-body (`EquationOfStateParamagnet`,
  `IsothermalHeatIntoTorus`, `CarnotHeatRatio`, `Figure3bAssignment`) — none references the target relation.
- The only definitions unfolding to vertex data are naming abbreviations `M1..M4`, `q`, which are projections (`m.cyc.Mmag .v1` etc.) —
  they name state-function readouts, not the answer; `q`'s docstring explicitly disclaims carrying the adiabatic-leg equality.
- The target appears only in the three `theorem` statements `m1_sq`, `m1_eq_sqrt`, `m1_sq_arg_nonneg`, each with a `sorry` body —
  i.e. on the conclusion side, still requiring proof.
- No scalar collapse of physical primitives: temperature/field/magnetization magnitudes are scalar readouts by design
  (permitted for measured scalar components), but the *relations* (EOS, B.1 heat law, Carnot ratio, adiabatic legs) are kept as
  honest `Prop`-valued law statements rather than transparent aliases.

## Derivability and bridge obligations

| # | Source claim | Lean carrier | Evidence / status |
|---|---|---|---|
| 1 | EOS $H = TMV/(nK)$ substituted into the B.1 heat law gives $Q = \tfrac{\mu_0 V}{2}(q_f - q_i)$ on an isothermal leg | `heat_isothermal_via_q` (uses `si/sf : ParamagnetState p`, whose EOS membership field grounds the substitution) | encoded locally, `sorry`; **covered** as a bridge lemma (EOS + B.1 fields are assumption-side) |
| 2 | $Q_h = \tfrac12\mu_0 V(q_4 - q_3)$ on leg $3{\to}4$ | `Qh_eq` from `heat_34` + `heat_isothermal_via_q` + `figure3b` ($T_3=T_4=T_h$) | `sorry`; **covered** |
| 3 | $Q_c = \tfrac12\mu_0 V(q_3 - q_2)$ on leg $1{\to}2$ | `Qc_eq` from `heat_12` + `heat_isothermal_via_q` + `figure3b` | `sorry`; **covered** |
| 4 | Carnot ratio ⇒ $T_c q_1 = (T_c - T_h) q_4 + T_h q_3$ | `q_relation` from `carnot_ratio` + `Qh_eq` + `Qc_eq` (cancel $\mu_0 V/2 > 0$) | `sorry`; **covered** |
| 5 | Adiabatic legs: $q_3 = q_2 = T_c M_2^2$ and $q_4 = T_c M_2^2$ (common adiabat / no heat transfer) | `q3_eq`, `q4_eq_adiabatic_41` | **partially blocked**: the pure-algebra route from `q_relation`+`Qh_eq`+`Qc_eq` gives the combination $q_4 - q_3 = T_h(M_2^2 - M_3^2)$ but not the common-value equation itself; the *physical* content "adiabats 2→3 and 4→1 retrace the same $q$-level" is recorded only in docstrings, and the `ProcessKind.adiabatic` labels carry no constraining equation. Statements are planner-frozen this lane, so this is logged as a redraft candidate for the prover stage (see Abstraction audit + Redraft requests). |
| 6 | Divide by $T_h$ and use $q_1 = T_h M_1^2$, $q_4 = T_h M_4^2$ | `m1_sq` from `q_relation` + bridges 5 | `sorry`; **covered** given bridge 5 |
| 7 | Nonnegative square root ($M_1 \ge 0$ magnitude) | `m1_eq_sqrt` from `m1_sq` + `M_nonneg .v1` (`Real.sqrt`, `Real.sqrt_eq_iff_sq_eq`/`NNReal.sqrt_eq_iff_eq_sq`-family) | `sorry`; **covered**; branch (nonnegative root) preserved via `M_nonneg` hypothesis, not selected only in the conclusion |
| 8 | Radicand nonnegativity | `m1_sq_arg_nonneg` from `m1_sq` + sq-nonneg | `sorry`; **covered** |

A compiling statement is present for every bridge; bridge 5 is the single blocked *derivability* gap (assertion-level, not statement-level).

## Abstraction sufficiency and countermodel audit

Local `Prop`-valued interfaces and their constraining content:
- `EquationOfStateParamagnet` — instant equation $T M V = n K H$; usable by `field_simp`/`ring` rewriting. Constraining ✔.
- `IsothermalHeatIntoTorus` — instant equation for $Q$ in terms of $(T, H_i, H_f)$. Constraining ✔.
- `CarnotHeatRatio` — instant equation $Q_h T_c = Q_c T_h$. Constraining ✔.
- `Figure3bAssignment` — 8-way conjunction of vertex-temperature and process-label equalities. Constraining for temperatures ✔;
  **process labels (`proc12..proc41`) are purely descriptive** — no elimination theorem ties `.adiabatic` to "$q$ conserved along the leg".
  Countermodel exposure: interpret `Mmag v2, Mmag v3` arbitrarily subject to EOS; all assumptions (they constrain only `Hmag` values
  and $Q_h, Q_c$ combinations via bridges 2–4) stay true while `q3_eq` fails. The main theorems `m1_sq`/`m1_eq_sqrt` are still
  protected conclusion-side (their proofs would need the missing adiabatic law), but the per-item countermodel rule flags
  `q3_eq`/`q4_eq_adiabatic_41` as underdetermined relative to the stated hypotheses. → redraft candidate below (statements frozen this lane).
- `ParamagnetState` — structure with $T>0$, $H\ge0$, $M\ge0$, EOS field; used only by `heat_isothermal_via_q`. Constraining ✔.
- `ProcessKind`/`Vertex`/`CarnotCycle` — honest enumerations/state bundle; branch (increasing/decreasing field) preserved by
  `isFieldDecreasing : Bool` per the branch-preservation rule ✔.

## Uncertainty and branch coverage

- Uncertainty: **not applicable** — the source states no `value ± uncertainty` data for C.2; the answer is an exact closed form.
- Branch/orientation: **covered** statement-side — (i) heat signs carried by the signed `Q` argument of `IsothermalHeatIntoTorus`
  plus `heat_34 : ... (-Qh)` / `heat_12 : ... Qc` (heat out vs. in); (ii) field direction per leg via `ProcessKind.isFieldDecreasing`;
  (iii) nonnegative-root branch via `M_nonneg`. The adiabatic-branch *law* gap is bridge 5 above.

## Declarations created / blueprint labels

All in `IPhO2026.Problem3.C2` (unchanged this iter; chapter pins 25/25 live):
- `ProcessKind`, `Vertex`, `CarnotCycle`, `TorusParams`, `EquationOfStateParamagnet`, `ParamagnetState`,
  `IsothermalHeatIntoTorus`, `CarnotHeatRatio`, `Figure3bAssignment`, `CarnotMagnetizationModel` — labels
  `def:..._3_C_2:<Name>` (assumption-side carriers).
- `CarnotMagnetizationModel.{M1,M2,M3,M4,q}` — naming/readout abbreviations (label `def:...` family).
- Lemmas `vertex_T_pos`, `heat_isothermal_via_q`, `Qh_eq`, `Qc_eq`, `q_relation`, `q4_eq_adiabatic_41`, `q3_eq` — labels
  `lem:..._3_C_2:<name>`.
- Theorems `m1_sq`, `m1_eq_sqrt`, `m1_sq_arg_nonneg`; umbrella `thm:physics:IPhO_2026_3_C_2:target`
  (`\uses` the model def + `m1_eq_sqrt`) is the direct source-to-contract carrier.
- `\leanok` markers: **not applied** (0 present; all 10 proofs remain `sorry`, so the deterministic `sync_leanok` phase owns
  any future marking — recorded here per the read-only-markers rule).

## LeanExplore queries / grounding (this iter)

- `Real.sqrt_eq_iff_sq_eq square root of nonnegative real equality (Mathlib, Physlib)` → `NNReal.sqrt_eq_iff_eq_sq`,
  `NNReal.sq_sqrt`, `NNReal.sqrt_sq`, `NNReal.sqrt_mul_self` (candidates for the prover-phase discharge of `m1_eq_sqrt`; the
  statement needs only `Real.sqrt`, already used).
- `Carnot cycle heat ratio Qh Tc Qc Th reversible thermodynamics (Mathlib, Physlib)` → near misses only
  (`CanonicalEnsemble.heatCapacity`, `TemperatureUnit.*`); **no PhysLean Carnot-cycle-on-(M,H,T) API** — matches the chapter's
  iter-002 import-policy exemption NOTE (Mathlib-baseline justification renewed).
- Grounded names actually used in the file: `Real.sqrt` (Mathlib) plus real-algebra baseline; all physical relations are the
  local abstractions above (also enumerated in the preserved register `physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_C_2.md`).

## Local abstractions (why they preserve physical meaning)

- `TorusParams`: keeps $\mu_0, n, K, V$ distinct with positivity certificates rather than folding into one constant — needed by
  the B.1 law's prefactor $\mu_0 n K/(2T)$.
- `CarnotCycle`/`ProcessKind`/`Vertex`: keeps the Figure-3b geometry and per-leg orientation instead of a bare tuple of scalars.
- `IsothermalHeatIntoTorus`, `CarnotHeatRatio`, `EquationOfStateParamagnet`: law-shaped `Prop`s carrying the actual equations,
  not conclusion-shaped formulas.

## Grounding gaps / redraft requests

- **Redraft candidate (prover stage; statements frozen here)** bridge 5: add a constraining adiabatic-leg law so
  `q3_eq`/`q4_eq_adiabatic_41` derive instead of being magnetization assertions — e.g. a field
  `adiabatic_leg_q_const : ∀ v_i v_f, [leg adiabatic] → cyc.T v_i * cyc.Mmag v_i ^ 2 = cyc.T v_f * cyc.Mmag v_f ^ 2`
  (the physical law "no heat ⇒ $T M^2$ conserved along the leg", per the Pm-T adiabatic invariant of the model), or fold it into
  `Figure3bAssignment`/`CarnotMagnetizationModel`; then `q3_eq` becomes `adiabatic` on $2{\to}3` and `q4_eq_adiabatic_41` on
  $4{\to}1$ chained with $q_3 = q_2$. Flagged for the review agent / prover-stage planner.
- No LeanExplore unresolved gaps beyond the PhysLean thermodynamics absence already exempted.
