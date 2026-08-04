# Task Result: `IPhO2026Problems/problem_IPhO_2026_4_C_7.lean` (autoformalize, iter-012)

- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_C_7.tex` (`% archon:physics` confirmed).
- Verification this session: fresh `lake env lean IPhO2026Problems/problem_IPhO_2026_4_C_7.lean` → **0 errors**, only the 2 expected `sorry` warnings at lines 179 and 203.
- File state: the iter-012 mandatory redraft (lane `4-c-7-contract-repair`) is on disk and **matches the restated blueprint chapter 1:1**; no Lean changes were needed in this lane. Work this iteration = re-read, re-verify, audit.

## Assumption/target split

**Governing laws (assumption-side):**
- Eq. (4) lumped heat-flow model `dQ/dt = (T_OC − T_IC)/R_Th` → `LumpedHeatFlowLaw` (`IPhO2026Problems/problem_IPhO_2026_4_C_7.lean:111`), a `Prop` asserting proportionality of an existing current `P`, not a definition of `P` or `R_Th`.
- Eq. (6) radial Fourier conduction `dQ/dt = −λ·A·dT/dr` with steady-state constancy of the wall current → `RadialFourierConduction` with fields `steady` (constancy of `P` on `[r₁,r₂]`) and `fourier` (pointwise law with `A(r) = 2πrh`) (`IPhO2026Problems/problem_IPhO_2026_4_C_7.lean:122`).

**Previous-part results (assumption-side):**
- C.6 effective wall thermal resistance `R_Th` ($5.17 ± 0.03 K/W$ sample) carried abstractly as the `R_Th : ℝ` field of `ThermalExperimentData` (policy `natural_language_prerequisite_only`; no Lean import of C.6 output).

**Figure/data readouts (assumption-side):**
- Figure 17 geometry: IC bore diameter 33.7 mm, wall thickness 6.4 mm → `r₁ = 16.85 mm`, `r₂ = 23.25 mm`; wetted height = IC water level (Procedure step 3). Captured by `CylindricalWallGeometry` with positivity guards `r₁_pos`, `r₁_lt_r₂`, `h_pos`, and projection `lateralArea G r = 2π·r·G.h`.
- Physical drive (E1 Procedure step 2: OC heated, IC cold receiving body): hypothesis `hΔT : D.T_OC < D.T_IC` in `acrylicConductivity_formula`.
- Positivity side conditions `hR : 0 < D.R_Th`, `hlam : 0 < lam`.
- Boundary temperatures `T(r₁) = T_IC`, `T(r₂) = T_OC`.

**Current target conclusions (conclusion-side only):**
- `acrylicConductivity_formula` conclusion: `lam = Real.log (G.r₂ / G.r₁) / (2 * π * G.h * D.R_Th)` (sorry at line 179).
- `acrylicConductivity_officialSample` conclusion: `|lam − 0.25| ≤ 0.01` (sorry at line 203); the official `0.25 ± 0.01` band appears **only** there.

## Goal-faithfulness audit

- Neither target conclusion appears as a hypothesis, structure field, premise, or local definition. `acrylicConductivity_formula` takes `lam` as an abstract real plus laws/geometry and concludes the formula; `acrylicConductivity_officialSample` takes the formula as hypothesis `hformula` (a previous-result contract, exactly what `acrylicConductivity_formula` proves — a legitimate previous-part carrier, not the current band conclusion) and concludes `|lam − 0.25| ≤ 0.01`.
- `LumpedHeatFlowLaw`/`RadialFourierConduction` state the physical laws (4)/(6) directly; neither unfolds to `λ = ln(r₂/r₁)/(2πhR_Th)` or to either conclusion. The C.7 formula is not the definition of `lam` anywhere.
- The `± 0.01` band is conclusion-side only (explicitly recorded in the chapter's coverage section).
- No `rfl`-closing of substantive answers: both value theorems are `by sorry`; only helper elimination `wall_current` is proved (from the `steady` field — a naming/elimination expansion, not a target answer).

## Derivability and bridge obligations

| # | Source claim | Lean carrier | Evidence | Status |
|---|---|---|---|---|
| 1 | Constancy of wall current from steady state | `RadialFourierConduction.wall_current` (proved, line 146) | proved `hF.steady r hr r' hr'` | covered (grounded) |
| 2 | `P < 0` from Eq. (4) under `T_OC < T_IC`, `R_Th > 0` | hypothesis pair `hflow`, `hΔT`, `hR` of `acrylicConductivity_formula` | `div_neg_of_neg_of_pos` route (Mathlib `div_neg`) | covered (encoded in hypotheses) |
| 3 | `dT/dr > 0` from Fourier's law under `lam > 0`, `P < 0` | `hfourier.fourier` pointwise equation | algebra from field equation; `G.lateralArea r > 0` on `[r₁,r₂]` from geometry guards | covered (encoded) |
| 4 | Integration `∫ r⁻¹ dr = ln(r₂/r₁)` over `[r₁,r₂]` | sorry body of `acrylicConductivity_formula` | Mathlib `intervalIntegral.integral_inv` / `integral_one_div`, `intervalIntegral.integral_const_mul`, `Real.log_div` (needs `0 < r₁ < r₂`, present via `G.r₁_pos`, `G.r₁_lt_r₂`) | covered as contract; proof body sorried by design (autoformalize stage) |
| 5 | Cancel nonzero `T_OC − T_IC` to get formula | sorry body of `acrylicConductivity_formula` | `sub_ne_zero.mpr (ne_of_lt hΔT)`, field_simp/ring | covered as contract; sorried |
| 6 | `0.2629 ≤ h·R_Th → |λ − 0.25| ≤ 0.01` by rational-interval arithmetic | sorry body of `acrylicConductivity_officialSample` | chapter-certified brackets `0.3219 < ln(465/337) < 0.3220`, `6.2831 < 2π < 6.2832`; `λ` strictly decreasing in positive `h·R_Th`; `λ ≤ 0.3220/(6.2831·0.2629) < 0.195 < 0.26` and `λ > 0` | covered as contract; sorried |

No bridge is blocked: the file compiles and every substantive target has a named carrier.

## Abstraction sufficiency and countermodel audit

- `RadialFourierConduction` (structure of two `Prop` fields): constraining via `steady` (an actual pairwise equation `P r = P r'` on the interval, eliminated by proved `wall_current`) and `fourier` (a pointwise equation tying `P r`, `lam`, `G.lateralArea r`, and `deriv T r`). A trivial/junk witness would have to satisfy both equations simultaneously with the boundary data — the iter-012 sign repair was precisely the removal of the Review's constructive countermodel (`lam = −1`, `T(r) = (2π)⁻¹ ln r`, `P ≡ 1`), which is now excluded by `hlam : 0 < lam` + `hΔT : T_OC < T_IC`. Under the current hypotheses all fields pin the model: `P < 0` (bridge 2), `deriv T > 0` (bridge 3), and the integrated identity (bridge 4) forces the conclusion — no countermodel remains.
- `LumpedHeatFlowLaw`: single equation `P = (T_OC − T_IC)/R_Th`; usable directly by rewriting; not satisfiable vacuously since `P`, `T_OC`, `T_IC`, `R_Th` are externally given.
- `CylindricalWallGeometry`: guards `r₁_pos`, `r₁_lt_r₂`, `h_pos` exclude degenerate radii/height (memory rule "readout structs need neq-guards"); `lateralArea` is a genuine positive area on the wall interval.
- `ThermalExperimentData`: pure readout record; carries no law and no target content.

## Uncertainty and branch coverage

- **Uncertainty**: `covered` where applicable. The source's `R_Th = 1.17 ± 0.03 K/W` interval content is preserved abstractly (only the interval was ever used, per the file docstring); the official `λ = 0.25 ± 0.01` band is conclusion-side in `acrylicConductivity_officialSample`. The frozen-C.6-input countermodel (0.10 × 1.17 gives `|λ−0.25| ≈ 0.188 > 0.01`) forced the sound-direction realizability contract `0.2629 ≤ h·R_Th → |λ−0.25| ≤ 0.01`; provenance of which recorded inputs the official 0.25 used is escalated to the user noticeboard (`raw/E1_solution.pdf` absent in checkout — see chapter `% NOTE`/R4 paragraph and PROGRESS.md).
- **Branch/orientation**: `covered`. The signed drive direction (OC hot → wait, OC is heated, IC cold receiving body: heat flows OC → IC) is hypothesis-side as `hΔT : D.T_OC < D.T_IC`, and sign obligations `0 < R_Th`, `0 < lam` are hypothesis-side per the iter-012 R4 sign repair — not selected only in the conclusion.

## Declarations created (and blueprint labels)

| Lean declaration | Blueprint label | Body |
|---|---|---|
| `IPhO2026.Problem4.C7.ThermalExperimentData` | `def:...:ThermalExperimentData` | structure (grounded) |
| `IPhO2026.Problem4.C7.CylindricalWallGeometry` (+ guards) | `def:...:CylindricalWallGeometry` | structure (grounded) |
| `IPhO2026.Problem4.C7.CylindricalWallGeometry.lateralArea` | folded into parent `\lean{}` line | `noncomputable def` (grounded) |
| `IPhO2026.Problem4.C7.LumpedHeatFlowLaw` | `def:...:LumpedHeatFlowLaw` | `def ... : Prop` (grounded) |
| `IPhO2026.Problem4.C7.RadialFourierConduction` | `def:...:RadialFourierConduction` | structure of `Prop` fields (grounded) |
| `IPhO2026.Problem4.C7.RadialFourierConduction.wall_current` | `lem:...:RadialFourierConduction.wall_current` | **proved** (no sorry) |
| `IPhO2026.Problem4.C7.acrylicConductivity_formula` | `thm:...:acrylicConductivity_formula` | `by sorry` (line 179, expected) |
| `IPhO2026.Problem4.C7.acrylicConductivity_officialSample` | `thm:...:acrylicConductivity_officialSample` | `by sorry` (line 203, expected) |

## LeanExplore queries/candidates actually used

Per the iter grounding preflight (`task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_C_7.md`): queries `Thermal Experiment Data`, `Cylindrical Wall Geometry`, `Lumped heat-flow law, Eq. (4)`, `Radial Fourier conduction, Eq. (6)`, `Constancy of the wall heat current`, etc., against packages `[Mathlib, Physlib]`. No candidate was a usable carrier for the apparatus-level laws (near misses: `CanonicalEnsemble.heatCapacity`, `DimArea`, `Space.distDiv_inv_pow_eq_dim` — all recorded there); faithful local abstractions were introduced instead, as the physics-modeling rules prescribe. The positive grounding hit is the import `Physlib.Thermodynamics.Temperature.Basic` (temperature-typing baseline for the thermal readouts), already present and retained (chapter `% NOTE`, iter-004 reconciliation).

## PhysLean/Mathlib names grounded

- Import-side: `Mathlib` ( `Real.log`, `deriv`, `Set.Icc`, `|·|` ), `Physlib.Thermodynamics.Temperature.Basic` (baseline domain import per chapter note).
- Proof-body (helper only): `wall_current` uses the `steady` field directly.

## Local abstractions introduced and physical faithfulness

- `CylindricalWallGeometry` + `lateralArea`: keeps radii/height as physical lengths with positivity guards; area law `2πrh` is the geometry that makes Fourier's law (6) integrate to `ln(r₂/r₁)`.
- `ThermalExperimentData`: readout package (SI scalars), explicitly distinguished from law content.
- `LumpedHeatFlowLaw`, `RadialFourierConduction`: the two governing equations as hypothesis interfaces, preserving direction/sign and steady-state branch; both expose equational consequences (see countermodel audit).
Scalar `ℝ` fields are justified in-file: the subquestion manipulates only SI numerical readouts; roles/laws live in the structures, satisfying the "no transparent scalar alias" rule.

## Grounding gaps / redraft requests

- None blocking. PhysLean has no apparatus-calibration/uncertainty-band library (recorded in chapter `% NOTE`); uncertainty handled conclusion-side as audited above.
- Provenance escalation (standing, not a redraft request): which recorded inputs produced the official `λ = 0.25` is under-determined in this checkout; user noticeboard item re vendoring `raw/E1_solution.pdf` stands (PROGRESS.md bookkeeping).

## `\leanok` readiness

- `wall_current` is fully proved → its `lemma` block is eligible for `\leanok`.
- All definition blocks (`ThermalExperimentData`, `CylindricalWallGeometry`, `LumpedHeatFlowLaw`, `RadialFourierConduction`) are grounded (no sorries) → eligible for `\leanok`.
- The two theorem blocks still carry `by sorry` (expected at autoformalize) → not `\leanok`-ready; review/sync applies markers per its own rules.
