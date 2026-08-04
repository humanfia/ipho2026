# Task result: `IPhO2026Problems/problem_IPhO_2026_2_B_2.lean` (iter-009 re-audit)

Mode: `physics-formalize`. Lane objective (PROGRESS.md, iter-009): re-audit the landed
session-8 R1 statement repair (`AbsorbedRays.full_side_coverage` strengthened from
`Set.Ioo 0 p.a` to `Set.Ioo 0 p.R`). Outcome: **repair verified in place; file is
faithful and compiles clean by-sorry; no changes required, none made**.

## Verification performed

- Fresh `lake env lean IPhO2026Problems/problem_IPhO_2026_2_B_2.lean` (iter-009):
  exit 0, **0 errors**, exactly the 5 contracted `sorry` warnings at
  L177 (`impactParam_le_aperture`), L186 (`collectedWidth_eq_radius`),
  L193 (`power_ratio_eq_width_ratio`), L201 (`radius_over_diameter_eq`),
  L212 (`power_ratio_in_terms_of_theta_max`). Matches the iter-009
  preflight record in PROGRESS.md exactly (zero line drift).
- `full_side_coverage` confirmed quantifying over `Set.Ioo (0 : R) p.R`
  (IPhO2026Problems/problem_IPhO_2026_2_B_2.lean:124).
- All 18 blueprint `\lean{...}` pins cross-checked against the 18 Lean
  declarations: 1:1 name-and-role correspondence, no orphans.
- Chapter carries `% archon:physics` (line 2) — physics-formalize discipline
  applied. `archon` CLI is not on PATH in this worker; the 1:1 pin check
  above substitutes for `dag-query` node status.
- `\leanok` markers: none applied. The 5 target/bridge declarations still carry
  `sorry` bodies by contract — the deterministic `sync_leanok` owns those markers;
  flagged here as **not ready** for `\leanok` (sorries present), ready for
  `\mathlibok`-style review only after the prover stage discharges them.

## Assumption/target split

- Governing laws (hypotheses / structure fields, never redefined):
  - Specular reflection on the circular profile with absorbed endpoint in the
    container disc: `AbsorbedRays.reflected_point_law`.
  - Every absorbed incidence point lies on the half-cylinder arc:
    `AbsorbedRays.on_mirror` (with `halfMirrorArc`).
  - Uniform parallel sunlight: `UniformIntensity.hI : 0 < I`; power accounting
    `PowerBudget.received_power_eq : P = I * collectedWidth`,
    `PowerBudget.unmirrored_power_eq : P0 = I * (2 * a)` (per unit axial
    length; common `I` and axial length cancel in the ratio).
- Previous-part results (B.1, natural-language prerequisite): `B1Calibration p theta`
  — `a = R sin theta - (R/2) sin (2 theta)` (i.e. `alpha = R`, `beta = -R/2`),
  passed as the hypothesis `hcal` to the target theorem; per chapter policy the
  B.1 Lean output is not imported.
- Figure/data readouts (Figure 2f): container centre offset
  `CookerGeometry.A_offset : A - C = (R/2) s n` with `n perp e`, `|e| = |n| = 1`;
  branch/topology readouts `AbsorbedRays.central_ray_absorbed`,
  `AbsorbedRays.no_gap`, and (iter-009 strengthened)
  `AbsorbedRays.full_side_coverage : forall y in Ioo 0 R, exists x in hitSet,
  inner (incidentPt x - C) e = y`.
- Current target conclusions (conclusion side only):
  `power_ratio_in_terms_of_theta_max`, `power_ratio_eq_width_ratio`,
  `radius_over_diameter_eq`, `collectedWidth_eq_radius`,
  `impactParam_le_aperture`.

## Goal-faithfulness audit

- The target relation `P / P0 = 1 / (1 - cos theta_max)` appears only as the
  conclusion of `power_ratio_in_terms_of_theta_max` and its two bridge lemmas.
  No hypothesis, premise structure, Laws/Valid/Satisfies field, or local
  definition contains it; in particular no field asserts `P/P0 = R/(2a)` or any
  closed form of the ratio — `PowerBudget` records only the two
  width-proportionality laws, from which the ratio still has to be derived via
  the sorried bridges.
- `ThetaMaxSpec` specifies `theta_max` (attained maximum incidence angle over the
  absorbed family, branch `(0, pi/2)`); it does not presuppose any value of
  `P/P0` and does not force `collectedWidth = R` by unfolding (the width lemma
  needs `full_side_coverage` + `no_gap` + the aperture bound).
- `B1Calibration`, though stated as an equation, is the upstream B.1 *answer*,
  legitimately imported as a hypothesis (recorded previous-part result); it is
  not the B.2 target. The trigonometric bridge that turns it into
  `1/(1 - cos theta)` is the sorried `radius_over_diameter_eq`, so no answer is
  closed by `rfl`/unfolding.
- Physical primitives kept abstract: mirror/container are `Set Plane`
  (sphere/closed ball), rays via `incidentPt : R -> Plane`; `P`, `P0`, `I` are
  reals only as measured scalar power/intensity readouts (explicitly documented).
  No scalar-placeholder aliases of physical quantities.

## Derivability and bridge obligations

- B1 incidence bound — source: `on_mirror` (norm of `incidentPt y - C` equals R)
  + Cauchy-Schwarz with `e_unit`. Carrier: `impactParam_le_aperture`
  (L177, sorry). Status: covered (statement sufficient; proof pending, route
  scripted in chapter lemma proof).
- B2 `collectedWidth = R` — source: upper bound B1; lower bound from
  iter-009-strengthened `full_side_coverage` (readouts contain `(0, R)`, whose
  supremum is `R`) + nonemptiness via `central_ray_absorbed`. Carrier:
  `collectedWidth_eq_radius` (L186, sorry). Status: covered — the iter-008
  thin-fan countermodel (`R = 1, a = 0.1, P/P0 = 5 != 1.005`) is structurally
  excluded by the `(0, R)` quantification.
- B3 `P/P0 = R/(2a)` — source: the two `PowerBudget` equalities + `hI : 0 < I`
  cancellation + B2. Carrier: `power_ratio_eq_width_ratio` (L193, sorry).
  Status: covered.
- B4 `R/(2a) = 1/(1 - cos theta)` — source: `B1Calibration` + double-angle
  identity, cancelling `2R sin theta > 0` for `theta in (0, pi/2)` (positivity
  needed for the cancellation and for `2a != 0`). Carrier:
  `radius_over_diameter_eq` (L201, sorry). Status: covered.
- B5 target assembly — source: transitivity of B3, B4 at the specified
  `theta_max` (`ThetaMaxSpec` supplies the branch `theta in (0, pi/2)`).
  Carrier: `power_ratio_in_terms_of_theta_max` (L212, sorry). Status: covered.

## Abstraction sufficiency and countermodel audit

- `AbsorbedRays` (Prop-mix structure): constraining via *equations and
  membership* — `reflected_point_law` is a vector equation for the absorbed
  endpoint (`q - incidentPt y = (2<incidentPt y - C, n> - R) s n`,
  `q in containerDisk`); `on_mirror` fixes every incidence point on
  `halfMirrorArc`; `no_gap`/`full_side_coverage`/`central_ray_absorbed` pin the
  hit-set topology. Reused by bridge lemmas B1/B2 (usable elimination content).
  Note (recorded for the prover stage): the chapter prose for clause (b) writes
  the reflected displacement generally; the exact specular direction
  `2<m-C,n> s n - R s e` quoted in the Lean docstring is the
  incoming-direction-`-e` specialization and they coincide on-axis — minor prose
  looseness, not a contract gap; the q-equation field is the binding one.
- `ThetaMaxSpec`: constraining via conjunction of attainment (exists an absorbed
  impact parameter with `incidenceAngle = theta`) and universal bound (every
  absorbed incidence angle `<= theta`) plus the open-interval branch — enough to
  feed B5's positivity side condition.
- `B1Calibration`, `CookerGeometry` fields, `PowerBudget` fields are plain
  equations — maximally constraining by construction.
- Countermodel check post-repair: arbitrary interpretations of
  `incidentPt`/`hitSet` satisfying all fields now force readouts containing
  `(0, R)` with all readouts bounded by `R`, so `collectedWidth = R` and the
  conclusion follows; no model with all laws true and the target false remains.
  The single-bounce figure premise (every absorbed ray reflects at most once)
  is enforced by construction: `AbsorbedRays` parametrizes only rays that hit
  the mirror (`on_mirror`) and assigns each exactly one reflected endpoint
  (`reflected_point_law`) — no third point exists in the model.

## Uncertainty and branch coverage

- Uncertainty: not applicable — the source reports an exact closed form
  (`P/P0 = 1/(1 - cos theta_max)`); no `+-` data in B.2.
- Branch coverage: covered — `ThetaMaxSpec` fixes `theta in Ioo 0 (pi/2)`
  (non-grazing, nontrivial branch of Figure 2f); sunlight direction `- e` and
  container side `n` fixed in `CookerGeometry`; hit-family topology
  (contiguous, one-sided, filling the open half aperture) fixed by
  `central_ray_absorbed`, `no_gap`, `full_side_coverage`.

## Declarations and blueprint labels

All pre-existing (iter-002 landing, iter-009 statement repair); re-audited, none added:

- `Plane` — `def:...:Plane`; `CookerParams` — `def:...:CookerParams`;
  `CookerGeometry` — `def:...:CookerGeometry`; `mirrorCircle` — `def:...:mirrorCircle`;
  `containerDisk` — `def:...:containerDisk`; `halfMirrorArc` — `def:...:halfMirrorArc`;
  `AbsorbedRays` — `def:...:AbsorbedRays`; `collectedWidth` — `def:...:collectedWidth`;
  `UniformIntensity` — `def:...:UniformIntensity`; `PowerBudget` — `def:...:PowerBudget`;
  `B1Calibration` — `def:...:B1Calibration`; `incidenceAngle` — `def:...:incidenceAngle`;
  `ThetaMaxSpec` — `def:...:ThetaMaxSpec`; `impactParam_le_aperture` —
  `lem:...:impactParam_le_aperture` (sorry); `collectedWidth_eq_radius` —
  `lem:...:collectedWidth_eq_radius` (sorry); `power_ratio_eq_width_ratio` —
  `lem:...:power_ratio_eq_width_ratio` (sorry); `radius_over_diameter_eq` —
  `lem:...:radius_over_diameter_eq` (sorry); `power_ratio_in_terms_of_theta_max` —
  `thm:...:power_ratio_in_terms_of_theta_max` (sorry; the umbrella
  `thm:physics:IPhO_2026_2_B_2:target` `\uses{}` it).

## LeanExplore queries/candidates actually used

Per the preserved register
`.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_B_2.md`
(queries run over Mathlib + Physlib for every declaration family: Euclidean plane,
sphere/ball profiles, ray bookkeeping, specular reflection, trig bridges).
Grounded in the file: `EuclideanSpace R (Fin 2)` (`Plane`), `Metric.sphere`,
`Metric.closedBall`, `inner R`, `Real.sin/cos/arccos`, `Set.Ioo`, `sSup`.
No new queries needed this iter (re-audit only; no statement drift).

## PhysLean/Mathlib names grounded

Mathlib only, per the chapter's recorded import-policy NOTE (PhysLean has no
specular-reflection / geometric-optics module for the Figure-2f half-cylinder
regime; exemption NOTE present in the chapter, `missing-physlib-import` doctor
check formally retired for this family).

## Local abstractions introduced

`CookerGeometry` (figure frame + offset law), `AbsorbedRays` (single-bounce ray
bookkeeping with specular-law field), `PowerBudget`/`UniformIntensity`
(uniform-intensity width accounting), `ThetaMaxSpec`/`B1Calibration` (angle spec
and previous-part calibration). Each preserves the physical role per the audits
above; no physical meaning collapsed to scalar aliases.

## Grounding gaps / redraft requests

None. No statement redraft requested; the lane's next consumer is the
deterministic review re-pass (retry gate 1/3) as scheduled in PROGRESS.md.
