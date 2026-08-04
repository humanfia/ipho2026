# Task result: IPhO2026Problems/problem_IPhO_2026_3_C_3.lean (iter-009)

Lane: review-gate retry 2/3, **recorded-stale** — statements planner-frozen
(PROGRESS.md + iter/iter-009/objectives.md "Not dispatched this iter"). This
register audits the landed formalization; the deterministic review re-pass is
the next consumer.

## Compile status

- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_C_3.lean` (fresh, iter-009):
  exit 0, no diagnostics. 658 lines, **0 `sorry` / 0 `admit` / 0 axioms added**.
- Chapter `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_3.tex`
  contains `% archon:physics` -> physics-formalize discipline confirmed.
- Chapter ledger: 29 declaration environments, all pinned with matching
  `\lean{IPhO2026.Problem3.C3.*}` names verified first-hand against the file; 0
  `\leanok` present. **Review-agent flag: every environment in the ledger is
  ready for `\leanok`** (the file is sorry-free and compiling; marker owned by
  deterministic sync — not added by hand per AGENTS.md).

## Assumption/target split

**Governing laws (hypothesis-side `def ... : Prop` carriers)**
- `EquationOfStateParamagnet` L151 — Curie EOS `T*M*V = n*K*H` (law, not target).
- `IsothermalHeatIntoTorus` L167 — B.1 previous-part heat law
  `Q = -(μ₀*n*K/T)*(Hf²-Hi²)/2` (signed; direction carried by sign).
- `CarnotHeatRatio` L174 — `Qh*Tc = Qc*Th` for the reversible cycle.
- `ConstantCapacityCalorimetry` L199 — `Q = m*c*ΔT`, constant-c regime.

**Previous-part results (assumed, natural-language prerequisites)**
- `TorusVolumeFromSource` L192 — B-part `V = n*M_mol/ρ_source` (field
  `p_volume`; volume cancels out of every C.3 heat, so no target value is
  available from it).
- `Figure3bAssignment` L184 — C.1/C.2 figure reading: `T(v1)=T(v4)=Th`,
  `T(v2)=T(v3)=Tc`, legs 12/34 adiabatic, 23/41 isothermal with field
  direction recorded (`isothermal true` = decreasing on 2→3). Field `figure3b`.

**Figure/data readouts (statement literals + positivity certificates)**
- `suppliedData` L251 (transparent `noncomputable`, per ARCHON_MEMORY),
  6 projections + 6 `_pos` + 6 `_value` rfl lemmas L256–L291;
  `heliumBathVolume = 1.00e-3` L296; `vacuumPermeability = 4π·10⁻⁷` L301;
  `potassiumChromateTorus` + 3 projections L315–L330;
  run fields `initial_is_Tc` (`TInitial = Tc ∧ TInitial = 1.00`), `bath_mass`
  (`m = ρ_He*V_He`), `vertex_fields` (H₁=411624, H₂=311306, H₃=204618,
  H₄=240446 A/m) in `PotassiumChromateCoolingRun` L341–L423.

**Current target conclusions (conclusion side ONLY)**
- `absorbed_heat_value` L585: `|Qc - 1.29e-1| < 5.0e-4`.
- `temperature_drop_value` L609: `|(TInitial - TFinal) - 9.92e-3| < 5.0e-5`.
- `final_temperature_value` L635: `|TFinal - 0.99008| < 5.0e-5`.

## Goal-faithfulness audit

- No field of `PotassiumChromateCoolingRun` mentions 1.29e-1, 9.92e-3, 0.99008
  or any band around them; verified by reading L341–L423. The docstring at
  L336–L340 states this invariant explicitly.
- `heat_23`/`heat_41` assume only the *signed* B.1 law applied to the figure
  legs (+Qc into torus on the field-decreasing leg, −Qh on the increasing one)
  — a governing-law instance, not the C.3 magnitudes.
- `helium_calorimetry` assumes `Qc = m*c*(TInitial - TFinal)` — the calorimetry
  law; `TFinal` is a free field, so the target value is not pinned by any
  hypothesis. Countermodel check: all assumptions hold with e.g. `TFinal =
  TInitial + Qc/(m*c)`? No — that violates `Qc = m*c*(TInitial - TFinal)` only
  if `Qc ≠ 0`, which `Qc_pos` excludes; but `TFinal` can still be any value `<
  TInitial` consistent with the equation, i.e. the targets remain substantive.
- Target numeric bands are officially-rounded answer windows, conclusion-side
  only; they were never used in any premise or `Laws`/`Valid...`/`Satisfies...`
  field (none exist in this file).
- `rfl`-proved lemmas are restricted to naming/projection certificates
  (`pmtAmount_value`, `potassiumChromateTorus_n/K/V`, `torus_volume_value` via
  definitional field unfolding) — none closes a substantive C.3 target.

## Derivability and bridge obligations

| # | Source claim | Lean carrier | Evidence | status |
|---|---|---|---|---|
| 1 | B.1 law on cold leg gives `Qc = (μ₀nK/Tc)(H₂²−H₃²)/2` | `Qc_cold_leg` L447 (closed proof, `ring` after field `heat_23`) | file L447–L457; fresh compile 0 errors | covered |
| 2 | B.1 law on hot leg gives `Qh = (μ₀nK/Th)(H₁²−H₄²)/2` | `Qh_hot_leg` L462 (field `heat_41`) | file L462–L478 | covered |
| 3 | Carnot ratio + leg identities fix `Tc/Th = (H₂²−H₃²)T₁/((H₁²−H₄²)Tc)` | `reservoir_temperature_consistency` L481 (fields `carnot_ratio`, `figure3b`, positivity neq-guards) | file L481–L540; `field_simp`+`mul_eq_zero` elimination | covered |
| 4 | Calorimetry gives `TFinal = TInitial − Qc/(m·c)` | `TFinal_from_calorimetry` L545 (field `helium_calorimetry`, **`neq-guard** `mul_ne_zero` on `m,c`) | file L545–L556 | covered |
| 5 | Cooling branch `TFinal < TInitial` | `helium_cools` L558 (`Qc_pos`, `div_pos`) | file L558–L564 | covered |
| 6 | Supplied-data readouts are literal statement values | 6 `_value` rfl lemmas + `potassiumChromateTorus_*` projections + `torus_volume_value` L432 | file L260–L330, L432–L444 | covered |
| 7 | Numeric evaluation inside official bands: `μ₀ = 4π·10⁻⁷`, `nK`, `H₂²−H₃²`, `m·c = 130·1e-3·100 = 13` J/K | the three target theorems L585/L609/L635 via `Real.pi_gt_d4`, `Real.pi_lt_d4`, `Real.pi_pos` + `norm_num`/`nlinarith` interval arithmetic | fresh compile exit 0; no sorry | covered |

No nontrivial bridge is blocked; every substantive target records bridge 7
against carriers 1, 4, 5.

## Abstraction sufficiency and countermodel audit

Local `Prop`-valued interfaces (no Mathlib/PhysLean counterpart exists — see
grounding log `task_results/physics-grounding-…3_C_3.md` and the chapter
exemption NOTE):
- `EquationOfStateParamagnet` — exposes the equation itself; consumed
  pointwise by field `eos`. Constraining: fixes M given (T,H).
- `IsothermalHeatIntoTorus` — equational; elimination via `ring` in bridges
  1–2. Constraining: pins Q up to the stated formula.
- `CarnotHeatRatio` — equational; eliminated in bridge 3 through `field_simp`
  plus `mul_eq_zero` case split, all neq-guards (`Tc_pos`, `Th_pos`, `Qc_pos`,
  `μ₀_pos`,`n_pos`,`K_pos`) present as structure fields (readout neq-guard rule
  from ARCHON_MEMORY honored — degenerate countermodels structurally excluded,
  e.g. `hd23`/`hdA` proofs L497–L537).
- `Figure3bAssignment` — conjunction of 4 temperature assignments + 4 leg-kind
  assignments with field-direction booleans; used in bridge 3 (`figure3b.1`).
- `TorusVolumeFromSource`, `ConstantCapacityCalorimetry` — equational; both
  eliminated in bridges 6 and 4.
- No opaque witness-only relation exists in the file.

## Uncertainty and branch coverage

- Uncertainty: **covered** as officially-rounded answer bands on the
  conclusion side (`5.0e-4`, `5.0e-5` windows around the marked answers); the
  source carries no `±` measured uncertainties, so propagation is not
  applicable beyond the rounding windows.
- Branch/orientation: **covered** — refrigeration orientation `Tc_lt_Th`,
  heat-sign conventions in `heat_23`/`heat_41`, leg field directions in
  `ProcessKind` constructors (L102) recorded in `figure3b`, and the explicit
  cooling-branch certificate `helium_cools` + drop form `(TInitial - TFinal)`
  in the targets.

## Declarations created (all blueprint labels pinned in the chapter ledger)

- `ProcessKind`, `Vertex`, `CarnotCycle`, `TorusParams`,
  `EquationOfStateParamagnet`, `IsothermalHeatIntoTorus`, `CarnotHeatRatio`,
  `Figure3bAssignment`, `TorusVolumeFromSource`, `ConstantCapacityCalorimetry`
- `SuppliedMaterialData`, `suppliedData`, 6 projections + 6 `_pos` + 6 `_value`
  lemmas, `heliumBathVolume`, `vacuumPermeability`, `vacuumPermeability_pos`,
  `potassiumChromateTorus` + 3 projection lemmas
- `PotassiumChromateCoolingRun` (structure) with `torus_volume_value`,
  `Qc_cold_leg`, `Qh_hot_leg`, `reservoir_temperature_consistency`,
  `TFinal_from_calorimetry`, `helium_cools`
- Targets: `absorbed_heat_value`, `temperature_drop_value`,
  `final_temperature_value` (blueprint labels
  `thm:IPhO2026Problems_problem_IPhO_2026_3_C_3:{absorbed_heat_value,
  temperature_drop_value, final_temperature_value}`)

## LeanExplore queries/candidates actually used

From the preserved register `physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_C_3.md`
(local backend, packages Mathlib + Physlib): queries `Real.sqrt square root`,
`Carnot heat ratio`, `Isothermal heat relation (part B.1)`,
`Ideal-paramagnet equation of state`, etc. — all near misses (generic
`MagneticField`/ideal-gas adiabatic hits); grounded Mathlib names actually
consumed: `Real.pi`, `Real.pi_pos`, `Real.pi_gt_d4`, `Real.pi_lt_d4`,
`abs_lt`, `mul_ne_zero`, `div_eq_div_iff`, `mul_div_cancel_left₀`, `div_pos`,
`mul_pos`, `ne_of_gt`, `mul_eq_zero`.

## Grounding gaps / redraft requests

- PhysLean gap (chapter exemption NOTE, planner-recorded iter-003): no
  classical-paramagnet thermodynamic-cycle module (Curie EOS, adiabatic
  demagnetization calorimetry); model stays local over `import Mathlib`.
  Nothing blocked.
- No redraft requested. The lane is faithful, compiling, and sorry-free; the
  deterministic review re-pass (retry 2/3, recorded-stale) is its next
  consumer, and the sync should mark the 29 ledger environments `\leanok`.
