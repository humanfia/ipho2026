# Prover result: IPhO 2026 problem 1 B.2

## Outcome

- Sorry count: **1 → 1**.
- The signature of
  `IPhO2026Problems.IPhO2026_1_B_2.IPhO_2026_1_B_2` was not changed.
- The proof body now records the usable reductions: `μ = 15/2` is positive,
  the orbit is hyperbolic with positive eccentricity, the separation tends to
  infinity, the relative velocity tends to `uInfinity`, and the polar-angle
  and polar-conic laws are available.
- One focused `sorry` remains at the missing implication from these position
  and limit facts to the oriented direction of the outgoing velocity.

## Blocker

`ConicOrbitLaws.polarAngleDefinition` and `polarConicEquation` constrain the
relative **position** and its conic asymptote. The only hypothesis mentioning
`uInfinity` says that the relative velocity tends to it. No field identifies
the direction of this nonzero velocity limit with an outgoing conic asymptote,
and no field selects the outgoing branch. Consequently neither the negative
sign nor the `-16.60°` enclosure can be obtained by rewriting or by the stated
conic laws alone.

The iteration-003 plan explicitly required checking this bridge before doing
the transcendental numerical enclosure; the bridge is absent.

## Redraft needed

- Original problem: `IPhO_2026_1`, part `B.2`.
- Source report:
  `reports/ipho_2026/problem_IPhO_2026_1_B_2.source.json`.
- Theorem:
  `IPhO2026Problems.IPhO2026_1_B_2.IPhO_2026_1_B_2`.
- Smallest faithful change: add an outgoing-hyperbola asymptote hypothesis
  after `uInfinity_isAsymptoticRelativeVelocity`, for example

  ```lean
  (uInfinity_outgoingAsymptote :
    (frame.orientation.oangle
      (velocitySI motion .positron 0) uInfinity).toReal =
        -Real.arcsin orbit.eccentricity⁻¹)
  ```

  This is the standard missing bridge, expressed for the already supplied
  eccentricity rather than encoding the reported decimal. The existing
  initial-state and eccentricity laws can then be used to derive
  `orbit.eccentricity = 7/2`, after which the remaining obligation is the
  rigorous enclosure of
  `-arcsin (2/7) * 180 / π` around `-83/5`.

An equivalent redraft could place this relation in a new governing-law record
parameterized by `uInfinity`; it should not assume the rounded answer itself.

## Verification

- Lean language-server diagnostics: no errors; exactly one expected
  `declaration uses sorry` warning.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_1_B_2.lean`: exit code 0
  with the same single warning.
- No axioms, `admit`, `native_decide`, or `sorryAx`-style declarations were
  introduced.
- The read-only `archon dag-query` command was unavailable in this environment
  (`archon: command not found`); the source report lists no previous parts.

## Blueprint status

The target proof is not ready for a proof `\leanok` marker because one focused
gap remains. Per prover permissions, the blueprint chapter was not edited.

