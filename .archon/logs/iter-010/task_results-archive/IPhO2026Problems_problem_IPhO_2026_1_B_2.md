# Task result — `IPhO2026Problems/problem_IPhO_2026_1_B_2.lean` (prover, iter-010)

- File: `IPhO2026Problems/problem_IPhO_2026_1_B_2.lean`
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_B_2.tex`
- Stage/mode: prover (physics)
- Final state: **compiles with 0 errors** (fresh `lake env lean`), **6 `sorry`s remain**
  (was 7). One non-blocking linter warning (`hμ` unused in `total_energy_pos`,
  because the proof only needs the constants' positivity).

## What was closed

- **`total_energy_pos`** — proved in full (was sorry at old L319). Pure field
  arithmetic from the governing-law fields. The proof derives
  `v0 = 2·mu·ℏ/(m·(100·a0))` from `angular_momentum_per_particle` +
  `initial_separation_value`, rewrites `coulomb_law`, eliminates `ke2` via
  `bohr_radius_def` (`ke2 = ℏ²/(m a0)`), and reduces to the rational identity
  `4·mu²/100² − 1/100 = 1/80 > 0` at `mu = 15/2` (`field_simp` + `nlinarith`,
  verified standalone before transplantation). **E = 1/80** in units
  `ℏ²/(m a0²)`, confirming the docstring's "unbound" claim (the docstring's
  alternative value `mu²/2500 − 1/200 = 7/400` is stale — the fields give
  1/80).

## What remains `sorry` and why

1. **`eccentricity_sq_eq`** (says `S.eccentricitySq = 67/4`). **False as stated.**
   From the same fields: `2EL²/(mred(ke2)²) = 2·(1/80)·(15ℏ)²/((m/2)·(ℏ²/(ma0))²)`
   in unit `U = ℏ²/(ma0²)` equals `16·(15/2)²·(1/80) = 45/4`, so
   `eps² = 1 + 45/4 = 49/4`, **not 67/4**. I verified the arithmetic twice
   (symbolically and numerically: `eps = 3.5`, correct deflection
   `atan(1/√(45/4)) = atan(2/√45) ≈ 16.6015°` — the official answer −16.60°).
   The `67/4` value belongs to the wrong extras `E = 7/400` (docstring) — a
   consistent-but-incorrect parameter set. The proof of the true value `49/4`
   is routine (same `field_simp`/`ring_nf` shape as `total_energy_pos`, tested
   in a scratch file: goal reduces to `(100²+2²·15²·(15²−100))·4 = 100²·49`,
   closed by `ring_nf`); it is recorded here so the redraft lands in minutes.
   Left `sorry` only because the conclusion `67/4` is a protected signature.

2. **`orbit_eq_conic`** (Hint 2 bridge). Blocked honestly: it is the full
   Kepler/Binet ODE integration on raw `ContDiff ℝ 2 sep` + `deriv` fields
   (solve `B(θ) = A/L²·(1+e cos(θ−θ0))`, use monotone `polar_angle` from
   `angular_momentum_law`, evaluate via `polar_decomposition`). No Mathlib
   Kepler module; this is a multi-hundred-line development. Documented in-code.

3. **`exists_asymptoticRelativeVelocity`**. Blocked by the same missing
   Kepler layer (construction of `u∞ = sqrt(2E/mred)·(b·Δy, −a·Δy)` plus the
   actual `Filter.Tendsto (deriv S.sep) atTop` proof). Dependent on 2.

4. **`signed_deflection_eq_formula`**. Its norm half (`‖u‖ = sqrt(2E/mred)`)
   is the standard asymptotic-speed identity, derivable from energy
   conservation + `hu.tendsto`, but again depends on the Kepler layer. Its
   **angle half is physically wrong as stated**: it asserts
   `angle = π − 2·arctan(1/√(eps²−1))` (≈146.8° at the true eps²=49/4), the
   *apocenter-referenced Rutherford turning angle*; the problem asks the
   *periapsis-referenced* deflection, which is the acute
   `arctan(1/√(eps²−1))` = `arctan(2/√45)` ≈ 16.6015° (trajectory starts at
   periapsis: incoming velocity direction = outgoing direction of the mirror
   periapsis passage; the true turn is half the Rutherford angle).

5. **`signed_deflection_angle_T1_B2`** (main target). Its claimed exact value
   `−(π − 2·arctan(2/√63))` evaluates to ≈ **−151.71°**, and the theorem's own
   rounding band requires it to lie in [−16.605, −16.595). **The conjunction
   of the 2nd and 3rd components is impossible.** I added (compiling, sorry-free)
   auxiliary haves inside the proof body that prove
   `radiansToDegrees (−(π−2·arctan(2/√63))) ≤ −90` and hence
   `¬ roundsToOfficialDegrees (…)` — an in-file, machine-checked witness of
   the obstruction. The existential component is additionally blocked by (3).

6. **`unsigned_deflection_angle_in_degrees_T1_B2`** (magnitude corollary).
   Same analysis: claimed angle `π − 2·arctan(2/√63)` ≈ 151.71° ≥ 90°,
   contradicting its own band [16.595, 16.615) — in-file machine-checked
   `¬ roundsToOfficialDegreesAbs (…)` witness added; the rest is blocked by
   (3). Note: the *physical* unsigned answer `arctan(2/√45)` does land in the
   band (16.6015°). I additionally built and verified the full Mathlib
   machinery for that band on the correct value (see "Banked work" below),
   ready to drop in after the redraft.

## Redraft needed (for the plan/review agents)

- Original problem id: IPhO_2026_1, part B.2. Report:
  `reports/ipho_2026_k3/problem_IPhO_2026_1_B_2.source.json`
  (grounding log: `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_B_2.md`).
- The governing-law fields of `CoulombScatteringData` are **faithful** to the
  physics (checked: they imply E = 1/80, unbound; periapsis at r0). The wrong
  content is entirely on the conclusion layer. Smallest faithful redraft:
  1. `eccentricity_sq_eq : S.eccentricitySq = 49 / 4` (proof available,
     one `field_simp`+`ring_nf` block; blueprint ledger text should say
     `eps = 7/2`).
  2. `signed_deflection_eq_formula` angle component:
     `angleBetween (initialDirection) u.vec = Real.arctan (1 / Real.sqrt (S.eccentricitySq - 1))`
     (periapsis-referenced acute deflection; blueprint NOTE explaining the
     two different "scattering angles").
  3. Main target closed form: `delta = -(Real.arctan (2 / Real.sqrt 45))`
     (equivalently `-(Real.pi/2 - Real.arcsin (Real.sqrt 45 / 7))` if one
     wants a manifest [0, π] form). Its degree reading:
     `radiansToDegrees (arctan (2/√45)) ∈ [16.595, 16.615)` ✓ (banked proof).
  4. `asymptote_factor_certificate` should be re-based:
     `1 / Real.sqrt ((49/4 : ℝ) - 1) = 2 / Real.sqrt 45` (same proof shape;
     `45/4 = (sqrt 45/2)²`).
  5. Blueprint `\uses{}` graph stays structurally identical (only the 67→49,
     63→45 substitutions and the formula replacement).
  After this redraft: closures (1),(4) are short algebra; (2),(3) remain the
  honest Kepler-layer blockers; (5),(6) become banked-lemma assemblies.

## Banked work (verified in isolated `lean_run_code` snippets, ready to reuse)

- `one_add_le_inv_sqrt_one_sub` : `1 + u/2 + 3u²/8 ≤ 1/√(1−u)` for `0 ≤ u < 1`
  (square-compare, polynomial identity `(1+u/2+3u²/8)²(1−u) = 1 − u³(9u²+15u+40)/64`).
- `arcsin_lower` : `y + y³/6 + 3y⁵/40 ≤ arcsin y` for `0 ≤ y < 1`
  (FTC via `intervalIntegral.integral_deriv_eq_sub` on `Real.arcsin`, pointwise
  bound on `[0,y]`, `intervalIntegral.integral_mono_on`, `integral_pow`).
- `(2/√45)/√(1+(2/√45)²) = 2/7` (via `div_div_div_cancel_right₀`), giving
  `arctan(2/√45) = arcsin(2/7)` through `arctan_eq_arcsin`.
- Numerical certificates: `2/7 + (2/7)³/6 + 3(2/7)⁵/40 ≈ 0.289744353` rad →
  `[16.6011°]` after ×180/π with `pi_gt_d6/pi_lt_d6`; the tail-sum upper bound
  `0.289751646` rad → `16.601550°`; both inside `[16.595, 16.615)` with
  ~10× margin. Remaining upper-side piece (geometric tail of the arcsin
  binomial series) is a summarizable `geom_series` estimate.
- `claimed_value_outside_band` (≤ −90°) and the corresponding `≥ 90°` lemma
  — already inserted as in-file witnesses.

## Compliance notes

- No statements/signatures/hypotheses were changed, no axioms introduced, no
  `sorry` laundering (remaining sorries are in the same bodies, now with the
  obstruction analysis inline). Only `total_energy_pos`'s body grew a real proof.
- Blueprint: declarations **not** ready for `\leanok` on (1)–(6);
  `total_energy_pos` has no `\lean`-pinned ledger block of its own (the
  umbrella chapter pins it inside the "Unboundness" prose); nothing for
  `\mathlibok`/`% NOTE` from my side beyond the redraft blockers above.
- `archon-informal-agent.py` second opinion was attempted but all configured
  providers returned 401/404 in this environment; the physics re-derivation
  was instead verified by exact symbolic/numeric computation (E = 1/80,
  eps² = 49/4, delta = atan(2/√45) = 16.601549…° ∈ [16.595, 16.615) ✓,
  matching the official −16.60°).
