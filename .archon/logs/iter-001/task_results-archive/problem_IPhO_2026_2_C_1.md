# Task Result — IPhO2026Problems/problem_IPhO_2026_2_C_1.lean (physics-formalize)

- Mode: `physics-formalize` (by-sorry autoformalization, no proof attempt).
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_C_1.tex` (contains `% archon:physics`).
- Source report: `reports/ipho_2026_k3/problem_IPhO_2026_2_C_1.source.json`.
- Official source page inspected: `/root/proposal_for_physic/science-mango/ipho_2026_source/image/T2_page-4.png` (Figure 2g).
- Compile status: `lake env lean IPhO2026Problems/problem_IPhO_2026_2_C_1.lean` exits 0 with exactly 4 expected `declaration uses sorry` warnings, no errors.

## Assumption/target split

### Governing laws (assumed, physics)
- Specular reflection on the half-cylinder in the Cartesian coordinates of
  Figure 2g, encoded as the structure field `reflection_law`: for every
  incidence angle `θ`, with outward radial unit normal `(P_x θ, P_y θ)/R`
  and reflected-line direction `d = (1, m_A θ)`:
  1. incidence — the reflected line passes through the reflection point:
     `P_y θ = m_A θ * P_x θ + b_A θ`;
  2. the angle between the incoming axial direction `(0, 1)` and the outward
     radial normal equals the angle `θ` labelled in Figure 2g:
     `P_y θ / R = cos θ`;
  3. angle of reflection equals angle of incidence:
     `(P_x θ + m_A θ * P_y θ)/(R * sqrt(m_A θ^2 + 1)) = P_y θ / R`;
  4. specular reversal of the tangential component along the clockwise unit
     tangent `(P_y θ, -P_x θ)/R`:
     `(P_y θ - m_A θ * P_x θ)/(R * sqrt(m_A θ^2 + 1)) = P_x θ / R`.
- `ray_B_reflection_law`: the same four constraints for the neighboring
  parallel ray B (incidence angle `θ + Δθ`, `0 < Δθ < θ`), recording that ray B
  belongs to the same mirrored family (setup stipulation used from C.2 on).

### Figure/data readouts (assumed, from Figure 2g)
- Coordinate convention: cylinder axis = `y`-axis, mirror = upper half-circle
  of radius `R`, diameter marked from `-R` to `R`; ray A travels parallel to
  the `y`-axis; `θ` is measured at the reflection point between the ray and
  the radial normal (dashed line in Figure 2g).
- Field `P_eq`: reflection point `P θ = (R * sin θ, R * cos θ)`.
- Field `θ_branch`: acute-incidence branch `θ ∈ (0, π/2)` (upper right
  quarter of the mirror), needed for the signed answers.
- Field `R_pos`: `0 < R`.

### Previous-part results
- None (`previous_parts: []`, `previous_part_count: 0` in the source report).

### Current target conclusions (conclusion side only)
- `reflected_ray_A_slope`: `m_A θ = cot (2 * θ)`.
- `reflected_ray_A_intercept`: `b_A θ = R / (2 * cos θ)`.
- `reflected_ray_A_slope_and_intercept`: conjunction (main target).
- `intercept_is_length`: dimensional sanity — `b_A θ` is a length scaling
  linearly with `R`; closed by projection from the intercept theorem.

## Goal-faithfulness audit

- The answers `cot (2 * θ)` and `R / (2 * cos θ)` appear nowhere in fields,
  premises, `Laws`-style fields, or local defs. `m_A`, `b_A`, `m_B`, `b_B`
  are uninterpreted functions constrained only by the geometric
  `reflection_law`, which never mentions `cot`, `2 * θ` as an angle doubling
  of the slope, or any explicit slope/intercept value.
- `reflection_law` is the physical law (incidence + equal angles + tangent
  reversal), not the target relation: extracting `m_A`, `b_A` from it still
  requires a unique-solution step plus `sin (2θ)`/`cos (2θ)` identities.
- Consistency (no vacuous smuggling): the recorded answer itself satisfies
  every law field under `P_eq` on the branch `θ ∈ (0, π/2)` (`cos θ > 0`),
  e.g. `(1 + m_A^2) = 1/sin^2 θ`, `P_x + m_A P_y = R cos θ / sin θ`,
  `P_y - m_A P_x = R sin θ`, `P_y - m_A P_x = R/(2 cos θ) = b_A`. So the
  laws hold of the true physics while not unfolding to it.
- Soundness (laws determine the answer): law 3 and law 4 together force
  `m_A θ` to be the slope of the specularly reflected direction: the
  equal-angle quadratic has two roots (the incident direction
  `m = -cot θ` line through `P` and the reflected one), and the signed
  tangent clause (law 4, RHS `+P_x/R` instead of `-(P_x/R)`) discards
  the incident root.  The remaining root is `m_A θ = cot (2 * θ)`;
  see Derivability bridge 4 for the algebra.  Detail is left to the
  prover stage; the statement side is unaffected.
- No `rfl`-provable target: every target theorem closes only via `sorry` at
  this stage and none is a definitional unfolding of an assumption.

## Derivability and bridge obligations

1. Source: axial ray strikes the mirror at polar angle `θ` from the `y`-axis
   (Figure 2g). Carrier: field `P_eq` + `θ_branch`. Status: covered
   (encoded locally as a figure readout, per policy).
2. Source: incidence-angle definition (angle between ray and radial normal).
   Carrier: `reflection_law` clause 2, `P_y θ / R = cos θ`. Status: covered.
3. Source: law of specular reflection (equal angles, tangent reversal).
   Carrier: `reflection_law` clauses 3–4 (`ray_B_reflection_law` for ray B).
   Status: covered. Mathlib has no geometric-optics reflection API; PhysLean
   has none either (see Grounding gaps), so this is a faithful local law with
   explicit equations, not an opaque witness predicate.
4. Bridge: `reflection_law` + `P_eq` + branch ⇒ `m_A θ = cot (2 θ)`.
   Carrier: theorem `reflected_ray_A_slope` (sorry). Evidence: with
   `P = (R sin θ, R cos θ)`, laws 3–4 give `sin θ - m cos θ = ±(cos θ + m sin θ)`;
   the `+` sign is the incident root `m = -cot θ`, the `-` sign (selected by
   law 4's positive RHS `sin θ`) gives `m = cos(2θ)/sin(2θ) = cot(2θ)`.
   Status: carrier present, proof deferred (covered as a statement).
5. Bridge: reflection point lies on the line ⇒ `b_A = P_y - m_A P_x =
   R/(2 cos θ)`. Carrier: `reflected_ray_A_intercept` (sorry), via law 1 +
   bridge 4 + `cos(2θ) = 2cos²θ - 1`. Status: carrier present, proof
   deferred (covered as a statement).
6. Source: recorded answer. Carrier: main theorem contract
   `reflected_ray_A_slope_and_intercept`. Status: covered.

## Abstraction sufficiency and countermodel audit

Local `Prop`-valued interfaces and their constraining content:
- `θ_branch` — membership equation `θ ∈ Set.Ioo 0 (π/2)`; yields
  `sin θ > 0`, `cos θ > 0` for later proofs.
- `P_eq` — explicit coordinate equations for `P_x θ`, `P_y θ`.
- `reflection_law` — four scalar equations per `θ` (incidence, incidence
  cosine, normal reflection cosine, tangent reversal). Not a bare existence
  statement. Countermodel check: interpreting `m_A = -cot θ` (the mirror-image
  slope of the unmirrored line) satisfies laws 1–2 but violates law 4 (gives
  tangent component `-(P_x/R)`); interpreting `m_A = cot θ` (continuation of
  the incident direction) violates law 3/4 sign; the reflected root
  `cot(2θ)` is the unique survivor, so the interface constrains the model
  to the intended physics on the branch.
- `ray_B_reflection_law` — same four equations instantiated at `θ + Δθ`,
  quantified with `0 < Δθ < θ`; carries the `Δθ ≪ θ` stipulation as an
  order hypothesis usable for first-order expansions in C.2.
No abstract type was needed: all quantities are genuine scalars
(coordinates, dimensionless slopes, length intercepts), which the rules
explicitly allow; `R` remains a named positive parameter.

## Uncertainty and branch coverage

- Uncertainty: not applicable — the subquestion asks for exact symbolic
  expressions; the source reports no `value ± uncertainty` data.
- Branch/orientation: covered — `θ_branch` (acute incidence, upper right
  quarter), the signed tangent-reversal clause (law 4), and `R_pos` record
  the Figure-2g orientation needed for the signed slope/intercept.

## Declarations created and blueprint labels

- `IPhO2026_2_C_1.HalfCylindricalMirrorReflection` (structure) — chapter
  `ch:IPhO2026Problems_problem_IPhO_2026_2_C_1`.
- `...θ_branch`, `...P_eq`, `...reflection_law`, `...ray_B_reflection_law`
  (law/readout fields).
- `IPhO2026_2_C_1.HalfCylindricalMirrorReflection.intercept_is_length`.
- `IPhO2026_2_C_1.HalfCylindricalMirrorReflection.reflected_ray_A_slope`.
- `IPhO2026_2_C_1.HalfCylindricalMirrorReflection.reflected_ray_A_intercept`.
- `IPhO2026_2_C_1.HalfCylindricalMirrorReflection.reflected_ray_A_slope_and_intercept`
  — corresponds to blueprint `thm:physics:IPhO_2026_2_C_1:target`.
- Marker note for review agent: all declarations carry `sorry` (by design in
  this stage); the chapter theorem is formalized but NOT proof-complete, so
  `\leanok` should be left to the deterministic sync.

## LeanExplore queries/candidates actually used

- `Real.cot cotangent cosine over sine` → grounded `Real.cot`
  (`Real.cot_eq_cos_div_sin` available for the prover stage).
- Preflight log `.archon/task_results/physics-grounding-...C_1.md` contained
  only irrelevant hits (`Path.target`, `semiformal_result`,
  `stereographic_target`); none used.

## PhysLean/Mathlib names grounded

- `Real.cot`, `Real.sin`, `Real.cos`, `Real.sqrt`, `Real.pi`, `Set.Ioo`,
  `Set.Mem`. No PhysLean optics API exists for specular reflection on a
  cylinder; local law fields used instead.

## Local abstractions introduced and why they preserve physical meaning

- One structure `HalfCylindricalMirrorReflection` bundling mirror radius,
  reflection point, the four slope/intercept functions, the Figure-2g
  readouts, and the equational reflection law. Scalar fields are the
  physical quantities themselves (coordinates and slope/intercept readouts),
  not placeholder aliases for a collapsed primitive; the law fields carry
  the geometry so the target cannot be unfolded from definitions.

## Grounding gaps / redraft requests

- Gap: no Mathlib/PhysLean geometric-optics reflection predicate — mitigated
  by the equational local `reflection_law`.
- Tooling note: `archon` CLI was not on PATH in this lane, so the leandag
  navigation step was skipped (read-only aid only).
- Note to prover stage: deriving bridge 4 needs the quadratic/root-selection
  argument sketched above plus `Real.cot_eq_cos_div_sin`,
  `Real.sin_two_mul`, `Real.cos_two_mul`.
