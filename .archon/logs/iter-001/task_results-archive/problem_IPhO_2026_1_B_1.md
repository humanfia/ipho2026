# Task result — `IPhO2026Problems/problem_IPhO_2026_1_B_1.lean` (T1, Part B.1)

- Stage: autoformalize (physics-formalize mode), Archon iteration 001.
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_B_1.tex`
  (carries `% archon:physics`; theorem target `thm:physics:IPhO_2026_1_B_1:target`,
  marked `\leanok` by this run).
- Source report: `reports/ipho_2026_k3/problem_IPhO_2026_1_B_1.source.json`.
- Official source page: `T1_page-2.png` (viewed; Fig. 1b with `100·a₀`
  separation, T1-B1 statement, Hint 1 ε=√(1+4L²E/(k²e⁴m)),
  Hint 2 r=a/(1−εcosθ)).
- Verification: `lake env lean IPhO2026Problems/problem_IPhO_2026_1_B_1.lean`
  exits 0 with exactly **four expected `sorry` warnings**
  (`boundMu_isBound`, `turningQuadratic_eq_zero_iff`,
  `maximum_separation_T1_B1`, `maximum_separation_in_bohr_radii_T1_B1`) and
  no other diagnostics. `lake build IPhO2026Run` succeeds.

## Assumption/target split

- Governing laws (assumptions — `CoulombPairData` fields, `IPhO2026Problems/problem_IPhO_2026_1_B_1.lean:141`):
  two-body → relative-coordinate reduction `reduced_mass_eq` (`μ_red = m/2`);
  problem data `angular_momentum_per_particle` (`m v₀ (r₀/2) = μℏ`) and
  `total_angular_momentum_eq` (`L = 2μℏ`); kinetic-energy reduction
  `relative_kinetic` (`2·½mv₀² = ½μ_red(2v₀)²`); Coulomb's law `coulomb_law`
  (`U(r) = −ke²/r`); effective radial law `radial_energy` (turning-point
  quadratic `Q(r) ≤ 0` along attained separations); `turning_100`
  (transverse initial instant of Fig. 1b is a turning point, `Q(r₀) = 0`);
  constants/positivity and the Bohr-radius definition in `ScalingRegime`
  (`a₀ = ℏ²/(k·m·e²)` i.e. the page's `a₀ = 4πε₀ℏ²/(me²)` with `k = 1/(4πε₀)`).
- Figure/data readouts: `initialSeparationInBohrRadii = 100` (Fig. 1b,
  `r₀ = 100·a₀`); `boundMu = 4` with `IsBoundMu` (recorded bound criterion:
  `E < 0` at the transverse instant ⇔ `4μ²ℏ² < kme²r₀`); antiparallel,
  separation-perpendicular velocities (encoded in
  `angular_momentum_per_particle`, `relative_kinetic`, `turning_100`).
- Previous-part results: none (`previous_part_count = 0`); the two official
  hints on the same page are governing-law input and are encoded through the
  effective-radial-law field rather than by `√`-expressions.
- Current target conclusions (conclusion side ONLY):
  `maximum_separation_T1_B1` (`∃ r_max, IsMaxSeparationAlongOrbit D r_max ∧
  r_max = (1600/9)·a₀`) and `maximum_separation_in_bohr_radii_T1_B1`
  (`x_max = 1600/9`).

## Goal-faithfulness audit

- No hypothesis, premise structure, structure field, or local definition
  asserts that `1600/9·a₀` is attained, maximal, or a turning point.
  `attainedSeparations` is defined solely from the governing quadratic
  `Q(r) ≤ 0`; `IsMaxSeparationAlongOrbit` is `IsGreatest` of that set — no
  numeric content.
- `certified_factorization` is a pure polynomial identity in `100/x`
  (the `(y−1)(y−9/16)` expansion, proved by `field_simp`/`ring`); the
  `9/16` constant appears only as one factor of an identity any proving
  route needs. It asserts nothing about attainability or maximality and is
  used only inside `turning_root_cases` (root classification of an
  *assumed* root equation).
- `turning_root_cases` assumes the root equation as hypothesis and
  concludes a disjunction `x = 100 ∨ x = 1600/9`; it never asserts the
  disjunction holds for any specific `x`.
- The attainability of the second root (`ha_max_attained`) and the support
  bound (`hfact`) are hypotheses of the *targets* only
  (`maximum_separation_T1_B1`, `attainedSeparations_subset_Icc`), i.e.
  they are the remaining proof obligations exposed for the next stage, not
  smuggled facts: they are premises of theorems whose conclusions still
  carry `sorry`, and they do not by themselves state the answer (the
  `IsGreatest`/`=` conclusion must still be derived from them).
- `boundMu_isBound` uses only `ScalingRegime.bohr_radius_def` and norm_num
  arithmetic (`64 < 100` after simplification); no target value involved.
- Recorded official answer `r_max = (1600/9)·a₀` appears only in the two
  target theorems' conclusions and in the (conclusion-side, algebra-only)
  factorization constant `9/16 = 100/(1600/9)`.

## Derivability and bridge obligations

| Source claim | Lean carrier | Evidence | Status |
|---|---|---|---|
| Two-body → one-body reduction, `μ_red = m/2`, `K = ½μ_red v_rel²` | `CoulombPairData.reduced_mass_eq`, `relative_kinetic` | structure fields | covered (encoded locally) |
| Coulomb's law `U(r) = −ke²/r` | `CoulombPairData.coulomb_law` | structure field | covered (encoded locally) |
| `L = 2μℏ` from per-particle `μℏ` | `angular_momentum_per_particle`, `total_angular_momentum_eq` | structure fields | covered (encoded locally) |
| Effective radial law ⇒ `Q(r) ≤ 0` on attained separations | `radial_energy`, `turningQuadratic`, `attainedSeparations`, `mem_attainedSeparations_iff` | definition + `Iff.rfl` lemma | covered |
| Transverse initial instant is a turning point | `turning_100`, `initial_turning_point` | field + rw proof | covered (proved) |
| Initial separation is attained | `initial_separation_attained` | proved from positivity + `turning_100` | covered (proved) |
| Root classification of the `1/x`-quadratic | `certified_factorization`, `turning_root_cases` | `field_simp`/`ring`/`nlinarith` | covered (proved, algebra only) |
| `μ = 4` satisfies bound criterion | `boundMu_isBound` | partial proof; final arithmetic `sorry` | blocked (numeric step remains) |
| Rescaling `Q(r) = 0` ⇔ dimensionless `1/r`-quadratic | `turningQuadratic_eq_zero_iff` | statement faithful; proof `sorry` | blocked |
| Orbit attains both turning points; larger root is max | `attainedSeparations_subset_Icc` (proved from explicit premise), `maximum_separation_T1_B1` (sorry) | bridges expose `ha_max_attained`, `hfact` premises | blocked (main derivation, next stage) |
| Direct source→contract mapping | `maximum_separation_T1_B1`, `maximum_separation_in_bohr_radii_T1_B1` | main theorem contracts | blocked (by design, autoformalize stage) |

## Abstraction sufficiency and countermodel audit

- `ScalingRegime` (Prop): positivity fields + `bohr_radius_def` equation —
  pins `a₀` to the constants; not satisfiable with `a₀ = 0`, etc.
- `IsBoundMu` (Prop): strict inequality `4μ²ℏ² < kme²r₀ ∧ 0 < μ` —
  constrains `μ` to the recorded bound branch; with `bohr_radius_def` the
  criterion becomes `μ² < 50`, so `μ = 4` passes and e.g. `μ = 8` fails.
- `CoulombPairData` (structure): its law fields are *equations*
  (`reduced_mass_eq`, `total_angular_momentum_eq`, `relative_kinetic`,
  `coulomb_law`, `turning_100`) that determine `E` and `L` from
  `(m, k, e, ℏ, μ, r₀)`; a countermodel perturbation (e.g. doubling `E`
  while keeping everything else) violates `coulomb_law`.  `radial_energy`
  is an eliminable consequence exposing the `Q(r) ≤ 0` inequality (the
  attainability content itself lives in `attainedSeparations`, so the
  eliminator stays principled).
- `IsTurningPointInBohrRadii` (Prop): conjunction `0 < x ∧ Q(x·a₀) = 0` —
  an equation; fails for non-turning `x` once `Q` is the Coulomb quadratic.
- `IsMaxSeparationAlongOrbit` (Prop): `IsGreatest` of the attained set —
  `IsMaxSeparationAlongOrbit.elim` yields `r' ≤ r` for every attained `r'`;
  a smaller candidate fails `IsGreatest.2` at the attained second root.
- Overall: not underdetermined — with the constant equations, `Q` has
  exactly the two certified roots, so
  `attainedSeparations = [100a₀, (1600/9)a₀]` and its greatest element is
  forced to be `(1600/9)a₀`; the remaining `sorry`s are honest gaps
  (arithmetic + continuity attainability), not smuggled definitions.

## Uncertainty and branch coverage

- Uncertainty (`value ± uncertainty`): **not applicable** — the source
  reports no uncertainties; the answer is the exact rational multiple
  `(1600/9)·a₀`, represented exactly as `(1600/9 : ℝ) * bohrRadius`.
- Branch/orientation: **covered** — bound vs unbound branch via
  `IsBoundMu`/`boundMu_isBound` (strict-energy criterion, not selected
  only in the conclusion); initial transverse orientation (velocities ⟂
  separation, antiparallel) via `angular_momentum_per_particle`,
  `relative_kinetic`, `turning_100`; ingoing/outgoing radial phase is
  irrelevant to `r_max` and therefore not modeled (Fig. 1b fixes the
  turning point at `r₀` regardless of radial phase convention).

## Declarations created (blueprint label mapping)

- `ScalingRegime`, `IsAngularMomentumFactor`, `initialSeparationInBohrRadii`,
  `boundMu`, `IsBoundMu`, `boundMu_isBound` — chapter “Problem source” /
  Formalization-target parameters.
- `CoulombPairData` (+ `turningQuadratic`, `attainedSeparations`,
  `mem_attainedSeparations_iff`, `initial_separation_attained`,
  `specificAngularMomentum`, `turningQuadratic_eq_zero_iff`) — governing
  laws of the chapter.
- `IsTurningPointInBohrRadii`, `initial_turning_point`,
  `certified_factorization`, `turning_root_cases`,
  `IsMaxSeparationAlongOrbit`, `IsMaxSeparationAlongOrbit.elim`,
  `attainedSeparations_subset_Icc` — bridge lemmas toward
  `thm:physics:IPhO_2026_1_B_1:target`.
- `maximum_separation_T1_B1`, `maximum_separation_in_bohr_radii_T1_B1` —
  Lean counterparts of `thm:physics:IPhO_2026_1_B_1:target`
  (chapter theorem environment marked `\leanok`).

## LeanExplore queries/candidates actually used

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
- `CoulombPairData`: smallest structure preserving two-body reduction,
  Coulomb law, per-particle angular momentum, and the effective radial
  law — all as constraining equations/inequalities.
- `attainedSeparations`/`IsMaxSeparationAlongOrbit`: abstract
  maximum-of-support notion with an `IsGreatest`-based elimination
  theorem.
- `IsTurningPointInBohrRadii`, `IsBoundMu`: equation/inequality-carrying
  predicates preserving physical meaning (turning-point set, bound branch).

## Grounding gaps

- Mathlib/PhysLean contain no classical Kepler/Coulomb two-body radial
  dynamics, no reduced-mass reduction API, and no conic-orbit
  turning-point framework → encoded via the faithful local abstractions
  above; the eccentricity hint (Hint 1) and polar conic equation (Hint 2)
  are represented through the equivalent turning-point quadratic, avoiding
  otherwise-ungrounded square-root/trigonometric commitments.
- Remaining `sorry`s (4) are recorded per declaration above; the main one
  is the continuity/IVT-style attainability plus `IsGreatest` assembly
  left for the prover stage.
