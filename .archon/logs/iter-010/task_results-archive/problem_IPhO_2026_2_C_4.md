# Task result — IPhO2026Problems/problem_IPhO_2026_2_C_4.lean (iter-009 verify lane)

Lane status: review-gate retry (2/3 used), statements planner-frozen. This lane
performed the required physics-formalize audit and a fresh verification only;
the Lean file was NOT modified (it already satisfies the frozen spec; any
redraft belongs to the deterministic review re-pass).

Verification (iter-009, this lane):
- lake env lean IPhO2026Problems/problem_IPhO_2026_2_C_4.lean (fresh process):
  0 errors, exactly 1 warning: declaration uses sorry at line 145:8
  (caustic_small_angle_power_law). This matches the iter-009 PROGRESS ledger
  entry "2_C_4 1 sorry". smallAngleRegime_mem_filter is fully proved (no
  sorry, no warning).
- Blueprint chapter contains % archon:physics (line 2): physics-formalize
  discipline confirmed.
- No USER comments present in the Lean file.

## Assumption/target split

- Governing laws (hypothesis side): the envelope/limiting-intersection law
  as the geometric definition of the caustic — structure field
  HalfCylindricalMirrorCaustic.envelope_law: for each angle theta,
  eventually in dtheta tending to 0 from the positive side, the two
  reflected lines y = m_A x + b_A and y = m_B x + b_B have a unique
  intersection. This states a physical/geometric law (existence and
  uniqueness of the neighboring-ray intersection), not the C.4 answer.
- Previous-part results (hypothesis side, natural-language prerequisite per
  the chapter's previous-part-policy): X_c_formula (X_c t = R * sin t ^ 3)
  and Y_c_formula (Y_c t = R/2 * cos t * (2 - cos (2t))) — the C.3
  conclusions, recorded as fields on the caustic data structure.
- Figure/data readouts (parameter side): mirror radius R with R_pos : 0 < R;
  reflected-line data m_A, b_A, m_B, b_B (Figure 2g coordinate convention);
  InSmallAngleRegime (0 < t < 1) as the plain-English reading of t << 1;
  smallAngleFilter = nhdsWithin 0 (Set.Ioi 0) carrying the operative
  one-sided asymptotics as t tends to 0 from above.
- Current target conclusions (conclusion side only): the recorded C.4 values
  u = R/2, v = (3/4) R^(1/3), p = 2, q = 3 and the leading-order power-law
  agreement Y_c ~ v |X_c|^(2/3) + u, all confined to the theorem
  caustic_small_angle_power_law (sorried) — nothing on the hypothesis side
  mentions them.

## Goal-faithfulness audit

- The recorded constants appear exactly once in the whole file: as the
  conclusion of caustic_small_angle_power_law, namely
  SatisfiesCausticPowerLaw c.X_c c.Y_c c.R (c.R / 2) ((3/4) c.R^(1/3)).
  No hypothesis, structure field, premise record, Valid...Physics or
  Satisfies...-as-assumption, or local definition states them in advance.
- SatisfiesCausticPowerLaw is a packaging predicate used only in the
  conclusion: its u = R/2 and v = (3/4) R^(1/3) equalities assert that the
  curve's shift and prefactor are the geometry-determined ones; asserting
  this in the target is exactly the C.4 question (determine u, v, p, q). It
  is never assumed of c.
- CausticPowerLawForm is fully general (parameters X Y u v p q), not
  specialized to the recorded answer; the extra existential clause
  (exists w > 0, X equivalent to w t^q) pins the parametrization scale so
  the exponent p/q is not vacuous (see countermodel audit).
- Not a tautology: CausticPowerLawForm unfolds to positivity of p, q, one
  Asymptotics.IsEquivalent between genuinely different functions of the
  curve data, and an existential scale equivalence — none is reflexive or
  True, and the IsEquivalent instances are not rfl-closeable. The blueprint
  documents that an exact identity is FALSE for this caustic; the statement
  encodes the physically intended leading-order (asymptotic) reading rather
  than an algebraic tautology.
- smallAngleRegime_mem_filter is a proved naming/bridge lemma only; it does
  not bear on the C.4 values.

## Derivability and bridge obligations

1. Source C.3 coordinates become Lean hypotheses.
   Carrier: structure fields X_c_formula, Y_c_formula. Evidence: verbatim
   transcription of the reusable-conclusions block of the chapter
   (X_c = R sin^3 t; Y_c = (R/2) cos t (2 - cos 2t)). Status: covered.
2. Envelope/caustic geometric definition (ray A / ray B reflected lines and
   their limiting intersection as dtheta tends to 0).
   Carrier: field envelope_law (for all t, eventually in dtheta within the
   positive side there exists a unique point p on both lines). Evidence:
   chapter problem-source paragraph (lines y = m_A x + b_A, y = m_B x + b_B).
   Status: covered. The future proof need not use it once C.3 coordinates
   are assumed, but it preserves the geometric meaning of X_c, Y_c and is
   available to a prover-stage consistency check.
3. The t << 1 regime becomes an asymptotic filter.
   Carrier: smallAngleFilter, InSmallAngleRegime, and the proved lemma
   smallAngleRegime_mem_filter (the predicate set is a neighborhood of 0
   within the positive angles, via mem_nhdsWithin with open Set.Iio 1).
   Evidence: compiles with no sorry. Status: covered.
4. Leading-order power-law agreement Y_c = v |X_c|^(2/3) + u for t << 1.
   Carrier: CausticPowerLawForm (Mathlib Asymptotics.IsEquivalent along
   smallAngleFilter) as conclusion of caustic_small_angle_power_law.
   Evidence: informal Taylor match recorded in the blueprint proof block and
   in the Lean module docstring (Y_c = R/2 + (3/2) R t^2 + O(t^4),
   |X_c|^(2/3) = R^(2/3) t^2 (1 + O(t^2)), hence the prefactor identity
   (3/2) R = (3/4) R^(1/3) R^(2/3)). Status: covered on the statement side;
   the analytic derivation itself is the contracted sorry, the prover
   stage's work-queue item.
5. The |X_c| branch of the source formula.
   Carrier: positive-angle branch of smallAngleFilter plus X_c_formula
   (R sin^3 t > 0 for small t > 0), documented in the theorem docstring.
   Status: covered at the statement level; the prover-stage body must
   discharge |X_c t| = X_c t eventually along the filter (routine from
   Real.sin_pos_of_pos_of_lt_pi).
6. Exponent integrality p = 2, q = 3.
   Carrier: CausticPowerLawForm ... 2 3 with the 0 < p and 0 < q guards.
   Status: covered (conclusion side).

## Abstraction sufficiency and countermodel audit

Local Prop-valued interfaces and what constrains them:

- HalfCylindricalMirrorCaustic.envelope_law (field): constrains via an
  existence-uniqueness statement with explicit line-membership equations
  (p.2 = m_A t p.1 + b_A t and p.2 = m_B t dt p.1 + b_B t dt), not a bare
  witness assertion. It ties m_A, b_A, m_B, b_B together: if slopes are
  eventually distinct the intersection is algebraically unique, so the field
  forces slope non-degeneracy on a dtheta-neighborhood.
- X_c_formula, Y_c_formula (fields): pointwise equations for every t —
  maximally constraining (they determine X_c, Y_c outright as functions of
  R sin^3 t and (R/2) cos t (2 - cos 2t)).
- InSmallAngleRegime (predicate): explicit inequalities 0 < t and t < 1.
- CausticPowerLawForm (predicate): constrains via two
  Asymptotics.IsEquivalent statements plus 0 < p, 0 < q and 0 < w.
  Countermodel check: could an arbitrary curve with wrong constants satisfy
  it by unfolding? No — IsEquivalent to v X^(2/3) + u for the GIVEN (u, v)
  forces the ratio Y t / (v X t^(2/3) + u) to tend to 1; for the caustic
  formulas the leading quadratic of Y_c is (3/2) R t^2 while the leading
  quadratic of v X_c^(2/3) is v R^(2/3) t^2, so the ratio tends to 1 only
  when v = (3/4) R^(1/3) and u = R/2; instantiating with any other (u, v)
  makes the predicate false on this curve. Conversely, with the recorded
  constants the predicate is true (Taylor match), so the contract is
  determinate and non-vacuous. The exists-w clause excludes degenerate
  reparametrization countermodels (curves with X flat or sign-indefinite
  near 0 from above) that would make a bare Y ~ v X^(p/q) + u
  underdetermined; IsEquivalent also gives an elimination route (its
  IsLittleO unfolding) for the prover stage.
- SatisfiesCausticPowerLaw (predicate): pure conjunction of the two
  constant-specifying equations with the general form; consequences are the
  equations themselves plus those of CausticPowerLawForm.

Remaining degrees of freedom (m_A, b_A, m_B, b_B) are genuinely
underdetermined — deliberately: they record the figure data without fixing
reflection formulas, and the C.4 conclusion depends only on the C.3
coordinate fields, so no underdetermined abstraction can make a true
hypothesis set yield a false conclusion here (the target speaks only about
X_c, Y_c, R).

## Uncertainty and branch coverage

- Uncertainty: not applicable. The source reports no value-plus-minus
  uncertainty data; C.4 asks for exact constants u, v, p, q in an asymptotic
  regime. The t << 1 qualifier is preserved as the filter variant
  (IsEquivalent along nhdsWithin 0 (Set.Ioi 0)), i.e. the approximation
  quality itself is formalized rather than a numeric tolerance.
- Branch/orientation: covered. The signed-direction content of the source is
  the positive-incidence-angle branch: smallAngleFilter restricts to the
  one-sided approach from positive angles, which (with R_pos and
  X_c_formula) makes X_c t > 0 eventually and resolves the |X_c| of the
  source formula to X_c. Recorded in the smallAngleFilter and
  caustic_small_angle_power_law docstrings; bridge entry 5 above tracks the
  remaining prover-stage discharge.

## Declarations and blueprint labels

- IPhO2026_2_C_4.HalfCylindricalMirrorCaustic —
  def:IPhO2026Problems_problem_IPhO_2026_2_C_4:HalfCylindricalMirrorCaustic
  — ready (structure, no sorry).
- IPhO2026_2_C_4.smallAngleFilter — def:...:smallAngleFilter — ready
  (noncomputable def).
- IPhO2026_2_C_4.InSmallAngleRegime — def:...:InSmallAngleRegime — ready.
- IPhO2026_2_C_4.smallAngleRegime_mem_filter —
  lem:...:smallAngleRegime_mem_filter — PROVED (0 sorries); leanok-eligible
  once the sync runs.
- IPhO2026_2_C_4.CausticPowerLawForm — def:...:CausticPowerLawForm — ready.
- IPhO2026_2_C_4.SatisfiesCausticPowerLaw — def:...:SatisfiesCausticPowerLaw
  — ready.
- IPhO2026_2_C_4.HalfCylindricalMirrorCaustic.caustic_small_angle_power_law
  — thm:...:caustic_small_angle_power_law — statement frozen; body is the
  contracted sorry (prover-stage queue); not leanok-eligible.

(Labels abbreviated: ... stands for IPhO2026Problems_problem_IPhO_2026_2_C_4.)
Marker flags: I may not edit blueprint chapters; the deterministic
sync_leanok phase owns them. Expected sync outcome: all definition/lemma
pins satisfied except the sorried target theorem.

## LeanExplore queries/candidates actually used

Grounding preflight register preserved at
task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_C_4.md
(backend local; packages Mathlib, Physlib). Queries covered every blueprint
block name (Caustic power-law form, Small-angle filter, C.4 target:
small-angle caustic power law, and the others). All returned candidates were
semantic near-misses (Polynomial.mirror, PowerSeries, Filter.smallSets,
PhysLean semiformal_result, ...); none model caustics or power-law
asymptotics, so the file correctly grounds only on core Mathlib asymptotics
and keeps faithful local abstractions for the physics. No new queries were
needed this lane (statements frozen; no new APIs introduced).

## PhysLean/Mathlib names grounded

- Asymptotics.IsEquivalent (the ~[l] relation) — the
  leading-order-agreement contract.
- nhdsWithin, Set.Ioi, Set.Iio, mem_nhdsWithin, isOpen_Iio — the one-sided
  small-angle filter and the proved regime-neighborhood lemma.
- Real.sin, Real.cos, real rpow — the C.3 coordinate formulas and the
  R^(1/3), |X_c|^(2/3) powers.
- Physlib: none — per the chapter's iter-002 PhysLean-coverage exemption
  NOTE (missing-physlib-import exemption; the stale iter-003 doctor snapshot
  was formally retired): PhysLean has no caustic/power-law asymptotics
  module, so the import Mathlib baseline stands. The iter-008 gate retry
  reason (does not import Physlib) is answered by that standing exemption;
  no irrelevant import added.

## Local abstractions introduced

(Introduced in earlier iterations; audited and unchanged this lane.)

- HalfCylindricalMirrorCaustic — structure bundling radius, reflected-line
  data, caustic coordinates, envelope law, and the C.3 formulas. Preserves
  the physical role of every named quantity (no scalar-alias collapse: R,
  X_c, Y_c are lengths-as-reals per explicit docstrings; line data stay
  functional).
- smallAngleFilter / InSmallAngleRegime — filter + predicate pair keeping
  both the asymptotic and plain-English readings of t << 1.
- CausticPowerLawForm — general leading-order power-law predicate with
  parametrization-scale guard (exists w > 0, X ~ w t^q), so the exponent
  carries meaning (see countermodel audit).
- SatisfiesCausticPowerLaw — conclusion-side packaging of the recorded
  constants over the general form.

## Grounding gaps / redraft requests

- No unresolved grounding gaps: the preflight register records none, and the
  used Mathlib API is stable core asymptotics.
- No redraft requested from this lane: statements are planner-frozen, the
  file compiles 0 errors with 1 contracted sorry, and all faithfulness,
  bridge, countermodel, uncertainty, and branch checks above pass. The lane
  is ready for the deterministic review re-pass; the single sorry belongs to
  the prover-stage work queue (bridges 4-5 localize exactly what that proof
  must supply: Taylor-level IsEquivalent derivations plus the eventual
  positivity of X_c on the filter).
