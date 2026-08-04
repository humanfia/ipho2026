# Prover result: `problem_IPhO_2026_3_C_1.lean`

## Outcome

Closed both proof obligations without changing either declaration signature:

- `identify_isothermal_reservoir_contacts`
- `identify_temperature_labels_and_heat_processes`

There are no remaining `sorry` placeholders.

## Proof summary

For `identify_isothermal_reservoir_contacts`, the isothermal-contact law
supplies a reservoir for each of `2 → 3` and `4 → 1`.  Splitting over the four
possible pairs leaves only `(cold, hot)`:

- `(cold, cold)` and `(hot, hot)` force states 2 and 1 to have equal
  temperatures, contradicting the strict figure ordering.
- `(hot, cold)` makes the figure ordering say `T_h < T_c`, contradicting
  `T_c < T_h`.

The main theorem then applies endpoint equilibrium at the identified contacts
to obtain all four temperature labels, uses the reservoir heat-transfer law
for the two isotherms, and composes the adiabatic-isolation and
no-contact/no-transfer laws for `1 → 2` and `3 → 4`.

The equation-of-state and isothermal-heat hypotheses remain in the frozen
physical contract, as specified, although the packaged qualitative
refrigerator laws suffice for this subquestion.

## Verification

- Lean LSP diagnostics: no errors or warnings.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_C_1.lean`: succeeded.
- `lake build IPhO2026Run`: succeeded.
- Source scan: no `sorry`, `admit`, `sorryAx`, custom `axiom`, or suspicious
  proof escape hatch.
- Axiom inspection for both completed theorems reports only the standard
  `propext`, `Classical.choice`, and `Quot.sound`.

## Blueprint status

The proof environments for
`identify_isothermal_reservoir_contacts` and
`identify_temperature_labels_and_heat_processes` are ready for deterministic
`\leanok` synchronization.  The blueprint was not edited because prover
permissions reserve marker updates for the synchronization/review phase.

## Redraft needed

None.
