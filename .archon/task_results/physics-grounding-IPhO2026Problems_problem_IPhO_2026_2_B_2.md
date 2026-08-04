# Physics LeanExplore Grounding Log

- Target Lean file: `IPhO2026Problems/problem_IPhO_2026_2_B_2.lean`
- Blueprint chapter: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_B_2.tex`
- Grounding status: complete
- Search backend: local
- Input fingerprint: sha256:e5f44bfa8c074e8447ebf40399b72fc3a3ca3785cd7750ff57891b69e9cc00ec
- Packages searched: Mathlib, Physlib

## LeanExplore queries/candidates actually used

### Query: `Physics formalization target`
- `Path.target` | module `Mathlib.Topology.Path` | package Mathlib | **Target of a Path.** For a path $\gamma$ from $x$ to $y$ in a topological space, the value of the path at the endpoint of the unit interval, $\gamma(1)$, is equal to $y$.
- `semiformal_result` | module `Physlib.Meta.Informal.SemiFormal` | package PhysLean | A semiformal result is either a - definition in which the type is given but not the definition. - proof in which the proposition is given but not the proof. Semiformal results cannot be used in further code. They are...
- `stereographic_target` | module `Mathlib.Geometry.Manifold.Instances.Sphere` | package Mathlib | **Target of the Stereographic Projection.** For any unit vector $v$ in an inner product space, the target of the stereographic projection associated with $v$ is the entire codomain (the orthogonal complement of the su...

### Query: `Declaration LengthReadout`
- `«command#long_names_»` | module `Mathlib.Util.LongNames` | package Mathlib | Lists all declarations with a long name, gathered according to the module they are defined in. Use as `#long_names` or `#long_names 100` to specify the length.
- `Physlib.HTMLNote.ofFormal` | module `Physlib.Meta.Notes.HTMLNote` | package PhysLean | An formal definition or lemma to html for a note.
- `Mathlib.Tactic.ClickSuggestions.SectionKind` | module `Mathlib.Tactic.ClickSuggestions.SectionState` | package Mathlib | Whether the section corresponds to local hypotheses, declarations from the current file, or imported declarations.

### Query: `Declaration opticalPowerDimension`
- `Dimension.instPowRat` | module `Physlib.Units.Dimension` | package PhysLean | **Rational Power of a Physical Dimension.** For any physical dimension $d$ and any rational number $n$, the power $d^n$ is defined as the dimension whose fundamental components—length, time, mass, charge, and temperat...
- `PowerSeries` | module `Mathlib.RingTheory.PowerSeries.Basic` | package Mathlib | Formal power series over a coefficient type `R`
- `Dimension` | module `Physlib.Units.Dimension` | package PhysLean | The foundational dimensions. Defined in the order ⟨length, time, mass, charge, temperature⟩

### Query: `Declaration irradianceDimension`
- `SSet.HasDimensionLT` | module `Mathlib.AlgebraicTopology.SimplicialSet.Dimension` | package Mathlib | A simplicial set `X` has dimension `< d` iff for any `n : ℕ` such that `d ≤ n`, all `n`-simplices are degenerate.
- `Dimension` | module `Physlib.Units.Dimension` | package PhysLean | The foundational dimensions. Defined in the order ⟨length, time, mass, charge, temperature⟩
- `HasDim` | module `Physlib.Units.Basic` | package PhysLean | This typeclass indicates that there is a dimension `dim M : Dimension` associated with the type `M`.

### Query: `Declaration PowerReadout`
- `PowerSeries` | module `Mathlib.RingTheory.PowerSeries.Basic` | package Mathlib | Formal power series over a coefficient type `R`
- `PowerSeries.coeff` | module `Mathlib.RingTheory.PowerSeries.Basic` | package Mathlib | The `n`th coefficient of a formal power series.
- `Turing.TM1to1.supportsStmt_read` | module `Mathlib.Computability.TuringMachine.PostTuringMachine` | package Mathlib | **Support of the Read Statement.** A finite set of labels $S$ supports a `read` statement if, for every possible symbol $a$ that can be read from the tape, the set $S$ supports the statement $f(a)$ that is executed af...

### Query: `Declaration IrradianceReadout`
- `HahnSeries.orderTop` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The orderTop of a Hahn series `x` is a minimal element of `WithTop Γ` where `x` has a nonzero coefficient if `x ≠ 0`, and is `⊤` when `x = 0`.
- `HahnSeries.order` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The order of a nonzero Hahn series `x` is a minimal element of `Γ` where `x` has a nonzero coefficient, the order of 0 is 0.
- `HahnSeries.single` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | `single a r` is the Hahn series which has coefficient `r` at `a` and zero otherwise.

### Query: `Declaration Figure2fSetup`
- `HahnSeries.orderTop` | module `Mathlib.RingTheory.HahnSeries.Basic` | package Mathlib | The orderTop of a Hahn series `x` is a minimal element of `WithTop Γ` where `x` has a nonzero coefficient if `x ≠ 0`, and is `⊤` when `x = 0`.
- `Mathlib.Notation3.setupLCtx` | module `Mathlib.Util.Notation3` | package Mathlib | Adds all the names in `boundNames` to the local context with types that are fresh metavariables. This is used for example when initializing `p` in `(scoped p => ...)` when elaborating `...`.
- `Mathlib.Tactic.TFAE.Parser.tfaeHaveDecl` | module `Mathlib.Tactic.TFAE` | package Mathlib | See `haveDecl`. Any of `tfaeHaveIdDecl`, `tfaeHavePatDecl`, or `tfaeHaveEqnsDecl`.

### Query: `Declaration Figure2fGeometry`
- `AlgebraicGeometry.Scheme` | module `Mathlib.AlgebraicGeometry.Scheme` | package Mathlib | We define `Scheme` as an `X : LocallyRingedSpace`, along with a proof that every point has an open neighbourhood `U` so that the restriction of `X` to `U` is isomorphic, as a locally ringed space, to `Spec.toLocallyRi...
- `AlgebraicGeometry.Spec` | module `Mathlib.AlgebraicGeometry.Scheme` | package Mathlib | The spectrum of a commutative ring, as a scheme. The notation `Spec(R)` for `(R : Type*) [CommRing R]` to mean `Spec (CommRingCat.of R)` is enabled in the scope `SpecOfNotation`. Please do not use it within Mathlib, b...
- `Mathlib.Meta.FunProp.FunPropDecls` | module `Mathlib.Tactic.FunProp.Decl` | package Mathlib | Discrimination tree for function properties.

### Query: `Declaration PreviousPartB1Result`
- `Part` | module `Mathlib.Data.Part` | package Mathlib | `Part α` is the type of "partial values" of type `α`. It is similar to `Option α` except the domain condition can be an arbitrary proposition, not necessarily decidable.
- `semiformal_result` | module `Physlib.Meta.Informal.SemiFormal` | package PhysLean | A semiformal result is either a - definition in which the type is given but not the definition. - proof in which the proposition is given but not the proof. Semiformal results cannot be used in further code. They are...
- `Mathlib.Command.MinImports.previousInstName` | module `Mathlib.Tactic.MinImports` | package Mathlib | `previousInstName nm` takes as input a name `nm`, assuming that it is the name of an auto-generated "nameless" `instance`. If `nm` ends in `..._n`, where `n` is a number, it returns the same name, but with `_n` replac...

### Query: `Declaration ValidFigure2fRayOptics`
- `SameRay` | module `Mathlib.LinearAlgebra.Ray` | package Mathlib | Two vectors are in the same ray if either one of them is zero or some positive multiples of them are equal (in the typical case over a field, this means one of them is a nonnegative multiple of the other).
- `RayVector` | module `Mathlib.LinearAlgebra.Ray` | package Mathlib | Nonzero vectors, as used to define rays. This type depends on an unused argument `R` so that `RayVector.Setoid` can be an instance.
- `Mathlib.Tactic.TFAE.Parser.tfaeHavePatDecl` | module `Mathlib.Tactic.TFAE` | package Mathlib | See `letPatDecl`. E.g. `⟨mp, mpr⟩ : 1 ↔ 3 := term`.

## Grounded Mathlib/PhysLean names

- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)
- `«command#long_names_»` (Mathlib)
- `Physlib.HTMLNote.ofFormal` (PhysLean)
- `Mathlib.Tactic.ClickSuggestions.SectionKind` (Mathlib)
- `Dimension.instPowRat` (PhysLean)
- `PowerSeries` (Mathlib)
- `Dimension` (PhysLean)
- `SSet.HasDimensionLT` (Mathlib)
- `Dimension` (PhysLean)
- `HasDim` (PhysLean)
- `PowerSeries` (Mathlib)
- `PowerSeries.coeff` (Mathlib)
- `Turing.TM1to1.supportsStmt_read` (Mathlib)
- `HahnSeries.orderTop` (Mathlib)
- `HahnSeries.order` (Mathlib)
- `HahnSeries.single` (Mathlib)
- `HahnSeries.orderTop` (Mathlib)
- `Mathlib.Notation3.setupLCtx` (Mathlib)
- `Mathlib.Tactic.TFAE.Parser.tfaeHaveDecl` (Mathlib)
- `AlgebraicGeometry.Scheme` (Mathlib)
- `AlgebraicGeometry.Spec` (Mathlib)
- `Mathlib.Meta.FunProp.FunPropDecls` (Mathlib)
- `Part` (Mathlib)
- `semiformal_result` (PhysLean)
- `Mathlib.Command.MinImports.previousInstName` (Mathlib)
- `SameRay` (Mathlib)
- `RayVector` (Mathlib)
- `Mathlib.Tactic.TFAE.Parser.tfaeHavePatDecl` (Mathlib)

## Local abstractions introduced

- `IPhO2026Problems.IPhO_2026_2_B_2.Figure2fGeometry`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO_2026_2_B_2.Figure2fPowerBalance`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO_2026_2_B_2.Figure2fSetup`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO_2026_2_B_2.IrradianceReadout`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO_2026_2_B_2.LengthReadout`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO_2026_2_B_2.PowerReadout`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO_2026_2_B_2.PreviousPartB1Result`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.IPhO_2026_2_B_2.ValidFigure2fRayOptics`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
