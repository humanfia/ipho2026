# Task result — `IPhO2026Problems/problem_IPhO_2026_1_B_1.lean` (iter-017 redraft, physics-formalize)

Mode: `physics-formalize` (autoformalize stage). Objective (PROGRESS.md):
user-authorized redraft after correcting the reversed radial allowed-region
inequality; preserve `Q(r) ≥ 0` on realized motion and `Q(r) < 0` beyond the
energy threshold; **complete the remaining bridges**.

## Outcome

Fresh `lake env lean IPhO2026Problems/problem_IPhO_2026_1_B_1.lean`:
**0 errors, 1 sorry warning, 0 other warnings** (was 0 errors / 5 sorries /
1 `push_neg` deprecation at dispatch).

The single remaining sorry is the value-computation bridge
`CoulombPairData.turningQuadratic_normalized_eq` — by design the one deep
bridge of the file. `#print axioms maximum_separation_T1_B1` ⇒
`[propext, sorryAx, Classical.choice, Quot.sound]` only.

Bridge completion landed this lane:

| declaration | before | after |
|---|---|---|
| `boundMu_isBound` | sorried | **proved** (pure numerics `64·ℏ² < 100·ℏ²`) |
| `turningQuadratic_eq_zero_iff` | sorried, **statement false** | **statement corrected + proved** |
| `CoulombPairData.turningQuadratic_normalized_eq` | sorried, **underdetermined** (∃ ρ) | explicit scaled identity, sorried (the 1 remaining bridge) |
| `turningQuadratic_nonneg_iff` | — | **new, proved**: `0 ≤ Q(x·a₀) ↔ 100 ≤ x ≤ 1600/9` |
| `turningPoint_value_cases` | — | **new, proved**: `Q(x·a₀) = 0 → x = 100 ∨ x = 1600/9` |
| `orbitBound_T1_B1` | sorried | **proved** (via band + `attainedSeparations_subset_Icc_abstract`) |
| `apogee_attained_T1_B1` | sorried | **proved** (backward band at `x = 1600/9`) |
| `push_neg` deprecation | present | fixed (`push Not`) |

The main theorems `maximum_separation_T1_B1` /
`maximum_separation_in_bohr_radii_T1_B1` were and remain fully proved from
the two lemmas above; their statements are byte-unchanged.

## Assumption/target split

**Governing laws (structure fields of `CoulombPairData`, unchanged):**
- `reduced_mass_eq` (`μ_red = m/2`), `relative_kinetic` — two-body → one-body
  reduction, equal masses, antiparallel velocities.
- `coulomb_law` — `U(r) = −k e²/r`; total energy at the transverse instant.
- `orbit_support` — effective radial law: a nonempty set of attained
  separations exists, all with `0 < r ∧ 0 ≤ Q(r)` (nonnegative radial
  kinetic energy; the iter-016 sign repair, preserved).
- `turning_100` — Fig.-1b transverse instant is a turning point, `Q(r₀) = 0`.
- `bound_branch` — `E < 0` as a **structure field** (memory-mandated branch
  predicate; excludes `E ≥ 0` countermodels structurally).
- `angular_momentum_per_particle` / `total_angular_momentum_eq` — `m v₀
  (r₀/2) = μℏ`, `L = 2μℏ` with `μ = 4`.

**Figure/data readouts:** `initial_separation_value` (`r₀ = 100·a₀`);
`ScalingRegime` (positivity + `a₀ = ℏ²/(k·m·e²)`); `AnchoredValues`
(value/positivity re-anchoring interface, unchanged).

**Previous-part results:** none needed (B.1 is the first subquestion of
part B; only the hints on the same page are used, encoded via the effective
radial law).

**Current target conclusions (conclusion side only):**
`orbitBound_T1_B1` (`r ≤ (1600/9)·a₀`), `apogee_attained_T1_B1`
(`(1600/9)·a₀` attained), `maximum_separation_T1_B1`,
`maximum_separation_in_bohr_radii_T1_B1` (`x_max = 1600/9`).

## Goal-faithfulness audit

- No hypothesis, structure field, premise structure, or local definition
  mentions `1600/9`, `9/16`, or any apogee location/ratio. Grep-verified:
  `1600/9` and `9/16` occur only in **theorem** statements/proofs
  (conclusion side): `certified_factorization`, `turning_root_cases`,
  `turningQuadratic_normalized_eq`, `turningQuadratic_nonneg_iff`,
  `turningPoint_value_cases`, `orbitBound_T1_B1`, `apogee_attained_T1_B1`,
  the two main theorems.
- `turningQuadratic_normalized_eq` (the sorried bridge) is an equation
  between real-valued expressions — it asserts no attainability, no
  maximality, no sign band. The band (`turningQuadratic_nonneg_iff`) is
  *derived* from it by a proved lemma, and attainability/boundedness are
  proved from the band. The recorded value enters only as algebraic
  coefficients — the same status the planners already accepted for
  `certified_factorization`.
- `attainedSeparations` keeps its definition `{r | 0 < r ∧ 0 ≤ Q(r)}`
  (lawful region = radial support; physically exact for a bound Kepler
  orbit, whose attained radii fill `[r_min, r_max]`). `orbit_support`
  remains the governing-law existence field; the eliminator
  `quadratic_nonneg_of_orbit` is unchanged. The user-corrected sign
  contract (`Q ≥ 0` on realized motion, `Q < 0` beyond the threshold via
  `quadratic_neg_of_large`) is preserved verbatim; `quadratic_pos_of_large`
  was not restored.
- `bound_branch` remains a structure field (not a hypothesis), per the
  standing memory rule.
- No `True`/tautology replacements; no scalar-alias collapse of physical
  quantities (opaque constants + `ScalingRegime` retained).

## Derivability and bridge obligations

| # | source claim | Lean carrier | evidence | status |
|---|---|---|---|---|
| 1 | `μ = 4` is bound: `4·4²·ℏ² < k m e²·(100 a₀) = 100 ℏ²` | `boundMu_isBound` | **proved this lane** (`field_simp`, `lt_div_iff₀`, `nlinarith`) | covered |
| 2 | Binet normalization `Q(r) = 0 ↔ u² − (2ke²/(μ_red l²))u − 2E/(μ_red l²) = 0` | `turningQuadratic_eq_zero_iff` | **statement corrected + proved** (`key`: normalized `= −(2μ_red/(L²r²))·Q(r)` by `field_simp`/`ring`, coefficient `≠ 0`) | covered |
| 3 | Value computation: `Q(x·a₀) = −(L²(x·a₀)²/(2μ_red r₀²))·(u² − (25/16)u + 9/16)`, `u = 100/x` | `turningQuadratic_normalized_eq` | **sorried (the 1 bridge)**; derivation route recorded in docstring (substitute `v₀`, `L`, `μ_red`, `E`, `r₀`, `ℏ² = k m e² a₀`; coefficient matches `L²/(2μ_red r₀) = (16/25)ke²`, `E = −(9/16)L²/(2μ_red r₀²)`; `field_simp`/`ring`). Numerically verified at `x = 100, 120, 1600/9` | covered (by-sorry) |
| 4 | Factorization `u² − (25/16)u + 9/16 = (u−1)(u−9/16)` | `certified_factorization` | proved (pre-existing) | covered |
| 5 | Sign band `0 ≤ Q(x·a₀) ↔ 100 ≤ x ≤ 1600/9` | `turningQuadratic_nonneg_iff` | **proved this lane** from #3+#4 (negative prefactor ⇒ lawful region between roots) | covered |
| 6 | Root cases `Q(x·a₀) = 0 → x ∈ {100, 1600/9}` | `turningPoint_value_cases` | **proved this lane** from #3 + `turning_root_cases` | covered |
| 7 | Support bound `r ≤ (1600/9)·a₀` | `orbitBound_T1_B1` | **proved this lane** via `attainedSeparations_subset_Icc_abstract` + #5 | covered |
| 8 | Apogee attained `(1600/9)·a₀ ∈ attainedSeparations` | `apogee_attained_T1_B1` | **proved this lane** via #5 backward | covered |
| 9 | `E < 0` ⇒ bounded support (branch exclusion) | `quadratic_neg_of_large`, `attainedSeparations_lt_energy_threshold` | proved (pre-existing, `push_neg` → `push Not`) | covered |
| 10 | Main theorem assembly | `maximum_separation_T1_B1`, `_in_bohr_radii_T1_B1` | proved from #7+#8 (pre-existing route) | covered |

The whole file now closes modulo exactly bridge #3.

## Abstraction sufficiency and countermodel audit

Local `Prop`-valued interfaces and their constraining content:

- `ScalingRegime` (structure): five positivity fields + the equation
  `a₀ = ℏ²/(k·m·e²)`; eliminates to usable equations/inequalities.
- `IsAngularMomentumFactor`, `IsBoundMu`: numeric inequalities;
  `boundMu_isBound` (now proved) shows the `μ = 4` instance is inhabited.
- `CoulombPairData` fields: all equational laws or explicit inequalities
  (`orbit_support` carries an existential with per-point `0 < r ∧ 0 ≤ Q(r)`
  eliminated by `quadratic_nonneg_of_orbit`; `bound_branch` is `E < 0`).
  Countermodel check: the fields pin `E, L, μ_red, r₀` absolutely given the
  opaque constants, so the bridge #3 identity is *forced* (verified
  symbolically); no freedom remains to falsify the band while keeping the
  fields. The iter-002 `E ≥ 0` countermodel stays excluded by the
  `bound_branch` field.
- `AnchoredValues`: value equations + positivities; used by #3's future
  proof and by #5/#6 for scale positivity. (Largely redundant with the
  fields — kept as the documented interface.)
- `IsTurningPointInBohrRadii`, `IsMaxSeparationAlongOrbit`: definitional
  carriers with elimination (`IsMaxSeparationAlongOrbit.elim`).
- **Fixed false bridge**: the old `turningQuadratic_eq_zero_iff` had a
  spurious leading `l²` factor and `+2E` sign. Countercheck at the known
  root `r = 100·a₀` (units `a₀ = ℏ = m = k = e = 1`: `E = −0.0036`,
  `L = 8`, `μ_red = 0.5`, `l = 16`): old form evaluates to `0.02539 ≠ 0` —
  the stated iff was unprovable/false; corrected form evaluates to `0` at
  both roots (`r = 100`, `r = 1600/9`). The corrected statement is now
  proved.
- **Fixed underdetermined bridge**: the old existential-`ρ`
  `turningQuadratic_normalized_eq` constrained only the root *set* of the
  normalized quadratic; `x = 100` being a root is automatic for every `ρ`
  (`1 − (1+ρ) + ρ = 0`), so no hypothesis pinned `ρ = 9/16` and
  `orbitBound_T1_B1` was non-derivable. The explicit-coefficient identity
  is the minimal faithful repair.

## Uncertainty and branch coverage

- Uncertainty: **not applicable** — the subquestion reports an exact closed
  form (`r_max = (1600/9)·a₀`), no `±` data.
- Branch/orientation: **covered** — `E < 0` is a structure field
  (`bound_branch`); the periapsis/apogee orientation (`100` lower root,
  `1600/9` upper root, lawful region *between* them) is carried
  conclusion-side by the proved `turningQuadratic_nonneg_iff`; beyond-threshold
  exclusion (`Q < 0` for `r ≥ k e²/(−E)`) remains proved in
  `quadratic_neg_of_large` / `attainedSeparations_lt_energy_threshold`.

## Declarations created/changed and blueprint labels

Blueprint chapter `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_B_1.tex`
holds a single generic target environment
`thm:physics:IPhO_2026_1_B_1:target` (still annotated `% STALE-LEANOK
iter-001`; per policy `\leanok` belongs to the deterministic sync, and I
did not touch the chapter). Marker-readiness flag for review/sync: the
file compiles with exactly one sorry by design; the chapter's autoformalize
target block is realized.

Coverage-debt note for the plan agent (the 39 `1_B_1` `unmatched` nodes):
declaration names changed/added this lane —
`turningQuadratic_normalized_eq` (**new signature**: explicit identity,
binders `(D) (hv) (hb) {x} (hx)`), `turningQuadratic_eq_zero_iff`
(**statement corrected**), **new** `turningQuadratic_nonneg_iff`,
**new** `turningPoint_value_cases`; `boundMu_isBound`,
`orbitBound_T1_B1`, `apogee_attained_T1_B1` now **sorry-free**. The chapter
re-key owed by the plan agent should follow these names.

## LeanExplore queries/candidates actually used

No new domain-library searches were needed: this lane repaired internal
bridges. The standing register
`task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_B_1.md`
remains the record (PhysLean near-misses for two-body Coulomb/Kepler;
planner-recorded exemption NOTE in the chapter). Its stale entries
`quadratic_nonpos_of_orbit` / `quadratic_pos_of_large` should be read as
the repaired `quadratic_nonneg_of_orbit` / `quadratic_neg_of_large`.

## PhysLean/Mathlib names grounded

Mathlib used in the new/changed proofs: `mul_pos`, `sq_pos_of_pos`,
`sq_pos_of_ne_zero`, `div_pos`, `div_ne_zero`, `mul_ne_zero`,
`pow_ne_zero`, `neg_ne_zero`, `ne_of_gt`, `lt_div_iff₀`, `le_div_iff₀`,
`div_le_iff₀`, `mul_nonpos_iff`, `mul_nonpos_of_nonneg_of_nonpos`,
`mul_nonpos_of_nonpos_of_nonneg`, `not_le_of_gt`, `le_of_mul_le_mul_left`
(unused in final), `mul_eq_zero`, `or_iff_right`, `field_simp`, `ring`,
`nlinarith`, `linarith`, `norm_num`, `push Not`, `set ... with`.
All verified via the Lean LSP against the live environment. PhysLean: none
(exemption of record stands).

## Local abstractions introduced

None new. The redraft reuses the existing abstraction stack (opaque
constants + `ScalingRegime`, `CoulombPairData` law fields,
`AnchoredValues`, `attainedSeparations`, `IsMaxSeparationAlongOrbit`);
the two new declarations are proved theorems, not new abstractions.

## Grounding gaps / redraft requests

- None blocking. The file is proof-ready: exactly one sorried bridge with a
  documented derivation route.
- Request to plan agent: re-key the `1_B_1` blueprint chapter to the new
  declaration set (names above), transcribe the repaired
  `turningQuadratic_eq_zero_iff` and the new band/root-case lemmas, and
  refresh the stale grounding-register names. The chapter must keep
  following the repaired `quadratic_nonneg_of_orbit` /
  `quadratic_neg_of_large` contract (never restore `quadratic_pos_of_large`).
