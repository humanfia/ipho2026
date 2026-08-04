# Task result: `IPhO2026Problems/problem_IPhO_2026_2_B_1.lean`

- Mode: physics-formalize (autoformalize, by-`sorry` formalization — no proof attempt)
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_B_1.tex` (contains `% archon:physics`; umbrella label `thm:physics:IPhO_2026_2_B_1:target`)
- Source report: `reports/ipho_2026_k3/problem_IPhO_2026_2_B_1.source.json`
- Source page image inspected: `T2_page-3.png` (Figure 2f + T2-B1/B2/B3 statements)
- Status: **`lake env lean` exits 0; only the 4 expected `sorry` warnings** (lemmas `impactParam_eq_sin`, `sin_two_pos`; theorems `container_radius_at_extremal_angle`, `alpha_beta_in_terms_of_R`).

## Assumption/target split

**Governing laws (hypothesis-side).**
- Specular reflection on the circular mirror profile: `CookerB1.reflection_law` — the reflected line passes through the mirror point `(x, -√(R²-x²))` and its direction is the mirror reflection of the incoming axial direction `(0,-1)` in the tangent line, stated as the 2×2 incidence system
  `-y = m·x + b ∧ m·(2xy) = -(y²-x²)` (`y = -√(R²-x²)`) — *not* as the solved slope formula given in part C.1.
- Absorption law: `CookerB1.absorbed_law` (every family ray's reflected line meets the container disc).
- Container/mirror geometry (Figure 2f readout): `A_coord : A = (0, -(R/2))`, `C_coord : C = (0,0)`, `mirrorSet` = lower half-circle of radius `R`, `containerSet` = closed disc of radius `a` about `A`. Orientation note: the frame (sunlight along `(0,-1)` onto the `y ≤ 0` half, container on the `-y` side toward the mirrored belly, symmetry plane ↦ `y`-axis) is fixed by Figure 2f and cross-checked against the official B.2/B.3 answers (`P/P₀ = 1/(1-cos θ_max)`; `a = 2.5 cm` at `P = 5P₀`, `R = 1 m`).
- Single-bounce bookkeeping: `hitSet` (impact parameters of rays absorbed after exactly one reflection) with `on_mirror`, `hit_branch` (`|x| < R`), `no_gap` (contiguous centred fan — symmetric under `x ↦ -x`).

**Figure/data readouts (hypothesis-side).**
- `IsThetaMax`: `θ_max` is attained by an absorbed ray, bounds all absorbed incidence angles, acute branch `(0, π/2)`.
- `ExtremalRaySpec`: extremal column `x ∈ hitSet` realizes `θ_max`; `off_axis : x ≠ 0` (tangent columns are the mirror-image pair `±|x|`); `tangent_dist : |distToLine (line x) A| = a` — the limiting ray is tangent to the container circle (the extremality bridge: maximizing `θ(x) = arcsin(|x|/R)` amounts to maximizing `|x|` over the fan, so the extreme ray is tangent).
- `SecondExtremalConfig`: the same-mirror-radius family contains an extremal configuration at a different angle (the later problem parts vary `a` at fixed `R`); the ansatz's universality is what makes `(α, β)` unique.

**Previous-part results.** None — B.1 is the first subquestion of part B (`previous_parts: []` in the source report). B.1's own statement (`a = R sin θ_max − (R/2) sin 2θ_max`) is conclusion-side here; sibling B.2 restates it locally as its `B1Calibration` hypothesis.

**Current target conclusions (conclusion-side only).**
- `container_radius_at_extremal_angle`: `a = R·sin θ − (R/2)·sin (2θ)` at the extremal angle.
- `alpha_beta_in_terms_of_R` (target, `thm:physics:IPhO_2026_2_B_1:target`): `α = R ∧ β = -R / 2`.

## Goal-faithfulness audit

- `α, β` appear only as free real parameters constrained by `CoeffSpec`, which states *the given ansatz* (`a = α sin θ' + β sin 2θ'` at extremal configs of the same-`R` family) — the problem's premise, not its answer. The recorded values `R`, `-R/2` occur nowhere in any structure field, hypothesis, `Laws`/`Valid`/`Satisfies`-style predicate, or local definition; they appear only in the target theorem's conclusion.
- `CoeffSpec` is not the answer in disguise: it quantifies over arbitrary `(α, β)` and says nothing about their values; instantiated at `(α, β) = (0, a·k)`-type junk pairs it is simply false, and the proof obligation of the target is exactly to compute the pair.
- `reflection_law` is the physical law of reflection as incidence data (through-point + specular direction), a 2×2 linear system of determinant `-(2x)(x²+y²) ≠ 0` — it constrains `(m, b)` but does not contain the target identity (verified: substituting the solved `m = -tan 2θ`, `b = -R/(2 cos θ)` is a derivation, not an unfolding).
- `ExtremalRaySpec.tangent_dist` involves `a` but only as the *tangency distance* (a physical incidence condition), from which the identity still has to be derived; it cannot be specialized to the answer formula because it speaks of `a` and line data, never of `sin (2θ)` coefficients.
- No `rfl`/unfolding closes anything substantive: all four substantive declarations end in explicit `sorry`.

## Derivability and bridge obligations

| Source claim | Lean carrier | Status | Evidence / proof route |
|---|---|---|---|
| `θ(x) = arcsin(|x|/R)`; extremal angle ⇔ extremal column; `|x| = R sin θ_max` | `incidenceAngle`, `IsThetaMax`, `impactParam_eq_sin` | covered (by-sorry lemma) | `arcsin` monotonic on `[0,1]`; absolute value absorbs the `±x` mirror branches. |
| Law of reflection on the circle solves to a 2×2 system on `(m, b)` | `CookerB1.reflection_law` | covered (hypothesis) | At extremal `x ≠ 0`, determinant `-(2x)(x²+y²) = -(2x)R² ≠ 0`; solve: `b = -R²/(2√(R²-x²))` (always negative, `|b| ≥ R/2`), `m x = (y²-x²)/(2xy)`. |
| Limiting ray tangent to the container circle | `ExtremalRaySpec.tangent_dist` | covered (hypothesis, figure/maximality readout) | `distToLine` is the standard point-line signed distance; tangency = distance-`a` from `A`. |
| `a = R sin θ − (R/2) sin 2θ` at the extremal angle | `container_radius_at_extremal_angle` | covered (by-sorry theorem) | With `A = (0,-R/2)`: signed numerator is `-R/2 - b > 0` (no sign branch lost); `|dist|` evaluates to `(|x|·R - R²/2)/√(R²-x²)` = `R sin θ − (R/2)·2 sin θ cos θ` via `impactParam_eq_sin` and `sin_two_pos` ⇒ `cos θ > 0`; double-angle elimination. |
| Coefficient pair is unique; `α = R ∧ β = -R/2` | `alpha_beta_in_terms_of_R` | covered (by-sorry theorem) | Tangency identity at the two distinct extremal angles `θ ≠ θ₁` (`SecondExtremalConfig`) minus `CoeffSpec` there gives a 2×2 homogeneous system in `(α-R, β+R/2)` with determinant `2 sin θ sin θ₁ (cos θ₁ - cos θ) ≠ 0` (`strictAntiOn cos` on `(0, π/2)`), forcing both factors to vanish. |

No bridge is blocked: every nontrivial source step has a named Lean carrier, and the main theorem contract lists the full hypothesis stack it needs.

## Abstraction sufficiency and countermodel audit

- `CookerB1` (structure with Prop fields): constrained by through-point/specular equations (`reflection_law`, 2×2, nonzero determinant off-axis), membership equations (`on_mirror`, `absorbed_law`), and fan topology (`no_gap`, `hit_branch`). Countermodel check: arbitrary `reflectedLine` data fails `reflection_law` (e.g. constant `m, b` cannot satisfy the system at two distinct columns); arbitrary tiny `hitSet` fails `no_gap`. Constraining.
- `ExtremalRaySpec`: fields `hx`, `hθ`, `off_axis`, `tangent_dist` jointly pin the extremal column to `|x| = R sin θ` with the reflected line at distance `a` from `A`; combined with `reflection_law` the line data is fully determined, so the interface cannot be witnessed by arbitrary lines. Constraining; elimination is direct field projection.
- `CoeffSpec`: exposes the usable consequence `q.a = α sin θ' + β sin 2θ'` at every extremal configuration — exactly the equations the target proof consumes. Not satisfiable vacuously *and* answer-falsifying simultaneously, because `SecondExtremalConfig` supplies a second genuine configuration and the 2×2 determinant is nonzero.
- `IsThetaMax`: exposes attainment + bound + branch-inequality consequences across the whole fan. Constraining (bounds every column's angle).
- `Line2D`/`distToLine`: concrete real-valued geometry, the standard non-vertical-line distance; not an opaque relation.

Conclusion-side statutes double-checked: no hypothesis list contains `α = R`, `β = -R/2`, or the identity `a = R sin θ_max − (R/2) sin 2θ_max` at the *same* configuration where the target requires it — the identity appears only as the conclusion of `container_radius_at_extremal_angle`.

## Uncertainty and branch coverage

- Uncertainty: **not applicable** — the source reports an exact symbolic answer with no `±` error data.
- Branch/orientation: **covered**. Frame orientation (`A = (0, -R/2)`, sunlit half `y ≤ 0`) recorded from Figure 2f and cross-checked against the official B.2/B.3 answers; the `±x` mirror-image tangent branches are absorbed by `|x|` in `incidenceAngle`/`impactParam_eq_sin`; the signed-distance sign is shown (in the header and `sin_two_pos` obligations) to be uniformly `-R/2 - b > 0`, so no unrecorded case split remains; acute branch `θ_max ∈ (0, π/2)` is in `IsThetaMax`; the incoming/outgoing ray orientation is fixed by `reflection_law`'s specular direction.

## Declarations created ↔ blueprint labels

- `IPhO2026_2_B_1.Vec`, `vnorm`, `Line2D`, `distToLine` — cross-section geometry helpers (no blueprint label yet).
- `CookerParams` — dimensionful parameters `R, a > 0`.
- `CookerB1` — full Figure-2f specular/absorption bookkeeping structure.
- `incidenceAngle`, `IsThetaMax` — `θ_max` specification.
- `impactParam_eq_sin`, `sin_two_pos` — elementary flashpoint lemmas (sorry).
- `ExtremalRaySpec` — extremal/tangency interface; `SecondExtremalConfig` — family nondegeneracy interface.
- `CoeffSpec` — the given ansatz `a = α sin θ' + β sin 2θ'` (family form).
- `container_radius_at_extremal_angle` — the B.1 geometric identity (sorry).
- `alpha_beta_in_terms_of_R` — **target** (`thm:physics:IPhO_2026_2_B_1:target`; sorry).
- Blueprint chapter: already contained `% archon:physics` and the umbrella `theorem` environment; no `\lean{}` pins existed to mark (memory note: no `\lean{}` pins in this wave). The chapter's `theorem`/`proof` block describes the autoformalization task itself; the new declarations `alpha_beta_in_terms_of_R` (target) and `container_radius_at_extremal_angle` are the candidates for `\leanok` once the deterministic sync adds `\lean{}` pins. I did not edit the chapter (write permissions).

## LeanExplore queries / candidates actually used

- Query `law of reflection specular reflection optics mirror ray` (packages `[Mathlib, Physlib]`): candidates `EuclideanGeometry.reflection` (Mathlib), `Submodule.reflection`, `SameRay`, `EuclideanGeometry.oangle_pointReflection_right`. **Near miss** — all are algebraic/affine reflection APIs in inner-product spaces; encoding the circular-profile specular law through `EuclideanGeometry.reflection` in an affine subspace would add heavy instance machinery for no gain. Recorded the mismatch; used the explicit slope-intercept incidence system instead (same idiom family as the on-disk `problem_IPhO_2026_2_C_1.lean`, which also encodes the law in Cartesian slope data).
- Preflight grounding log (`.archon/task_results/physics-grounding-..._2_B_1.md`) returned only irrelevant hits (`Path.target`, `stereographic_target`, `semiformal_result`) — none used.

## PhysLean/Mathlib names grounded

- Mathlib (used): `Real.arcsin`, `Real.sin`, `Real.cos`, `Real.pi`, `Real.sqrt`, `Set.Ioo` — all standard, verified clean compile.
- PhysLean: **no usable optics/ray API found** for plane-mirror/circular-mirror specular reflection — recorded as a near miss; no PhysLean names used.

## Local abstractions introduced (and why they preserve physical meaning)

- `Vec := ℝ × ℝ` (abbrev, not scalar alias): keeps the 2-D cross-sectional geometry of Figure 2f; chosen over `EuclideanSpace ℝ (Fin 2)` only to keep coordinate equations tactic-light for the next (prover) stage — physically equivalent, units documented in docstrings.
- `Line2D` + `distToLine`: non-vertical reflected lines (verticality never occurs off-axis here; the `±π/2` columns are excluded by `hit_branch`) with the standard signed distance — the tangency/point-line language of the source.
- `CookerB1`, `ExtremalRaySpec`, `CoeffSpec`, `SecondExtremalConfig`: see the countermodel audit; each preserves a distinct physical role (setup/laws, extremal tangency, given ansatz, family nondegeneracy) and none hides the answer.

## Grounding gaps / redraft requests

- No PhysLean geometric-optics reflection API (gap on the Physlib side, worked around with explicit Cartesian incidence equations).
- No blueprint chapter changes requested; the chapter's umbrella `theorem` correctly describes this as an autoformalization task. Plan agent may wish to add a one-line informal derivation of `a = R sin θ_max − (R/2) sin 2θ_max` (tangent-ray solve sketched in this file's header) when the chapter is fleshed out.
