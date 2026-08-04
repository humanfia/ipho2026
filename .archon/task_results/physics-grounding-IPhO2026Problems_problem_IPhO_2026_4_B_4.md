# Physics LeanExplore Grounding Log

- Target Lean file: `IPhO2026Problems/problem_IPhO_2026_4_B_4.lean`
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_B_4.tex`
- Grounding status: complete
- Search backend: local
- Input fingerprint: sha256:36f427802353e1eb10f88ee173e98e7353195d5be3178d79c74600e9d628ba8a
- Packages searched: Mathlib, Physlib

## LeanExplore queries/candidates actually used

### Query: `Physics formalization target`
- `Path.target` | module `Mathlib.Topology.Path` | package Mathlib | **Target of a Path.** For a path $\gamma$ from $x$ to $y$ in a topological space, the value of the path at the endpoint of the unit interval, $\gamma(1)$, is equal to $y$.
- `semiformal_result` | module `Physlib.Meta.Informal.SemiFormal` | package PhysLean | A semiformal result is either a - definition in which the type is given but not the definition. - proof in which the proposition is given but not the proof. Semiformal results cannot be used in further code. They are...
- `stereographic_target` | module `Mathlib.Geometry.Manifold.Instances.Sphere` | package Mathlib | **Target of the Stereographic Projection.** For any unit vector $v$ in an inner product space, the target of the stereographic projection associated with $v$ is the entire codomain (the orthogonal complement of the su...

### Query: `Gas column geometry`
- `IdealGas` | module `Physlib.StatisticalMechanics.MicroCanonicalEnsemble.IdealGas` | package PhysLean | The Hamiltonian for an ideal gas: particles live in a cube of volume V^(1/3), and each contributes an energy p^2/2. The per-particle mass is normalized to 1.
- `AlgebraicGeometry.Spec` | module `Mathlib.AlgebraicGeometry.Scheme` | package Mathlib | The spectrum of a commutative ring, as a scheme. The notation `Spec(R)` for `(R : Type*) [CommRing R]` to mean `Spec (CommRingCat.of R)` is enabled in the scope `SpecOfNotation`. Please do not use it within Mathlib, b...
- `AlgebraicGeometry.Scheme` | module `Mathlib.AlgebraicGeometry.Scheme` | package Mathlib | We define `Scheme` as an `X : LocallyRingedSpace`, along with a proof that every point has an open neighbourhood `U` so that the restriction of `X` to `U` is isomorphic, as a locally ringed space, to `Spec.toLocallyRi...

### Query: `Trapped gas volume`
- `IdealGas.ideal_gas_law` | module `Physlib.StatisticalMechanics.MicroCanonicalEnsemble.IdealGas` | package PhysLean | The ideal gas law: PV = nRT. In our unitsless system, R = 1.
- `Orientation.volumeForm` | module `Mathlib.Analysis.InnerProductSpace.Orientation` | package Mathlib | The volume form on an oriented real inner product space, a nonvanishing top-dimensional alternating form uniquely defined by compatibility with the orientation and inner product structure.
- `IdealGas` | module `Physlib.StatisticalMechanics.MicroCanonicalEnsemble.IdealGas` | package PhysLean | The Hamiltonian for an ideal gas: particles live in a cube of volume V^(1/3), and each contributes an energy p^2/2. The per-particle mass is normalized to 1.

### Query: `B.4 physical data`
- `CanonicalEnsemble.physicalProbability` | module `Physlib.StatisticalMechanics.CanonicalEnsemble.Basic` | package PhysLean | The dimensionless physical probability density. This is is the probability density w.r.t. the measure, obtained by dividing the phase space measure by the fundamental unit `h^dof`, making the probability density `ρ_ph...
- `jacobiSym.at_four` | module `Mathlib.NumberTheory.LegendreSymbol.JacobiSymbol` | package Mathlib | If `b` is odd, then `J(4 | b) = 1`.
- `CanonicalEnsemble.log_physicalProbability` | module `Physlib.StatisticalMechanics.CanonicalEnsemble.Basic` | package PhysLean | **Logarithm of the Physical Probability in a Canonical Ensemble.** For a canonical ensemble with a finite Boltzmann measure and a non-zero reference measure, the logarithm of the physical probability of a state $i$ at...

### Query: `Admissible measured state and reference state`
- `CongrState` | module `Mathlib.Tactic.CongrExclamation` | package Mathlib | **Congruence Tactic State.** A structure representing the state of a congruence-based decomposition process, consisting of a collection of unresolved goals (metavariables) that the procedure could not automatically di...
- `StateT.eval` | module `Mathlib.Control.Monad.Basic` | package Mathlib | run a `StateT` program and discard the final state
- `MeasureTheory.Adapted.measurable` | module `Mathlib.Probability.Process.Adapted` | package Mathlib | **Measurability of Adapted Processes.** If a stochastic process $u$ is adapted to a filtration $\mathcal{F}$ indexed by $\iota$, then for every index $i \in \iota$, the function $u_i$ is measurable with respect to the...

### Query: `Clausius--Clapeyron vapor-pressure relation`
- `NVEHamiltonian.pressure` | module `Physlib.StatisticalMechanics.MicroCanonicalEnsemble.ThermoQuantities` | package PhysLean | Pressure, as a function of T. Defined as the conjugate variable to volume.
- `adiabatic_relation_log` | module `Physlib.Thermodynamics.IdealGas.Basic` | package PhysLean | Adiabatic relation in logarithmic form: If S(Ua,Va,N) = S(Ub,Vb,N) with N fixed, then c * log (Ua/Ub) + log (Va/Vb) = 0.
- `DimPressure` | module `Physlib.Units.WithDim.Pressure` | package PhysLean | Pressure as a dimensional quantity with dimension `ML⁻¹T⁻2`..

### Query: `Dry air carries the whole pressure at the reference state`
- `DimPressure.standardAtmosphere` | module `Physlib.Units.WithDim.Pressure` | package PhysLean | The dimensional pressure corresponding to 1 standard atmosphere (101,325 pascals).
- `IdealGas.ideal_gas_law` | module `Physlib.StatisticalMechanics.MicroCanonicalEnsemble.IdealGas` | package PhysLean | The ideal gas law: PV = nRT. In our unitsless system, R = 1.
- `NVEHamiltonian.pressure` | module `Physlib.StatisticalMechanics.MicroCanonicalEnsemble.ThermoQuantities` | package PhysLean | Pressure, as a function of T. Defined as the conjugate variable to volume.

### Query: `Combined gas-law form at an admitted state`
- `IdealGas.ideal_gas_law` | module `Physlib.StatisticalMechanics.MicroCanonicalEnsemble.IdealGas` | package PhysLean | The ideal gas law: PV = nRT. In our unitsless system, R = 1.
- `IdealGas.helmholtzA_eq` | module `Physlib.StatisticalMechanics.MicroCanonicalEnsemble.IdealGas` | package PhysLean | The Helmholtz Free Energy A for an ideal gas.
- `IdealGas` | module `Physlib.StatisticalMechanics.MicroCanonicalEnsemble.IdealGas` | package PhysLean | The Hamiltonian for an ideal gas: particles live in a cube of volume V^(1/3), and each contributes an energy p^2/2. The per-particle mass is normalized to 1.

### Query: `Zero reference value forces identically zero vapor pressure`
- `NVEHamiltonian.pressure` | module `Physlib.StatisticalMechanics.MicroCanonicalEnsemble.ThermoQuantities` | package PhysLean | Pressure, as a function of T. Defined as the conjugate variable to volume.
- `Electromagnetism.ElectromagneticPotential.zero_val` | module `Physlib.Electromagnetism.Kinematics.EMPotential` | package PhysLean | **Zero Electromagnetic Potential.** The value of the zero electromagnetic potential is equal to zero.
- `DimPressure` | module `Physlib.Units.WithDim.Pressure` | package PhysLean | Pressure as a dimensional quantity with dimension `ML⁻¹T⁻2`..

### Query: `B.4 vapor-pressure readout formula`
- `DimPressure` | module `Physlib.Units.WithDim.Pressure` | package PhysLean | Pressure as a dimensional quantity with dimension `ML⁻¹T⁻2`..
- `Real.logb` | module `Mathlib.Analysis.SpecialFunctions.Log.Base` | package Mathlib | The real logarithm in a given base. As with the natural logarithm, we define `logb b x` to be `logb b |x|` for `x < 0`, and `0` for `x = 0`.
- `IdealGas.ideal_gas_law` | module `Physlib.StatisticalMechanics.MicroCanonicalEnsemble.IdealGas` | package PhysLean | The ideal gas law: PV = nRT. In our unitsless system, R = 1.

## Grounded Mathlib/PhysLean names

- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)
- `IdealGas` (PhysLean)
- `AlgebraicGeometry.Spec` (Mathlib)
- `AlgebraicGeometry.Scheme` (Mathlib)
- `IdealGas.ideal_gas_law` (PhysLean)
- `Orientation.volumeForm` (Mathlib)
- `IdealGas` (PhysLean)
- `CanonicalEnsemble.physicalProbability` (PhysLean)
- `jacobiSym.at_four` (Mathlib)
- `CanonicalEnsemble.log_physicalProbability` (PhysLean)
- `CongrState` (Mathlib)
- `StateT.eval` (Mathlib)
- `MeasureTheory.Adapted.measurable` (Mathlib)
- `NVEHamiltonian.pressure` (PhysLean)
- `adiabatic_relation_log` (PhysLean)
- `DimPressure` (PhysLean)
- `DimPressure.standardAtmosphere` (PhysLean)
- `IdealGas.ideal_gas_law` (PhysLean)
- `NVEHamiltonian.pressure` (PhysLean)
- `IdealGas.ideal_gas_law` (PhysLean)
- `IdealGas.helmholtzA_eq` (PhysLean)
- `IdealGas` (PhysLean)
- `NVEHamiltonian.pressure` (PhysLean)
- `Electromagnetism.ElectromagneticPotential.zero_val` (PhysLean)
- `DimPressure` (PhysLean)
- `DimPressure` (PhysLean)
- `Real.logb` (Mathlib)
- `IdealGas.ideal_gas_law` (PhysLean)

## Local abstractions introduced

- `IPhO2026_4_B_4.ClausiusClapeyron`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_4_B_4.GasColumnGeometry`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_4_B_4.VaporPressureB4Data`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_4_B_4.VaporPressureB4Data.MeasuredState`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
