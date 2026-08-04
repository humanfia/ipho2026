# Prover result: `problem_IPhO_2026_3_A_3.lean`

## Outcome

Closed all four `sorry` placeholders without changing any declaration
signature:

- `dimensionful_ext_si`
- `siValue_energyFromSI`
- `materialWork_siValue_eq`
- `materialWork_eq_mu0_volume_H_dM`

The SI bridge uses the inverse of Physlib's
`CarriesDimension.toDimensionful` equivalence together with `WithDim.ext`.
The scalar physics result substitutes the source-work, vacuum-work,
differential constitutive, and vacuum-increment laws into the work split,
then closes the resulting polynomial identity with `ring_nf` and `linarith`.
The final dimensionful equality follows by SI injectivity.

## Verification

- Archon Lean LSP diagnostics: no errors or warnings.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_A_3.lean`: exit code 0.
- `lake build IPhO2026Run`: succeeded.
- Source scan: no `sorry`, `admit`, `axiom`, `sorryAx`, or `native_decide`.
- `lean_verify` on
  `IPhO2026Problems.Problem3A3.materialWork_eq_mu0_volume_H_dM`: no
  suspicious-source warnings; only standard imported axioms `propext`,
  `Classical.choice`, and `Quot.sound`.

## Blueprint status

All four proof environments are ready for deterministic `\leanok`
synchronization. The blueprint chapter was not edited because prover
permissions make it read-only.

## Redraft needed

None.
