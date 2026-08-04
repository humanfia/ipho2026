# Physics LeanExplore Grounding Log

- Target Lean file: `IPhO2026Problems/problem_IPhO_2026_3_C_4.lean`
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_4.tex`
- Grounding status: complete
- Search backend: local
- Input fingerprint: sha256:1fc704ab4be0932f157533a40662b99cf85820b7cd12585e943d57799b32cb44
- Packages searched: Mathlib, Physlib

## LeanExplore queries/candidates actually used

### Query: `Physics formalization target`
- `Path.target` | module `Mathlib.Topology.Path` | package Mathlib | **Target of a Path.** For a path $\gamma$ from $x$ to $y$ in a topological space, the value of the path at the endpoint of the unit interval, $\gamma(1)$, is equal to $y$.
- `semiformal_result` | module `Physlib.Meta.Informal.SemiFormal` | package PhysLean | A semiformal result is either a - definition in which the type is given but not the definition. - proof in which the proposition is given but not the proof. Semiformal results cannot be used in further code. They are...
- `stereographic_target` | module `Mathlib.Geometry.Manifold.Instances.Sphere` | package Mathlib | **Target of the Stereographic Projection.** For any unit vector $v$ in an inner product space, the target of the stereographic projection associated with $v$ is the entire codomain (the orthogonal complement of the su...

### Query: `Global scalar quantities of the run`
- `WriterT.runThe` | module `Mathlib.Control.Monad.Writer` | package Mathlib | **Writer Transformer Execution.** The operation `runThe` executes a writer monad transformer action for a specified accumulation type, returning the underlying monadic computation of a pair containing the result and t...
- `IsScalarTower` | module `Mathlib.Algebra.Group.Action.Defs` | package Mathlib | An instance of `IsScalarTower M N α` states that the multiplicative action of `M` on `α` is determined by the multiplicative actions of `M` on `N` and `N` on `α`.
- `Mathlib.Tactic.Algebra.collectScalarRings` | module `Mathlib.Tactic.Algebra.Basic` | package Mathlib | Collect all scalar rings from scalar multiplications and `algebraMap` applications in the expression.

### Query: `Torus parameters 0, n, K, V`
- `torusMap_eq_center_iff` | module `Mathlib.MeasureTheory.Integral.TorusIntegral` | package Mathlib | **Equality of the Torus Map and its Center.** For a center $c \in \mathbb{C}^n$, a vector of radii $R \in \mathbb{R}^n$, and an angular vector $\theta \in \mathbb{R}^n$, the value of the torus map at $\theta$ is equal...
- `Polynomial.Chebyshev.T` | module `Mathlib.RingTheory.Polynomial.Chebyshev` | package Mathlib | `T n` is the `n`-th Chebyshev polynomial of the first kind.
- `gronwallBound_of_K_ne_0` | module `Mathlib.Analysis.ODE.Gronwall` | package Mathlib | **Grönwall Bound for Non-zero Growth Rates.** For any real numbers $\delta, K,$ and $\epsilon$, if $K \neq 0$, then the Grönwall bound function is given by $x \mapsto \delta e^{Kx} + \frac{\epsilon}{K}(e^{Kx} - 1)$.

### Query: `Working state (T,H,M)`
- `Turing.TM2to1.Λ'.ret` | module `Mathlib.Computability.TuringMachine.StackTuringMachine` | package Mathlib | **Return State of the TM2 Emulator.** The return state is a state in the Turing machine emulating a multi-stack machine, parameterized by a specific statement from the original machine's program. It signifies the phas...
- `Turing.TM2to1.Λ'` | module `Mathlib.Computability.TuringMachine.StackTuringMachine` | package Mathlib | The machine states of the TM2 emulator. We can either be in a normal state when waiting for the next TM2 action, or we can be in the "go" and "return" states to go to the top of the stack and return to the bottom, res...
- `Turing.TM0to1.Λ'` | module `Mathlib.Computability.TuringMachine.PostTuringMachine` | package Mathlib | The machine states for a TM1 emulating a TM0 machine. States of the TM0 machine are embedded as `normal q` states, but the actual operation is split into two parts, a jump to `act s q` followed by the action and a jum...

### Query: `Cycle corners 1,2,3,4`
- `SimpleGraph.cycleGraph` | module `Mathlib.Combinatorics.SimpleGraph.CycleGraph` | package Mathlib | Cycle graph over `Fin n`
- `Fin.isThreeCycle_cycleRange_two` | module `Mathlib.GroupTheory.Perm.Fin` | package Mathlib | **Three-cycle Property of the Range Cycle.** For any natural number $n$, the permutation of the set $\{0, 1, \dots, n+2\}$ defined by the cycle $(0 \ 1 \ 2)$ is a three-cycle.
- `Equiv.Perm.IsThreeCycle.isCycle` | module `Mathlib.GroupTheory.Perm.Cycle.Type` | package Mathlib | **Three-cycles are cycles.** Every three-cycle of a finite set is a cycle.

### Query: `Cooling-run densities`
- `MeasureTheory.Measure.withDensity` | module `Mathlib.MeasureTheory.Measure.WithDensity` | package Mathlib | Given a measure `μ : Measure α` and a function `f : α → ℝ≥0∞`, `μ.withDensity f` is the measure such that for a measurable set `s` we have `μ.withDensity f s = ∫⁻ a in s, f a ∂μ`.
- `MeasureTheory.Measure.withDensity_sub` | module `Mathlib.MeasureTheory.Measure.SubFinite` | package Mathlib | **Linearty of Measure Density under Subtraction.** Given two measurable functions $f, g: \alpha \to [0, \infty]$, if the measure induced by the density $g$ with respect to $\mu$ is finite, then the measure with densit...
- `MeasureTheory.withDensity_zero_left` | module `Mathlib.MeasureTheory.Measure.WithDensity` | package Mathlib | **Density with Respect to the Zero Measure.** For any function $f$ mapping into the extended nonnegative real numbers, the measure obtained by taking the density $f$ with respect to the zero measure is itself the zero...

### Query: `Regime assumptions of the cooling branch`
- `Mathlib.Tactic.Linarith.Branch` | module `Mathlib.Tactic.Linarith.Datatypes` | package Mathlib | Some preprocessors perform branching case splits. A `Branch` is used to track one of these case splits. The first component, an `MVarId`, is the goal corresponding to this branch of the split, given as a metavariable....
- `Turing.TM2.Stmt.branch` | module `Mathlib.Computability.TuringMachine.StackTuringMachine` | package Mathlib | **Conditional Branching Statement.** The `branch` constructor defines a control flow instruction that takes a predicate on the internal state and two statements; it executes the first statement if the predicate evalua...
- `Physlib.FourTree.Branch` | module `Physlib.Mathematics.DataStructures.FourTree.Basic` | package PhysLean | A branch has the data of a term of type `α2` and a multiset of type `Twig α3 α4`.

### Query: `Equation of state of the ideal paramagnet`
- `WeierstrassCurve.Affine.Equation` | module `Mathlib.AlgebraicGeometry.EllipticCurve.Affine.Basic` | package Mathlib | The proposition that an affine point `(x, y)` lies in a Weierstrass curve `W`. In other words, it satisfies the Weierstrass equation `W(X, Y) = 0`.
- `IdealGas.ideal_gas_law` | module `Physlib.StatisticalMechanics.MicroCanonicalEnsemble.IdealGas` | package PhysLean | The ideal gas law: PV = nRT. In our unitsless system, R = 1.
- `adiabatic_relation_UaUbVaVb` | module `Physlib.Thermodynamics.IdealGas.Basic` | package PhysLean | Adiabatic relation in product form: If S(Ua,Va,N) = S(Ub,Vb,N) with N fixed, then (Ua/Ub)^c * (Va/Vb) = 1.

### Query: `Isothermal heat relation into the torus`
- `torusMap_eq_center_iff` | module `Mathlib.MeasureTheory.Integral.TorusIntegral` | package Mathlib | **Equality of the Torus Map and its Center.** For a center $c \in \mathbb{C}^n$, a vector of radii $R \in \mathbb{R}^n$, and an angular vector $\theta \in \mathbb{R}^n$, the value of the torus map at $\theta$ is equal...
- `RelIso.symm` | module `Mathlib.Order.RelIso.Basic` | package Mathlib | Inverse map of a relation isomorphism is a relation isomorphism.
- `CanonicalEnsemble.heatCapacity` | module `Physlib.StatisticalMechanics.CanonicalEnsemble.Lemmas` | package PhysLean | The heat capacity (at constant volume) C_V = ∂U/∂T (as a derivWithin on T > 0).

### Query: `Carnot heat ratio, refrigerator branch`
- `CanonicalEnsemble.heatCapacity` | module `Physlib.StatisticalMechanics.CanonicalEnsemble.Lemmas` | package PhysLean | The heat capacity (at constant volume) C_V = ∂U/∂T (as a derivWithin on T > 0).
- `HahnSeries.orderTop` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The orderTop of a Hahn series `x` is a minimal element of `WithTop Γ` where `x` has a nonzero coefficient if `x ≠ 0`, and is `⊤` when `x = 0`.
- `adiabatic_relation_UaUbVaVb` | module `Physlib.Thermodynamics.IdealGas.Basic` | package PhysLean | Adiabatic relation in product form: If S(Ua,Va,N) = S(Ub,Vb,N) with N fixed, then (Ua/Ub)^c * (Va/Vb) = 1.

## Grounded Mathlib/PhysLean names

- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)
- `WriterT.runThe` (Mathlib)
- `IsScalarTower` (Mathlib)
- `Mathlib.Tactic.Algebra.collectScalarRings` (Mathlib)
- `torusMap_eq_center_iff` (Mathlib)
- `Polynomial.Chebyshev.T` (Mathlib)
- `gronwallBound_of_K_ne_0` (Mathlib)
- `Turing.TM2to1.Λ'.ret` (Mathlib)
- `Turing.TM2to1.Λ'` (Mathlib)
- `Turing.TM0to1.Λ'` (Mathlib)
- `SimpleGraph.cycleGraph` (Mathlib)
- `Fin.isThreeCycle_cycleRange_two` (Mathlib)
- `Equiv.Perm.IsThreeCycle.isCycle` (Mathlib)
- `MeasureTheory.Measure.withDensity` (Mathlib)
- `MeasureTheory.Measure.withDensity_sub` (Mathlib)
- `MeasureTheory.withDensity_zero_left` (Mathlib)
- `Mathlib.Tactic.Linarith.Branch` (Mathlib)
- `Turing.TM2.Stmt.branch` (Mathlib)
- `Physlib.FourTree.Branch` (PhysLean)
- `WeierstrassCurve.Affine.Equation` (Mathlib)
- `IdealGas.ideal_gas_law` (PhysLean)
- `adiabatic_relation_UaUbVaVb` (PhysLean)
- `torusMap_eq_center_iff` (Mathlib)
- `RelIso.symm` (Mathlib)
- `CanonicalEnsemble.heatCapacity` (PhysLean)
- `CanonicalEnsemble.heatCapacity` (PhysLean)
- `HahnSeries.orderTop` (Mathlib)
- `adiabatic_relation_UaUbVaVb` (PhysLean)

## Local abstractions introduced

- `IPhO2026.Problem3.C4.BodyCalorimeterDensityLaw`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C4.CarnotHeatRatio`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C4.ConstantPowerDensityLaw`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C4.CoolingRun`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C4.CycleCorners`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C4.CycleWorkHeatBalance`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C4.Figure3bCorners`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C4.InfinitesimalCycleLaw`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C4.IsCoolingRun`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C4.IsothermalHeatIntoTorus`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C4.ParamagnetEOS`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C4.RegimeAssumptions`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C4.TorusParams`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C4.WorkingState`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
