# Task Result: IPhO2026Problems/problem_IPhO_2026_1_B_2.lean (iter-014 redraft, autoformalize)

- Mode: `physics-formalize`; chapter `IPhO2026Problems_problem_IPhO_2026_1_B_2.tex` confirmed `% archon:physics` (line 2).
- Redraft authorization: target-only `autoformalize` redraft per the validated Review certificate (`redraft_kind: missing_foundational_bridge`, iter-013 reopen, `last_review_iter: 11`, gate status `retry`). The certificate's stated root cause: the physical core of the contract — Hint 2's conic (`orbit_eq_conic`), existence of `u∞` as a `Filter.Tendsto` limit (`exists_asymptoticRelativeVelocity`), and the energy/asymptote-derived deflection formula (`signed_deflection_eq_formula`) — was sorry-bodied with **no mathematical bridge** from the raw `ContDiff`/`deriv` law fields (no perp Leibniz rule, no torque vanishing, no angular-momentum conservation from the central-force equation), and `newton_relative_law` was norm-only (lost the radial direction that makes the torque vanish).
- Contract repair (root cause, not just the last proof error):
  1. `CoulombScatteringData.newton_relative_law` (structure field, unprotected — `archon-protected.yaml` has no entries) upgraded from the norm-only equation `‖(1/2)•sep''‖ = k e²/‖sep‖²` to the faithful VECTOR Newton equation `sep'' = -(2 k e²/m) • ((‖sep‖³)⁻¹ • sep)`: attraction along `-sep` with the `r⁻³` radial unit factor, i.e. `m_red * sep'' = -(k e²/r³) sep` with `m_red = m/2`. This preserves the physical law (the central character is exactly what conserves angular momentum) and closes the factor-of-two gap between the norm form and the equal-mass two-body reduction.
  2. 13 PROVED infrastructure lemmas inserted (the missing Binet-layer calculus bridge), none of which mentions any deflection angle, eccentricity value, or `u∞`: `hasDerivAt_apply_coord` (coordinate-wise `HasDerivAt` on the Euclidean plane via `PiLp.hasFDerivAt_apply` + `comp_hasDerivAt`), `differentiable_deriv_of_contDiff_two`, `perp_smul_right`, `perp_smul_left`, `perp_self`, `lagrange_coord`, `norm_sq_coord`, `lagrange_norm` (Cauchy–Schwarz content in Lagrange form), `norm_sq_differentiable`, `norm_differentiable_of_ne_zero` (radial coordinate differentiable along the trajectory — uses `sep_ne_zero`), `perp_sep_hasDerivAt` (Leibniz: `(perp f f')' = perp f f''`, the `perp f' f'` term dropping out by `perp_self`), `perp_sep_is_const_of_central_force` (torque of a radial acceleration vanishes ⇒ specific angular momentum constant, via `is_const_of_deriv_eq_zero`).
  3. 3 PROVED field-level consistency certificates binding the upgraded field set: `newton_relative_law_norm` (norm of the vector law gives `m_red·|sep''| = k e²/r²`), `perp_sep_initial` (figure readouts force the initial bracket value `2 r0 v0`), `angular_momentum_conserved_value` (the field's conserved value `L/m_red` equals that figure value — the constancy theorem's initial datum).
- Verification: fresh `timeout 400 lake env lean IPhO2026Problems/problem_IPhO_2026_1_B_2.lean` → **0 errors, exactly the 3 documented Kepler-bridge sorries** (now at `orbit_eq_conic` 739:8, `exists_asymptoticRelativeVelocity` 790:8, `signed_deflection_eq_formula` 820:8 after the insertions), plus 4 pre-existing unused-variable linter warnings. Same sorry set as the pre-redraft gate state, statements of the two main theorems and every prior proved certificate (`eccentricity_sq_eq`, `arctan_deg_band`, `signed_deflection_certificate`, `asymptote_factor_certificate`, …) byte-unchanged; no collateral breakage anywhere in the file.

## Assumption/target split

- **Governing laws** (hypothesis-side, fields of `ScalingRegime` + `CoulombScatteringData`): positivity of constants and the Bohr-radius SI relation (`ScalingRegime.bohr_radius_def`); isolated classical non-relativistic system; equal-mass two-body → one-body reduction (`reduced_mass_eq`, `relative_kinetic_law`, `newton_relative_law` — NOW the faithful vector central-force equation `sep'' = -(2 k e²/m)•(r⁻³ sep)`); Coulomb's law `U = -k e²/r` in energy form (`coulomb_law`); angular-momentum conservation `r²θ' = L/m_red` in bracket form (`angular_momentum_law`); multiplied-out radial energy identity (`radial_energy_law`); regularity (`smooth_sep`), non-collision (`sep_ne_zero`), polar decomposition (`polar_decomposition`).
- **Figure/data readouts**: `r0 = 100·a0` (`initial_separation_value`); transverse initial instant with the Fig.-1b orientation `perp sep0 v0 = +r0 v0` (`initial_transverse`); turning point at `t = 0` (`turning_point_initial`); `sep 0`, `deriv sep 0 = 2 v0` (`initial_instant`); per-particle angular momentum `μ ℏ` (`angular_momentum_per_particle`).
- **Given problem parameter**: `μ = 15/2` (`unboundMu`, `IsAngularMomentumFactor`), carried as hypothesis `hμ` — never as a conclusion.
- **Current target conclusions** (conclusion-side only): existence of `u∞` (`exists_asymptoticRelativeVelocity`), its speed/angle formula (`signed_deflection_eq_formula`), the signed answer `delta = -arctan(2/√45)` inside the official rounding band (`signed_deflection_angle_T1_B2`), the magnitude corollary (`unsigned_deflection_angle_in_degrees_T1_B2`). The 13 new bridge lemmas and 3 certificates conclude only calculus/dynamics facts (constancy of `perp`, bracket identities, norm magnitudes) — no angle/eccentricity value appears in their statements.

## Goal-faithfulness audit

- `16.60`/`16.595`/`16.615` appear only inside `roundsToOfficialDegrees`/`roundsToOfficialDegreesAbs` (rounding-recognition predicates used conclusion-side) and in the two main theorems' conclusions; `arctan (2 / Real.sqrt 45)` appears only in main-theorem conclusions and the proved pure-numeric lemmas `arctan_deg_band` / `signed_deflection_certificate`.
- `grep -n "arctan\|16.6\|49 / 4\|2 / Real.sqrt"` restricted to the 16 new declarations: no occurrence — the bridge layer carries zero answer data.
- `newton_relative_law`'s upgrade states Newton's equation itself (a governing law as the page gives it), not the conic or the deflection; `perp_sep_is_const_of_central_force` concludes constancy only (the conserved VALUE is still the separate field content of `angular_momentum_law`, whose multiplier form `L/m_red` the conic integration consumes). `angular_momentum_conserved_value` equates the field value with the figure datum — a consistency check, not the conservation statement.
- `IsAsymptoticRelativeVelocity` unchanged: genuine `Filter.Tendsto` limit + branch field only.

## Derivability and bridge obligations

| Bridge | Source claim | Lean carrier | Evidence / status |
|---|---|---|---|
| L = 2 μ ℏ | per-particle μℏ about CM | `total_angular_momentum_value` | covered (proved) |
| r0 > 0 | Fig.-1b readout | `initial_separation_pos` | covered (proved) |
| turning point at r0 | transverse + radial-energy | `turningQuadratic_periapsis` | covered (proved) |
| E > 0 | energy law, μ = 15/2 | `total_energy_pos` | covered (proved) |
| eps² = 49/4 | Hint 1 evaluation | `eccentricity_gt_one`, `eccentricity_sq_eq` | covered (proved) |
| coordinate calculus on the plane | — | `hasDerivAt_apply_coord`, `differentiable_deriv_of_contDiff_two` | **covered (NEW, proved)** |
| Lagrange identity / CS cycle | — | `lagrange_coord`, `norm_sq_coord`, `lagrange_norm` | **covered (NEW, proved)** |
| r(t) differentiable | `sep` smooth, no collision | `norm_sq_differentiable`, `norm_differentiable_of_ne_zero` | **covered (NEW, proved)** |
| (perp sep sep')' = perp sep sep'' | Leibniz | `perp_sep_hasDerivAt` | **covered (NEW, proved)** |
| central force ⇒ perp const | Newton eq radial | `perp_sep_is_const_of_central_force` | **covered (NEW, proved)** |
| vector law ⇒ norm law | magnitudes | `newton_relative_law_norm` | **covered (NEW, proved)** |
| figure bracket = L/m_red | Fig. 1b + defs | `perp_sep_initial`, `angular_momentum_conserved_value` | **covered (NEW, proved)** |
| Hint 2: r = p/(eps cos θ − 1) | Binet/Kepler integration of the conserved quantities against `radial_energy_law` | `orbit_eq_conic` | **blocked (sorry)** — integration across the polar-time reparametrization is the remaining multi-hundred-line project; no Mathlib Kepler API |
| u∞ exists as a limit | hyperbolic orbit | `exists_asymptoticRelativeVelocity` | **blocked (sorry)** |
| u∞ speed/angle formula | energy at ∞ + periapsis asymptote | `signed_deflection_eq_formula` | **blocked (sorry)** |
| signed value + band | certificates | `signed_deflection_certificate`, `arctan_deg_band` | covered (proved) |

The redraft moved the bridge boundary: what remains sorried is the *integration* step (Binet substitution + `polar_angle` monotonicity argument), not the *differentiation/conservation* step, which is now fully proved from first principles.

## Abstraction sufficiency and countermodel audit

- The upgraded `newton_relative_law` pins both magnitude AND direction of the acceleration, so a countermodel cannot rotate the acceleration off-axis while keeping hypotheses (the old norm-only field allowed any direction — the exact underdetermination the certificate flagged). `perp_sep_is_const_of_central_force` eliminates centrally from any scalar multiple of `sep` (the `q • (r⁻³ sep)` shape), so the physical content is constant-specific-force-independent.
- `angular_momentum_conserved_value` + `perp_sep_initial` remove the remaining sign ambiguity: arbitrary mirror countermodels (`perp sep0 v0 = -r0 v0`) are excluded by `initial_transverse`, and the conserved value is now proved to match the figure's bracket, not just asserted in a docstring.
- `IsAsymptoticRelativeVelocity`: unchanged `Filter.Tendsto` uniqueness argument.
- New Prop interfaces introduced: none (all new declarations are concrete equations/HasDerivAt statements over the fixed `Plane`/`perp`/`dot` — no new opaque relations).

## Uncertainty and branch coverage

- **Uncertainty**: `not applicable` — the source gives an exact angle rounded to a marking-scheme band; the band remains conclusion-side (`roundsToOfficialDegrees(Abs)`, proved `arctan_deg_band`).
- **Branch/orientation**: **covered and strengthened** — Fig.-1b orientation via `initial_transverse`; deflection branch via `direction_toward_pair`; the sign consistency of `angular_momentum_law`'s conserved value with the figure bracket is now machine-checked (`angular_momentum_conserved_value`, `perp_sep_initial`), removing the previous docstring-only justification.

## Declarations created / blueprint labels

- NEW this redraft (all proved, in `IPhO2026.Problem1.B2`): `hasDerivAt_apply_coord`, `differentiable_deriv_of_contDiff_two`, `perp_smul_right`, `perp_smul_left`, `perp_self`, `lagrange_coord`, `norm_sq_coord`, `lagrange_norm`, `norm_sq_differentiable`, `norm_differentiable_of_ne_zero`, `perp_sep_hasDerivAt`, `perp_sep_is_const_of_central_force`, `CoulombScatteringData.newton_relative_law_norm`, `CoulombScatteringData.perp_sep_initial`, `CoulombScatteringData.angular_momentum_conserved_value`. These 15 have no blueprint chapter entries yet (post-redraft coverage debt — flagged for the writer lane; the chapter's ledger is otherwise still accurate for the pre-existing declarations).
- CHANGED: `CoulombScatteringData.newton_relative_law` field (norm → vector form); its chapter entry `def:...:CoulombScatteringData` narrative should be re-keyed to the vector law (writer-lane task; I may not edit blueprint chapters).
- UNCHANGED: all 36 prior declarations incl. both main theorems `signed_deflection_angle_T1_B2` / `unsigned_deflection_angle_in_degrees_T1_B2` and every proved certificate.
- `\leanok` ownership: no marker edits made; left to deterministic `sync_leanok` per AGENTS.md.

## LeanExplore queries / grounding

- LeanExplore (`search_summary`): "function with zero derivative everywhere is constant deriv eq zero" → grounded `is_const_of_deriv_eq_zero` (Mathlib `Analysis/Calculus/MeanValue.lean:751`); "derivative of function applied componentwise EuclideanSpace" → grounded `PiLp.hasFDerivAt_apply` (used in `hasDerivAt_apply_coord`).
- Mathlib names used in the new proofs: `PiLp.hasFDerivAt_apply`, `PiLp.proj`, `HasFDerivAt.comp_hasDerivAt`, `contDiff_succ_iff_deriv`, `hasDerivAt_sqrt`, `Real.sqrt_sq`, `EuclideanSpace.norm_sq_eq`, `Fin.sum_univ_two`, `sq_abs`, `is_const_of_deriv_eq_zero`, `norm_smul`, `norm_neg`, `Real.norm_of_nonneg`, `smul_smul`, `inv_nonneg`, `pow_ne_zero`, `sq_eq_one_iff` (pre-existing uses unaffected).
- Grounding gaps (standing): no Mathlib/PhysLean Kepler-orbit API (Binet equation, conic integration, asymptote limit) — exactly the 3 remaining sorries; PhysLean-coverage exemption recorded in-chapter (iter-003).

## Grounding gaps / redraft requests

- Same standing grounding gap as before (Kepler layer), now narrowed to the integration half after this redraft's proved conservation layer.
- No redraft requested; the two main-theorem statements and the recorded-answer chain are untouched and consistent with the official `-16.60°`.
