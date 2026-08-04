# Autoformalization result

## Assumption/target split

### Governing laws

- `HalfCylindricalReflectionLaw setup` states the exact Figure 2g
  specular-reflection relations for every admissible incidence angle:
  the dimensionless slope is `cot (2 * angleRad)`, and the reflected ray's
  physical intercept has readout
  `figure2gLengthReadout setup.coordinateUnits setup.radius /
  (2 * cos angleRad)`.
- The law is exact input physics to be Taylor-expanded. It does not state
  either first-order or quadratic-remainder conclusion.

### Previous-part results

- `PreviousPartC1Result setup` records only the C.1 central-ray formulas for
  `rayA setup`: slope `cot (2θ)` and intercept readout `R / (2 cos θ)`.

### Figure/data readouts

- `Figure2gSetup.coordinateUnits` is the single unit choice used for every
  Figure 2g coordinate readout.
- `Figure2gSetup.radius` is a unit-independent physical length, and
  `radiusLengthReadout_pos` asserts positivity after the named common-unit
  projection.
- `incidenceAngleRad` is a dimensionless radian readout restricted to
  `(0, π/2)`.
- `reflectedRayReadoutAt` is the Figure 2g family of reflected rays indexed by
  incidence angle. Each ray has a dimensionless slope and a physical-length
  intercept.
- `rayA` selects the central ray at `θ`; `rayB` selects the neighboring ray at
  `θ + Δθ`.

### Current target conclusions

- `rayB_slope_firstOrder` concludes that the residual from
  `cot(2θ) - 2 csc²(2θ) Δθ` is `O(Δθ²)` at `Δθ → 0`.
- `rayB_intercept_firstOrder` concludes, after the common Figure 2g length
  projection, that the residual from
  `(R / (2 cos θ)) * (1 + tan θ * Δθ)` is `O(Δθ²)`.
- `IPhO_2026_2_C_2` conjoins exactly those two filter-local contracts.

## Goal-faithfulness audit

The current C.2 expansions occur only as theorem conclusions. Neither
`Figure2gSetup`, `HalfCylindricalReflectionLaw`, nor `PreviousPartC1Result`
contains a first-order expansion or an `O(Δθ²)` assertion. The exact
reflection law supplies only the functions to be differentiated, and the
previous-part predicate supplies only the value of the central ray. The named
projection merely evaluates an already unit-independent physical length in a
chosen unit system; it does not encode either target formula.

Both remainder statements still use Mathlib's filter-local
`Asymptotics.IsBigO` notation at `𝓝 0`. No target was replaced by `True`,
reflexivity, a scalar alias, or a definition that unfolds to the answer.

## Declarations and blueprint labels

- `ReflectedRayReadout` —
  `decl:physics:IPhO_2026_2_C_2:ReflectedRayReadout`.
- `ReflectedRayReadout.yCoordinateLengthReadout` —
  `decl:physics:IPhO_2026_2_C_2:ReflectedRayReadout:yCoordinateLengthReadout`.
- `Figure2gSetup` —
  `decl:physics:IPhO_2026_2_C_2:Figure2gSetup`.
- `rayA` — `decl:physics:IPhO_2026_2_C_2:rayA`.
- `rayB` — `decl:physics:IPhO_2026_2_C_2:rayB`.
- `HalfCylindricalReflectionLaw` —
  `decl:physics:IPhO_2026_2_C_2:HalfCylindricalReflectionLaw`.
- `PreviousPartC1Result` —
  `decl:physics:IPhO_2026_2_C_2:PreviousPartC1Result`.
- `rayB_slope_firstOrder` —
  `decl:physics:IPhO_2026_2_C_2:rayB_slope_firstOrder`.
- `rayB_intercept_firstOrder` —
  `decl:physics:IPhO_2026_2_C_2:rayB_intercept_firstOrder`.
- `IPhO_2026_2_C_2` —
  `thm:physics:IPhO_2026_2_C_2:target`.

The support declarations `PhysicalLength` and `figure2gLengthReadout` were
added to implement the chapter's dimensioned-length and named-projection
requirements; the current blueprint has no separate environments for them.
All listed blueprint environments are ready for the deterministic
`\leanok` synchronization. The prover did not edit the blueprint, as required
by `.archon/AGENTS.md`.

## LeanExplore grounding

Queries used with `packages: ["Mathlib", "Physlib"]`:

- `physical length dimensionful quantity with units and real-valued coordinate
  readout`
- `Dimensionful WithDim Dimension.L𝓭 UnitChoices SI length quantity`
- `WithDim`
- `UnitChoices physical unit system projection dimensionful quantity`
- `UnitChoices`
- `specular reflection law geometrical optics reflected ray cylindrical
  mirror`
- `Asymptotics.IsBigO filter local big O notation`

Candidates inspected and used:

- `Dimensionful` (source inspected), from `Physlib.Units.Basic`.
- `WithDim` (source inspected), from `Physlib.Units.WithDim.Basic`.
- `Dimension.L𝓭` (source inspected), from `Physlib.Units.Dimension`.
- `UnitChoices` (source inspected), from `Physlib.Units.Basic`.
- `Asymptotics.IsBigO` (source inspected), from
  `Mathlib.Analysis.Asymptotics.Defs`.

The explicit `Physlib.Units.WithDim.Basic` import provides the dimensioned
quantity infrastructure used in the file.

## Local abstractions

- `PhysicalLength := Dimensionful (WithDim L𝓭 ℝ)` is a dimension-carrying,
  unit-independent physical quantity, not a transparent scalar alias.
- `figure2gLengthReadout coordinateUnits length := (length
  coordinateUnits).val` is the named projection required to place radius,
  intercept, `x`, and `y` readouts in one common Figure 2g coordinate unit.
- `ReflectedRayReadout`, `Figure2gSetup`, and
  `HalfCylindricalReflectionLaw` remain the smallest local optical interface
  needed to represent the half-cylinder ray family and its exact specular
  geometry.

## Grounding gaps and redraft requests

- LeanExplore returned generic mathematical rays and affine reflections
  (`RayVector`, `Module.Ray`, `EuclideanGeometry.reflection`) but no
  half-cylindrical specular-reflection model matching Figure 2g. The local
  exact-law predicate is therefore retained.
- If full one-environment-per-declaration blueprint coverage is desired, the
  plan agent should add environments for `PhysicalLength` and
  `figure2gLengthReadout`. No change to the target statement is requested.
- The advertised `archon dag-query` executable was unavailable on this
  prover lane's `PATH`, so no dependency-graph result was consumed.

## Verification

`archon-lean-lsp` diagnostics report no errors and exactly three expected
`declaration uses sorry` warnings, at `rayB_slope_firstOrder`,
`rayB_intercept_firstOrder`, and `IPhO_2026_2_C_2`. A final
`lake env lean IPhO2026Problems/problem_IPhO_2026_2_C_2.lean` check produced
the same three warnings and exited successfully.
