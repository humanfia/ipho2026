# Prover result: IPhO 2026 problem 2, B.1

## Outcome

- The existing algebraic proof of `problem_IPhO_2026_2_B_1` is sound
  conditional on `radiusAtIncidence_from_figure2f`: evaluation at `π / 2`
  identifies `α`, and evaluation at `π / 4` then identifies `β`.
- The sole remaining `sorry` in `radiusAtIncidence_from_figure2f` cannot be
  closed from the frozen contract. Its proof body already extracts the
  limiting tangent path, the one-reflection fact, and its incidence angle;
  none of these abstract predicates yields a coordinate, distance, tangency,
  or radius equation.
- No theorem signature, definition, import, or blueprint file was changed.
  The focused partial proof was preserved rather than replaced by a bare
  `sorry`.

## Formal countermodel

A standalone Lean check importing the compiled assigned file successfully
constructed concrete values satisfying:

- `Figure2fReadout setup`;
- every field of `ValidSolarCookerPhysics setup`; and
- `IsRadiusCoefficientFormula setup α β`;

while making both claimed conclusions false. The countermodel uses
`mirrorRadius = 1`, `containerRadius = 2`, `thetaMax = π / 2`,
`radiusAtIncidence θ = 2 * sin θ`, `α = 2`, and `β = 0`. Physical paths are
explicit one-reflection paths parameterized by each admissible angle, while
the contract's unconstrained limiting/tangency predicates hold for them.
Thus the helper would assert `2 = 1` at `θ = π / 2`, and the final theorem
would assert `2 = 1` for `α`.

This type-checked countermodel shows that the blocker is logical
under-specification, not missing Mathlib/Physlib infrastructure or an
unfound tactic.

## Verification

- `lake env lean IPhO2026Problems/problem_IPhO_2026_2_B_1.lean`: exit code
  `0`.
- Lean LSP diagnostics: no errors or failed dependencies; exactly one
  expected warning, `declaration uses 'sorry'`, on
  `radiusAtIncidence_from_figure2f`.
- Source scan finds no `axiom`, `admit`, `native_decide`, or `sorryAx`
  laundering. The only placeholder is the focused line described above.
- The advertised read-only command `archon dag-query` was unavailable in
  this runtime (`archon: command not found`).

## Blueprint marker readiness

- `radiusAtIncidence_from_figure2f`: not ready for proof `\leanok`.
- `problem_IPhO_2026_2_B_1`: its local algebraic proof body is closed, but
  the declaration still depends on the incomplete geometry helper.

## Redraft needed

- Original problem: `IPhO_2026_2`, part `B.1`.
- Source report:
  `reports/ipho_2026/problem_IPhO_2026_2_B_1.source.json`.
- Theorems: `radiusAtIncidence_from_figure2f` and, transitively,
  `problem_IPhO_2026_2_B_1`.
- Why the current statement is not provable: `radiusAtIncidence`,
  `isLimitingPathForRadius`, and `isTangentToContainer` are independent
  abstract fields. `ValidSolarCookerPhysics` asserts existence of paths with
  these predicates but supplies no law connecting them to the Figure 2f
  center displacement or the claimed sine radius response. The formal
  countermodel above satisfies all hypotheses and refutes both conclusions.
- Smallest faithful change: add a governing-law field to
  `ValidSolarCookerPhysics` saying that an admissible, one-reflection
  limiting tangent path of incidence `θ` implies
  ```
  setup.radiusAtIncidence θ =
    scaleLength
      (Real.sin θ - (1 / 2) * Real.sin (2 * θ))
      setup.mirrorRadius
  ```
  with the corresponding path hypotheses. The existing witness extraction
  would then prove `radiusAtIncidence_from_figure2f`, and the already-closed
  coefficient argument would finish the final theorem.
