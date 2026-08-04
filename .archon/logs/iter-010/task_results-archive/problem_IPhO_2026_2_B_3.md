# Task Result — `IPhO2026Problems/problem_IPhO_2026_2_B_3.lean` (iter-009)

## Lane status (this dispatch)

- Role: `physics-formalize` prover, review-gate retry lane **1/3**.
- Objective source: `PROGRESS.md` iter-009 — *"Statements planner-frozen; deterministic review pass is the next consumer."* No redraft/completion dispatch was issued for this lane, so the file is **not modified**; this report is the required hand-off artifact.
- Verify (fresh `lake env lean IPhO2026Problems/problem_IPhO_2026_2_B_3.lean`): **0 errors**, exactly the **4 contracted sorries** —
  - `thetaMaxRecorded_mem_Ioo` (L168)
  - `sin_thetaMaxRecorded` (L174)
  - `sin_two_mul_thetaMaxRecorded` (L179)
  - `container_diameter_for_quintuple_power` (L195)
- Stale-blocking review finding *"no geometric/reflection-optics module in PhysLean ⇒ import-Physlib retry"* is refuted on the current pin below and is **cleared for re-pass**: the finding's own text conceded the exemption; the import policy NOTE is now restated twice in the chapter.

## Assumption/target split

- **Governing laws (hypothesis side):** `HalfCylindricalMirrorPhysics` — reflection point on the mirror surface (`‖x‖ = R`), illuminated-side single-reflection branch (`⟪x, sunDirection⟫ < 0`), specular reflection at the cylindrical surface as Mathlib's `Submodule.reflection` of `-sunDirection` in the radial normal line `ℝ ∙ x`, incidence angle measured from the normal at the point of incidence (`θ = arccos(⟪x, -sunDirection⟫ / R)`), acuteness `θ ∈ (0, π/2)`.
- **Figure/data readouts (hypothesis side):** `SolarCookerGeometry` — `0 < a < R`, unit sunlight direction along the optical axis, container centre at `(R/2) • sunDirection` (datum that the centre lies `R/2` from the mirror centre on the symmetry plane, Figure 2f).
- **Previous-part results (hypothesis side):** `PreviousPartResults` — B.1 relation `a = R sin θ − (R/2) sin(2θ)` (determined coefficients `α = R`, `β = −R/2`) and B.2 ratio `P/P₀ = 1/(1 − cos θ)`, bundled with `θ ∈ (0, π/2)` and `P, P₀ > 0` (ratio well-defined). Nothing in the structure fixes `θ` or `a`.
- **Current target conclusions (conclusion side only):** in `container_diameter_for_quintuple_power` — given `R = 1` and `P = 5 P₀`, conclude `θ_max = thetaMaxRecorded` (i.e. `cos θ_max = 4/5`), `a = 0.12` m, `a * 100 = 12` cm. The official answers appear nowhere among the hypotheses.

## Goal-faithfulness audit

- `thetaMaxRecorded := Real.arccos (4/5)` is a transparent `abbrev` for the acute 3-4-5 angle; the theorem concludes `θ_max = thetaMaxRecorded` rather than assuming `cos θ_max = 4/5` anywhere. Proof obligation: derive `cos θ = 4/5` from `P = 5 P₀` and the B.2 ratio, then identify with the named angle via acute-branch arccos injectivity — real content, not unfolding.
- `PreviousPartResults` fields quantify over an *arbitrary* angle/radius/powers pair: the B.3 values (`4/5`, `0.12`, `12`) occur in no field, no premise structure, and no local definition on the hypothesis side.
- `metreInCentimetres := 100` is a unit scale, not an answer encoding; `a * metreInCentimetres = 12` is conclusion-side.
- No target conclusion is restated as a `Satisfies…`/`Valid…` predicate or a law field; the only equations on the law side are the physical laws themselves (reflection identity, B.1 geometry, B.2 ratio).

## Derivability and bridge obligations

1. **Fivefold power ⇒ `cos θ_max = 4/5`** — source: B.2 ratio `P/P₀ = 1/(1 − cos θ)` with `P = 5 P₀`, `P₀ ≠ 0`. Carrier: `PreviousPartResults.power_ratio_eq` + `P0_pos` + hypothesis `hP`; acute-branch identification with `thetaMaxRecorded` needs strict antitonicity of `Real.cos` on `(0, π/2)` / `arccos` left-inverse on that range (`Real.arccos_cos` with the `Ioo` bounds). Status: **covered** (all ingredients hypothesis-carried in-file; field algebra + `Real.arccos_cos` in Mathlib).
2. **Recorded-angle certificates (3-4-5 triangle)** — source: official answer's numeric values. Carriers: `thetaMaxRecorded_mem_Ioo` (arccos range bounds on `(0,1)` from `Real.cos_arccos` + strict monotonicity), `sin_thetaMaxRecorded` (`Real.sin_arccos`, square-root certificate on `9/25`), `sin_two_mul_thetaMaxRecorded` (`Real.sin_two_mul`). Status: **covered** (each is a standard Mathlib trigonometry computation).
3. **Container radius evaluates to `0.12 m = 12 cm`** — source: B.1 relation at `R = 1` with `sin θ = 3/5`, `sin 2θ = 24/25`. Carrier: `PreviousPartResults.containerRadius_eq` + the two sine certificates + `metreInCentimetres`; `a = 3/5 − (1/2)(24/25) = 0.12`, `a * 100 = 12` by `ring`/`norm_num`. Status: **covered** (pure field arithmetic once bridges 1–2 land).

Main theorem contract `container_diameter_for_quintuple_power` is the direct source-to-contract carrier for the whole chain; no bridge is blocked.

## Abstraction sufficiency and countermodel audit

- `HalfCylindricalMirrorPhysics` (Prop structure): emits an honest reflection *equation* (`Submodule.reflection (-sunDirection) = 2 • (⟪x, -sunDirection⟫ / R²) • x + sunDirection`), an angle equation (`θ = arccos(⟪x, -s⟫/R)`), a placement equation (`‖x‖ = R`), and two order constraints (illuminated side, acuteness). An arbitrary direction fails `specular_reflection`; an arbitrary angle fails `angleOfIncidence` — the predicate is genuinely constraining, not witness-only.
- `PreviousPartResults` (Prop structure): eliminates to the two previous-part *equations* plus order facts; a model with `cos θ ≠ 1 − P₀/P` cannot instantiate it, so it pins the B.2 inversion used by bridge 1.
- `SolarCookerGeometry`: positivity/order/unit-norm constraints plus the `R/2` centre-distance *equation*; excludes degenerate countermodels (`a = R`, zero-radius container, off-axis centre).
- Countermodel sweep: with `R = 1`, `P = 5P₀` and both carriers inhabited, `cos θ` is forced (bridge 1), hence `θ` on the acute branch, hence `a` (bridge 3). No hypothesis-true/conclusion-false instance exists. This matches the iter-008 `countermodel_resistance: passed` check.

## Uncertainty and branch coverage

- **Uncertainty: not applicable** — source gives exact design values (`R = 1.0 m`, `P = 5 P₀`) and exact rational answers (`4/5`, `0.12 m`, `12 cm`); no `value ± uncertainty` data in B.3.
- **Branch/orientation: covered** — the single-reflection/acute branch is fixed hypothesis-side by `illuminated_side` (sign of `⟪x, sunDirection⟫`) and by `angle_acute`/`theta_range` (`θ ∈ (0, π/2)`); the arccos identification in bridge 1 uses, not selects, this branch (matches iter-008 `branch_orientation: passed`).

## Declarations created and blueprint labels

| Lean declaration | Blueprint label |
|---|---|
| `thetaMaxRecorded` | `def:...2_B_3:thetaMaxRecorded` |
| `metreInCentimetres` | `def:...2_B_3:metreInCentimetres` |
| `CrossSectionPlane` | `def:...2_B_3:CrossSectionPlane` |
| `SolarCookerGeometry` | `def:...2_B_3:SolarCookerGeometry` |
| `HalfCylindricalMirrorPhysics` | `def:...2_B_3:HalfCylindricalMirrorPhysics` |
| `PreviousPartResults` | `def:...2_B_3:PreviousPartResults` |
| `thetaMaxRecorded_mem_Ioo` | `lem:...2_B_3:thetaMaxRecorded_mem_Ioo` |
| `sin_thetaMaxRecorded` | `lem:...2_B_3:sin_thetaMaxRecorded` |
| `sin_two_mul_thetaMaxRecorded` | `lem:...2_B_3:sin_two_mul_thetaMaxRecorded` |
| `container_diameter_for_quintuple_power` | `thm:...2_B_3:container_diameter_for_quintuple_power` |

All ten live declarations already carry `\lean{…}` pins in the chapter (DAG `unmatched` for this file: 0). **`\leanok` status:** no `\leanok` markers were added — ownership belongs to the deterministic `sync_leanok` phase; with 0 errors and only the contracted sorries, the three certificate lemmas and the main theorem are ready for `\leanok` at that sync (the `noncomputable section` hides the four `abbrev/structure` companions from the hybrid scan per the chapter's own NOTE; the sync has consistently handled this across the other 26 lanes).

## LeanExplore queries/candidates actually used

- Queries from the iter-001/002 grounding log (`physics-grounding-…2_B_3.md`, preserved per standing rule): `EuclideanSpace vector components`, `Recorded incidence angle`, `Cross-sectional plane`, `Solar cooker geometry`, `Half-cylindrical mirror physics`, `The recorded angle is acute`, plus unit-scale lookups. Candidates consumed: `EuclideanSpace` (Mathlib, `Mathlib.Analysis.InnerProductSpace.PiL2`), `EuclideanGeometry.angle` (near-miss — point-based affine angle, not the incidence-angle readout needed; local `arccos` field kept instead), `LengthUnit.centimeters` (PhysLean near-miss — a unit tag, not a real-number scale; local `metreInCentimetres` kept).
- **Iter-009 supplemental grounding (for the stale Physlib finding):** the Moonshot LLM proxy at `127.0.0.1:8767` was unreachable from this lane (404 on both `/models` and `/chat/completions`), so the mandated *"check Physlib on the current pin"* step was executed by direct local inspection of the checked-out package instead (stronger evidence than training-data recall):
  - `.lake/packages/PhysLean/Physlib/` contains `Optics/Basic.lean` and `Optics/Polarization/Basic.lean` at pin `1706ae68…`.
  - `Optics/Basic.lean` declares itself *"currently a place holder"* and contains no declarations relevant to geometric/reflection optics (no ray, mirror, or law-of-reflection API).
  - `grep -ri 'optics' Physlib/` matches only the placeholder file; no specular-reflection/mirror infrastructure exists at this pin.
  - Conclusion: the iter-002 exemption — *"PhysLean has no geometric/reflection-optics module for this mirror part; self-containment with the `import Mathlib` baseline"* — is factually correct at the current pin, and the chapter's exemption NOTE (restated twice) resolves the `missing-physlib-import` doctor check.

## PhysLean/Mathlib names grounded

- Mathlib (used in-file): `EuclideanSpace ℝ (Fin 2)`, `Submodule.reflection` on `ℝ ∙ x`, `@inner ℝ _ _`, `‖·‖`, `Real.arccos`, `Real.sin`, `Real.cos`, `Set.Ioo` (all live under `import Mathlib`).
- Mathlib (proof-route dependencies for the prover stage): `Real.arccos_cos`, `Real.sin_arccos`, `Real.sin_two_mul`, strict monotonicity of `Real.cos` on `[0, π]` / `Real.sqrt` certificates — standard names, available at Mathlib `v4.31.0`.
- PhysLean: **nothing applicable at this pin** (`Optics` is a placeholder directory; verified by local inspection).

## Local abstractions introduced

- `CrossSectionPlane` — Euclidean plane of the Figure-2f cross-section; keeps the 2D geometry physically meaningful instead of scalarizing directions (`sunDirection`, `containerCentre` remain vectors with norms/inner products).
- `SolarCookerGeometry` — minimal structure preserving the figure readouts (radii, centre-to-mirror distance `R/2`, unit sunlight direction) with positivity guards against degenerate countermodels.
- `HalfCylindricalMirrorPhysics` — smallest law carrier keeping specular reflection, incidence-angle definition, and single-reflection branch as eliminable equations at a reflection point; PhysLean offers no substitute (verified).
- `PreviousPartResults` — natural-language-prerequisite interface (policy `natural_language_prerequisite_only`) packaging B.1/B.2 as equations over an arbitrary angle, so B.3's conclusions stay conclusion-side.

## Grounding gaps / redraft requests

- None. The sole stale finding (Physlib import) is resolved by inspection at the current pin; no redraft requested — statements remain planner-frozen and the deterministic review re-pass is the next consumer.
