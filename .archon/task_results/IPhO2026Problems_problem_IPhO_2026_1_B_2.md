# Prover task result — `IPhO2026Problems/problem_IPhO_2026_1_B_2.lean` (iter-017, final)

## Outcome

**COMPLETE — 0 errors, 0 sorries, both main targets fully proved.**

Fresh `lake env lean IPhO2026Problems/problem_IPhO_2026_1_B_2.lean`:
exit 0; the only remaining diagnostics are style lints (`show`-vs-`change`,
deprecated `push_neg` alias, two >100-char lines, one unused-binder note
in `radial_sq_identity` — harmless, binder kept for interface uniformity).
`grep -n sorry` over the file hits only prose comments (now updated to
reflect the proved state).

Axiom audit (`#print axioms` via the LSP verify tool):

- `IPhO2026.Problem1.B2.signed_deflection_angle_T1_B2` —
  `[propext, Classical.choice, Quot.sound]`
- `IPhO2026.Problem1.B2.unsigned_deflection_angle_in_degrees_T1_B2` —
  `[propext, Classical.choice, Quot.sound]`

No `sorryAx`, no extra axioms, no axiom laundering. The five `opaque`
constants flagged by the source scan (`particleMass`, `hbar`, `coulombK`,
`elementaryCharge`, `bohrRadius`) are the intentional frozen
statement-layer design (physical parameters with positivity imposed via
`ScalingRegime`), not proof artifacts.

All statements are byte-identical to the frozen iter-017 contract;
signatures were not touched. Only proof bodies after `:= by` were
edited, plus four stale prose comments that still described the leaves
as `sorry`s (updated to describe the proved state — no signature or
statement text changed). The corrected physical chain `eps² = 49/4`
(`eccentricity_sq_eq`) and signed deflection `-arctan(2/√45)` is
preserved; no `67/4`, `√63`, or `≈ -151.71°` content exists anywhere.

## What was proved (the nine former Kepler-layer leaves — all closed)

Every leaf from the previous ledger is now a theorem with a complete
proof; the dependency order below is the one used.

| former leaf | status | proof route |
|---|---|---|
| `angular_momentum_polar` | **proved** | differentiate `polar_decomposition` coordinate-wise (`hasDerivAt_apply_coord`); the `perp` bracket kills the radial term (`perp_self`, `perp_smul_*`), leaving `perp = r²·θ'` |
| `harmonic_solution_on_interval` | **proved** | ODE uniqueness for `w''+w = c` on `Ioo α β`: the candidate `A·cos(θ-θ0)` is fitted at one interior point (value + derivative), and the difference `d` satisfies `d''+d = 0`, so `d² + d'²` is constant (derivative zero by the ODE), vanishes at the fitting point, hence `d ≡ 0` |
| `energy_conservation` | **proved** | `d/dt[(1/2)m_red‖sep'‖² - ke²/r] = 0` by `newton_relative_law` + coordinate Leibniz (`norm_sq_hasDerivAt`, `dot_sep_hasDerivAt`); constant value identified at `t = 0` via `turning_point_initial` + `relative_kinetic_law` + `coulomb_law` |
| `separation_tendsto_atTop` | **proved** | `r` is monotone nondecreasing on `Ici 0` (`rderiv_nonneg_of_pos` + `monotoneOn_of_deriv_nonneg`); unboundedness follows from energy conservation (bounded `r` would bound the speed term while the potential term stays bounded, contradicting `r'² ≥ 0` algebra at large kinetic energy — routed via the cleared first integral `radial_sq_identity` and `periapsis_eps_relation`) |
| `speed_tendsto_atTop` | **proved** | energy conservation rearranged: `‖sep'‖² = 2(E + ke²/r)/m_red`; `r → ∞` gives `ke²/r → 0`, so `‖sep'‖ → √(2E/m_red)` by `Filter.Tendsto` algebra + `Real.sqrt` continuity |
| `initialDirection_eq` | **proved** | transversality `perp sep0 v0 = -(r0·v0)` + the norm constraints pin the unit tangent to `dirVec(θ0 - π/2)` (coordinate solve with `dot_dirVec`/`perp_dirVec`) |
| `velocity_tendsto_atTop` | **proved** | polar velocity decomposition `sep' = r'•e_r + rθ'•e_θ` (`polar_velocity_decomp`); along the outgoing branch `r' → 0`-component controlled by `radial_sq_identity` + `r → ∞`, `rθ' = -(L/m_red)/r → 0`, and the direction tends to the asymptote angle via `polar_angle_tendsto_outgoing` + `dirVec_lipschitz` (Lipschitz continuity of the direction frame); speed limit from `speed_tendsto_atTop` fixes the magnitude |
| `orbit_eq_conic` | **proved** | `exact S.conic_first_integral hμ` over the new `conic_first_integral` (below) |
| `binet_ode` | **proved** | **ansatz route** (not the docstring's chain-rule sketch): with `eps` and the conic from `conic_first_integral`, set `w θ = 1/p + (eps/p)·cos(θ - polar_angle 0)`; `ContDiff ℝ 2` by `ContDiff.add`/`ContDiff.mul` over `Real.contDiff_cos`; `w(θ t)·r t = 1` is the conic equation rearranged (`field_simp` with denominator positivity from the conic's `0 < 1 + eps·cos` conjunct); `w''+w = 1/p` is the explicit second derivative of the cos ansatz (`HasDerivAt` chains, then `ring`). The hμ-hypothesis gap is bridged by the proved `unboundMu_isAngularMomentumFactor` |

## New helper lemmas proved this session (all inside `namespace CoulombScatteringData` unless noted)

The Kepler/first-integral chain, in dependency order, with 0 sorries
upstream at every step:

1. `reduced_mass_pos`, `total_angular_momentum_pos`,
   `semilatusRectum_pos` — positivity readouts.
2. `semilatusRectum_mul`, `eccentricitySq_mul` — cleared (denominator-free)
   defining equations for `p` and `eps²`.
3. `cleared_energy_of_turning` — `radial_energy_law` at a turning point,
   multiplied through by `2 m_red r²`.
4. `radial_sq_identity` — the squared first integral
   `m_red² p² r² r'² = L² (eps² r² - (p - r)²)`: pure `linear_combination`
   certificate off `radial_energy_law` + the cleared definitions
   (certificate `2 m_red³ p² · radial_energy_law` after substitution).
5. `periapsis_eps_relation` — at `t = 0` (`turning_point_initial`):
   `p/r0 - 1 > 1` and `(p/r0 - 1)² = eps²`, i.e. the periapsis fixes the
   conic's scale.
6. `r_ge_initial` — `r0 ≤ r t` for all `t`: both `p/r0 - 1 = +eps` and
   `= -eps` branches analyzed; a violation forces an interior turning
   point whose radius contradicts the energy algebra.
7. `turning_radius_eq` — any turning point (`r' t = 0`) has
   `r t = r0` (same energy algebra: the turning quadratic has the unique
   positive root `r0` in the realized region).
8. `rderiv_nonneg_of_pos` / `rderiv_nonpos_of_neg` — sign of `r'` for
   `t > 0` / `t < 0`: by_contra + max of `r` on `Icc` via
   `isCompact_Icc.exists_isMaxOn`; the constant-max case gives
   `deriv = 0` on `Ioo` and propagates to `t0` by continuity of `r'`
   (`tendsto_nhds_unique` against `0` on `nhdsWithin t0 (Set.Iio t0)`,
   using root `Ioo_mem_nhdsLT_of_mem`); the interior-max case collapses
   via Fermat (`IsMaxOn.isLocalMax` + `IsLocalMax.deriv_eq_zero`) +
   `turning_radius_eq` + the endpoint slope sign
   (`hasDerivAt_iff_tendsto_slope` + `slope_fun_def_field`).
9. `dot_self_sq`, `norm_sq_hasDerivAt`, `dot_sep_hasDerivAt` —
   coordinate Leibniz rules for `‖f‖²` and `dot f f'` on `Plane`.
10. `not_const_initial` — `r` cannot be constant on any open interval:
    constancy forces `sep·sep' = 0`, its derivative
    `‖sep'‖² + sep·sep'' = 0`, Newton (`newton_relative_law` — the one
    place the vector law enters the chain) gives
    `sep·sep'' = -(2ke²/m)/r0`, and Lagrange (`lagrange_norm`) +
    `angular_momentum_law` gives `L² = r0²‖sep'‖²m_red²`; the combined
    certificate `linear_combination 2*h3 + (r0·m/2)*h2` yields
    `2L² = ke²·r0·m`, i.e. `p = r0` (`semilatusRectum_mul` +
    `mul_right_cancel₀`), contradicting `2r0 < p` from
    `periapsis_eps_relation`.
11. `r_gt_initial` — strict periapsis `r0 < r t` for `t ≠ 0`:
    `r_ge_initial` + (eq-case) `monotoneOn_of_deriv_nonneg` /
    `antitoneOn_of_deriv_nonpos` on `Icc` force constancy on `Ioo`,
    excluded by `not_const_initial`.
12. `conic_first_integral` — the arccos quadrature: with
    `Q s := (p·r⁻¹ - 1)/√eps²`, per-point `HasDerivAt` chains give the
    cleared identity `Q'·(√eps²·r²) = -p·r'` and the angular law
    `θ'·(m·r²) = -L`; the squared certificates
    (`linear_combination` over `radial_sq_identity`, certificates
    hand-computed: `hsc1 = m²r²·hq'2 + hRI`,
    `hsc2 = √e²r²(1-Q²)·hB2 + L²·haux`) yield
    `(Q')² = (θ')²(1 - Q²)`; `|Q| < 1` off periapsis (strictness via
    `sub_eq_self` → `r' = 0` → `turning_radius_eq` vs `r_gt_initial`);
    then `F = arccos ∘ Q + θ` has derivative `0` on each half-line
    (sign of `Q'` from `rderiv_nonneg/_nonpos_of_neg`,
    `sq_eq_sq_iff_eq_or_eq_neg` branch kill by `linarith`), so
    `monotone + antitone` on `convex_Ici/Iic 0` pins
    `arccos(Q t) = -(θ t - θ 0)` on `t ≥ 0` (and the mirror on
    `t ≤ 0`), glued by `lt_trichotomy`; `Real.cos_arccos` +
    `Real.cos_neg` give `Q t = cos(θ t - θ 0)`, and the conic
    `r = p/(1 + eps·cos(θ - θ0))` follows by `field_simp` algebra with
    denominator positivity from `|Q| < 1`.

## Blueprint ledger (`\leanok`-readiness flags — sync-owned, not touched)

All previously-listed entries whose status was "sorry (leaf)" should now
flip to proved; suggested new entries for the helpers above:

| suggested label | Lean name | status |
|---|---|---|
| `lem:...:angular_momentum_polar` | `...B2.CoulombScatteringData.angular_momentum_polar` | **proved (was sorry)** |
| `lem:...:harmonic_solution_on_interval` | `...B2.harmonic_solution_on_interval` | **proved (was sorry)** |
| `lem:...:binet_ode` | `...B2.CoulombScatteringData.binet_ode` | **proved (was sorry)** — note the ansatz route |
| `lem:...:orbit_eq_conic` (existing `thm:` entry) | `...B2.CoulombScatteringData.orbit_eq_conic` | **proved (was sorry)** |
| `lem:...:energy_conservation` | `...B2.CoulombScatteringData.energy_conservation` | **proved (was sorry)** |
| `lem:...:separation_tendsto_atTop` | `...B2.CoulombScatteringData.separation_tendsto_atTop` | **proved (was sorry)** |
| `lem:...:speed_tendsto_atTop` | `...B2.CoulombScatteringData.speed_tendsto_atTop` | **proved (was sorry)** |
| `lem:...:initialDirection_eq` | `...B2.CoulombScatteringData.initialDirection_eq` | **proved (was sorry)** |
| `lem:...:velocity_tendsto_atTop` | `...B2.CoulombScatteringData.velocity_tendsto_atTop` | **proved (was sorry)** |
| new | `radial_sq_identity`, `periapsis_eps_relation`, `r_ge_initial`, `turning_radius_eq`, `rderiv_nonneg_of_pos`, `rderiv_nonpos_of_neg`, `not_const_initial`, `r_gt_initial`, `conic_first_integral`, `cleared_energy_of_turning`, `semilatusRectum_mul`, `eccentricitySq_mul`, `dot_self_sq`, `norm_sq_hasDerivAt`, `dot_sep_hasDerivAt`, `polar_angle_tendsto_outgoing`, `polar_velocity_decomp`, `dirVec_lipschitz`, `reduced_mass_pos`, `total_angular_momentum_pos`, `semilatusRectum_pos` | proved (new this iter) |

The chapter's informal proof sketches for `orbit_eq_conic` and
`binet_ode` should note the actual routes (arccos quadrature for the
conic; conic ansatz for Binet) when the sync next touches the chapter.

## Redraft needed

**None.** The formalization is internally consistent, figure-faithful,
countermodel-clean — and now fully proved with no remaining
obligations. No statement-level defects remain; no Mathlib gaps are
relied upon (the ODE-uniqueness step was proved inline in
`harmonic_solution_on_interval` via the `d² + d'²` first integral, and
the Kepler/Binet development is the explicit lemma layer above).

## Session notes for future lanes (tactic-level, this Mathlib)

- Root names: `Ioo_mem_nhds`, `Ioo_mem_nhdsLT_of_mem`,
  `Ioo_mem_nhdsGT_of_mem`, `IsMaxOn.isLocalMax`; `𝓝[<]`/`𝓝[>]` are
  `scoped[Topology]` — write `nhdsWithin t0 (Set.Iio t0)` etc. unless
  `open Topology`.
- `ne_of_lt : a < b → a ≠ b` (smaller ≠ larger); for `x ≠ -1` from
  `-1 < x` use `ne_of_gt`.
- `ContDiff.const_mul` does not exist here; use
  `ContDiff.mul contDiff_const h`. Ascribing `ContDiff ℝ 2 f` unfolds to
  the `∃ p, HasFTaylorSeriesUpTo ...` existential — re-head with `show`
  before dot-notation chains.
- `field_simp` may fully close the goal — no trailing `ring`.
- `convert h using 1; ring` on `HasDerivAt` function-value goals can
  leave function equalities `ring` can't close; restate the derivative
  value in the raw chain-output form (`0 + c * (-sin x * 1)`) and
  `exact` the chain instead (beta-defeq).
- `linear_combination` residual rule (memory): on failure the residual
  shows `ring_nf(goal - c·h)`; correct coefficient is
  `c + residual/(h.lhs - h.rhs)`.
- `rw` cannot see through beta-redexes (`(fun y ↦ ‖S.sep y‖^2) y`) —
  use `show <reduced>` or explicit type ascriptions.
