# Autoformalization result: IPhO 2026 Problem 2 B.2

## Assumption/target split

### Governing laws

- Constant uniform solar irradiance is represented by
  `ValidFigure2fRayOptics.uniform_irradiance`.
- Parallel sunlight along the optical axis is represented by
  `ValidFigure2fRayOptics.parallel_to_optical_axis`.
- Full absorption and the at-most-one-reflection condition are represented by
  `fully_absorbing` and `absorbed_after_at_most_one_reflection`.
- The projected-area law for a uniform fully absorbed beam is represented by
  the two power-balance equations in `Figure2fPowerBalance`. The common
  projected area is width times the common illuminated axial length.

### Previous-part results

- `PreviousPartB1Result` records
  `a = α sin θ_max + β sin (2 θ_max)`, `α = R`, and `β = -R/2`.
- No sibling Lean file is imported; this is a local contract for the
  natural-language prerequisite, as required by the dependency policy.

### Figure/data readouts

- `Figure2fSetup` records the mirror radius `R`, container radius `a`,
  center separation, Figure 2f projected widths, the three relevant axis
  directions, `θ_max`, irradiance, powers `P` and `P₀`, and ray observables.
- `Figure2fGeometry.center_separation` records the `R/2` center offset in the
  symmetry plane.
- `Figure2fGeometry.axes_parallel` exposes parallelism through a nonzero scalar
  and a vector equation.
- `Figure2fPowerBalance` records the no-mirror width `2a` and actual collected
  width `2R sin θ_max`.
- `ValidFigure2fRayOptics` records that `θ_max` is a nonnegative incidence
  angle upper bound for reflected rays striking the container and is attained
  by a limiting ray.

### Current target conclusions

- The only current B.2 answer is the conclusion of
  `power_ratio_eq_one_div_one_sub_cos`:
  `P / P₀ = 1 / (1 - cos θ_max)`.
- `container_radius_factorization` and
  `power_ratio_eq_projected_width_ratio` are intermediate bridge conclusions,
  not hypotheses.

## Goal-faithfulness audit

No premise field contains the requested ratio or an algebraically identical
restatement of it. `Figure2fPowerBalance` instead states the independent
uniform-irradiance power law and two projected-width readouts. The B.1
structure states only the prior radius decomposition and its two coefficients.
The final ratio therefore requires both the trigonometric factorization and
the cancellation of positive irradiance, axial length, and projected-width
factors. No definition unfolds to the target, and the target is not a field of
any `Laws`, `Valid...`, or `Satisfies...` predicate.

## Derivability and bridge obligations

1. **Dimensioned physical readouts**
   - Source claim: radii/lengths, irradiance, and powers have distinct
     dimensional roles.
   - Carrier: Physlib `WithDim`, `Dimension.L𝓭`, and the local
     `opticalPowerDimension`/`irradianceDimension`.
   - Evidence: LeanExplore declarations `WithDim` in
     `Physlib.Units.WithDim.Basic` and `Dimension.L𝓭` in
     `Physlib.Units.Dimension`.
   - Status: **covered**.

2. **Figure 2f geometry and ray branches**
   - Source claim: parallel cylinder axes, `R/2` offset, parallel uniform
     incoming rays, full absorption, at most one reflection, and a greatest
     reflected incidence angle.
   - Carrier: `Figure2fGeometry` and `ValidFigure2fRayOptics`; their carriers
     are equations, inequalities, implications, and an attained maximum.
   - Evidence: direct source-to-contract encoding from the official Figure 2f
     page.
   - Status: **covered**.

3. **B.1 coefficients to factored radius**
   - Source claim: `α = R`, `β = -R/2` in the B.1 radius decomposition.
   - Carrier: `PreviousPartB1Result` and
     `container_radius_factorization`.
   - Evidence: Mathlib `Real.sin_two_mul`, from
     `Mathlib.Analysis.Complex.Trigonometric`.
   - Status: **covered** at statement level; the proof body is intentionally
     `sorry` in this autoformalization stage.

4. **Uniform irradiance to the two powers**
   - Source claim: absorbed power is irradiance times the projected collecting
     area; the relevant widths are `2a` without the mirror and
     `2R sin θ_max` with it.
   - Carrier: the four equations in `Figure2fPowerBalance`.
   - Evidence: faithful local reduced-optics interface. LeanExplore returned
     generic Euclidean reflection and ray declarations but no theorem for this
     irradiance/projected-aperture law.
   - Status: **covered** by a constraining local law.

5. **Cancellation of the common beam factors**
   - Source claim: the common irradiance and axial length cancel in `P/P₀`.
   - Carrier: `power_ratio_eq_projected_width_ratio`, supported by positivity
     in `Figure2fGeometry` and `Figure2fPowerBalance`.
   - Evidence: direct algebraic bridge theorem contract.
   - Status: **covered** at statement level; proof intentionally deferred.

6. **Projected-width ratio to the requested closed form**
   - Source claim: combine the width equations with
     `a = R sin θ_max (1 - cos θ_max)`.
   - Carrier: `power_ratio_eq_one_div_one_sub_cos`.
   - Evidence: the main theorem contract consumes geometry, B.1, ray optics,
     and power balance separately.
   - Status: **covered** at statement level; proof intentionally deferred.

No substantive derivability bridge is blocked.

## Abstraction sufficiency and countermodel audit

- `Figure2fGeometry` is `Prop`-valued and constrains the setup by three strict
  positivity inequalities, the `R/2` equation, a nonzero-scaling vector
  equation for parallel axes, and the strict acute-angle branch.
- `PreviousPartB1Result` is `Prop`-valued and constrains all three B.1 claims by
  explicit real equations.
- `ValidFigure2fRayOptics` is `Prop`-valued and constrains uniformity and
  direction by equations, absorption/reflection behavior by implications,
  incidence by inequalities, and maximality by an existential limiting ray
  with an equality.
- `Figure2fPowerBalance` is `Prop`-valued and constrains the optical model by
  positive irradiance, two projected-width equations, and two power equations.

Countermodel sanity check: arbitrary interpretations of the ray predicates do
not make the target automatic; they must still satisfy the absorption,
reflection-count, direction, intensity, bound, and attained-maximum fields.
More importantly, once the independent B.1 and power-balance equations and
their positivity conditions hold, assigning `P`, `P₀`, `a`, or `R`
arbitrarily cannot falsify the target while preserving all assumptions. Thus
the complete theorem contract is determined strongly enough for the intended
algebraic proof.

## Uncertainty and branch coverage

- **Uncertainty: not applicable.** The source gives no `value ± uncertainty`,
  tolerance, or experimental error datum.
- **Incidence-angle branch: covered.** `0 < θ_max < π/2` fixes the acute
  physical branch, and incidence angles are explicitly measured from the
  mirror normal.
- **Incoming/reflected distinction: covered.** Incoming directions are
  parallel to the optical axis; `reflectedFromMirror` selects the rays used in
  the maximum-angle condition.
- **Maximum branch: covered.** The maximum is both an upper bound and attained.
- **Reflection multiplicity: covered.** Every absorbed ray has reflection
  count at most one.
- **Axis orientation: covered.** Parallelism is witnessed by a nonzero scalar,
  so either representative orientation of the undirected cylinder axes is
  allowed.

## Declarations created and blueprint labels

- Dimensional carriers: `LengthReadout`, `opticalPowerDimension`,
  `irradianceDimension`, `PowerReadout`, `IrradianceReadout`.
- Model/interface declarations: `Figure2fSetup`, `Figure2fGeometry`,
  `PreviousPartB1Result`, `ValidFigure2fRayOptics`,
  `Figure2fPowerBalance`.
- Bridge theorems: `container_radius_factorization`,
  `power_ratio_eq_projected_width_ratio`.
- Main theorem:
  `IPhO2026Problems.IPhO_2026_2_B_2.power_ratio_eq_one_div_one_sub_cos`
  corresponds to blueprint label
  `thm:physics:IPhO_2026_2_B_2:target`.

The blueprint theorem currently has no `\lean{...}` declaration reference.
Because prover write permissions exclude blueprint chapters, it was not
edited. The plan/review/sync lane should attach the fully qualified main
theorem name and manage `\leanok`.

## LeanExplore queries/candidates actually used

Queries were run with package filters `["Mathlib", "Physlib"]`:

- `physical dimension power energy per time irradiance length dimensional quantity`
- `Physlib Units WithDim length power`
- `WithDim`
- `Dimensionful physical quantity with fixed dimension`
- `Dimension.L𝓭 Dimension.M𝓭 Dimension.T𝓭`
- `WithDim val division`
- `Real.sin_two`
- `sine double angle sin (2*x) = 2*sin x*cos x`
- `specular reflection law optical ray mirror incidence angle`
- `uniform irradiance power equals irradiance times projected area`
- `Optics Ray reflection incidenceAngle`

Candidates used after source/module inspection:

- `WithDim` — dimension-tagged carrier.
- `Dimension` and `Dimension.L𝓭` — physical dimensions and length dimension.
- `Real.sin_two_mul` — double-angle identity for the B.1 bridge.
- `WithDim.val_div_val` — confirmed dimension-tagged ratios reduce to scalar
  readout ratios.

## PhysLean/Mathlib names grounded

- Physlib: `WithDim`, `WithDim.val`, `WithDim.val_div_val`, `Dimension`,
  `Dimension.L𝓭`, `Dimension.M𝓭`, `Dimension.T𝓭`.
- Mathlib: `Real.sin`, `Real.cos`, `Real.pi`, `Real.sin_two_mul`.

## Local abstractions introduced

- `opticalPowerDimension` and `irradianceDimension` are the standard SI
  dimensions `M L² T⁻³` and `M T⁻³`; no dedicated Physlib power or irradiance
  carrier was found.
- `Figure2fSetup` is the smallest local data interface retaining dimensioned
  physical readouts, coordinate directions, and ray observables.
- The four `Prop`-valued validity/result structures separate figure geometry,
  previous-part information, ray assumptions, and power laws from the current
  target.
- `axialLength` makes the power equations dimensionally meaningful. It is the
  common illuminated cylinder length implicit in the apparatus and cancels
  from the ratio.
- Rays remain an abstract type because no Physlib geometric-optics ray model
  matching the problem was found; all source-relevant consequences are exposed
  as fields rather than hidden behind an opaque relation.

## Grounding gaps

- LeanExplore found generic `EuclideanGeometry.reflection`, `RayVector`, and
  `Module.Ray`, but no ready-made Physlib law for specular cylindrical-mirror
  ray collection or uniform-irradiance projected-aperture power. The local
  interfaces encode exactly the equations needed here.
- The optional `archon dag-query` executable was not available on `PATH`, so
  the blueprint dependency graph could not be queried. The chapter itself
  lists only B.1 as a natural-language prerequisite, which is represented
  locally without a Lean import.

## Verification

- `mcp__archon_lean_lsp.lean_diagnostic_messages`: no errors; exactly three
  expected `declaration uses sorry` warnings.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_2_B_2.lean`: exit code 0;
  exactly the same three expected warnings.
- `archon-protected.yaml` contains no active protected declaration affecting
  this file.
