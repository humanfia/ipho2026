# Physics LeanExplore Grounding Log

- Target Lean file: `IPhO2026Problems/problem_IPhO_2026_1_A_1.lean`
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_A_1.tex`
- Grounding status: complete
- Search backend: local
- Input fingerprint: sha256:b24cdaa524537e53e14b02048d3fc3269443b8e945a8151912d289dcff98da8d
- Packages searched: Mathlib, Physlib

## LeanExplore queries/candidates actually used

### Query: `Real.sqrt square root`
- `Real.sqrt` | module `Mathlib.Analysis.Real.Sqrt` | package Mathlib | The square root of a real number. This returns 0 for negative inputs. This has notation `√x`. Note that `√x⁻¹` is parsed as `√(x⁻¹)`.
- `Real.coe_sqrt` | module `Mathlib.Analysis.Real.Sqrt` | package Mathlib | **Square Root of Nonnegative Reals.** For any nonnegative real number $x$, the real-valued square root of $x$ is equal to the square root of $x$ computed in the nonnegative real numbers and then cast to a real number.
- `Real.sqrt_lt'` | module `Mathlib.Analysis.Real.Sqrt` | package Mathlib | **Strict Monotonicity of the Square Root.** For any real number $x$ and any positive real number $y$, the square root of $x$ is strictly less than $y$ if and only if $x$ is strictly less than $y^2$.

### Query: `EuclideanSpace vector components`
- `EuclideanSpace` | module `Mathlib.Analysis.InnerProductSpace.PiL2` | package Mathlib | The standard real/complex Euclidean space, functions on a finite type. For an `n`-dimensional space use `EuclideanSpace 𝕜 (Fin n)`. For the case when `n = Fin _`, there is `!₂[x, y, ...]` notation for building element...
- `Space.fderiv_space_components` | module `Physlib.SpaceAndTime.Space.Module` | package PhysLean | **Components of the Fréchet Derivative of a Vector-Valued Function.** For a differentiable function $f$ mapping from a normed space $M$ to the space of $d$-dimensional vectors $\mathbb{R}^d$, the $\mu$-th component of...
- `Lorentz.ContrMod.toSpace` | module `Physlib.Relativity.Tensors.RealTensor.Vector.Pre.Modules` | package PhysLean | The underlying space part of a `ContrMod` formed by removing the first element. A better name for this might be `tail`.

### Query: `Physics formalization target`
- `Path.target` | module `Mathlib.Topology.Path` | package Mathlib | **Target of a Path.** For a path $\gamma$ from $x$ to $y$ in a topological space, the value of the path at the endpoint of the unit interval, $\gamma(1)$, is equal to $y$.
- `semiformal_result` | module `Physlib.Meta.Informal.SemiFormal` | package PhysLean | A semiformal result is either a - definition in which the type is given but not the definition. - proof in which the proposition is given but not the proof. Semiformal results cannot be used in further code. They are...
- `stereographic_target` | module `Mathlib.Geometry.Manifold.Instances.Sphere` | package Mathlib | **Target of the Stereographic Projection.** For any unit vector $v$ in an inner product space, the target of the stereographic projection associated with $v$ is the entire codomain (the orthogonal complement of the su...

### Query: `Transverse figure plane`
- `UpperHalfPlane` | module `Mathlib.Analysis.Complex.UpperHalfPlane.Basic` | package Mathlib | The open upper half plane, denoted as `ℍ` within the `UpperHalfPlane` namespace
- `ClassicalMechanics.transverseHarmonicPlaneWave` | module `Physlib.ClassicalMechanics.WaveEquation.HarmonicWave` | package PhysLean | Transverse monochromatic time-harmonic plane wave where the direction of propagation is taken to be `EuclideanSpace.single 2 1`. `f₀x` and `f₀y` are the respective amplitudes, `ω` is the angular frequency, `δx` and `δ...
- `YoungDiagram.transpose` | module `Mathlib.Combinatorics.Young.YoungDiagram` | package Mathlib | The `transpose` of a Young diagram is obtained by swapping i's with j's.

### Query: `Water density`
- `MeasureTheory.Measure.withDensity` | module `Mathlib.MeasureTheory.Measure.WithDensity` | package Mathlib | Given a measure `μ : Measure α` and a function `f : α → ℝ≥0∞`, `μ.withDensity f` is the measure such that for a measurable set `s` we have `μ.withDensity f s = ∫⁻ a in s, f a ∂μ`.
- `jacobson_density` | module `Mathlib.RingTheory.SimpleModule.Basic` | package Mathlib | **Jacobson Density Theorem.** Let $M$ be a module over a ring $R$. For any endomorphism $f$ of $M$ that commutes with all $R$-linear endomorphisms of $M$ (i.e., $f \in \text{End}_{\text{End}_R(M)}(M)$) and for any fin...
- `Finset.dens_eq_card_div_card` | module `Mathlib.Data.Finset.Density` | package Mathlib | **Density of a Finite Set.** For any finite set $s$ contained in a finite type $\alpha$, the density of $s$ is equal to the cardinality of $s$ divided by the cardinality of $\alpha$.

### Query: `Cube side length`
- `Cube.boundary` | module `Mathlib.Topology.Homotopy.HomotopyGroup` | package Mathlib | The points in a cube with at least one projection equal to 0 or 1.
- `MSSMACC.lineCube` | module `Physlib.Particles.SuperSymmetry.MSSMNu.AnomalyCancellation.OrthogY3B3.PlaneWithY3B3` | package PhysLean | The line in the plane spanned by `Y₃`, `B₃` and `R` which is in the cubic.
- `pureU1_cube` | module `Physlib.QFT.QED.AnomalyCancellation.Basic` | package PhysLean | A solution to the pure U(1) accs satisfies the cubic ACCs.

### Query: `Level-difference bound`
- `RootPairing.one_le_chainBotCoeff_of_root_add_mem` | module `Mathlib.LinearAlgebra.RootSystem.Chain` | package Mathlib | **Lower Bound of the Root String for Differences.** In a reduced root pairing, if the difference between two roots $\alpha_i$ and $\alpha_j$ is itself a root, then the lower bound $q$ of the $\alpha_i$-string through...
- `ChevalleyThm.MvPolynomialC.degBound_le_degBound` | module `Mathlib.RingTheory.Spectrum.Prime.ChevalleyComplexity` | package Mathlib | **Monotonicity of the Degree Bound.** For any natural numbers $k_1, k_2$ and functions $D_1, D_2: \mathbb{N} \to \mathbb{N}$, if $k_1 \le k_2$ and $D_1(i) \le D_2(i)$ for all $i < n$, then the associated degree bound...
- `ModularForm.sturm_bound_levelOne` | module `Mathlib.NumberTheory.ModularForms.LevelOne.DimensionFormula` | package Mathlib | **Sturm bound for level-1 modular forms.** If a modular form `f` of weight `k` for `SL(2, ℤ)` has q-expansion of order strictly greater than `k / 12`, then `f` is identically zero. Corollary of the natural-weight vers...

### Query: `Gravitational field magnitude`
- `Field` | module `Mathlib.Algebra.Field.Defs` | package Mathlib | A `Field` is a `CommRing` with multiplicative inverses for nonzero elements. An instance of `Field K` includes maps `ratCast : ℚ → K` and `qsmul : ℚ → K → K`. Those two fields are needed to implement the `DivisionRing...
- `Electromagnetism.ElectromagneticPotential.toFieldStrength_ofGradient` | module `Physlib.Electromagnetism.Kinematics.GaugeTransformation` | package PhysLean | A pure-gauge potential has vanishing field strength.
- `Electromagnetism.ElectromagneticPotential.toFieldStrength` | module `Physlib.Electromagnetism.Kinematics.FieldStrength` | package PhysLean | The field strength from an electromagnetic potential, as a tensor `F^{μν}`.

### Query: `Positivity regime`
- `Mathlib.Meta.Positivity.PositivityExt` | module `Mathlib.Tactic.Positivity.Core` | package Mathlib | An extension for `positivity`.
- `positivity` | module `Mathlib.Tactic.Positivity.Core` | package Mathlib | A definition of type `PositivityExt` tagged `@[positivity t]` extends the `positivity` tactic. The term (with underscores) `t` indicates which expressions this extension accepts. An extension will be given an expressi...
- `SzemerediRegularity.Positivity.tacticSz_positivity` | module `Mathlib.Combinatorics.SimpleGraph.Regularity.Bound` | package Mathlib | Local extension for the `positivity` tactic: A few facts that are needed many times for the proof of Szemerédi's regularity lemma.

### Query: `Cube mass`
- `Cubic.toPoly` | module `Mathlib.Algebra.CubicDiscriminant` | package Mathlib | Convert a cubic polynomial to a polynomial.
- `Cube.boundary` | module `Mathlib.Topology.Homotopy.HomotopyGroup` | package Mathlib | The points in a cube with at least one projection equal to 0 or 1.
- `MassUnit` | module `Physlib.ClassicalMechanics.Mass.MassUnit` | package PhysLean | The choices of translationally-invariant metrics on the mass-manifold. Such a choice corresponds to a choice of units for mass.

## Grounded Mathlib/PhysLean names

- `Real.sqrt` (Mathlib)
- `Real.coe_sqrt` (Mathlib)
- `Real.sqrt_lt'` (Mathlib)
- `EuclideanSpace` (Mathlib)
- `Space.fderiv_space_components` (PhysLean)
- `Lorentz.ContrMod.toSpace` (PhysLean)
- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)
- `UpperHalfPlane` (Mathlib)
- `ClassicalMechanics.transverseHarmonicPlaneWave` (PhysLean)
- `YoungDiagram.transpose` (Mathlib)
- `MeasureTheory.Measure.withDensity` (Mathlib)
- `jacobson_density` (Mathlib)
- `Finset.dens_eq_card_div_card` (Mathlib)
- `Cube.boundary` (Mathlib)
- `MSSMACC.lineCube` (PhysLean)
- `pureU1_cube` (PhysLean)
- `RootPairing.one_le_chainBotCoeff_of_root_add_mem` (Mathlib)
- `ChevalleyThm.MvPolynomialC.degBound_le_degBound` (Mathlib)
- `ModularForm.sturm_bound_levelOne` (Mathlib)
- `Field` (Mathlib)
- `Electromagnetism.ElectromagneticPotential.toFieldStrength_ofGradient` (PhysLean)
- `Electromagnetism.ElectromagneticPotential.toFieldStrength` (PhysLean)
- `Mathlib.Meta.Positivity.PositivityExt` (Mathlib)
- `positivity` (Mathlib)
- `SzemerediRegularity.Positivity.tacticSz_positivity` (Mathlib)
- `Cubic.toPoly` (Mathlib)
- `Cube.boundary` (Mathlib)
- `MassUnit` (PhysLean)

## Local abstractions introduced

- `IPhO2026_1_A_1.DeltaH`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_1_A_1.GatePlane`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_1_A_1.HingeAxis`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_1_A_1.HydrostaticGateSetup`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_1_A_1.IsBuoyantForce`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_1_A_1.IsCriticalTorqueBalance`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_1_A_1.IsHydrostaticPressure`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_1_A_1.IsNetImmersedWeight`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_1_A_1.IsUniformGravityField`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_1_A_1.IsWeightForce`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_1_A_1.PhysicalParameters`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_1_A_1.PressureMomentReadout`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
