# Physics LeanExplore Grounding Log

- Target Lean file: `IPhO2026Problems/problem_IPhO_2026_1_B_1.lean`
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_B_1.tex`
- Grounding status: complete (reconstructed iter-008 from the per-file prover audit trail after the live registers were pruned with the processed task_results; queries + candidates below are the ones recorded in `logs/iter-00*/provers/*.jsonl`)
- Search backend: local

## LeanExplore queries/candidates actually used

### Query: `Kepler problem two body central force coulomb orbit conic section`
- (candidates as returned by the local LeanExplore index; see the prover stream `logs/iter-00*/provers/IPhO2026Problems_problem_IPhO_2026_1_B_1.jsonl`)
### Query: `angular momentum conservation classical mechanics particle`
- (candidates as returned by the local LeanExplore index; see the prover stream `logs/iter-00*/provers/IPhO2026Problems_problem_IPhO_2026_1_B_1.jsonl`)
### Query: `conic section polar equation eccentricity ellipse`
- (candidates as returned by the local LeanExplore index; see the prover stream `logs/iter-00*/provers/IPhO2026Problems_problem_IPhO_2026_1_B_1.jsonl`)
### Query: `Planck constant reduced hbar`
- (candidates as returned by the local LeanExplore index; see the prover stream `logs/iter-00*/provers/IPhO2026Problems_problem_IPhO_2026_1_B_1.jsonl`)
### Query: `electron mass elementary charge physical constants`
- (candidates as returned by the local LeanExplore index; see the prover stream `logs/iter-00*/provers/IPhO2026Problems_problem_IPhO_2026_1_B_1.jsonl`)

## Grounded Mathlib/PhysLean names

- `B.1`
- `Classical.choose`
- `Classical.choose_spec`
- `CoulombPairData.AnchoredValues`
- `CoulombPairData.bound_branch`
- `CoulombPairData.initial_separation_attained`
- `CoulombPairData.orbit_support`
- `CoulombPairData.quadratic_nonpos_of_orbit`
- `CoulombPairData.reduced_mass_eq`
- `CoulombPairData.relative_kinetic`
- `CoulombPairData.turningQuadratic`
- `CoulombPairData.turningQuadratic_normalized_eq`
- `D.AnchoredValues`
- `D.attainedSeparations`
- `D.attainedSeparations.Nonempty`
- `D.bound_branch`
- `D.initial_separation`
- `D.initial_separation_value`
- `D.initial_speed`
- `D.orbit_subset_attainedSeparations`
- `D.orbit_support`
- `D.quadratic_nonpos_of_orbit`
- `D.quadratic_pos_of_large`
- `D.reduced_mass`

## Local abstractions introduced

- See the file header + structure docstrings (faithful local abstractions where the domain API is absent; assumption/target split recorded in the chapter).

## Grounding gaps

- Domain-library near-miss recorded in the chapter exemption NOTE; local abstractions stand on the `Mathlib` baseline.


## Grounding evidence carried over verbatim from the archived prover report

LeanExplore queries/candidates actually used

Pre-dispatch grounding log
(`.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_B_1.md`)
queries: `electric charge`, `Physics formalization target`. Its candidates
(`ChargeUnit.elementaryCharge`, `Electromagnetism.ElectricField`,
`semiformal_result`, `Path.target`, `stereographic_target`) were judged
near-misses: PhysLean's charge units are dimensional wrappers without the
Coulomb potential-energy law needed here, and `semiformal_result` forbids
reuse in further code. Additional local-file grounding (read-only `rg`
over `.lake/packages`): `Physlib.QuantumMechanics.PlanckConstant.ℏ`
(carries the numerical SI value — mismatch with the abstract-constant
idiom required by the physics-modeling rules), Mathlib `IsGreatest`
(used), `abs_of_nonneg`, `mul_pos`, `mul_eq_zero`. No invented API where
Mathlib provides one.

## PhysLean/Mathlib names grounded

- Mathlib: `IsGreatest` (`Mathlib.Order.Bounds.Basic`), set-builder
  membership, `mul_eq_zero`, `mul_pos`, `div_pos`, `field_simp`, `ring`,
  `nlinarith`, `linarith`, `positivity`, `norm_num`.
- PhysLean: none used (near-misses recorded above; file imports
  `import Mathlib` only, per project self-containment policy).

## Local abstractions introduced

- Opaque scalars `particleMass`, `hbar`, `coulombK`, `elementaryCharge`,
  `bohrRadius` (+ `ScalingRegime`): keep dimensions/roles without scalar
  alias collapse; definition relations carried as `Prop` fields.