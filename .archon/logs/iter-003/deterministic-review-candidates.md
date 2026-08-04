# Deterministic Review Candidate Pack

Iteration: 003
Exact review target count: 1

Review only these targets. Direct Lean compilation was already run in
parallel by the orchestrator; use the recorded result instead of rerunning it.

## 1. `IPhO2026Problems/problem_IPhO_2026_1_B_1.lean`

- Compile status: failed
- Open sorries: 5
- Direct-check seconds: 10.28
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_B_1.tex`
- Reports: `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_B_1.md`

### Lean excerpt
```lean
bPairData.orbit_support`; it is NOT assumed by
any other declaration. -/
theorem orbitBound_T1_B1 {hR : ScalingRegime} (D : CoulombPairData hR)
    (hv : D.AnchoredValues) (hb : IsBoundMu boundMu)
    {r : ℝ} (hr : r ∈ D.attainedSeparations) :
    r ≤ (1600 / 9) * bohrRadius := by
  sorry

/-- Certified-root attainability (conclusion-side first use of the
recorded value): the upper turning-point separation `(1600/9)·a₀` is
realized along the bound orbit (the apogee of the elliptic motion of Hint
2).  Its proof is a bridge obligation (continuity of the radial motion
between the two turning points, Intermediate Value Theorem for the
separation as a function of time); it is NOT assumed by any other
declaration. -/
theorem apogee_attained_T1_B1 {hR : ScalingRegime} (D : CoulombPairData hR)
    (hv : D.AnchoredValues) (hb : IsBoundMu boundMu) :
    (1600 / 9) * bohrRadius ∈ D.attainedSeparations := by
  sorry

/-- **Main target (T1-B1, 1.0 pt).**  Under the two-body Coulomb model of
Fig. 1b with `μ = 4` (bound case), there exists a maximal attained
separation between `e⁺` and `e⁻`, and its value is exactly
`(1600/9)·a₀`.  The recorded official value first becomes *asserted as the
answer* here, on the conclusion side: attainability (`apogee_attained_T1_B1`)
and the certified support bound (`orbitBound_T1_B1`), whose conjunction is
exactly the greatest-element statement, are conclusion-side lemmas proved
from the governing laws — nothing in the hypothesis list mentions the
value `1600/9`.  The proof combines `orbitBound_T1_B1`,
`apogee_attained_T1_B1` and `IsMaxSeparationAlongOrbit`. -/
theorem maximum_separation_T1_B1 {hR : ScalingRegime} (D : CoulombPairData hR)
    (hv : D.AnchoredValues) (hb : IsBoundMu boundMu) :
    ∃ r_max : ℝ,
      IsMaxSeparationAlongOrbit D r_max ∧ r_max = (1600 / 9) * bohrRadius := by
  refine ⟨(1600 / 9) * bohrRadius, ⟨⟨?_, ?_⟩, rfl⟩⟩
  · exact apogee_attained_T1_B1 D hv hb
  · intro r' hr'
    exact orbitBound_T1_B1 D hv hb hr'

/-- The numeric readout requested by the subquestion (“in terms of `a₀`”):
the maximum separation in units of `a₀` is exactly `1600/9`.  Corollary
form of `maximum_separation_T1_B1` with the division by `a₀ > 0` made
explicit. -/
theorem maximum_separation_in_bohr_radii_T1_B1 {hR : ScalingRegime}
    (D : CoulombPairData hR)
    (hv : D.AnchoredValues) (hb : IsBoundMu boundMu) :
    ∃ x_max : ℝ,
      IsMaxSeparationAlongOrbit D (x_max * bohrRadius) ∧ x_max = 1600 / 9 := by
  exact ⟨1600 / 9,
    ⟨apogee_attained_T1_B1 D hv hb, fun _ hr' => orbitBound_T1_B1 D hv hb hr'⟩, rfl⟩

end

end IPhO2026.Problem1.B1
... [leading content omitted]
```

### Blueprint excerpt
```tex
aximum electron-positron separation in units of a\_0.

\paragraph{Recorded answer/context.}
r\_max = (1600/9)*a\_0.

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/T1\_page-2.png

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_1\_B\_1.lean`.
The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a domain API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target] % STALE-LEANOK iter-001: marker does not vouch (4 sorries open; redraft in iter-002 repair wave) — deterministic sync owns future marker state
\label{thm:physics:IPhO_2026_1_B_1:target}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce faithful statements that can later be proved without weakening the source contract.
\end{proof}
% NOTE: PhysLean-coverage exemption (planner-recorded, iter-003): PhysLean has no two-body Coulomb/Kepler-orbit module (turning-point quadratics, bound-orbit support sets); nearest LeanExplore hits were single-particle ElectricField/charge APIs (see task\_results/physics-grounding-IPhO2026Problems\_problem\_IPhO\_2026\_1\_B\_1.md). Self-containment is kept with the `import Mathlib` baseline; no irrelevant Physlib import is added.
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_B_1.md`
```markdown
ean | A semiformal result is either a - definition in which the type is given but not the definition. - proof in which the proposition is given but not the proof. Semiformal results cannot be used in further code. They are...
- `stereographic_target` | module `Mathlib.Geometry.Manifold.Instances.Sphere` | package Mathlib | **Target of the Stereographic Projection.** For any unit vector $v$ in an inner product space, the target of the stereographic projection associated with $v$ is the entire codomain (the orthogonal complement of the su...

## Grounded Mathlib/PhysLean names

- `Electromagnetism.ElectromagneticPotential.electricField` (PhysLean)
- `ChargeUnit.elementaryCharge` (PhysLean)
- `Electromagnetism.ElectricField` (PhysLean)
- `Electromagnetism.ElectricField` (PhysLean)
- `Electromagnetism.FreeSpace.c` (PhysLean)
- `Electromagnetism.DistElectromagneticPotential.oneDimPointParticle_electricField` (PhysLean)
- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
- `stereographic_target` (Mathlib)

## Local abstractions introduced

- None detected from blueprint Lean references.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```
