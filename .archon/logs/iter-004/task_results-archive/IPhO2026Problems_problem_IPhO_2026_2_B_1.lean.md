# Prover result: IPhO 2026 problem 2, B.1

## Outcome

- `problem_IPhO_2026_2_B_1` is proved algebraically from
  `radiusAtIncidence_from_figure2f` and `coefficientFormula`.
  Evaluating the two identities at `θ = π / 2` gives
  `α = setup.mirrorRadius`; evaluating them at `θ = π / 4` then gives
  `β = scaleLength (-(1 / 2)) setup.mirrorRadius`.
- `radiusAtIncidence_from_figure2f` retains one focused `sorry` after
  extracting the limiting tangent path supplied by
  `physics.limiting_tangent_path_exists`.
- No signatures, declarations, imports, or blueprint files were changed.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_2_B_1.lean` succeeds.
- Lean LSP diagnostics report no errors and exactly one expected warning:
  `declaration uses 'sorry'` at `radiusAtIncidence_from_figure2f`.
- The project does not register this standalone scaffold as a Lake module
  target (`+IPhO2026Problems.problem_IPhO_2026_2_B_1` is unknown), so the
  direct `lake env lean` check is the applicable file-level verification.

## Blueprint marker readiness

- `problem_IPhO_2026_2_B_1`: proof body closed, but it depends on the still
  incomplete geometry lemma.
- `radiusAtIncidence_from_figure2f`: not ready for `\leanok`.

## Redraft needed

- Original problem: `IPhO_2026_2`, part `B.1`.
- Source report:
  `reports/ipho_2026/problem_IPhO_2026_2_B_1.source.json`.
- Theorem: `radiusAtIncidence_from_figure2f`.
- Blocker: the current `ValidSolarCookerPhysics` contract treats
  `setup.radiusAtIncidence`, `setup.isLimitingPathForRadius`, and
  `setup.isTangentToContainer` as abstract data/predicates. Its only relevant
  field asserts that a limiting tangent path exists at each admissible angle.
  No field states what tangency means geometrically or connects such a path
  to the displacement/radius equation. Consequently the extracted
  `path`, `hlimiting`, `htangent`, and `hincidence` provide no equality from
  which the claimed sine formula can be deduced.
- Smallest faithful change: add a governing-law hypothesis to
  `ValidSolarCookerPhysics` (or directly to
  `radiusAtIncidence_from_figure2f`) stating that an admissible one-reflection
  limiting tangent path at incidence `θ` implies
  `setup.radiusAtIncidence θ =
    scaleLength (Real.sin θ - (1 / 2) * Real.sin (2 * θ))
      setup.mirrorRadius`.
  A more structural redraft could instead define tangency, reflection
  geometry, and the limiting-radius relation concretely, but that is larger
  than the minimum needed to close the frozen theorem.
