# Physics LeanExplore Grounding Log

- Target Lean file: `IPhO2026Problems/problem_IPhO_2026_3_A_2.lean`
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_A_2.tex`
- Grounding status: complete
- Search backend: local
- Input fingerprint: sha256:00e1bde5ffec47466da454e556fbdc3c7d8aa0a0ace54c3b5c984bc96cdb479f
- Packages searched: Mathlib, Physlib

## LeanExplore queries/candidates actually used

### Query: `Physics formalization target`
- `Path.target` | module `Mathlib.Topology.Path` | package Mathlib | **Target of a Path.** For a path $\gamma$ from $x$ to $y$ in a topological space, the value of the path at the endpoint of the unit interval, $\gamma(1)$, is equal to $y$.
- `semiformal_result` | module `Physlib.Meta.Informal.SemiFormal` | package PhysLean | A semiformal result is either a - definition in which the type is given but not the definition. - proof in which the proposition is given but not the proof. Semiformal results cannot be used in further code. They are...
- `stereographic_target` | module `Mathlib.Geometry.Manifold.Instances.Sphere` | package Mathlib | **Target of the Stereographic Projection.** For any unit vector $v$ in an inner product space, the target of the stereographic projection associated with $v$ is the entire codomain (the orthogonal complement of the su...

### Query: `Strictly positive scalar`
- `IsStrictlyPositive` | module `Mathlib.Algebra.Algebra.StrictPositivity` | package Mathlib | An element of an ordered algebra is *strictly positive* if it is nonnegative and invertible. NOTE: This definition will be generalized to the non-unital case in the future; do not unfold the definition and use the API...
- `IsScalarTower` | module `Mathlib.Algebra.Group.Action.Defs` | package Mathlib | An instance of `IsScalarTower M N α` states that the multiplicative action of `M` on `α` is determined by the multiplicative actions of `M` on `N` and `N` on `α`.
- `pos_of_smul_pos_left` | module `Mathlib.Algebra.Order.Module.Defs` | package Mathlib | **Positivity of Scalar Multiplication.** If the scalar product $a \cdot b$ is strictly positive and the scalar $a$ is non-negative, then $b$ must be strictly positive, provided that scalar multiplication by non-negati...

### Query: `Toroid geometry and winding data`
- `torusMap_sub_center` | module `Mathlib.MeasureTheory.Integral.TorusIntegral` | package Mathlib | **Translation of the Torus Map Relative to its Center.** For any center $c \in \mathbb{C}^n$, radii $R \in \mathbb{R}^n$, and angles $\theta \in \mathbb{R}^n$, the difference between the torus map centered at $c$ and...
- `AlgebraicGeometry.affineAnd` | module `Mathlib.AlgebraicGeometry.Morphisms.AffineAnd` | package Mathlib | This is the affine target morphism property where the source is affine and the induced map of rings on global sections satisfies `P`.
- `torusMap_eq_center_iff` | module `Mathlib.MeasureTheory.Integral.TorusIntegral` | package Mathlib | **Equality of the Torus Map and its Center.** For a center $c \in \mathbb{C}^n$, a vector of radii $R \in \mathbb{R}^n$, and an angular vector $\theta \in \mathbb{R}^n$, the value of the torus map at $\theta$ is equal...

### Query: `Uniform operating point of the magnetized torus`
- `torusMap_eq_center_iff` | module `Mathlib.MeasureTheory.Integral.TorusIntegral` | package Mathlib | **Equality of the Torus Map and its Center.** For a center $c \in \mathbb{C}^n$, a vector of radii $R \in \mathbb{R}^n$, and an angular vector $\theta \in \mathbb{R}^n$, the value of the torus map at $\theta$ is equal...
- `UniformContinuous` | module `Mathlib.Topology.UniformSpace.Defs` | package Mathlib | A function `f : α → β` is *uniformly continuous* if `(f x, f y)` tends to the diagonal as `(x, y)` tends to the diagonal. In other words, if `x` is sufficiently close to `y`, then `f x` is close to `f y` no matter whe...
- `torusMap` | module `Mathlib.MeasureTheory.Integral.TorusIntegral` | package Mathlib | The n-dimensional exponential map $θ_i ↦ c + R e^{θ_i*I}, θ ∈ ℝⁿ$ representing a torus in `ℂⁿ` with center `c ∈ ℂⁿ` and generalized radius `R ∈ ℝⁿ`, so we can adjust it to every n axis.

### Query: `Quasistatic change with induced EMF (Faraday's law)`
- `Electromagnetism.ElectromagneticPotential.electricField` | module `Physlib.Electromagnetism.Kinematics.ElectricField` | package PhysLean | The electric field from the electromagnetic potential.
- `induced_sInf` | module `Mathlib.Topology.Order` | package Mathlib | **Induced Topology of an Infimum.** For any set of topologies $s$ on a codomain, the topology induced by a function $g$ from the infimum of $s$ is equal to the infimum of the set of topologies induced by $g$ from each...
- `Electromagnetism.ElectromagneticPotential.ofElectromagneticField_electricField` | module `Physlib.Electromagnetism.Kinematics.ElectricField` | package PhysLean | The electric field of the electromagnetic potential created from the electric field `E` and the magnetic field `B` is `E`, as long as Gauss's law for magnetism and Faraday's law are satisfied.

### Query: `Work delivered by the source, as a typed readout`
- `Mathlib.Tactic.ClickSuggestions.SectionKind.currFile` | module `Mathlib.Tactic.ClickSuggestions.SectionState` | package Mathlib | **Current File Section.** Within the classification of declaration sources, this represents the case where a declaration originates from the current file.
- `RigidBody.rigid_body_work_and_power` | module `Physlib.ClassicalMechanics.RigidBody.Basic` | package PhysLean | The power delivered to a rigid body by forces is P = ∑ Fᵢ ⋅ vᵢ = F_tot ⋅ V + M ⋅ ω, where F_tot is total force, V the reference point velocity, and M the torque. Translational and rotational contributions separate.
- `Mathlib.Tactic.ClickSuggestions.SectionKind` | module `Mathlib.Tactic.ClickSuggestions.SectionState` | package Mathlib | Whether the section corresponds to local hypotheses, declarations from the current file, or imported declarations.

### Query: `Source work over an induced-EMF change`
- `ext_coord_change_source` | module `Mathlib.Geometry.Manifold.IsManifold.ExtChartAt` | package Mathlib | **Source of the Extended Coordinate Change.** For any two points $x$ and $x'$ in a manifold $M$, the source of the transition map between the extended charts centered at $x'$ and $x$ is equal to the image under the mo...
- `Electromagnetism.ElectromagneticPotential.electricField` | module `Physlib.Electromagnetism.Kinematics.ElectricField` | package PhysLean | The electric field from the electromagnetic potential.
- `VectorBundleCore.mem_trivChange_source` | module `Mathlib.Topology.VectorBundle.Basic` | package Mathlib | **Domain of the Transition Map for a Vector Bundle.** For a vector bundle core $Z$ over a base space $B$ with fiber $F$, a point $p = (b, v)$ in the product space $B \times F$ belongs to the source of the transition m...

### Query: `A.1 bridge: field strength in A/V parameters`
- `Electromagnetism.DistElectromagneticPotential.fieldStrength_eq_fieldStrengthAux` | module `Physlib.Electromagnetism.Distributional.FieldStrength` | package PhysLean | **Equivalence of Field Strength and Auxiliary Field Strength.** For an electromagnetic potential distribution $A$ in $d$-dimensional spacetime and a Schwartz test function $\varepsilon$, the electromagnetic field stre...
- `Electromagnetism.ElectromagneticPotential.toFieldStrength` | module `Physlib.Electromagnetism.Kinematics.FieldStrength` | package PhysLean | The field strength from an electromagnetic potential, as a tensor `F^{μν}`.
- `Electromagnetism.ElectromagneticPotential.fieldStrengthMatrix` | module `Physlib.Electromagnetism.Kinematics.FieldStrength` | package PhysLean | The matrix corresponding to the field strength in the standard basis.

### Query: `A.2 target: source work dW emf = V H ,dB`
- `Electromagnetism.ElectromagneticPotential.electricField` | module `Physlib.Electromagnetism.Kinematics.ElectricField` | package PhysLean | The electric field from the electromagnetic potential.
- `Electromagnetism.ElectromagneticPotential.IsPlaneWave` | module `Physlib.Electromagnetism.Vacuum.IsPlaneWave` | package PhysLean | The proposition on a electromagnetic potential which is true if it corresponds to a plane wave.
- `Electromagnetism.DistElectromagneticPotential.fieldStrength_eq_fieldStrengthAux` | module `Physlib.Electromagnetism.Distributional.FieldStrength` | package PhysLean | **Equivalence of Field Strength and Auxiliary Field Strength.** For an electromagnetic potential distribution $A$ in $d$-dimensional spacetime and a Schwartz test function $\varepsilon$, the electromagnetic field stre...

### Query: `Is Positive`
- `IsStrictlyPositive` | module `Mathlib.Algebra.Algebra.StrictPositivity` | package Mathlib | An element of an ordered algebra is *strictly positive* if it is nonnegative and invertible. NOTE: This definition will be generalized to the non-unital case in the future; do not unfold the definition and use the API...
- `SignType.pos` | module `Mathlib.Data.Sign.Defs` | package Mathlib | **Positive Sign.** The positive element of the sign type, representing a strictly positive value.
- `IsStrictlyPositive.isUnit` | module `Mathlib.Algebra.Algebra.StrictPositivity` | package Mathlib | **Strictly Positive Elements are Units.** In a monoid equipped with a zero element and a less-than-or-equal relation, any strictly positive element is a unit.

## Grounded Mathlib/PhysLean names

- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)
- `IsStrictlyPositive` (Mathlib)
- `IsScalarTower` (Mathlib)
- `pos_of_smul_pos_left` (Mathlib)
- `torusMap_sub_center` (Mathlib)
- `AlgebraicGeometry.affineAnd` (Mathlib)
- `torusMap_eq_center_iff` (Mathlib)
- `torusMap_eq_center_iff` (Mathlib)
- `UniformContinuous` (Mathlib)
- `torusMap` (Mathlib)
- `Electromagnetism.ElectromagneticPotential.electricField` (PhysLean)
- `induced_sInf` (Mathlib)
- `Electromagnetism.ElectromagneticPotential.ofElectromagneticField_electricField` (PhysLean)
- `Mathlib.Tactic.ClickSuggestions.SectionKind.currFile` (Mathlib)
- `RigidBody.rigid_body_work_and_power` (PhysLean)
- `Mathlib.Tactic.ClickSuggestions.SectionKind` (Mathlib)
- `ext_coord_change_source` (Mathlib)
- `Electromagnetism.ElectromagneticPotential.electricField` (PhysLean)
- `VectorBundleCore.mem_trivChange_source` (Mathlib)
- `Electromagnetism.DistElectromagneticPotential.fieldStrength_eq_fieldStrengthAux` (PhysLean)
- `Electromagnetism.ElectromagneticPotential.toFieldStrength` (PhysLean)
- `Electromagnetism.ElectromagneticPotential.fieldStrengthMatrix` (PhysLean)
- `Electromagnetism.ElectromagneticPotential.electricField` (PhysLean)
- `Electromagnetism.ElectromagneticPotential.IsPlaneWave` (PhysLean)
- `Electromagnetism.DistElectromagneticPotential.fieldStrength_eq_fieldStrengthAux` (PhysLean)
- `IsStrictlyPositive` (Mathlib)
- `SignType.pos` (Mathlib)
- `IsStrictlyPositive.isUnit` (Mathlib)

## Local abstractions introduced

- `IPhO2026_3_A_2.InducedEMFChange`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_3_A_2.IsPositive`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_3_A_2.ToroidData`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_3_A_2.UniformToroidOperatingPoint`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_3_A_2.WorkOnSource`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
