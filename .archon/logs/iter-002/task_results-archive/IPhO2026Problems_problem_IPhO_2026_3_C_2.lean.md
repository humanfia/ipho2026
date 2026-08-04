# Autoformalization result: IPhO 2026 problem 3 C.2

## Assumption/target split

### Governing laws

- `SatisfiesParamagneticCarnotLaws.equationOfState` states
  \(T M V = n K H\) at each of the four labeled vertices.
- `SatisfiesParamagneticCarnotLaws.coldIsothermalHeat` instantiates the
  part-B isothermal heat law on the oriented leg \(2\to3\), with \(Q_c\)
  positive into the torus.
- `SatisfiesParamagneticCarnotLaws.hotIsothermalHeat` instantiates the same
  law on \(4\to1\), with signed heat into the torus equal to \(-Q_h\).
- `SatisfiesParamagneticCarnotLaws.carnotEntropyBalance` states the reversible
  Carnot relation \(Q_h/T_h=Q_c/T_c\).
- Positivity fields on the reservoir temperatures and torus parameters make
  all divisions and cancellations used by the intended derivation legitimate.

### Previous-part results

- B.1 is represented by the two oriented isothermal heat-law equations, not by
  an import of the B.1 Lean output.
- C.1 is represented by `state_one_at_hot`, `state_four_at_hot`,
  `state_two_at_cold`, and `state_three_at_cold`, together with the heat-flow
  sign conventions on \(2\to3\) and \(4\to1\). No sibling Lean output is
  imported.

### Figure/data readouts

- `CycleVertex` records labels \(1,2,3,4\).
- `CycleLeg`, `CycleLeg.initial`, and `CycleLeg.final` record the oriented
  route \(1\to2\to3\to4\to1\).
- `CycleLeg.processKind` records the two adiabatic legs, cold-isothermal heat
  absorption on \(2\to3\), and hot-isothermal heat rejection on \(4\to1\).
- `CarnotCycleData` records \(T_h,T_c,Q_h,Q_c\), all four states, and
  \(T_c<T_h\).
- `ParamagneticTorus` records \(V,n,K,\mu_0\).
- The physical quantities use Physlib dimension tags. In particular,
  \(H\) and \(M\) have dimension `A / m`, \(V\) has `m³`, \(K\) has
  temperature-times-volume, \(\mu_0\) has `kg m / C²`, and heat has the
  energy dimension.

### Current target conclusions

- Derived bridge conclusion `magnetization_square_balance`:
  \(M_1^2-M_4^2=M_2^2-M_3^2\).
- Final conclusion `magnetization_at_state_one`:
  \(M_1=\sqrt{M_2^2-M_3^2+M_4^2}\), on the nonnegative magnitude branch.

## Goal-faithfulness audit

Neither target conclusion occurs in `CarnotCycleData`,
`ParamagneticTorus`, `ThermodynamicState`, or
`SatisfiesParamagneticCarnotLaws`. The law structure contains only the source
equation of state, the reusable isothermal heat law with its two physical sign
conventions, and the general reversible-Carnot entropy balance.

`siValue`, `magnetizationSI`, `magneticFieldSI`, and `stateTemperatureSI`
are coordinate projections/naming helpers; unfolding them does not prove
either target. `CycleLeg.processKind` is a figure and previous-part readout,
not a hidden algebraic answer. Nonnegativity of magnetization is the stated
magnitude/branch information and does not imply the requested expression
without the governing-law equations.

The radicand's nonnegativity is deliberately not assumed. It is intended to be
derived from `magnetization_square_balance`, because the radicand then equals
\(M_1^2\).

## Derivability and bridge obligations

1. **Source claim:** replace each \(H_i\) by the corresponding
   \(T_i M_i V/(nK)\).
   **Lean carrier:** `SatisfiesParamagneticCarnotLaws.equationOfState`,
   the four reservoir-temperature readouts in `CarnotCycleData`, and the
   positivity fields for \(n,K\).
   **Evidence:** these are explicit equalities and strict inequalities, so
   field cancellation is available.
   **Status:** covered.

2. **Source claim:** compute \(Q_c\) on \(2\to3\) and signed heat \(-Q_h\)
   on \(4\to1\) from the part-B isothermal law.
   **Lean carrier:** `coldIsothermalHeat` and `hotIsothermalHeat`.
   **Evidence:** both fields expose the full equations, including initial and
   final magnetic fields and the heat-flow signs.
   **Status:** covered.

3. **Source claim:** relate the two heat magnitudes in a reversible Carnot
   cycle.
   **Lean carrier:** `carnotEntropyBalance`.
   **Evidence:** the field directly states \(Q_h/T_h=Q_c/T_c\), independently
   of the requested magnetization relation.
   **Status:** covered.

4. **Source claim:** after substituting the equation of state into both heat
   laws, cancel the common nonzero factor
   \(\mu_0 V^2/(2nK)\).
   **Lean carrier:** theorem contract `magnetization_square_balance`, with
   `volume_pos`, `constituentCount_pos`, `curieConstant_pos`, and
   `vacuumPermeability_pos` providing the cancellation side conditions.
   **Evidence:** the exposed law equations algebraically force
   \(M_1^2-M_4^2=M_2^2-M_3^2\); no additional physics premise is needed.
   **Status:** covered at statement level; proof body intentionally deferred
   with `sorry` in the autoformalize stage.

5. **Source claim:** select the nonnegative square-root branch.
   **Lean carrier:** `ThermodynamicState.magnetization_nonneg`,
   `magnetization_square_balance`, Mathlib's `Real.sqrt`, and the theorem
   contract `magnetization_at_state_one`.
   **Evidence:** the square balance rewrites the radicand as \(M_1^2\), and
   the state field supplies \(0\le M_1\).
   **Status:** covered at statement level; proof body intentionally deferred
   with `sorry`.

6. **Source-to-contract mapping:** the recorded answer itself.
   **Lean carrier:** `IPhO2026Problem3C2.magnetization_at_state_one`.
   **Evidence:** its conclusion is the recorded formula verbatim at the level
   of SI magnetization-magnitude readouts.
   **Status:** covered.

## Abstraction sufficiency and countermodel audit

The only local abstract `Prop`-valued interface is
`SatisfiesParamagneticCarnotLaws`. It is constraining because its projections
are three explicit physical equations (equation of state and two oriented heat
laws) plus one explicit Carnot heat-ratio equation. It is not an opaque
existence predicate.

Countermodel check: under the positive \(V,n,K,\mu_0,T_h,T_c\) assumptions,
the four equation-of-state instances determine the relevant \(H_i\) in terms
of \(T_iM_i\). Substitution into the two heat equations and use of the Carnot
balance force the square balance after cancellation of a strictly positive
common factor. Therefore the law fields cannot be interpreted arbitrarily
while keeping all assumptions true and making the square-balance conclusion
false. Magnetization nonnegativity then rules out the negative square-root
branch.

`ThermodynamicState`, `ParamagneticTorus`, and `CarnotCycleData` are data
structures in `Type`, not opaque `Prop` relations. Their proposition-valued
fields expose the required equalities and inequalities directly.

## Uncertainty and branch coverage

- **Uncertainty:** not applicable. The source gives no `value ± uncertainty`,
  experimental error bar, or tolerance.
- **Square-root sign branch:** covered by
  `ThermodynamicState.magnetization_nonneg` and the use of `Real.sqrt`.
- **Cycle orientation:** covered by `CycleLeg`, its endpoint maps, and the
  signed heat equations for \(2\to3\) and \(4\to1\).
- **Hot/cold branch:** covered by the four state-temperature equalities and
  `cold_lt_hot`.

## Declarations created and blueprint mapping

- Physical infrastructure: `magneticIntensityDimension`,
  `volumeDimension`, `curieConstantDimension`,
  `vacuumPermeabilityDimension`, `energyDimension`, `PhysicalQuantity`,
  the seven named physical-quantity types, and `siValue`.
- Figure infrastructure: `CycleVertex`, `CycleLeg`,
  `CycleLeg.initial`, `CycleLeg.final`, `CycleProcessKind`, and
  `CycleLeg.processKind`.
- Model infrastructure: `ThermodynamicState`, `ParamagneticTorus`,
  `CarnotCycleData`, `magnetizationSI`, `magneticFieldSI`,
  `stateTemperatureSI`, and `SatisfiesParamagneticCarnotLaws`.
- Derived declarations:
  `IPhO2026Problem3C2.magnetization_square_balance` and
  `IPhO2026Problem3C2.magnetization_at_state_one`.
- Blueprint label `thm:physics:IPhO_2026_3_C_2:target` corresponds primarily
  to `IPhO2026Problem3C2.magnetization_at_state_one`; the square-balance
  theorem is its explicit derivation bridge.
- The existing blueprint environment is ready for the deterministic
  `\leanok` synchronization. Per prover write permissions, the chapter was
  not edited. A future semantic pass may add
  `\lean{IPhO2026Problem3C2.magnetization_at_state_one}`.

## LeanExplore queries/candidates actually used

- Query `physical dimensions unitful quantity SI units magnetization magnetic
  field temperature volume heat`: used candidates `Dimension`,
  `UnitChoices.SI`, and the dimension-system grounding.
- Query `PhysLean.Units Quantity SI`: used `UnitChoices.SI` and the
  dimension-tagged-quantity approach.
- Query `WithDim dimension-tagged physical quantity definition`: used
  `WithDim`; source and module `Physlib.Units.WithDim.Basic` were fetched.
- Query `Real.sqrt`: used `Real.sqrt`; source, docstring, and module
  `Mathlib.Analysis.Real.Sqrt` were fetched.
- Query `Real.sqrt_sq_eq_abs nonnegative square root equality`: inspected
  `NNReal.sqrt_sq`, `NNReal.sq_sqrt`, and
  `NNReal.sqrt_eq_iff_eq_sq`. These were near matches but were not used
  because the official target is most faithfully stated with a real radicand
  and `Real.sqrt`.
- Query `Carnot refrigerator heat ratio temperature thermodynamics`: found no
  dedicated Carnot-cycle theorem suitable for this contract.

## PhysLean/Mathlib names grounded

- Physlib/PhysLean: `Dimension`, `Dimension.L𝓭`, `Dimension.T𝓭`,
  `Dimension.M𝓭`, `Dimension.C𝓭`, `Dimension.Θ𝓭`, `WithDim`,
  `Dimensionful`, and `UnitChoices.SI`.
- Mathlib: `Real.sqrt`.

## Local abstractions introduced

- The five problem-specific derived dimensions identify the dimensional roles
  absent as named Physlib aliases.
- `CycleVertex`, `CycleLeg`, and `CycleProcessKind` preserve the figure labels,
  orientation, and process kinds.
- The three data structures preserve the distinction between a physical
  dimensionful quantity and its real SI readout.
- `SatisfiesParamagneticCarnotLaws` supplies the smallest explicit local
  governing-law interface found sufficient for the derivation.

## Grounding gaps

- LeanExplore exposed a general Physlib dimension system but no ready-made
  magnetization-magnitude, paramagnetic equation-of-state, isothermal magnetic
  heat, or reversible Carnot refrigerator API. These are represented locally
  by dimension-tagged quantities and explicit equations rather than guessed
  library names.
- The `archon dag-query` navigation command was unavailable on this prover
  process's `PATH`; the blueprint itself specifies that previous parts are
  natural-language prerequisites only, so no sibling Lean dependency was
  introduced.
- No formalization redraft is requested.

## Verification

- LSP diagnostics: no errors; exactly two expected `declaration uses sorry`
  warnings, for the two derived theorems.
- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_C_2.lean`: exit code
  `0`, with the same two expected warnings.
- Project-default `lake build`: completed successfully.
