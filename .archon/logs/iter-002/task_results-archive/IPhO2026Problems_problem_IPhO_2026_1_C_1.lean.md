# Autoformalization result: IPhO 2026 Problem 1 C.1

## Status

- Created `IPhO2026Problems/problem_IPhO_2026_1_C_1.lean`.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_1_C_1.lean` exits
  successfully.
- The project target `lake build IPhO2026Run` also completes successfully.
- The only diagnostics are the seven expected `declaration uses sorry`
  warnings.
- The assigned file did not previously exist, so there was no
  `/- USER: ... -/` file-specific hint.
- The blueprint contains `% archon:physics`; the physics-formalize discipline
  was used.
- The dependency graph has no ancestors for
  `thm:physics:IPhO_2026_1_C_1:target`.

## Assumption/target split

### Governing laws

- `Parameters.Valid` requires positive `ℏ`, positive oxygen-atom mass, positive
  dissociation gap, and
  `2 ΔU < m c²`. The final inequality is the discriminant/small-energy
  applicability condition for the classical nonrelativistic model.
- `photonEnergy` encodes `E_γ = ℏω`.
- `photonMomentumMagnitude` encodes `p_γ = E_γ/c = ℏω/c`.
- `DissociationEvent.photon_momentum_law` fixes the incident photon momentum
  along Figure 1c's horizontal incoming direction.
- `DissociationEvent.momentum_conservation` states conservation of vector
  momentum for an initially stationary ozone molecule in the isolated system.
- `fragmentKineticEnergy` and
  `DissociationEvent.energy_conservation` state nonrelativistic energy
  conservation with outgoing masses `2m` for O₂ and `m` for O.
- `DissociationEvent.oxygenMoleculeMomentum_ne_zero` ensures that the outgoing
  O₂ angle is physically defined rather than using Mathlib's zero-vector angle
  convention.

### Previous-part results

- None. The source report records no previous parts for C.1, and the file has
  no sibling imports.

### Figure/data readouts

- `figure1cIncidentDirection` is the horizontal incident-photon direction in
  Figure 1c.
- `DissociationEvent.photonMomentum`,
  `.oxygenMoleculeMomentum`, and `.oxygenAtomMomentum` distinguish the incoming
  photon and both outgoing fragments.
- `DissociationEvent.figure1c_angle` identifies `θ` with Mathlib's unoriented
  angle from the incident photon momentum to the outgoing O₂ momentum.
- `DissociationEvent.theta_nonneg` and `.theta_le_pi` preserve the complete
  unsigned angular range shown by the figure.
- `Parameters.ozoneGroundEnergy` and
  `.oxygenMoleculeGroundEnergy` retain `U_i` and `U_f`; `Parameters.energyGap`
  is exactly the source definition `ΔU = U_f - U_i`.

### Current target conclusions

- `minimumAngularFrequency_isDissociationThreshold` concludes that the explicit
  piecewise expression `minimumAngularFrequencyExpression parameters theta`
  satisfies the lower-bound-and-approach characterization of the minimum
  dissociation frequency.
- `minimumAngularFrequency_eq` gives the equivalent value form: any frequency
  already identified semantically as the threshold equals that expression.
- For `θ ≤ π/2`, the expression uses the angular factor
  `1 + 2 sin² θ`; for `θ ≥ π/2`, it uses the same expression evaluated at
  `π/2`.

## Goal-faithfulness audit

The requested threshold expression is not a hypothesis, field of
`DissociationEvent`, part of `Parameters.Valid`, or premise of
`KinematicallyAllowed`/`HasEnoughPhotonEnergy`. The physical interfaces contain
only positivity/applicability conditions, Figure 1c geometry, and conservation
laws.

The main theorem proves that the displayed expression has the threshold
property. It does not assume an `omegaMinimum` at all. The secondary equality
theorem assumes only the semantic predicate that its arbitrary
`omegaMinimum` is an infimum threshold; the explicit formula remains solely in
the conclusion. Naming definitions for photon energy, photon momentum, the
energy gap, radial kinetic energy, and the final expression do not make either
theorem true by unfolding.

The infimum formulation is necessary rather than cosmetic. At and beyond
`π/2`, the constrained kinetic-energy infimum occurs as the outgoing O₂
momentum tends to zero. Requiring the threshold event itself to have nonzero O₂
momentum would falsely demand attainment.

## Derivability and bridge obligations

1. **Source claim:** `p_γ = E_γ/c = ℏω/c`, directed along the incident ray.
   **Lean carrier:** `photonEnergy`, `photonMomentumMagnitude`,
   `figure1cIncidentDirection`, and
   `DissociationEvent.photon_momentum_law`.
   **Evidence:** these expose the exact scalar relation and vector equality.
   **Status:** covered (Physlib `SpeedOfLight` plus a local equation).

2. **Source claim:** isolated-system momentum conservation eliminates the
   outgoing atomic momentum as `p_O = p_γ - p_O₂`.
   **Lean carrier:** `DissociationEvent.momentum_conservation`.
   **Evidence:** it is an equality of two-dimensional Euclidean momentum
   vectors, not an opaque conservation tag.
   **Status:** covered (encoded locally).

3. **Source claim:** Figure 1c gives the cosine cross term between the incident
   photon and outgoing O₂ momenta.
   **Lean carrier:** `DissociationEvent.figure1c_angle`, grounded by
   `InnerProductGeometry.angle`; the inspected theorem
   `InnerProductGeometry.cos_angle_mul_norm_mul_norm` supplies the future
   elimination step.
   **Evidence:** the angle equality and nonzero O₂ momentum determine the
   inner-product term.
   **Status:** covered (Mathlib-grounded).

4. **Source claim:** vector momentum and energy conservation reduce to the
   scalar radial energy equation.
   **Lean carrier:** `event_scalar_energy_balance`.
   **Evidence:** its conclusion is
   `ℏω = ΔU + K_radial(θ,ω,|p_O₂|)`.
   **Status:** covered (local bridge theorem; proof intentionally deferred).

5. **Source claim:** minimizing over the nonnegative O₂ momentum magnitude
   gives `q²(1 + 2 sin² θ)/(6m)` for `θ ≤ π/2` and the limiting value
   `q²/(2m)` for `θ ≥ π/2`.
   **Lean carrier:** `minimumFragmentKineticEnergy` and
   `radialFragmentKineticEnergy_lower_bound`.
   **Evidence:** the local functions expose both explicit expressions; the
   theorem states the reusable inequality for every `r ≥ 0`.
   **Status:** covered (local constrained-quadratic bridge).

6. **Source claim:** the minimized scalar inequality is not merely necessary
   but characterizes the existence of physical momentum vectors.
   **Lean carrier:** `kinematicallyAllowed_iff_hasEnoughPhotonEnergy`.
   **Evidence:** the conclusion is an `↔` between the event witness and a
   concrete energy inequality; the backscattering branch is strict because
   O₂ momentum must be nonzero.
   **Status:** covered (local construction/elimination theorem).

7. **Source claim:** the lower quadratic root is the displayed threshold
   expression.
   **Lean carrier:**
   `minimumAngularFrequencyExpression_energy_boundary`, using `Real.sqrt`.
   **Evidence:** it states the exact equality between photon energy and the
   minimized required energy at the displayed expression.
   **Status:** covered (Mathlib-grounded square root plus local algebraic
   bridge).

8. **Source claim:** the lower root is the infimum of all feasible
   frequencies, including the limiting backscattering case.
   **Lean carrier:** `minimumAngularFrequency_isDissociationThreshold`.
   **Evidence:** its conclusion is the complete lower-bound-and-arbitrary-close
   threshold contract.
   **Status:** covered (main theorem contract; proof intentionally deferred).

9. **Source claim:** the numerical value called `ω_min` is uniquely determined.
   **Lean carrier:** `isDissociationThreshold_unique` and
   `minimumAngularFrequency_eq`.
   **Evidence:** uniqueness follows from the two lower-bound/approach
   contracts, and the value theorem concludes the requested equality.
   **Status:** covered.

## Abstraction sufficiency and countermodel audit

- `Parameters.Valid` is a concrete conjunction of four strict inequalities;
  it is not an opaque “valid physics” marker.
- `DissociationEvent` is constrained by explicit angle-range inequalities,
  a nonzero outgoing-momentum condition, photon momentum equality, vector
  momentum conservation, Figure 1c angle equality, and scalar energy
  conservation.
- `KinematicallyAllowed` unfolds to `Nonempty DissociationEvent`, so a witness
  immediately exposes every preceding equation and inequality.
- `HasEnoughPhotonEnergy` unfolds to a concrete non-strict/strict energy
  inequality selected by the physical angular branch.
- `IsDissociationThreshold` unfolds to nonnegativity, a lower bound for every
  feasible frequency, and feasible frequencies arbitrarily close above the
  threshold. Thus it rules out arbitrary threshold assignments and implies
  uniqueness.

Countermodel check: after choosing an event arbitrarily, its momentum and
energy fields still force the scalar radial balance through
`event_scalar_energy_balance`; the radial lower-bound theorem then forces the
minimized energy condition. Conversely, the `↔` bridge requires construction
of actual momentum vectors from that condition. Hence the event and feasibility
relations cannot be interpreted freely while making the threshold conclusion
false.

## Uncertainty and branch coverage

- **Uncertainty: genuinely not applicable.** Neither the problem nor its
  symbolic answer reports `value ± uncertainty` or any experimental error bar.
- **Incoming/outgoing roles: covered.** The photon and both fragments have
  separate named vector fields, and the conservation direction is explicit.
- **Angular orientation: covered.** The source uses the unsigned angle between
  momenta, represented by `InnerProductGeometry.angle` in `[0,π]`; no
  clockwise/counterclockwise sign is requested.
- **Forward branch: covered.** `θ ≤ π/2` uses the tangency/minimization factor
  `1 + 2 sin² θ`.
- **Backscattering branch: covered.** `effectiveThresholdAngle` clamps
  `θ ≥ π/2` to `π/2`, while `IsDissociationThreshold` preserves the limiting,
  generally unattained nature of the threshold.
- **Square-root branch: covered.** `minimumAngularFrequencyExpression` selects
  `1 - sqrt(...)`, the lower nonnegative quadratic root; `Parameters.Valid`
  keeps the discriminant strictly positive.

## Declarations created and blueprint correspondence

All declarations are in namespace `IPhO2026Problem1C1`.

- Physical/setup declarations:
  `MomentumPlane`, `figure1cIncidentDirection`, `Parameters`,
  `Parameters.energyGap`, `Parameters.Valid`, `photonEnergy`,
  `photonMomentumMagnitude`, `fragmentKineticEnergy`, and
  `DissociationEvent`.
- Constraining relations:
  `KinematicallyAllowed`, `HasEnoughPhotonEnergy`, and
  `IsDissociationThreshold`.
- Algebraic helpers:
  `radialFragmentKineticEnergy`, `angularFactor`,
  `minimumFragmentKineticEnergy`, and `effectiveThresholdAngle`.
- Bridge theorems:
  `event_scalar_energy_balance`,
  `radialFragmentKineticEnergy_lower_bound`,
  `kinematicallyAllowed_iff_hasEnoughPhotonEnergy`,
  `minimumAngularFrequencyExpression_energy_boundary`, and
  `isDissociationThreshold_unique`.
- Main declaration:
  `IPhO2026Problem1C1.minimumAngularFrequency_isDissociationThreshold`.
- Equivalent value declaration:
  `IPhO2026Problem1C1.minimumAngularFrequency_eq`.

The main declaration corresponds to
`thm:physics:IPhO_2026_1_C_1:target`. The theorem environment is formalized
with a `sorry` body and is ready for `\leanok`, but the blueprint currently has
no `\lean{...}` declaration name. Per prover permissions, the blueprint was not
edited; plan/review or deterministic sync should attach/mark it.

## LeanExplore queries/candidates actually used

All searches passed package filters `["Mathlib", "Physlib"]`.

1. Query: `photon momentum energy divided by speed of light conservation of
   energy and momentum nonrelativistic two-body dissociation`
   - Used `SpeedOfLight` from `Physlib.Relativity.SpeedOfLight`.
   - `ClassicalMechanics.FreeParticle.linearMomentum_conserved` was a near
     miss: it concerns a single free-particle trajectory, not an instantaneous
     absorbing two-body dissociation event.

2. Query: `Real.sqrt sin pi EuclideanSpace inner product angle between vectors
   norm squared`
   - Used `InnerProductGeometry.angle`.
   - Inspected
     `InnerProductGeometry.cos_angle_mul_norm_mul_norm` as the exact future
     angle-to-inner-product bridge.

3. Query: `InnerProductGeometry.angle definition angle between vectors`
   - Used `InnerProductGeometry.angle`, whose source defines the unoriented
     angle by `Real.arccos` of the normalized inner product.

4. Query: `ReducedPlanckConstant Planck constant hbar angular frequency photon
   energy`
   - Inspected `Constants.ℏ`.
   - It was not used because it is the fixed numerical SI value, whereas the
     problem asks for a symbolic `ℏ` in an arbitrary coherent unit system.

5. Query: `physical unit dimensions mass energy momentum angular frequency
   quantity SI units dimensioned quantity`
   - Inspected `Dimensionful` and `Dimension`.
   - `Dimensionful` is a function over all `UnitChoices`; it was not selected
     because this problem's equations are readouts in one fixed coherent
     system. The multi-field `Parameters` record retains each dimensional role
     without defining physical primitives as scalar aliases.

6. Preflight query: `Real.sqrt square root`
   - Used `Real.sqrt` from `Mathlib.Analysis.Real.Sqrt`.

## PhysLean/Mathlib names grounded

- Physlib: `SpeedOfLight`, `SpeedOfLight.val`, and its positivity invariant.
- Mathlib: `Real.sqrt`, `Real.sin`, `Real.cos`, `Real.pi`,
  `EuclideanSpace`, `EuclideanSpace.single`,
  `InnerProductGeometry.angle`, and
  `InnerProductGeometry.cos_angle_mul_norm_mul_norm` (future proof bridge).

## Local abstractions introduced

- `Parameters` is a multi-field coherent-unit readout context. It keeps `ℏ`,
  `m`, `c`, `U_i`, and `U_f` distinct and records their dimensional roles;
  it is not a transparent scalar alias or one-field physical wrapper.
- `MomentumPlane` is a two-dimensional vector representation, not a scalar
  replacement for momentum.
- `DissociationEvent` is the smallest event interface retaining the three
  momentum roles, Figure 1c geometry, and both conservation laws.
- The radial energy, energy-feasibility, and threshold predicates expose
  explicit equalities/inequalities and reusable elimination theorems.

## Grounding gaps

- No matching Physlib API was found for photon absorption followed by
  nonrelativistic two-fragment molecular dissociation. The local event
  structure and conservation equations are therefore necessary.
- Physlib's fixed `Constants.ℏ` cannot represent the symbolic arbitrary-unit
  parameter requested by the problem.
- The blueprint's recorded C.1 answer omits a factor `2` multiplying `ΔU`
  under the square root. The official `T1_solution.pdf` gives the factor `2`
  (its discriminant has
  `36ℏ²m²c⁴ + 24 ΔU m c² ℏ² (cos(2θ)-2)`), and the official C.2 expansion
  `ℏω_min - ΔU = (2-cos(2θ))(ΔU)²/(6mc²)` independently requires it.
  The Lean file follows the conservation laws and official solution rather
  than introducing a false energy law to reproduce the transcription error.

## Redraft requests

- Correct the recorded C.1 answer to include the factor `2` under the square
  root:
  `1 - sqrt(1 - (2 ΔU/(3mc²))(1 + 2 sin² θ))`.
- Add
  `\lean{IPhO2026Problem1C1.minimumAngularFrequency_isDissociationThreshold}`
  to the target theorem environment so marker synchronization can identify the
  formalization.
