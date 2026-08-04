# Physics LeanExplore Grounding Log

- Target Lean file: `IPhO2026Problems/problem_IPhO_2026_3_C_3.lean`
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_3.tex`
- Grounding status: complete
- Search backend: local
- Input fingerprint: sha256:daffa18b36cfc9fa55b1e252bf5f3006ac452a7b402fd8487fb72bb9a5e06f91
- Packages searched: Mathlib, Physlib

## LeanExplore queries/candidates actually used

### Query: `Real.sqrt square root`
- `Real.sqrt` | module `Mathlib.Analysis.Real.Sqrt` | package Mathlib | The square root of a real number. This returns 0 for negative inputs. This has notation `√x`. Note that `√x⁻¹` is parsed as `√(x⁻¹)`.
- `Real.coe_sqrt` | module `Mathlib.Analysis.Real.Sqrt` | package Mathlib | **Square Root of Nonnegative Reals.** For any nonnegative real number $x$, the real-valued square root of $x$ is equal to the square root of $x$ computed in the nonnegative real numbers and then cast to a real number.
- `Real.sqrt_lt'` | module `Mathlib.Analysis.Real.Sqrt` | package Mathlib | **Strict Monotonicity of the Square Root.** For any real number $x$ and any positive real number $y$, the square root of $x$ is strictly less than $y$ if and only if $x$ is strictly less than $y^2$.

### Query: `Physics formalization target`
- `Path.target` | module `Mathlib.Topology.Path` | package Mathlib | **Target of a Path.** For a path $\gamma$ from $x$ to $y$ in a topological space, the value of the path at the endpoint of the unit interval, $\gamma(1)$, is equal to $y$.
- `semiformal_result` | module `Physlib.Meta.Informal.SemiFormal` | package PhysLean | A semiformal result is either a - definition in which the type is given but not the definition. - proof in which the proposition is given but not the proof. Semiformal results cannot be used in further code. They are...
- `stereographic_target` | module `Mathlib.Geometry.Manifold.Instances.Sphere` | package Mathlib | **Target of the Stereographic Projection.** For any unit vector $v$ in an inner product space, the target of the stereographic projection associated with $v$ is the entire codomain (the orthogonal complement of the su...

### Query: `Kinds of cycle legs`
- `Equiv.Perm.cycleType` | module `Mathlib.GroupTheory.Perm.Cycle.Type` | package Mathlib | The cycle type of a permutation
- `Equiv.Perm.cycleType_eq` | module `Mathlib.GroupTheory.Perm.Cycle.Type` | package Mathlib | **Cycle Type of a Product of Disjoint Cycles.** Let $\sigma$ be a permutation of a finite set $\alpha$. If $\sigma$ is the product of a list of permutations $l$ such that every permutation in $l$ is a cycle and the el...
- `Equiv.Perm.mem_cycleType_iff` | module `Mathlib.GroupTheory.Perm.Cycle.Type` | package Mathlib | **Membership in the Cycle Type of a Permutation.** For a permutation $\sigma$ of a finite set and a natural number $n$, $n$ belongs to the cycle type of $\sigma$ if and only if $\sigma$ can be decomposed into the prod...

### Query: `Cycle vertex labels`
- `SimpleGraph.cycleGraph.getVert_cycle` | module `Mathlib.Combinatorics.SimpleGraph.CycleGraph` | package Mathlib | **Vertex Mapping of a Cycle Graph.** For a cycle graph on $n+3$ vertices, the $m$-th vertex of the cycle (where $m \le n+3$) is given by the residue class $(n+3-m) \pmod{n+3}$.
- `SimpleGraph.Walk.IsCycle` | module `Mathlib.Combinatorics.SimpleGraph.Paths` | package Mathlib | A *cycle* at `u : V` is a circuit at `u` whose only repeating vertex is `u` (which appears exactly twice).
- `SimpleGraph.cycleGraph_degree_two_le` | module `Mathlib.Combinatorics.SimpleGraph.CycleGraph` | package Mathlib | **Degree of a Vertex in a Cycle Graph.** For any natural number $n \ge 2$, the degree of a vertex $v$ in the cycle graph $C_n$ is equal to the cardinality of the set $\{v - 1, v + 1\}$, where the arithmetic is perform...

### Query: `Carnot-cycle state record`
- `Cycle` | module `Mathlib.Data.List.Cycle` | package Mathlib | `Cycle α` is the quotient of `List α` by cyclic permutation. Duplicates are allowed.
- `adiabatic_relation_UaUbVaVb` | module `Physlib.Thermodynamics.IdealGas.Basic` | package PhysLean | Adiabatic relation in product form: If S(Ua,Va,N) = S(Ub,Vb,N) with N fixed, then (Ua/Ub)^c * (Va/Vb) = 1.
- `Cycle.nil` | module `Mathlib.Data.List.Cycle` | package Mathlib | The unique empty cycle.

### Query: `Paramagnetic-torus parameters`
- `TorusIntegrable` | module `Mathlib.MeasureTheory.Integral.TorusIntegral` | package Mathlib | A function `f : ℂⁿ → E` is integrable on the generalized torus if the function `f ∘ torusMap c R θ` is integrable on `Icc (0 : ℝⁿ) (fun _ ↦ 2 * π)`.
- `HahnSeries.orderTop` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The orderTop of a Hahn series `x` is a minimal element of `WithTop Γ` where `x` has a nonzero coefficient if `x ≠ 0`, and is `⊤` when `x = 0`.
- `torusIntegral` | module `Mathlib.MeasureTheory.Integral.TorusIntegral` | package Mathlib | The integral over a generalized torus with center `c ∈ ℂⁿ` and radius `R ∈ ℝⁿ`, defined as the `•`-product of the derivative of `torusMap` and `f (torusMap c R θ)`

### Query: `Ideal-paramagnet equation of state`
- `Ideal` | module `Mathlib.RingTheory.Ideal.Defs` | package Mathlib | A (left) ideal in a semiring `R` is an additive submonoid `s` such that `a * b ∈ s` whenever `b ∈ s`. If `R` is a ring, then `s` is an additive subgroup.
- `IdealGas.ideal_gas_law` | module `Physlib.StatisticalMechanics.MicroCanonicalEnsemble.IdealGas` | package PhysLean | The ideal gas law: PV = nRT. In our unitsless system, R = 1.
- `WeierstrassCurve.Projective.equation_of_equiv` | module `Mathlib.AlgebraicGeometry.EllipticCurve.Projective.Basic` | package Mathlib | **Invariance of the Weierstrass Equation under Projective Equivalence.** For any two points $P$ and $Q$ in the projective plane represented as triples in $R^3$, if $P$ and $Q$ are projectively equivalent, then $P$ sat...

### Query: `Isothermal heat relation (part B.1)`
- `adiabatic_relation_log` | module `Physlib.Thermodynamics.IdealGas.Basic` | package PhysLean | Adiabatic relation in logarithmic form: If S(Ua,Va,N) = S(Ub,Vb,N) with N fixed, then c * log (Ua/Ub) + log (Va/Vb) = 0.
- `RelIso.symm` | module `Mathlib.Order.RelIso.Basic` | package Mathlib | Inverse map of a relation isomorphism is a relation isomorphism.
- `WeierstrassCurve.b_relation` | module `Mathlib.AlgebraicGeometry.EllipticCurve.Weierstrass` | package Mathlib | **Relation between the $b$-invariants of a Weierstrass curve.** For any Weierstrass curve defined over a commutative ring, the invariants $b_2, b_4, b_6,$ and $b_8$ satisfy the identity $4b_8 = b_2b_6 - b_4^2$.

### Query: `Carnot heat ratio`
- `CanonicalEnsemble.heatCapacity` | module `Physlib.StatisticalMechanics.CanonicalEnsemble.Lemmas` | package PhysLean | The heat capacity (at constant volume) C_V = ∂U/∂T (as a derivWithin on T > 0).
- `HahnSeries.orderTop` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The orderTop of a Hahn series `x` is a minimal element of `WithTop Γ` where `x` has a nonzero coefficient if `x ≠ 0`, and is `⊤` when `x = 0`.
- `adiabatic_relation_UaUbVaVb` | module `Physlib.Thermodynamics.IdealGas.Basic` | package PhysLean | Adiabatic relation in product form: If S(Ua,Va,N) = S(Ub,Vb,N) with N fixed, then (Ua/Ub)^c * (Va/Vb) = 1.

### Query: `Figure-3b vertex assignment (part C.1)`
- `Polynomial.C_1` | module `Mathlib.Algebra.Polynomial.Basic` | package Mathlib | **Constant Polynomial of Unity.** The constant polynomial map $C$ sends the multiplicative identity $1$ of a semiring to the multiplicative identity $1$ of the corresponding polynomial ring.
- `SimpleGraph.TripartiteFromTriangles.graph` | module `Mathlib.Combinatorics.SimpleGraph.Triangle.Tripartite` | package Mathlib | The tripartite-from-triangles graph. Two vertices are related iff there exists a triangle index containing them both.
- `MSSMACC.AnomalyFreePerp.InQuadCube` | module `Physlib.Particles.SuperSymmetry.MSSMNu.AnomalyCancellation.OrthogY3B3.ToSols` | package PhysLean | Those charge assignments perpendicular to `Y₃` and `B₃` which satisfy the conditions `lineEqProp`, `inQuadProp` and `inCubeProp`.

## Grounded Mathlib/PhysLean names

- `Real.sqrt` (Mathlib)
- `Real.coe_sqrt` (Mathlib)
- `Real.sqrt_lt'` (Mathlib)
- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)
- `Equiv.Perm.cycleType` (Mathlib)
- `Equiv.Perm.cycleType_eq` (Mathlib)
- `Equiv.Perm.mem_cycleType_iff` (Mathlib)
- `SimpleGraph.cycleGraph.getVert_cycle` (Mathlib)
- `SimpleGraph.Walk.IsCycle` (Mathlib)
- `SimpleGraph.cycleGraph_degree_two_le` (Mathlib)
- `Cycle` (Mathlib)
- `adiabatic_relation_UaUbVaVb` (PhysLean)
- `Cycle.nil` (Mathlib)
- `TorusIntegrable` (Mathlib)
- `HahnSeries.orderTop` (Mathlib)
- `torusIntegral` (Mathlib)
- `Ideal` (Mathlib)
- `IdealGas.ideal_gas_law` (PhysLean)
- `WeierstrassCurve.Projective.equation_of_equiv` (Mathlib)
- `adiabatic_relation_log` (PhysLean)
- `RelIso.symm` (Mathlib)
- `WeierstrassCurve.b_relation` (Mathlib)
- `CanonicalEnsemble.heatCapacity` (PhysLean)
- `HahnSeries.orderTop` (Mathlib)
- `adiabatic_relation_UaUbVaVb` (PhysLean)
- `Polynomial.C_1` (Mathlib)
- `SimpleGraph.TripartiteFromTriangles.graph` (Mathlib)
- `MSSMACC.AnomalyFreePerp.InQuadCube` (PhysLean)

## Local abstractions introduced

- `IPhO2026.Problem3.C3.CarnotCycle`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C3.CarnotHeatRatio`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C3.ConstantCapacityCalorimetry`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C3.EquationOfStateParamagnet`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C3.Figure3bAssignment`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C3.IsothermalHeatIntoTorus`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C3.PotassiumChromateCoolingRun`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C3.PotassiumChromateCoolingRun.H1`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C3.PotassiumChromateCoolingRun.H2`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C3.PotassiumChromateCoolingRun.H3`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C3.PotassiumChromateCoolingRun.H4`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C3.PotassiumChromateCoolingRun.Qc_cold_leg`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C3.PotassiumChromateCoolingRun.Qh_hot_leg`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C3.PotassiumChromateCoolingRun.TFinal_from_calorimetry`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C3.ProcessKind`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C3.SuppliedMaterialData`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C3.TorusParams`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C3.TorusVolumeFromSource`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C3.Vertex`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
