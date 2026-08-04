# Prover result: `problem_IPhO_2026_3_A_2.lean`

## Outcome

Closed both assigned `sorry` placeholders without changing any declaration
signature:

- `IPhO2026Problems.Problem3A2.source_work_eq_current_turns_area_dB`
- `IPhO2026Problems.Problem3A2.external_source_work_for_flux_density_change`

The intermediate lemma successively substitutes the electrical-work,
external-source Faraday, dense-winding flux-linkage, and per-turn flux laws,
then normalizes the product. The target theorem combines that result with
the previous-part identity `H = N I A / V`; positivity of the torus volume
discharges the nonzero denominator needed by `field_simp`.

## Verification

- Archon Lean LSP diagnostics: no errors or warnings.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_A_2.lean`: exit code 0.
- `lake build IPhO2026Run`: succeeded.
- Source scan: no `sorry`, `admit`, `axiom`, `sorryAx`, `native_decide`, or
  file-specific `USER` comment remains.
- `lean_verify` on both proved declarations found no suspicious source
  patterns and reported only the standard imported axioms `propext`,
  `Classical.choice`, and `Quot.sound`.

## Blueprint status

The proof environments for the intermediate lemma and final theorem are ready
for deterministic `\leanok` synchronization. The blueprint was not edited
because prover permissions make it read-only.

## Redraft needed

None.

## Remaining blockers

None.
