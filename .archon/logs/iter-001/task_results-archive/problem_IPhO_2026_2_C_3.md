# Task result: `IPhO2026Problems/problem_IPhO_2026_2_C_3.lean` (autoformalize, iter 001)

- Mode: `physics-formalize` (chapter contains `% archon:physics` — confirmed).
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_C_3.tex`.
- Source report: `reports/ipho_2026_k3/problem_IPhO_2026_2_C_3.source.json`.
- Figure read: `/root/proposal_for_physic/science-mango/ipho_2026_source/image/T2_page-4.png`
  (IPhO 2026 T2 page: Fig. 2g shows the half-cylindrical mirror, upper semicircle of
  radius `R` centred at the origin, ray A striking at incidence angle `θ`; T2-C3 asks
  for the intersection `(X_c, Y_c)` of the reflected rays of A and the parallel
  neighboring ray B at `θ + Δθ`, `Δθ ≪ θ`).
- Compile status: `lake env lean IPhO2026Problems/problem_IPhO_2026_2_C_3.lean`
  exits 0 with exactly one expected warning `declaration uses sorry` and no errors.
  (The file is deliberately not imported by `IPhO2026Run.lean`; only that root file
  is protected-convention context, and adding imports is done by the orchestrator.)

## Assumption/target split

- Governing laws / setup (figure Figure 2g):
  - geometry: reflecting upper semicircle of radius `R` centred at the origin —
    `Figure2gMirror`, `Figure2gMirror.OnReflectingSurface`;
  - reflected rays are affine lines `y = m x + b` with dimensionless slope and
    length-valued intercept — `ReflectedRayLine`, `ReflectedRayLine.Contains`.
- Previous-part results used as hypotheses (natural-language prerequisites only,
  no Lean import of C.1/C.2 files, per source policy):
  - C.1: `m_A = cot(2θ)`, `b_A = R/(2 cos θ)` — `hRayA_slope`, `hRayA_intercept`;
  - C.2: `m_B = cot(2θ) − 2 csc²(2θ) Δθ + O(Δθ²)`,
    `b_B = R/(2 cos θ) (1 + tan θ · Δθ) + O(Δθ²)` — encoded as genuine
    `=O[𝓝 0] (fun Δθ ↦ Δθ ^ 2)` hypotheses `hRayB_slope_firstOrder`,
    `hRayB_intercept_firstOrder` (asymptotic laws, not assigned functions).
- Figure/data readouts: none additional (no numeric data; `θ` acute and incidence
  geometry from Fig. 2g — `hθ_pos`, `hθ_acute`).
- Current target conclusions (conclusion side only):
  - `Tendsto (X_c-readout) (𝓝[≠] 0) (𝓝 (R · sin³ θ))`,
  - `Tendsto (Y_c-readout) (𝓝[≠] 0) (𝓝 ((R/2) cos θ (2 − cos 2θ)))`
  inside `limitingIntersectionCoordinates`. The limit values `R sin³θ` and
  `(R/2) cos θ (2 − cos 2θ)` appear nowhere in hypotheses, structure fields, or
  local definitions.

## Goal-faithfulness audit

- The recorded answer `X_c = R sin³θ; Y_c = (R/2) cos θ (2 − cos 2θ)` occurs only
  as the limit point in the `Tendsto` conclusions of the main theorem.
- Ray B's data is NOT fixed to its first-order Taylor polynomial: the would-be
  function `reflectedRayAtIncidenceAngle` is an arbitrary family parameter, and
  the C.2 expansions enter only as `IsBigO Δθ²` error laws — a proof must actually
  divide the line-intersection equation by `Δθ` and pass to the limit. A model
  where ray B is `m_B = 7θ³ + O(Δθ²)` would not satisfy the hypotheses, so the
  hypotheses do constrain the physics.
- No hypothesis asserts the intersection equals `(R sin³θ, ·)` nor that the
  limit holds; `hNeighboringIntersection` only says the two lines meet at the
  chosen point for small nonzero `Δθ` (existence/incidence, not the limit value).
- Theorem body is `by constructor <;> sorry` — the conjunction split is bookkeeping
  only and contains no mathematical content; both conjuncts remain open `sorry`s.
- Physical lengths are genuine Physlib `Dimensionful (WithDim Dimension.L𝓭 ℝ)`
  values, not `abbrev Length := ℝ`; real numbers appear only via the named
  `Figure2gLengthProjection.readout` projection (allowed for coordinate readouts).

## Derivability and bridge obligations

1. C.1 line data for ray A → substitution into the intersection equation.
   Carrier: `hRayA_slope`, `hRayA_intercept` (hypotheses). Status: covered
   (they are exactly the official reusable conclusions; figure-verified via
   `K₁ = 1, K₂ = 2, K₃ = 1, K₄ = 2` in the on-page hint).
2. C.2 first-order expansions → ordinary limits of difference quotients.
   Carrier: hypotheses `hRayB_*_firstOrder` (IsBigO `Δθ²`); bridge theorems
   `Asymptotics.IsBigO.trans_isLittleO` +
   `Asymptotics.IsLittleO.tendsto_div_nhds_zero` (Mathlib, names verified via
   local search / prior-run usage). Status: covered (statement-level).
3. Line intersection algebra: `x(Δθ) = −(b_B − b_A)/(m_B − m_A)` for `Δθ ≠ 0`
   with `m_B ≠ m_A` eventually (from bridge 2, slope quotient limit `≠ 0` since
   `sin 2θ ≠ 0` for `0 < θ < π/2`). Carrier: `ReflectedRayLine.Contains`,
   `IsNeighboringReflectedIntersection` + Mathlib field/ring lemmas. Status:
   covered.
4. Quotient limits → closed `X_c`: `X_c = −(b_A tan θ)/(−2 csc² 2θ) = R sin³θ`
   (uses `tan = sin/cos`, `sin 2θ = 2 sinθ cosθ`). Then `Y_c = m_A X_c + b_A =
   (R/2) cos θ (2 − cos 2θ)` (uses `cos 2θ` in one of its standard forms).
   Carrier: Mathlib trigonometry lemmas (`Real.tan_eq_sin_div_cos`,
   `Real.sin_two_mul`, a `Real.cos_two_mul*` variant). Status: covered
   (statement-level; exact `cos_two_mul` form to be chosen by the prover).
5. Direct source-to-contract mapping for the overall claim. Carrier:
   `limitingIntersectionCoordinates` (main theorem contract). Status: covered.

## Abstraction sufficiency and countermodel audit

- `Figure2gLengthProjection` + `readout`: pure projection interface; every
  physical equation (line containment, semicircle constraint, limits) is stated
  through readout equations, so unit choices cannot be gamed — the readout values
  obey Physlib's dimensional scaling (`Dimensionful`, `WithDim`, `UnitChoices`).
- `Figure2gMirror.radius_pos`: positivity in EVERY unit choice; constrains `R`
  to be a genuine nonzero length.
- `Figure2gMirror.OnReflectingSurface`: full incidence condition
  `x² + y² = R² ∧ 0 ≤ y` (provided as reusable geometry for the eventual proof;
  not needed as a hypothesis of the limit statement itself).
- `ReflectedRayLine.Contains`: the actual line equation `y = m x + b` — equality
  constraint, sufficient for the intersection algebra of bridge 3.
- `IsNeighboringReflectedIntersection`: conjunction of both line equations —
  exact incidence condition, no opacity.
- Countermodel check: hypotheses fix `m_A, b_A` exactly and `m_B, b_B` up to
  `O(Δθ²)` with the prescribed first-order terms; for any family satisfying them,
  the quotient analysis of bridges 2–4 forces the same limit. Conversely the
  hypotheses are satisfiable (the true ray family from the mirror-reflection law
  of parts A–B satisfies C.1–C.2). No underdetermination detected.

## Uncertainty and branch coverage

- Uncertainty (`±`): not applicable — the subquestion has an exact symbolic
  answer and no measurement uncertainties in the source.
- Branch/orientation: covered — acute-incidence branch `0 < θ < π/2` (the Fig. 2g
  geometry, ray A on the right half of the semicircle with `A` on the positive
  x-axis); `Δθ → 0` taken on `𝓝[≠] 0` so both signs of small `Δθ` are included,
  matching "limiting intersection". Incoming/outgoing orientation is already
  fixed by C.1's reflected-line convention and is not re-decided here.

## Declarations created (blueprint labels)

- `IPhO2026Problems.IPhO2026_2_C_3.PhysicalLength` (abbrev on Physlib
  `Dimensionful (WithDim Dimension.L𝓭 ℝ)`)
- `...Figure2gLengthProjection` (+ `.readout`)
- `...Figure2gMirror` (+ `.OnReflectingSurface`)
- `...Figure2gPoint`
- `...ReflectedRayLine` (+ `.Contains`)
- `...IsNeighboringReflectedIntersection`
- `...limitingIntersectionCoordinates` — main theorem (both bodies `sorry`).

Blueprint chapter update: appended a new environment
`thm:IPhO2026Problems_problem_IPhO_2026_2_C_3:limitingIntersectionCoordinates`
with `\lean{IPhO2026Problems.IPhO2026_2_C_3.limitingIntersectionCoordinates}`,
`\leanok`, and `\uses{thm:physics:IPhO_2026_2_C_3:target}`. The pre-existing
plan-agent environment `thm:physics:IPhO_2026_2_C_3:target` (meta "translate this
problem" statement) was left untouched, as instructed not to edit blueprint
content; the new label carries the actual formalized content. Recommended:
review agent may keep `\leanok` on the new theorem (file compiles; bodies are
intentionally `sorry` at this stage, so the deterministic sync_leanok may flip it
— that is expected for autoformalize).
`archon dag-query` was unavailable on PATH in this container, so the dependency
annotation was done manually from the chapter graph (previous parts C.1, C.2 are
natural-language prerequisites only).

## LeanExplore queries/candidates actually used

- `caustic envelope of reflected rays geometrical optics mirror reflection`
  → only generic `EuclideanGeometry.reflection` (reflection in an affine
  subspace) — near miss: our reflection is against a circular mirror with the
  local tangent law already encoded in the C.1 line data; not used.
- `Dimensionful WithDim physical length unit scaling Physlib`
  → `Dimensionful` (id 394284), `UnitChoices.dimScale`,
  `Dimensionful.of_scaleUnit`, `LengthUnit.scale` — used to confirm the Physlib
  idiom for the length type.
- `isBigO isLittleO trans asymptotics first order expansion limit division`
  → `Asymptotics.IsBigO.mul_isLittleO`, `Asymptotics.IsBigOWith.trans_isLittleO`,
  etc. — confirmed the Big-O/little-o API family for bridge 2.

## PhysLean/Mathlib names grounded

- Physlib: `Dimensionful`, `WithDim`, `Dimension.L𝓭`, `UnitChoices`
  (import `Physlib.Units.WithDim.Basic`; each name verified in
  `.lake/packages/PhysLean/Physlib/Units/`).
- Mathlib: `Real.cot`, `Real.tan`, `Real.sin`, `Real.cos`, `Real.pi`,
  `Filter.Tendsto`, `nhdsWithin` (`𝓝[≠]`), `Asymptotics.IsBigO` (`=O[𝓝 0]`),
  and (for the later proof) `Asymptotics.IsBigO.trans_isLittleO`,
  `Asymptotics.IsLittleO.tendsto_div_nhds_zero`, `Real.tan_eq_sin_div_cos`,
  `Real.sin_two_mul` — all names exist in the pinned Mathlib v4.31.0
  (the file itself compiles against them; proof-side lemmas listed for the
  prover stage).

## Local abstractions and physical meaning

- Physical lengths use Physlib's dimensional framework rather than a scalar
  alias, per the modeling rules; real-number readouts pass through the single
  named `Figure2gLengthProjection`, preserving the figure's fixed unit.
- `ReflectedRayLine` (dimensionless slope + length intercept) is the smallest
  structure preserving the `y = m x + b` physics of C.1; the ray family
  `ℝ → ReflectedRayLine` indexed by incidence angle is the minimal interface
  that lets the envelope/limit be expressed without fixing ray B's formula.

## Grounding gaps

- Physlib has `Physlib.Optics` but no caustic/envelope-of-rays or
  line-intersection-limit API; the ray-line and intersection predicates are
  local abstractions (faithful, equation-level, see audit above).
- No Mathlib/Physlib "caustic" or "envelope of a family of lines in the limit of
  intersections" theorem found — bridge 3/4 must be proven from limits +
  asymptotics + trigonometry by the prover stage (all ingredients grounded).
- `archon` CLI not on PATH in this container — dag-query navigation skipped;
  recorded for the plan agent.
