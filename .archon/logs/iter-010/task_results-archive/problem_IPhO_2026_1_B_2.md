# Task Result: `IPhO2026Problems/problem_IPhO_2026_1_B_2.lean` (iter-009 lane)

- Mode: physics-formalize (autoformalize stage; by-sorry compilation contract).
- Lane status: review-gate retry 2/3, statements planner-frozen. No statement
  redraft performed (would risk a third recorded-stale strike; the deterministic
  review re-pass is the next consumer per PROGRESS.md).
- Work performed this lane: full re-read (AGENTS/PROGRESS/chapter/Lean file),
  fresh `lake env lean` verification, faithfulness audit, this report.

## Compile status (fresh `lake env lean`, iter-009)

`lake env lean IPhO2026Problems/problem_IPhO_2026_1_B_2.lean` exit 0:
- 0 errors.
- Exactly 7 `declaration uses sorry` warnings (L319, L353, L376, L421, L443,
  L502, L535). These are the contracted sorries of the autoformalize stage:
  `total_energy_pos`, `eccentricity_sq_eq`, `orbit_eq_conic`,
  `exists_asymptoticRelativeVelocity`, `signed_deflection_eq_formula`,
  `signed_deflection_angle_T1_B2`,
  `unsigned_deflection_angle_in_degrees_T1_B2`.
  (PROGRESS.md's per-file ledger line `1_B_2` 5 bundles the two main-target
  sorries under the two `\lean{}`-pinned target theorems; the raw compiler
  count is 7. The authoritative contract is the blueprint's marks: only the
  seven declarations above carry sorry bodies.)
- No other warnings (linter-clean).

## Assumption/target split

Governing laws (hypothesis-side, `CoulombScatteringData` fields):
- Newton equation for the reduced particle under attractive Coulomb:
  `newton_relative_law`.
- Angular-momentum conservation along the trajectory:
  `angular_momentum_law`.
- Coulomb potential energy / total-energy definition: `coulomb_law`.
- Multiplied-out radial energy identity: `radial_energy_law`.
- Two-body to one-body reduction: `reduced_mass_eq`, `relative_kinetic_law`,
  `initial_instant`.
- Regularity/asymptotic nontriviality: `smooth_sep`, `sep_ne_zero`.

Previous-part results: none consumed (B.1 is frozen/broken; B.2 stands alone).

Figure/data readouts (hypothesis-side):
- `initial_separation_value` (`r0 = 100 * a0`),
  `initial_separation_is_norm`, `initial_speed_value`,
  `angular_momentum_per_particle` (`m v0 (r0/2) = mu*hbar`),
  `total_angular_momentum_eq`, `initial_transverse` (velocities ⟂ separation),
  `turning_point_initial` (recorded instant is the periapsis),
  `ScalingRegime` (positivity of m, hbar, k, e, a0 + `bohr_radius_def`).
- Constants are `opaque`, not scalar aliases; roles preserved via the
  `ScalingRegime` relation. PhysLean has no Coulomb/Rutherford-scattering
  module (chapter carries a recorded PhysLean-coverage exemption NOTE,
  iter-003), so `import Mathlib` baseline is by design.

Current target conclusions (conclusion-side only):
- `signed_deflection_angle_T1_B2`: exists `u_inf`; signed deflection equals
  `-(pi - 2*arctan(2/sqrt 63))` and rounds to official `-16.60` deg.
- `unsigned_deflection_angle_in_degrees_T1_B2`: magnitude corollary rounding
  to `16.60` deg.

## Goal-faithfulness audit

- The official answer value (`-16.60`, bands `16605/16595`, `67/4` numerics,
  `2/sqrt 63`) occurs only inside the two target theorems, the
  `roundsToOfficialDegrees*` predicates they invoke, and conclusion-side
  certificates (`asymptote_factor_certificate`, `eccentricity_sq_eq`).
  No hypothesis, premise field, `Laws`-style field, or local definition
  mentions any deflection-angle value.
- The two official hints (eccentricity formula, polar conic) are encoded as
  *derivable bridge lemmas* `eccentricity_sq_eq` / `orbit_eq_conic` with
  sorry proof bodies, i.e. they are obligations to prove from the governing
  laws, not assumed laws and not definitional unfoldings.
- `u_inf` is introduced as data (`RelativeVelocityVector`) plus a constraining
  predicate (`IsAsymptoticRelativeVelocity`, a genuine `Filter.Tendsto`
  field); existence is the sorry-bodied theorem
  `exists_asymptoticRelativeVelocity`. The target theorem existentially
  quantifies `u` and discharges it through that theorem, so the current
  answer is not assumed as a witness.
- Closed proofs are purely definitional/algebraic certificates
  (`unboundMu_isAngularMomentumFactor`, `total_angular_momentum_value`,
  `initial_separation_pos`, `turningQuadratic_periapsis`,
  `eccentricity_gt_one`, `asymptote_factor_certificate`,
  `signedDeflection_eq_neg_angle`); none asserts a deflection value.
  `signedDeflection_eq_neg_angle` is an `if_neg` unfolding of the sign
  convention, not the target relation.
- No `True`-replacement, reflexive tautology, or scalar-placeholder alias of
  a physical primitive: constants are `opaque` with relations in
  `ScalingRegime`; the plane is `EuclideanSpace (Fin 2)` with explicit
  `dot`/`perp`.

## Derivability and bridge obligations

1. Figure readouts + Coulomb law -> `E = mu^2/2500 - 1/200` units
   `hbar^2/(m a0^2)`, hence `0 < S.total_energy` at `mu = 15/2`.
   Carrier: `total_energy_pos` (sorry). Evidence: `coulomb_law`,
   `angular_momentum_per_particle`, `initial_separation_value`,
   `bohr_radius_def`, `relative_kinetic_law` (pure algebra). Status: covered
   (encoded locally, proof deferred).
2. `E > 0`, `L > 0`, positivity of constants -> `1 < eccentricitySq`.
   Carrier: `eccentricity_gt_one` (PROVED, `linarith` over `div_pos`).
   Status: covered-grounded.
3. Same laws -> `eccentricitySq = 67/4` (Hint 1 value).
   Carrier: `eccentricity_sq_eq` (sorry). Status: covered (encoded, deferred).
4. Governing laws (energy + angular momentum) -> conic form of the orbit
   (Hint 2) on the unbound branch `eps*cos(theta-theta0) - 1 > 0`.
   Carrier: `orbit_eq_conic` (sorry). Status: covered (encoded, deferred).
5. Unbound orbit -> existence of limiting relative velocity at `atTop`.
   Carrier: `exists_asymptoticRelativeVelocity` (sorry).
   Status: covered (encoded, deferred).
6. Conic asymptote geometry + energy speed -> magnitude
   `sqrt(2E/m_red)` and angle `pi - 2*arctan(1/sqrt(eps^2-1))`.
   Carrier: `signed_deflection_eq_formula` (sorry).
   Status: covered (encoded, deferred).
7. `eps^2 = 67/4` -> asymptote factor `2/sqrt 63`.
   Carrier: `asymptote_factor_certificate` (PROVED, sqrt algebra).
   Status: covered-grounded.
8. Fig.-1b orientation (`direction_toward_pair`, `perp u_dir u < 0`) ->
   signed = -unsigned. Carrier: `signedDeflection_eq_neg_angle` (PROVED,
   `if_neg`). Status: covered-grounded.
9. Closed form -> official rounding band `-16.60 deg`.
   Carrier: conclusion of `signed_deflection_angle_T1_B2` via
   `roundsToOfficialDegrees`/`radiansToDegrees` (inside the main sorry).
   Status: covered (main target contract).

No blocked bridge: every nontrivial source-to-target step has a named Lean
carrier; the seven carriers still needing proofs are exactly the contracted
sorries (the prover-stage work queue).

## Abstraction sufficiency and countermodel audit

- `IsAsymptoticRelativeVelocity` (Prop structure): constraining via the
  `tendsto` limit equation (uniqueness of limits), `u_inf_ne_zero`, and the
  branch inequality `direction_toward_pair : perp initialDir u.vec <= 0`.
  A countermodel assigning arbitrary `u.vec` fails the `tendsto` field.
- `CoulombScatteringData` law fields are equations/identities (`newton_relative_law`,
  `angular_momentum_law`, `coulomb_law`, `radial_energy_law`,
  `turning_point_initial`), not mere witness assertions; degenerate
  trajectories are excluded by `sep_ne_zero`, `initial_speed_value` (v0 != 0),
  and norm equalities tying `sep0`/`v0` to the readout scales.
- `ScalingRegime` ties `bohrRadius` to the constants by an equality, so the
  opaque-constant interface cannot be instantiated with a0 unrelated to
  k, hbar, m, e.
- `initialDirection` is a genuine definition (`|v0|^-1 . v0`); the target
  angle is `angleBetween` via `Real.arccos`, not a stipulated constant.

## Uncertainty and branch coverage

- Uncertainty: genuinely not applicable. The source reports an exact
  official value (`-16.60 deg` rounding convention) with no `+/-`
  measurement uncertainty; the rounding band is encoded conclusion-side in
  `roundsToOfficialDegrees`/`roundsToOfficialDegreesAbs`.
- Branch/orientation: covered. Signed answer support:
  `IsAsymptoticRelativeVelocity.direction_toward_pair` (rolling branch toward
  the line connecting the pair, `perp` nonpositive), the Fig.-1b orientation
  convention in the file header, `signedDeflection`'s `theta_sign`
  construction, and the proved `signedDeflection_eq_neg_angle` bridge.

## Declarations created (blueprint labels pinned)

37 `\lean{}`-pinned declarations, all present and compiling:
`Plane`, `dot`, `perp`, `particleMass`, `hbar`, `coulombK`,
`elementaryCharge`, `bohrRadius`, `ScalingRegime`,
`IsAngularMomentumFactor`, `unboundMu`,
`unboundMu_isAngularMomentumFactor`, `CoulombScatteringData` (+ fields),
`CoulombScatteringData.initial_separation_pos`,
`CoulombScatteringData.total_angular_momentum_value`,
`CoulombScatteringData.turningQuadratic`,
`CoulombScatteringData.turningQuadratic_periapsis`,
`CoulombScatteringData.semilatusRectum`,
`CoulombScatteringData.eccentricitySq`, `total_energy_pos` (sorry),
`eccentricity_gt_one`, `eccentricity_sq_eq` (sorry), `orbit_eq_conic`
(sorry), `initialDirection`, `RelativeVelocityVector`,
`IsAsymptoticRelativeVelocity`, `exists_asymptoticRelativeVelocity`
(sorry), `angleBetween`, `signed_deflection_eq_formula` (sorry),
`signedDeflection`, `radiansToDegrees`, `signedDeflection_eq_neg_angle`,
`roundsToOfficialDegrees`, `signed_deflection_angle_T1_B2` (sorry, main
target), `asymptote_factor_certificate`, `roundsToOfficialDegreesAbs`,
`unsigned_deflection_angle_in_degrees_T1_B2` (sorry).

`\leanok` markers: none added anywhere in the blueprint yet (deterministic
`sync_leanok` phase owns them; zero `\leanok` occurrences project-wide at
iter-009). No chapter edits were made (not permitted). Flag for review:
all 37 ledger declarations are compile-verified fresh this iter; the seven
bridge/target declarations intentionally remain sorry-bodied per the
autoformalize contract, so `\leanok` is the sync's call, not appropriate
for by-sorry declarations if the gate reads it as proof-complete.

## LeanExplore queries/candidates actually used

(Recorded in `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_B_2.md`.)
Grounded names used: `Real.sqrt` (+`Real.sq_sqrt`, `Real.sqrt_sq`),
`EuclideanSpace`/`Fin 2` baseline, `Filter.Tendsto`/`Filter.atTop`/`nhds`,
`ContDiff`, `deriv`, `Real.arccos`, `Real.arctan`, `Real.pi`, norm on
EuclideanSpace, `div_pos`/`mul_pos`/`sq_pos_of_ne_zero`/`pow_ne_zero`,
`linarith`/`norm_num`/`positivity`/`field_simp`.
PhysLean candidates checked and rejected as near misses (no Coulomb/
Rutherford-scattering asymptote module): `Electromagnetism.ElectricField`,
`ChargeUnit.elementaryCharge`, `RigidBody.angularMomentum`,
`Constants.hbar` — mismatch recorded; local abstractions carry the physical
roles instead (chapter exemption NOTE, iter-003; review-gate reason string
is the recorded-stale residue of that standing exemption).

## Grounding gaps / redraft requests

- PhysLean gap (standing, exemption-recorded): no hyperbolic Coulomb
  scattering / deflection-angle module; not a redraft blocker.
- No statement redraft initiated this lane: gate is retry 2/3 with
  planner-frozen statements; the deterministic review re-pass is the
  designated next consumer. Any redraft belongs to the review decision, not
  a self-initiated edit.
- Note for plan agent: PROGRESS.md's sorry ledger line (`1_B_2` 5) vs.
  compiler count (7) is a bundling artifact of the two main-target sorries;
  counts above are the authoritative per-declaration numbers.
