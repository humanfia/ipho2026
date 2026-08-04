# Iteration 010 proof plan

## Current Objectives

1. **`IPhO2026Problems/problem_IPhO_2026_3_C_1.lean`** — Deterministically selected new proof target; fill 2 open Lean placeholder(s) without weakening the statement. [prover-mode: physics]

## Per-target proof strategy

### 1. `IPhO2026Problems/problem_IPhO_2026_3_C_1.lean`

- Freeze both theorem signatures and all physical hypotheses. In particular,
  retain the equation-of-state and isothermal-heat-relation assumptions even
  though the accepted refrigerator-law interface already supplies the
  qualitative consequences used by the final proof.
- For `identify_isothermal_reservoir_contacts`, use the two figure
  isothermal classifications with the laws' isothermal-contact existence
  field. Destructure both witnesses and case-split on the finite
  `Reservoir` labels. For the cold/cold and hot/hot branches, apply endpoint
  equilibrium to states 2 and 1 and contradict the figure's strict
  temperature ordering. For the hot/cold branch, rewrite that ordering via
  endpoint equilibrium to obtain \(T_h<T_c\), contradicting the laws'
  \(T_c<T_h\). The remaining cold/hot branch is exactly the conjunction.
- For `identify_temperature_labels_and_heat_processes`, first obtain both
  contact equalities from the bridge theorem. Apply endpoint equilibrium on
  \(2\to3\) and \(4\to1\); simplify `reservoirTemperature` to read off states
  2 and 3 at the cold temperature and states 4 and 1 at the hot temperature.
  Apply `heat_transfer_at_reservoir` to those same equalities for the two
  isothermal heat labels. Apply the adiabatic no-transfer law to the figure's
  \(1\to2\) and \(3\to4\) classifications. Assemble the nested conjunction
  in the statement's exact order.
- Validate each body with the target's Lean goal/diagnostics, then run
  `lake env lean IPhO2026Problems/problem_IPhO_2026_3_C_1.lean`. Require zero
  placeholders, no proof escape hatches or new axioms, and Proof Review
  acceptance before the full 23-theory-target build.

## Blueprint correction

- Added the missing final C.1 theorem block to the listed chapter. It now
  preserves all four temperature labels, both isothermal heat directions,
  both adiabatic no-transfer conclusions, and both governing-law hypotheses.
