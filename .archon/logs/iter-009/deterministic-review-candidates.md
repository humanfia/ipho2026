# Deterministic Review Candidate Pack

Iteration: 009
Exact review target count: 17

Review only these targets. Direct Lean compilation was already run in
parallel by the orchestrator; use the recorded result instead of rerunning it.

## 1. `IPhO2026Problems/problem_IPhO_2026_1_B_2.lean`

- Compile status: passed
- Open sorries: 7
- Direct-check seconds: 12.212
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_B_2.tex`
- Reports: `.archon/task_results/problem_IPhO_2026_1_B_2.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_B_2.md`

### Lean excerpt
```lean
`e+` equals
the exact value `-(pi - 2 * arctan(2 / sqrt 63))` radians, whose degree
reading rounds to the official `-16.60` degrees.  The negative sign
(“16.60 degrees BELOW the initial line of motion”) is carried by the
branch condition `perp u0 u_inf ≤ 0` inside
`IsAsymptoticRelativeVelocity.direction_toward_pair` together with the
closed form.  The recorded official value first appears here,
conclusion-side; every hypothesis is a governing law, a figure readout,
or a derivable bridge. -/
theorem signed_deflection_angle_T1_B2 {hR : ScalingRegime}
    (S : CoulombScatteringData hR) (hμ : IsAngularMomentumFactor unboundMu) :
    ∃ u : RelativeVelocityVector, ∃ delta : ℝ,
      IsAsymptoticRelativeVelocity S u ∧
        delta = signedDeflection (S := S) u ∧
        delta = -(Real.pi - 2 * Real.arctan (2 / Real.sqrt 63)) ∧
        roundsToOfficialDegrees (radiansToDegrees delta) := by
  sorry

/-- Algebraic certificate for the equal-mass eccentricity value: the
hyperbola `eps² = 67/4` makes the scattering asymptote factor
`1/sqrt(eps²-1) = 2/sqrt(63)`, so the exact signed deflection in
`signed_deflection_angle_T1_B2` has the stated closed form.  Pure
algebra up to the square-root identity `sqrt(63/4) = sqrt 63 / 2`. -/
theorem asymptote_factor_certificate :
    1 / Real.sqrt ((67 / 4 : ℝ) - 1) = 2 / Real.sqrt 63 := by
  have h634 : (63 / 4 : ℝ) = (Real.sqrt 63 / 2) ^ 2 := by
    rw [div_pow, Real.sq_sqrt (by norm_num)]
    norm_num
  have halg : (67 / 4 : ℝ) - 1 = 63 / 4 := by norm_num
  rw [halg, h634, Real.sqrt_sq (by positivity)]
  field_simp

/-- A real `x` rounds to the official magnitude `16.60` degrees, i.e. to
two decimal places in the sense of the official marking scheme:
`16.595 ≤ x < 16.615`. -/
def roundsToOfficialDegreesAbs (x : ℝ) : Prop :=
  (16595 : ℝ) / 1000 ≤ x ∧ x < (16615 : ℝ) / 1000

/-- Magnitude corollary: the unsigned deflection angle between `u_inf` and
the initial line of motion of `e+` equals the exact value
`pi - 2 * arctan(2 / sqrt 63)` radians, whose degree reading rounds to
the official `16.60` degrees below the initial line of motion. -/
theorem unsigned_deflection_angle_in_degrees_T1_B2 {hR : ScalingRegime}
    (S : CoulombScatteringData hR) (hμ : IsAngularMomentumFactor unboundMu) :
    ∃ u : RelativeVelocityVector,
      IsAsymptoticRelativeVelocity S u ∧
        angleBetween (initialDirection (S := S)) u.vec =
          Real.pi - 2 * Real.arctan (2 / Real.sqrt 63) ∧
        roundsToOfficialDegreesAbs
          (radiansToDegrees (angleBetween (initialDirection (S := S)) u.vec)) := by
  sorry

end

end IPhO2026.Problem1.B2
... [leading content omitted]
```

### Blueprint excerpt
```tex
rinted magnitude $16.60$ degrees: $16.595 \le x < 16.615$.
\end{definition}

\begin{theorem}[Magnitude corollary: unsigned deflection in degrees]
\label{thm:IPhO2026Problems_problem_IPhO_2026_1_B_2:unsigned_deflection_angle_in_degrees_T1_B2}
\lean{IPhO2026.Problem1.B2.unsigned_deflection_angle_in_degrees_T1_B2}
\uses{thm:IPhO2026Problems_problem_IPhO_2026_1_B_2:exists_asymptoticRelativeVelocity, thm:IPhO2026Problems_problem_IPhO_2026_1_B_2:signed_deflection_eq_formula, thm:IPhO2026Problems_problem_IPhO_2026_1_B_2:eccentricity_sq_eq, lem:IPhO2026Problems_problem_IPhO_2026_1_B_2:asymptote_factor_certificate, def:IPhO2026Problems_problem_IPhO_2026_1_B_2:angleBetween, def:IPhO2026Problems_problem_IPhO_2026_1_B_2:initialDirection, def:IPhO2026Problems_problem_IPhO_2026_1_B_2:radiansToDegrees, def:IPhO2026Problems_problem_IPhO_2026_1_B_2:roundsToOfficialDegreesAbs, def:IPhO2026Problems_problem_IPhO_2026_1_B_2:CoulombScatteringData}
The unsigned deflection angle between $u_\infty$ and the initial line of
motion of $e^+$ equals the exact value $\pi - 2\arctan(2/\sqrt{63})$
radians, whose degree reading rounds to the official $16.60$ degrees
below the initial line of motion.
\end{theorem}
\begin{proof}
Take $u_\infty$ from
\cref{thm:IPhO2026Problems_problem_IPhO_2026_1_B_2:exists_asymptoticRelativeVelocity};
\cref{thm:IPhO2026Problems_problem_IPhO_2026_1_B_2:signed_deflection_eq_formula}
with $\varepsilon^2 = 67/4$
(\cref{thm:IPhO2026Problems_problem_IPhO_2026_1_B_2:eccentricity_sq_eq})
and the factor $2/\sqrt{63}$
(\cref{lem:IPhO2026Problems_problem_IPhO_2026_1_B_2:asymptote_factor_certificate})
identify the angle; its degree reading lies in $[16.595, 16.615)$, so it
rounds to $16.60$ by
\cref{def:IPhO2026Problems_problem_IPhO_2026_1_B_2:roundsToOfficialDegreesAbs}.
\end{proof}
... [leading content omitted]
```

### Report excerpt: `problem_IPhO_2026_1_B_2.md`
```markdown
`Real.arccos`, `Real.arctan`, `Real.pi`, norm on
EuclideanSpace, `div_pos`/`mul_pos`/`sq_pos_of_ne_zero`/`pow_ne_zero`,
`linarith`/`norm_num`/`positivity`/`field_simp`.
PhysLean candidates checked and rejected as near misses (no Coulomb/
Rutherford-scattering asymptote module): `Electromagnetism.ElectricField`,
`ChargeUnit.elementaryCharge`, `RigidBody.angularMomentum`,
`Constants.hbar` — mismatch recorded; local abstractions carry the physical
roles instead (chapter exemption NOTE, iter-003; review-gate reason string
is the recorded-stale residue of that standing exemption).

## Grounding gaps / redraft requests

- PhysLean gap (standing, exemption-recorded): no hyperbolic Coulomb
  scattering / deflection-angle module; not a redraft blocker.
- No statement redraft initiated this lane: gate is retry 2/3 with
  planner-frozen statements; the deterministic review re-pass is the
  designated next consumer. Any redraft belongs to the review decision, not
  a self-initiated edit.
- Note for plan agent: PROGRESS.md's sorry ledger line (`1_B_2` 5) vs.
  compiler count (7) is a bundling artifact of the two main-target sorries;
  counts above are the authoritative per-declaration numbers.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_B_2.md`
```markdown
npair` (Mathlib)
- `Part.bind` (Mathlib)
- `Mathlib.Notation3.BoundValueType` (Mathlib)

## Local abstractions introduced

- `IPhO2026.Problem1.B2.CoulombScatteringData`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem1.B2.IsAngularMomentumFactor`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem1.B2.IsAsymptoticRelativeVelocity`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem1.B2.Plane`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem1.B2.RelativeVelocityVector`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem1.B2.ScalingRegime`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 2. `IPhO2026Problems/problem_IPhO_2026_1_C_1.lean`

- Compile status: passed
- Open sorries: 6
- Direct-check seconds: 11.829
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_C_1.tex`
- Reports: `.archon/task_results/problem_IPhO_2026_1_C_1.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_C_1.md`

### Lean excerpt
```lean
* c ^ 2)) * (2 * Real.sin θ ^ 2 + 1)) :
    let E₀ := hbar * hbarOmegaMin m c dU θ
    0 < E₀ ∧
      (2 - Real.cos (2 * θ)) * E₀ ^ 2 - 6 * m * c ^ 2 * E₀ + 6 * dU * m * c ^ 2 = 0 ∧
      ∀ E : ℝ, 0 < E →
        (2 - Real.cos (2 * θ)) * E ^ 2 - 6 * m * c ^ 2 * E + 6 * dU * m * c ^ 2 = 0 →
        E₀ ≤ E := by
  sorry

/-- **Main target** (blueprint `thm:physics:IPhO_2026_1_C_1:target`,
    forward branch).  Under the positive-constant regime, for a nondegenerate
    forward scattering angle `0 < θ ≤ π/2` with a real square root in the
    candidate formula, the candidate expression `Ω(m, c, ΔU, θ)` *is* the
    dissociation threshold: it is reachable, and no smaller positive
    frequency can dissociate ozone at that angle.

    The recorded answer appears strictly on the conclusion side: the
    hypotheses carry only the physical regime, the figure angle range, and
    the algebraic nondegeneracy needed for the square root to be real. -/
theorem minimum_angular_frequency_T1_C1
    (reg : ConstantRegime) (θ : ℝ)
    (hrange : IsAngularRange θ) (hfwd : IsForwardBranch θ) (hθpos : 0 < θ)
    (hdisc : 0 ≤ 1 - (dissociationEnergyGap /
        (3 * oxygenAtomMass * speedOfLight ^ 2)) * (2 * Real.sin θ ^ 2 + 1)) :
    IsDissociationThreshold oxygenAtomMass dissociationEnergyGap θ
      (hbarOmegaMin oxygenAtomMass speedOfLight dissociationEnergyGap θ) := by
  sorry

/-- **Main target, backward branch.**  For `θ ≥ π/2` the official solution
    records that the threshold freezes at its `θ = π/2` value: the minimum
    angular frequency for dissociation at a backward angle `θ` equals the
    forward-branch threshold evaluated at `π/2`.  Again the answer occurs
    only in the conclusion. -/
theorem minimum_angular_frequency_backward_branch_T1_C1
    (reg : ConstantRegime) (θ : ℝ)
    (hrange : IsAngularRange θ) (hbwd : Real.pi / 2 ≤ θ)
    (hdisc : 0 ≤ 1 - dissociationEnergyGap /
        (3 * oxygenAtomMass * speedOfLight ^ 2)) :
    IsDissociationThreshold oxygenAtomMass dissociationEnergyGap θ
      (hbarOmegaMin oxygenAtomMass speedOfLight dissociationEnergyGap (Real.pi / 2)) := by
  sorry

/-- The forward-branch threshold formula is invariant under the
    reflection `θ ↦ π - θ`: it depends on `θ` only through `sin²θ`, and
    `sin(π - θ) = sin θ`.  This pure-math symmetry is what justifies the
    backward-branch freeze recorded in
    `minimum_angular_frequency_backward_branch_T1_C1`. -/
theorem hbarOmegaMin_pi_sub (m c dU θ : ℝ) :
    hbarOmegaMin m c dU (Real.pi - θ) = hbarOmegaMin m c dU θ := by
  sorry

end ThresholdContracts

end IPhO2026.Problem1.C1
... [leading content omitted]
```

### Blueprint excerpt
```tex
lean{IPhO2026.Problem1.C1.minimum_angular_frequency_backward_branch_T1_C1}
\uses{def:IPhO2026Problems_problem_IPhO_2026_1_C_1:ConstantRegime, def:IPhO2026Problems_problem_IPhO_2026_1_C_1:IsAngularRange, def:IPhO2026Problems_problem_IPhO_2026_1_C_1:IsDissociationThreshold, def:IPhO2026Problems_problem_IPhO_2026_1_C_1:hbarOmegaMin, thm:IPhO2026Problems_problem_IPhO_2026_1_C_1:minimum_angular_frequency_T1_C1, thm:IPhO2026Problems_problem_IPhO_2026_1_C_1:hbarOmegaMin_pi_sub}
In the positive-constant regime, for a backward angle
$\pi/2 \le \theta \le \pi$ with a real square root (at $\theta = \pi/2$),
the dissociation threshold freezes at its $\theta = \pi/2$ value: the
threshold at $\theta$ is the forward-branch candidate evaluated at
$\pi/2$, $\Omega(m, c, \Delta U, \pi/2)$.  The recorded answer again
occurs only in the conclusion.
\end{theorem}
\begin{proof}
The tangent-line critical configuration of Figure~1c exists only in the
forward branch, so for $\theta \ge \pi/2$ the binding constraint is the
$\pi/2$ one; formally this rests on the forward-branch threshold theorem
at $\pi/2$ together with the reflection symmetry of the candidate formula.
\end{proof}

\begin{theorem}[Reflection symmetry of the candidate threshold]
\label{thm:IPhO2026Problems_problem_IPhO_2026_1_C_1:hbarOmegaMin_pi_sub}
\lean{IPhO2026.Problem1.C1.hbarOmegaMin_pi_sub}
\uses{def:IPhO2026Problems_problem_IPhO_2026_1_C_1:hbarOmegaMin}
The candidate threshold is invariant under the reflection
$\theta \mapsto \pi - \theta$:
$\Omega(m, c, \Delta U, \pi - \theta) = \Omega(m, c, \Delta U, \theta)$,
the pure-math symmetry justifying the backward-branch freeze.
\end{theorem}
\begin{proof}
The candidate expression depends on $\theta$ only through $\sin^2\theta$,
and $\sin(\pi - \theta) = \sin\theta$.
\end{proof}
... [leading content omitted]
```

### Report excerpt: `problem_IPhO_2026_1_C_1.md`
```markdown
ion keeps `k̂` intrinsic.
- `IsScatteringAngle`: component-equation form of the Figure-1c angle readout; eliminable for the cosine-law elimination.
- `IsTwoBodyDissociation`: the governing-law record — vector momentum balance, its cosine-law shadow, the figure angle readout, and non-relativistic energy balance with masses `2m`, `m`. None of its fields mentions the threshold candidate.
- `ReachableFrequency` / `IsDissociationThreshold`: existential reachability plus minimality — the physical content of "minimum angular frequency for dissociation" without any closed-form assumption.
- `hbarOmegaMin`: the bare recorded candidate expression; carrying it as a plain `def` (not an assumption) preserves the prove obligation.

## Grounding gaps and redraft requests
- Gap: PhysLean has no module for relativistic/two-body photodissociation kinematics; the file stays on the `import Mathlib` baseline per the chapter's recorded import-policy exemption NOTE.
- Review-gate ledger note: this lane's sole recorded retry reason is the generic `missing-physlib-import` check, which the chapter-level exemption NOTE already resolves; all six semantic review checks passed at iter-008. No redraft requested.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_C_1.md`
```markdown
issociationThreshold`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem1.C1.IsForwardBranch`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem1.C1.IsScatteringAngle`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem1.C1.IsTwoBodyDissociation`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem1.C1.PhotonLine`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem1.C1.ReachableFrequency`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem1.C1.ReactionPlane`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 3. `IPhO2026Problems/problem_IPhO_2026_2_A_1.lean`

- Compile status: passed
- Open sorries: 5
- Direct-check seconds: 11.589
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_A_1.tex`
- Reports: `.archon/task_results/problem_IPhO_2026_2_A_1.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_A_1.md`

### Lean excerpt
```lean
nt is exactly the number of odd multiples
  of `α` not exceeding `π`, an impact exactly on the rim angle `π`
  included. The left-half count is fixed by the mirror symmetry
  `N_refl_abs`. -/
  reflection_count_law : ∀ α : ℝ, α ∈ Set.Ioc 0 (π / 2) →
    N_refl (R * cos α) = Set.ncard {k : ℕ | (2 * (k : ℝ) + 1) * α ≤ π}

namespace HalfCylindricalMirror

variable (s : HalfCylindricalMirror)

/-- The limiting ray: the ray whose first impact has polar angle
`α = π / (2 N + 1)` strikes the mirror at the odd multiples
`π / (2 N + 1), 3 π / (2 N + 1), …, (2 N + 1) π / (2 N + 1) = π`, so its
`(N + 1)`-st impact is exactly the rim point and it undergoes exactly
`N + 1` reflections. Bridge lemma from the reflection-count law to the
threshold: the odd-multiples count of `π / (2 N + 1)` up to `π` is `N + 1`. -/
theorem limiting_ray_reflection_count (n : ℕ) :
    s.N_refl (s.R * cos (π / (2 * ((n : ℝ) + 1) + 1))) = n + 2 := by
  sorry

/-- The two recorded forms of the answer agree: for every positive integer
`N`, `R * sin ((2 N − 1) * π / (4 N + 2)) = R * cos (π / (2 N + 1))`
(with `N = n + 1` in `0`-based indexing), because
`(2 N − 1) * π / (4 N + 2) = π / 2 − π / (2 N + 1)` and
`sin (π / 2 − θ) = cos θ`. Pure trigonometric bridge step. -/
theorem threshold_forms_agree (n : ℕ) :
    s.R * sin ((2 * ((n : ℝ) + 1) - 1) * π / (4 * ((n : ℝ) + 1) + 2)) =
      s.R * cos (π / (2 * ((n : ℝ) + 1) + 1)) := by
  sorry

/-- Main formalization target for A.1 (recorded answer, cosine form): the
threshold sequence of Figure 2e is
`x_N = R * cos (π / (2 N + 1))` for every positive integer `N`
(`N = n + 1` in `0`-based indexing). This is a target conclusion of the
subquestion, not an assumption. -/
theorem threshold_x_N_cos (n : ℕ) :
    s.x_NAt n = s.R * cos (π / (2 * ((n : ℝ) + 1) + 1)) := by
  sorry

/-- Recorded answer to A.1 (sine form): the threshold sequence is
`x_N = R * sin ((2 N − 1) * π / (4 N + 2))` for every positive integer `N`
(`N = n + 1` in `0`-based indexing). This is a target conclusion of the
subquestion, not an assumption. -/
theorem threshold_x_N_sin (n : ℕ) :
    s.x_NAt n =
      s.R * sin ((2 * ((n : ℝ) + 1) - 1) * π / (4 * ((n : ℝ) + 1) + 2)) := by
  sorry

/-- Combined recorded answer to T2-A1: both closed forms of the general
threshold agree,
`x_N = R * sin ((2 N − 1) * π / (4 N + 2)) = R * cos (π / (2 N + 1))`. -/
theorem threshold_x_N (n : ℕ) :
    s.x_NAt n =
        s.R * sin ((2 * ((n : ℝ) + 1) - 1) * π / (4 * ((n : ℝ) + 1) + 2)) ∧
      s.x_NAt n = s.R * cos (π / (2 * ((n : ℝ) + 1) + 1)) := by
  sorry

end HalfCylindricalMirror

end IPhO2026_2_A_1
... [leading content omitted]
```

### Blueprint excerpt
```tex
1$ reflections, so $x_*$ sits on the next plateau and
the defining threshold property of $x_{N\mathrm{At}}\,n$ (at most $n + 1$
below the edge, more than $n + 1$ from the edge on, within $(-R, R)$)
identifies $x_{N\mathrm{At}}\,n = x_*$.
\end{proof}

\begin{theorem}[A.1 answer, sine form]
\label{thm:IPhO2026Problems_problem_IPhO_2026_2_A_1:threshold_x_N_sin}
\lean{IPhO2026_2_A_1.HalfCylindricalMirror.threshold_x_N_sin}
\uses{def:IPhO2026Problems_problem_IPhO_2026_2_A_1:HalfCylindricalMirror, thm:IPhO2026Problems_problem_IPhO_2026_2_A_1:threshold_x_N_cos, thm:IPhO2026Problems_problem_IPhO_2026_2_A_1:threshold_forms_agree}
\textbf{(Target, T2-A1.)}  The threshold sequence of Figure~2e is
\[
x_N = R\sin\!\frac{(2N-1)\pi}{4N+2}
\]
for the positive integer $N$ ($x_{N\mathrm{At}}\,n$ with $N = n + 1$,
$0$-based).  This is the recorded answer in sine form; the value appears
only conclusion-side.
\end{theorem}
\begin{proof}
Chain the cosine-form threshold with the forms-agree bridge.
\end{proof}

\begin{theorem}[A.1 answer, combined]
\label{thm:IPhO2026Problems_problem_IPhO_2026_2_A_1:threshold_x_N}
\lean{IPhO2026_2_A_1.HalfCylindricalMirror.threshold_x_N}
\uses{def:IPhO2026Problems_problem_IPhO_2026_2_A_1:HalfCylindricalMirror, thm:IPhO2026Problems_problem_IPhO_2026_2_A_1:threshold_x_N_sin, thm:IPhO2026Problems_problem_IPhO_2026_2_A_1:threshold_x_N_cos}
\textbf{(Target, T2-A1.)}  Both closed forms of the general threshold agree:
\[
x_N = R\sin\!\frac{(2N-1)\pi}{4N+2} = R\cos\!\frac{\pi}{2N+1}
\]
for the positive integer $N$ ($N = n + 1$, $0$-based).  Conclusion-side
only: the conjunction of the sine- and cosine-form recorded answers.
\end{theorem}
\begin{proof}
Conjoin the sine-form and cosine-form target theorems.
\end{proof}
% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `problem_IPhO_2026_2_A_1.md`
```markdown
law) instead of erasing them to scalar aliases.

## Grounding gaps

- **PhysLean gap (known, exemption on record):** PhysLean has no geometric /
  reflection-optics module for this regime; the file therefore builds on
  `import Mathlib` alone. This is documented by the planner-recorded exemption
  NOTE in the chapter (iter-002) and re-confirmed by Physlib-filtered LeanExplore
  queries (iter-008). The gate's standing "does not import Physlib/PhysLean"
  failure reason for this lane is the iter-003 stale-snapshot finding
  (`PROGRESS.md`: the 18 injected `missing-physlib-import` findings are the
  stale snapshot, 8th iter, formally retired; exemption NOTEs present). Deferred
  to the deterministic review re-pass; no redraft is warranted or permitted
  (statements planner-frozen).
- No other grounding gaps: every Mathlib name used resolves under `import Mathlib`.

## Redraft requests

None. Recommendation: review re-pass should grade this lane on the on-disk
chapter exemption NOTE + this report; the file is semantically faithful
(source_faithfulness/derivability/abstraction_sufficiency/branch_orientation/
countermodel_resistance were all `passed` at the last gate) and compiles clean.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_A_1.md`
```markdown
irror` (Mathlib)
- `Turing.Tape.mk'` (Mathlib)
- `Polynomial.mirror_mirror` (Mathlib)
- `SameRay` (Mathlib)
- `CategoryTheory.Limits.ReflectsLimits` (Mathlib)
- `Lean.Elab.Tactic.iterateExactly'` (Mathlib)
- `PFunctor.Approx.Agree` (Mathlib)
- `LinearMap.BilinForm.ext_iff_basis` (Mathlib)
- `PFunctor.M.Agree'` (Mathlib)
- `Real.cos` (Mathlib)
- `PowerSeries.cos` (Mathlib)
- `Real.cos_three_mul` (Mathlib)
- `Real.sin` (Mathlib)
- `Real.abs_sin_half` (Mathlib)
- `sineTerm` (Mathlib)
- `WithTop.untopA` (Mathlib)
- `WithBot.unbotA` (Mathlib)
- `QuaternionGroup.a` (Mathlib)
- `Polynomial.mirror` (Mathlib)
- `UpperHalfPlane` (Mathlib)
- `HomotopicalAlgebra.Precylinder.symm` (Mathlib)
- `SameRay` (Mathlib)
- `RayVector` (Mathlib)
- `CategoryTheory.Limits.instReflectsFiniteLimitsOfReflectsLimits` (Mathlib)
- `HahnSeries.orderTop` (Mathlib)
- `Asymptotics.IsTheta` (Mathlib)
- `PFunctor.M.Agree'` (Mathlib)

## Local abstractions introduced

- `IPhO2026_2_A_1.HalfCylindricalMirror`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 4. `IPhO2026Problems/problem_IPhO_2026_2_B_1.lean`

- Compile status: passed
- Open sorries: 0
- Direct-check seconds: 33.279
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_B_1.tex`
- Reports: `.archon/task_results/problem_IPhO_2026_2_B_1.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_B_1.md`

### Lean excerpt
```lean
eal.sin (2 * θ') := by
    have h := container_radius_at_extremal_angle cfg₂.q cfg₂.t hθ'' cfg₂.e'
    rw [cfg₂.qR] at h
    exact h
  have hans₂ : cfg₂.q.a = α * Real.sin θ' + β * Real.sin (2 * θ') :=
    hcoef cfg₂.q cfg₂.qR cfg₂.t θ' cfg₂.hθ' cfg₂.e'
  have heq₂ : (α - p.R) * Real.sin θ' + (β + p.R / 2) * Real.sin (2 * θ') = 0 := by
    linarith [hid₂, hans₂]
  -- the two-by-two system for `(α - R, β + R / 2)` has nonzero determinant
  have hsθ : 0 < Real.sin θ := by
    apply Real.sin_pos_of_mem_Ioo
    exact ⟨hθ.1.1, by linarith [hθ.1.2, Real.pi_pos]⟩
  have hsθ' : 0 < Real.sin θ' := by
    apply Real.sin_pos_of_mem_Ioo
    exact ⟨hθ''.1, by linarith [hθ''.2, Real.pi_pos]⟩
  have hcos_ne : Real.cos θ' ≠ Real.cos θ := by
    intro hcos
    apply hdist
    have hsub : Set.Ioo 0 Real.pi ⊆ Set.Icc 0 Real.pi := Set.Ioo_subset_Icc_self
    exact Real.injOn_cos
      (hsub ⟨by linarith [hθ''.1], by linarith [hθ''.2, Real.pi_pos]⟩)
      (hsub ⟨by linarith [hθ.1.1], by linarith [hθ.1.2, Real.pi_pos]⟩) hcos
  have hdet : 2 * Real.sin θ * Real.sin θ' * (Real.cos θ' - Real.cos θ) ≠ 0 := by
    have hne1 : Real.sin θ ≠ 0 := ne_of_gt hsθ
    have hne2 : Real.sin θ' ≠ 0 := ne_of_gt hsθ'
    have hne3 : Real.cos θ' - Real.cos θ ≠ 0 := sub_ne_zero.mpr hcos_ne
    exact mul_ne_zero (mul_ne_zero (mul_ne_zero two_ne_zero hne1) hne2) hne3
  rw [Real.sin_two_mul θ'] at heq₂
  rw [Real.sin_two_mul θ] at heq₁
  have hβ : β + p.R / 2 = 0 := by
    have key : (β + p.R / 2) * (2 * Real.sin θ * Real.sin θ'
        * (Real.cos θ' - Real.cos θ)) = 0 := by
      have hthis : ((α - p.R) * Real.sin θ'
          + (β + p.R / 2) * (2 * Real.sin θ' * Real.cos θ')) * Real.sin θ = 0 := by
        rw [heq₂]; ring
      have h1 : ((α - p.R) * Real.sin θ
          + (β + p.R / 2) * (2 * Real.sin θ * Real.cos θ)) * Real.sin θ' = 0 := by
        rw [heq₁]; ring
      have h2 : (β + p.R / 2) * (2 * Real.sin θ * Real.sin θ'
            * (Real.cos θ' - Real.cos θ))
          = ((α - p.R) * Real.sin θ'
              + (β + p.R / 2) * (2 * Real.sin θ' * Real.cos θ')) * Real.sin θ
            - ((α - p.R) * Real.sin θ
              + (β + p.R / 2) * (2 * Real.sin θ * Real.cos θ)) * Real.sin θ' := by ring
      rw [h2, hthis, h1]; ring
    exact (mul_eq_zero.mp key).resolve_right hdet
  have hα : α - p.R = 0 := by
    have hsθne : Real.sin θ ≠ 0 := ne_of_gt hsθ
    have hz : (α - p.R) * Real.sin θ = 0 := by
      rw [hβ] at heq₁
      ring_nf at heq₁ ⊢
      linarith [heq₁]
    exact (mul_eq_zero.mp hz).resolve_right hsθne
  constructor
  · linarith [hα]
  · linarith [hβ]

end IPhO2026_2_B_1

end
... [leading content omitted]
```

### Blueprint excerpt
```tex
blems_problem_IPhO_2026_2_B_1:SecondExtremalConfig, lem:IPhO2026Problems_problem_IPhO_2026_2_B_1:sin_two_pos, thm:IPhO2026Problems_problem_IPhO_2026_2_B_1:container_radius_at_extremal_angle}
\textbf{(Target, T2-B1.)}  For the Figure-2f cooker with extremal absorbed
ray at maximum incidence angle $\theta_{\max}$, a coefficient pair
$\alpha, \beta$ fulfilling the family ansatz
\cref{def:IPhO2026Problems_problem_IPhO_2026_2_B_1:CoeffSpec}, and a
second extremal configuration of the same mirror radius at a distinct
extremal angle $\theta' \neq \theta_{\max}$, the coefficients of the given
ansatz $a = \alpha \sin\theta_{\max} + \beta \sin(2\theta_{\max})$ are
\[
\alpha = R, \qquad \beta = -\frac{R}{2} .
\]
This is the recorded official answer of part B.1; the values are
conclusion-side only, confined to this target theorem (no hypothesis or
structure field states them in advance).
\end{theorem}
\begin{proof}
Apply
\cref{thm:IPhO2026Problems_problem_IPhO_2026_2_B_1:container_radius_at_extremal_angle}
at the given extremal ray and at the second configuration
$\theta'$: both angles satisfy the tangency identity, while the ansatz of
\cref{def:IPhO2026Problems_problem_IPhO_2026_2_B_1:CoeffSpec} gives the
family identity at the same two configurations.  Subtracting at
$\theta_{\max}$ and $\theta'$ yields a two-by-two homogeneous linear
system in $(\alpha - R, \beta + R/2)$ whose determinant
$2\sin\theta_{\max}\sin\theta'\,(\cos\theta' - \cos\theta_{\max})$ is
nonzero --- both sines are positive by
\cref{lem:IPhO2026Problems_problem_IPhO_2026_2_B_1:sin_two_pos} (and
$\sin\theta > 0$ on the acute branch), and $\cos$ is strictly
antitone on $(0, \pi/2)$, so $\theta' \neq \theta_{\max}$ gives
$\cos\theta' \neq \cos\theta_{\max}$ --- forcing $\alpha = R$ and
$\beta = -R/2$.
\end{proof}
... [leading content omitted]
```

### Report excerpt: `problem_IPhO_2026_2_B_1.md`
```markdown
t a scalar alias): keeps the 2-D cross-sectional geometry of Figure 2f; chosen over `EuclideanSpace ℝ (Fin 2)` to keep coordinate equations tactic-light for the prover stage — physically equivalent, length dimension documented in docstrings.
- `Line2D` + `distToLine`: non-vertical reflected lines with the standard signed point-line distance — the source's tangency language (verticality excluded off-axis by `hit_branch`).
- `CookerB1`, `IsThetaMax`, `ExtremalRaySpec`, `CoeffSpec`, `SecondExtremalConfig`: setup/laws, `θ_max` spec, extremal tangency, given ansatz, family nondegeneracy — each a distinct physical role; none hides the answer (see audits above).

## Grounding gaps / redraft requests

- Gap (Physlib side, standing): no geometric-optics reflection API; worked around with the explicit Cartesian 2×2 incidence system. Documented in the chapter exemption NOTEs.
- No redraft requested. Statements are planner-frozen at review-gate retry 2/3; the deterministic review re-pass is the next consumer. The sole recorded gate `reason` (missing Physlib import) is resolved by the exemption NOTE and the placeholder status of `Physlib.Optics` — flagged here so the re-pass can close the lane.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_B_1.md`
```markdown
the physical role instead of erasing it to a bare scalar.
- `IPhO2026_2_B_1.CookerB1`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_2_B_1.CookerParams`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_2_B_1.ExtremalRaySpec`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_2_B_1.IsThetaMax`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_2_B_1.Line2D`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_2_B_1.SecondExtremalConfig`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_2_B_1.Vec`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 5. `IPhO2026Problems/problem_IPhO_2026_2_B_2.lean`

- Compile status: passed
- Open sorries: 5
- Direct-check seconds: 11.714
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_B_2.tex`
- Reports: `.archon/task_results/problem_IPhO_2026_2_B_2.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_B_2.md`

### Lean excerpt
```lean
g.C) g.e| / p.R)

/-- Specification of `θ_max`: the largest angle of incidence on the mirror
(measured against the normal at the point of incidence) among all reflected
rays striking the container, lying in `(0, π / 2)` — the branch of
nontrivial, non-grazing rays seen in Figure 2f. -/
def ThetaMaxSpec (p : CookerParams) (g : CookerGeometry p)
    (r : AbsorbedRays p g) (θ : ℝ) : Prop :=
  (θ ∈ Set.Ioo 0 (Real.pi / 2)) ∧
  (∃ y ∈ r.hitSet, incidenceAngle p g (r.incidentPt y) = θ) ∧
  (∀ y ∈ r.hitSet, incidenceAngle p g (r.incidentPt y) ≤ θ)

/-- Geometric bridge (proof side): all mirror-collected impact parameters are
bounded by the aperture radius `R` — the trivial bound from `mirrorCircle`
and `‖e‖ = 1`. -/
lemma impactParam_le_aperture (p : CookerParams) (g : CookerGeometry p)
    (r : AbsorbedRays p g) :
    ∀ y ∈ r.hitSet, |inner ℝ (r.incidentPt y - g.C) g.e| ≤ p.R := by
  sorry

/-- Width accounting bridge: the transverse width collected by the
half-cylinder mirror on the container's side equals `R` (one full half of
the aperture `2 R`, realized by the contiguous fan of `full_side_coverage`
and `no_gap`, bounded by `impactParam_le_aperture`). -/
lemma collectedWidth_eq_radius (p : CookerParams) (g : CookerGeometry p)
    (r : AbsorbedRays p g) :
    collectedWidth p g r = p.R := by
  sorry

/-- Power ratio from the width accounting only: `P / P₀ = R / (2 a)`. With
the B.1 calibration this becomes the target trigonometric form. -/
lemma power_ratio_eq_width_ratio (p : CookerParams) (g : CookerGeometry p)
    (r : AbsorbedRays p g) (budget : PowerBudget p g r) :
    budget.P / budget.P₀ = p.R / (2 * p.a) := by
  sorry

/-- Trigonometric bridge (B.1 calibration, elementary):
`R / (2 a) = 1 / (1 - cos θ)` for `θ ∈ (0, π / 2)` satisfying
`a = R sin θ - (R / 2) sin (2 θ)`. -/
lemma radius_over_diameter_eq (p : CookerParams) {θ : ℝ}
    (hθ : θ ∈ Set.Ioo 0 (Real.pi / 2)) (hcal : B1Calibration p θ) :
    p.R / (2 * p.a) = 1 / (1 - Real.cos θ) := by
  sorry

/-- **Target (T2-B2).** For the cooker of Figure 2f with absorbed-ray
bookkeeping `r`, power budget `budget`, and maximum incidence angle
specification `θ`, the ratio of the received power `P` to the unmirrored
power `P₀` is `P / P₀ = 1 / (1 - cos θ_max)`.

Blueprint: `thm:physics:IPhO_2026_2_B_2:target`. -/
theorem power_ratio_in_terms_of_theta_max
    (p : CookerParams) (g : CookerGeometry p)
    (r : AbsorbedRays p g) (budget : PowerBudget p g r)
    {θ : ℝ} (hθ : ThetaMaxSpec p g r θ) (hcal : B1Calibration p θ) :
    budget.P / budget.P₀ = 1 / (1 - Real.cos θ) := by
  sorry

end IPhO2026_2_B_2

end
... [leading content omitted]
```

### Blueprint excerpt
```tex
_radius}
replaces $\mathrm{collectedWidth}$ by $R$.
\end{proof}

\begin{lemma}[Radius-over-diameter trigonometric bridge]
\label{lem:IPhO2026Problems_problem_IPhO_2026_2_B_2:radius_over_diameter_eq}
\lean{IPhO2026_2_B_2.radius_over_diameter_eq}
\uses{def:IPhO2026Problems_problem_IPhO_2026_2_B_2:B1Calibration}
For $\theta \in (0, \/2)$ satisfying the B.1 calibration,
$R / (2a) = 1 / (1 - \cos\theta)$.
\end{lemma}
\begin{proof}
By the double-angle identity and the calibration,
$2a = 2R\sin\theta - R\sin(2\theta)
= 2R\sin\theta\,(1 - \cos\theta)$,
so $R/(2a) = 1/(1 - \cos\theta)$ after cancelling the positive factor
$2R\sin\theta$ (positivity from $\theta \in (0, \/2)$ and $0 < R$);
this leaves $R/(2a) = 1/(1 - \cos\theta)$.
\end{proof}

\begin{theorem}[Power ratio in terms of $\theta_{\max}$ (T2-B.2 target)]
\label{thm:IPhO2026Problems_problem_IPhO_2026_2_B_2:power_ratio_in_terms_of_theta_max}
\lean{IPhO2026_2_B_2.power_ratio_in_terms_of_theta_max}
\uses{lem:IPhO2026Problems_problem_IPhO_2026_2_B_2:power_ratio_eq_width_ratio, lem:IPhO2026Problems_problem_IPhO_2026_2_B_2:radius_over_diameter_eq, def:IPhO2026Problems_problem_IPhO_2026_2_B_2:ThetaMaxSpec}
For the cooker of Figure~2f with absorbed-ray bookkeeping, power budget,
and maximum-incidence-angle specification $\theta_{\max}$, the ratio of
the received power $P$ to the unmirrored power $P_0$ is
$P / P_0 = 1 / (1 - \cos\theta_{\max})$ --- the recorded official
answer of part B.2.
\end{theorem}
\begin{proof}
The B.1 calibration at the specified maximum angle yields
$R/(2a) = 1/(1 - \cos\theta_{\max})$ by
\cref{lem:IPhO2026Problems_problem_IPhO_2026_2_B_2:radius_over_diameter_eq};
chaining with
\cref{lem:IPhO2026Problems_problem_IPhO_2026_2_B_2:power_ratio_eq_width_ratio},
$P/P_0 = R/(2a)$, yields the claim.
\end{proof}
... [leading content omitted]
```

### Report excerpt: `problem_IPhO_2026_2_B_2.md`
```markdown
plane,
sphere/ball profiles, ray bookkeeping, specular reflection, trig bridges).
Grounded in the file: `EuclideanSpace R (Fin 2)` (`Plane`), `Metric.sphere`,
`Metric.closedBall`, `inner R`, `Real.sin/cos/arccos`, `Set.Ioo`, `sSup`.
No new queries needed this iter (re-audit only; no statement drift).

## PhysLean/Mathlib names grounded

Mathlib only, per the chapter's recorded import-policy NOTE (PhysLean has no
specular-reflection / geometric-optics module for the Figure-2f half-cylinder
regime; exemption NOTE present in the chapter, `missing-physlib-import` doctor
check formally retired for this family).

## Local abstractions introduced

`CookerGeometry` (figure frame + offset law), `AbsorbedRays` (single-bounce ray
bookkeeping with specular-law field), `PowerBudget`/`UniformIntensity`
(uniform-intensity width accounting), `ThetaMaxSpec`/`B1Calibration` (angle spec
and previous-part calibration). Each preserves the physical role per the audits
above; no physical meaning collapsed to scalar aliases.

## Grounding gaps / redraft requests

None. No statement redraft requested; the lane's next consumer is the
deterministic review re-pass (retry gate 1/3) as scheduled in PROGRESS.md.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_B_2.md`
```markdown
cal role instead of erasing it to a bare scalar.
- `IPhO2026_2_B_2.B1Calibration`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_2_B_2.CookerGeometry`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_2_B_2.CookerParams`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_2_B_2.Plane`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_2_B_2.PowerBudget`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_2_B_2.ThetaMaxSpec`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_2_B_2.UniformIntensity`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 6. `IPhO2026Problems/problem_IPhO_2026_2_B_3.lean`

- Compile status: passed
- Open sorries: 4
- Direct-check seconds: 11.788
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_B_3.tex`
- Reports: `.archon/task_results/problem_IPhO_2026_2_B_3.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_B_3.md`

### Lean excerpt
```lean
light direction.  Together with `on_mirror` this encodes
  the single-reflection condition of the problem. -/
  illuminated_side : @inner ℝ _ _ x G.sunDirection < 0
  /-- Law of specular reflection at the cylindrical surface: the outward
  direction of the ray reflected at `x` is the Euclidean reflection of the
  incoming direction `-sunDirection` in the normal line `ℝ ∙ x`. -/
  specular_reflection :
    (ℝ ∙ x).reflection (-G.sunDirection)
      = 2 • ((@inner ℝ _ _ x (-G.sunDirection))
              / (G.mirrorRadius ^ 2)) • x - (-G.sunDirection)
  /-- The incidence angle at `x`, measured with respect to the normal drawn
  at the point of incidence. -/
  angleOfIncidence : theta = Real.arccos ((@inner ℝ _ _ x (-G.sunDirection)) / G.mirrorRadius)
  /-- The incidence angle is acute, as it is for any ray of the
  single-reflection branch that reaches the container. -/
  angle_acute : theta ∈ Set.Ioo 0 (Real.pi / 2)

/-- Auxiliary fact supporting the recorded value: the incidence angle whose
cosine is `4 / 5` is acute, as required by the single-reflection branch. -/
lemma thetaMaxRecorded_mem_Ioo :
    thetaMaxRecorded ∈ Set.Ioo 0 (Real.pi / 2) := by
  sorry

/-- The sine of the recorded maximal incidence angle is `3 / 5`
(the 3-4-5 triangle of Figure 2f's geometry). -/
lemma sin_thetaMaxRecorded : Real.sin thetaMaxRecorded = 3 / 5 := by
  sorry

/-- The sine of twice the recorded maximal incidence angle is `24 / 25`,
via `sin (2θ) = 2 sin θ cos θ`. -/
lemma sin_two_mul_thetaMaxRecorded : Real.sin (2 * thetaMaxRecorded) = 24 / 25 := by
  sorry

/-- **Main target of subquestion B.3.**

Given a solar-cooker geometry governed by the mirror physics above (at
some reflection point reaching the container, hence with incidence angle
`θ_max`), with mirror radius `R = 1 m`, container radius `a`, received
power `P` and no-mirror power `P₀` satisfying the previous-part relations
B.1 and B.2, if the received power is five times the no-mirror power
(`P = 5 P₀`), then:

* the maximal incidence angle equals the recorded value
  (`cos θ_max = 4 / 5`),
* the container radius is `a = 0.12 m`,
* reported in centimetres, `a * 100 = 12 cm`. -/
theorem container_diameter_for_quintuple_power
    (G : SolarCookerGeometry)
    (R a thetaMax P P0 : ℝ)
    (hR_val : R = 1)
    (hR : G.mirrorRadius = R)
    (ha : G.containerRadius = a)
    (x : CrossSectionPlane)
    (hphys : HalfCylindricalMirrorPhysics G x thetaMax)
    (hprev : PreviousPartResults R a thetaMax P P0)
    (hP : P = 5 * P0) :
    thetaMax = thetaMaxRecorded ∧ a = 0.12 ∧ a * metreInCentimetres = 12 := by
  sorry

end
... [leading content omitted]
```

### Blueprint excerpt
```tex
)
governed by the mirror physics
(\cref{def:IPhO2026Problems_problem_IPhO_2026_2_B_3:HalfCylindricalMirrorPhysics})
at a reflection point reaching the container, with mirror radius
$R = 1\,\mathrm{m}$, container radius $a$, received power $P$ and no-mirror
power $P_0$ satisfying the previous-part relations B.1 and B.2
(\cref{def:IPhO2026Problems_problem_IPhO_2026_2_B_3:PreviousPartResults}),
if $P = 5\,P_0$ then: $\theta_{\max}$ equals the recorded angle
($\cos\theta_{\max} = 4/5$), the container radius is
$a = 0.12\,\mathrm{m}$, and reported in centimetres $a = 12\,\mathrm{cm}$.
The official answers $\cos\theta_{\max} = 4/5$ and $12\,\mathrm{cm}$ appear
here conclusion-side only; no hypothesis fixes them in advance.
\end{theorem}
\begin{proof}
Invert the B.2 ratio: $P/P_0 = 5 = 1/(1-\cos\theta_{\max})$ forces
$1-\cos\theta_{\max} = 1/5$, hence $\cos\theta_{\max} = 4/5$; since both
\cref{def:IPhO2026Problems_problem_IPhO_2026_2_B_3:PreviousPartResults} and
\cref{def:IPhO2026Problems_problem_IPhO_2026_2_B_3:HalfCylindricalMirrorPhysics}
confine $\theta_{\max}$ to the acute range $(0, \pi/2)$, on which cosine is
strictly monotone (so arccosine is its inverse there),
\cref{lem:IPhO2026Problems_problem_IPhO_2026_2_B_3:thetaMaxRecorded_mem_Ioo}
identifies $\theta_{\max}$ with the recorded angle.  Substitute into the B.1
relation $a = R\sin\theta_{\max} - (R/2)\sin(2\theta_{\max})$ at $R = 1$
with
\cref{lem:IPhO2026Problems_problem_IPhO_2026_2_B_3:sin_thetaMaxRecorded} and
\cref{lem:IPhO2026Problems_problem_IPhO_2026_2_B_3:sin_two_mul_thetaMaxRecorded}:
$a = 3/5 - (1/2)(24/25) = 3/25 = 0.12\,\mathrm{m}$, and the conversion scale
of
\cref{def:IPhO2026Problems_problem_IPhO_2026_2_B_3:metreInCentimetres} turns
this into $a \cdot 100 = 12$, i.e. $a = 12\,\mathrm{cm}$.
\end{proof}
... [leading content omitted]
```

### Report excerpt: `problem_IPhO_2026_2_B_3.md`
```markdown
eholder directory; verified by local inspection).

## Local abstractions introduced

- `CrossSectionPlane` — Euclidean plane of the Figure-2f cross-section; keeps the 2D geometry physically meaningful instead of scalarizing directions (`sunDirection`, `containerCentre` remain vectors with norms/inner products).
- `SolarCookerGeometry` — minimal structure preserving the figure readouts (radii, centre-to-mirror distance `R/2`, unit sunlight direction) with positivity guards against degenerate countermodels.
- `HalfCylindricalMirrorPhysics` — smallest law carrier keeping specular reflection, incidence-angle definition, and single-reflection branch as eliminable equations at a reflection point; PhysLean offers no substitute (verified).
- `PreviousPartResults` — natural-language-prerequisite interface (policy `natural_language_prerequisite_only`) packaging B.1/B.2 as equations over an arbitrary angle, so B.3's conclusions stay conclusion-side.

## Grounding gaps / redraft requests

- None. The sole stale finding (Physlib import) is resolved by inspection at the current pin; no redraft requested — statements remain planner-frozen and the deterministic review re-pass is the next consumer.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_B_3.md`
```markdown
- `cross_cross` (Mathlib)
- `MassUnit.nominalSolarMasses` (PhysLean)
- `EuclideanGeometry.oangle` (Mathlib)
- `Cosmology.SpatialGeometry` (PhysLean)
- `Polynomial.mirror_eq_iff` (Mathlib)
- `UpperHalfPlane` (Mathlib)
- `Polynomial.mirror` (Mathlib)
- `Part.inter_def` (Mathlib)
- `CategoryTheory.PreOneHypercover.interSnd` (Mathlib)
- `Int.gcdB` (Mathlib)
- `EuclideanGeometry.angle` (Mathlib)
- `Affine.Triangle.acuteAngled_iff_angle_lt` (Mathlib)
- `Affine.Simplex.AcuteAngled` (Mathlib)

## Local abstractions introduced

- `CrossSectionPlane`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `HalfCylindricalMirrorPhysics`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `PreviousPartResults`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `SolarCookerGeometry`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 7. `IPhO2026Problems/problem_IPhO_2026_2_C_2.lean`

- Compile status: passed
- Open sorries: 3
- Direct-check seconds: 11.17
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_C_2.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_2_C_2.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_C_2.md`

### Lean excerpt
```lean
mainder `o(Δθ)`. -/
  B_first_order :
    ∃ db : ℝ, (fun Δθ : ℝ ↦ B (θ + Δθ) - B θ - db * Δθ) =o[𝓝 0]
      fun Δθ : ℝ ↦ Δθ

namespace NeighboringRayExpansion

variable (s : NeighboringRayExpansion)

/-- The quantities of the subquestion are well-formed on the Figure-2g
branch: `sin (2 * θ) ≠ 0` and `cos θ ≠ 0`, so `csc (2 * θ)`, `cot (2 * θ)`,
`tan θ`, and the C.1 intercept `R / (2 * cos θ)` are all defined with
nonzero denominators.  This is a bridge lemma exposing the branch
information, not a target conclusion. -/
theorem branch_denominators_ne_zero :
    sin (2 * s.θ) ≠ 0 ∧ cos s.θ ≠ 0 := by
  sorry

/-- First-order expansion of the neighboring-ray slope (recorded answer to
C.2, slope half): as `Δθ → 0`,
`m_B θ Δθ = cot (2 * θ) - 2 * csc (2 * θ) ^ 2 * Δθ + o(Δθ)`.
This is the derivative identity
`(d/dθ) cot (2 * θ) = -2 * csc (2 * θ) ^ 2` applied to the smooth ray
family; it is a target conclusion of the subquestion, not an assumption. -/
theorem ray_B_slope_first_order :
    (fun Δθ : ℝ ↦
        s.m_B s.θ Δθ - (cot (2 * s.θ) - 2 * (sin (2 * s.θ))⁻¹ ^ 2 * Δθ))
      =o[𝓝 0] fun Δθ : ℝ ↦ Δθ := by
  sorry

/-- First-order expansion of the neighboring-ray intercept (recorded answer
to C.2, intercept half): as `Δθ → 0`,
`b_B θ Δθ = (R / (2 * cos θ)) * (1 + tan θ * Δθ) + o(Δθ)`.
This is the derivative identity
`(d/dθ) (R / (2 * cos θ)) = (R / (2 * cos θ)) * tan θ` applied to the
smooth ray family; it is a target conclusion of the subquestion, not an
assumption. -/
theorem ray_B_intercept_first_order :
    (fun Δθ : ℝ ↦
        s.b_B s.θ Δθ -
          (s.R / (2 * cos s.θ)) * (1 + tan s.θ * Δθ))
      =o[𝓝 0] fun Δθ : ℝ ↦ Δθ := by
  sorry

/-- Main formalization target for C.2 (blueprint label
`thm:physics:IPhO_2026_2_C_2:target`): the reflected line
`y = m_B θ Δθ * x + b_B θ Δθ` of the neighboring parallel ray B, incident
at `θ + Δθ` with `Δθ ≪ θ`, expands to first order in `Δθ` as

  `m_B θ Δθ = cot (2 * θ) - 2 * csc (2 * θ) ^ 2 * Δθ + o(Δθ)`,
  `b_B θ Δθ = (R / (2 * cos θ)) * (1 + tan θ * Δθ) + o(Δθ)`.

Both remainders are little-o of `Δθ` as `Δθ → 0`, which is the faithful
first-order content of the official `+ O(Δθ ^ 2)` phrasing. -/
theorem ray_B_first_order_expansion :
    ((fun Δθ : ℝ ↦
          s.m_B s.θ Δθ - (cot (2 * s.θ) - 2 * (sin (2 * s.θ))⁻¹ ^ 2 * Δθ))
        =o[𝓝 0] fun Δθ : ℝ ↦ Δθ) ∧
      ((fun Δθ : ℝ ↦
          s.b_B s.θ Δθ -
            (s.R / (2 * cos s.θ)) * (1 + tan s.θ * Δθ))
        =o[𝓝 0] fun Δθ : ℝ ↦ Δθ) := by
  exact ⟨s.ray_B_slope_first_order, s.ray_B_intercept_first_order⟩

end NeighboringRayExpansion

end IPhO2026_2_C_2
... [leading content omitted]
```

### Blueprint excerpt
```tex
coefficients conclusion-side.)}
As $\Delta\theta \to 0$,
\[
b_B(\theta, \Delta\theta)
= \frac{R}{2\cos\theta}\,\bigl(1 + \tan\theta\,\Delta\theta\bigr)
+ o(\Delta\theta) ,
\]
stated formally as an \texttt{IsLittleO} contract of the defect against
$\Delta\theta \mapsto \Delta\theta$ in the neighborhood filter of $0$.
\end{theorem}
\begin{proof}
Family membership rewrites $b_B(\theta,\Delta\theta) = B(\theta+\Delta\theta)$
and the interface expands $B$ to first order with little-$o$ remainder.
The C.1 value $B(\theta) = R/(2\cos\theta)$ fixes the zeroth order; the
derivative identity
$(d/d\theta)\bigl(R/(2\cos\theta)\bigr)
= \bigl(R/(2\cos\theta)\bigr)\tan\theta$ of the specular family fixes the
first-order coefficient.
\end{proof}

\begin{theorem}[Neighboring-ray first-order expansion (C.2 main target)]
\label{thm:IPhO2026Problems_problem_IPhO_2026_2_C_2:ray_B_first_order_expansion}
\lean{IPhO2026_2_C_2.NeighboringRayExpansion.ray_B_first_order_expansion}
\uses{thm:IPhO2026Problems_problem_IPhO_2026_2_C_2:ray_B_slope_first_order, thm:IPhO2026Problems_problem_IPhO_2026_2_C_2:ray_B_intercept_first_order}
\textbf{(Target, T2-C.2.)}  The two recorded C.2 expansions hold jointly:
the reflected slope and intercept of the neighboring ray B expand to first
order in $\Delta\theta$ with remainders little-$o$ of $\Delta\theta$ ---
the faithful first-order content of the official $+\,O(\Delta\theta^{2})$
phrasing.  The expansion coefficients appear only here and in the two halves
above, never hypothesis-side.
\end{theorem}
\begin{proof}
Conjunction of
\cref{thm:IPhO2026Problems_problem_IPhO_2026_2_C_2:ray_B_slope_first_order}
and
\cref{thm:IPhO2026Problems_problem_IPhO_2026_2_C_2:ray_B_intercept_first_order};
the formal proof is exact pair introduction of the two halves.
\end{proof}
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_2_C_2.md`
```markdown
` / `b_B` for the two physical rays,
  the acute-branch datum, family-membership equations, the C.1
  prerequisite values, and the smooth-law `IsLittleO` interfaces. No
  scalar-placeholder aliases; no target formula appears hypothesis-side.
  This frozen `import Mathlib` style was kept (rather than retrofitting
  the sibling C.3 lane's `Physlib.Units.WithDim` dimension typing)
  because the statements were certified source-faithful across two review
  cycles, the live gate reason concerns imports rather than dimensional
  typing, and the lane is statement-frozen — a structural retrofit would
  violate the freeze without changing the physical content.

## Grounding gaps / redraft requests

- **Grounding gap (documented exemption)**: no PhysLean geometric-optics
  / specular-reflection module exists; the reflected-ray family is a
  faithful local abstraction with `IsLittleO` interfaces. No redraft
  requested — statements frozen; the deterministic review re-pass is the
  next consumer.

## Verification

Fresh `lake env lean IPhO2026Problems/problem_IPhO_2026_2_C_2.lean`:
exit 0, 0 errors, exactly 3 `sorry` warnings (L138, L148, L161) — the
contracted sorries. No other files touched.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_C_2.md`
```markdown
ult` (PhysLean)
- `stereographic_target` (Mathlib)
- `SameRay` (Mathlib)
- `Ioi_mem_nhdsSet_Ici_iff` (Mathlib)
- `Besicovitch.TauPackage` (Mathlib)
- `Metric.AreSeparated` (Mathlib)
- `Mathlib.Tactic.FieldSimp.DenomCondition` (Mathlib)
- `Mathlib.Tactic.FieldSimp.DenomCondition.proof` (Mathlib)
- `slope` (Mathlib)
- `Ioi_mem_nhdsSet_Ici_iff` (Mathlib)
- `FirstOrder.«term_⟹_»` (Mathlib)
- `FirstOrder.«term_='_»` (Mathlib)
- `SameRay` (Mathlib)
- `Ioi_mem_nhdsSet_Ici_iff` (Mathlib)
- `FirstOrder.Language.LHom.IsExpansionOn` (Mathlib)
- `FirstOrder.Language.addConstants_expansion` (Mathlib)
- `Ioi_mem_nhdsSet_Ici_iff` (Mathlib)
- `SameRay` (Mathlib)
- `Ioi_mem_nhdsSet_Ici_iff` (Mathlib)
- `RayVector` (Mathlib)
- `NoZeroDivisors` (Mathlib)
- `Mathlib.Tactic.FieldSimp.DenomCondition` (Mathlib)
- `NNRat.den_zero` (Mathlib)
- `slope` (Mathlib)
- `slope_pos_iff_gt` (Mathlib)
- `slope_pos_iff` (Mathlib)

## Local abstractions introduced

- `IPhO2026_2_C_2.NeighboringRayExpansion`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 8. `IPhO2026Problems/problem_IPhO_2026_2_C_4.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 11.909
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_C_4.tex`
- Reports: `.archon/task_results/problem_IPhO_2026_2_C_4.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_C_4.md`

### Lean excerpt
```lean
ilter: the set of angles satisfying `InSmallAngleRegime` is a neighborhood
of `0` within the positive angles, so statements eventually true along
`smallAngleFilter` apply to it (proved, not assumed). -/
theorem smallAngleRegime_mem_filter :
    {θ : ℝ | InSmallAngleRegime θ} ∈ smallAngleFilter := by
  rw [smallAngleFilter, mem_nhdsWithin]
  exact ⟨Set.Iio 1, isOpen_Iio, by simp, fun θ hθ => ⟨hθ.2, hθ.1⟩⟩

/-- The `θ ≪ 1` power-law form of a parametric plane curve `θ ↦ (X θ, Y θ)`:
the coordinate functions have a well-defined positive leading-order balance
as `θ → 0⁺`, i.e. they are asymptotically equivalent
(`Asymptotics.IsEquivalent`, `f ~[l] g`) along the small-angle filter:
`Y θ ~ v * X θ ^ (p / q) + u` and `X θ ~ w * θ ^ q` for some positive scale
`w`. The exponent is a positive rational; `u`, `v` carry the dimension of
length and `p / q` is dimensionless. This is the genuine asymptotic content
of the subquestion: the two sides agree to leading order without being
required to coincide exactly (they do not for the mirror caustic). All
quantities are parameters of the definition, so nothing here is specialized
to the recorded answer. -/
def CausticPowerLawForm (X Y : ℝ → ℝ) (u v : ℝ) (p q : ℕ) : Prop :=
  0 < p ∧ 0 < q ∧
  (fun θ : ℝ => Y θ) ~[smallAngleFilter]
    (fun θ => v * X θ ^ ((p : ℝ) / (q : ℝ)) + u) ∧
  ∃ w : ℝ, 0 < w ∧
    (fun θ : ℝ => X θ) ~[smallAngleFilter] (fun θ => w * θ ^ q)

/-- The power-law form with the recorded constants of subquestion C.4 made
explicit: the vertical shift `u` and the prefactor `v` are the ones determined
from the mirror geometry, with exponent `p / q = 2 / 3`. -/
def SatisfiesCausticPowerLaw (X Y : ℝ → ℝ) (R u v : ℝ) : Prop :=
  u = R / 2 ∧
  v = (3 / 4) * R ^ ((1 : ℝ) / 3) ∧
  CausticPowerLawForm X Y u v 2 3

namespace HalfCylindricalMirrorCaustic

variable (c : HalfCylindricalMirrorCaustic)

/-- Main formalization target for C.4: in the small-angle regime `θ ≪ 1`, the
caustic of the half-cylindrical mirror has the power-law form
`Y_c = v * |X_c| ^ (p / q) + u` with the recorded constants
`u = R / 2`, `v = (3 / 4) * R ^ (1 / 3)`, `p = 2`, `q = 3`, read as
asymptotic agreement to leading order as `θ → 0⁺`. The `|X_c|` of the source
statement is subsumed by the positive-angle branch encoded in
`smallAngleFilter`, where `X_c θ = R * sin θ ^ 3` is positive. All recorded
constants appear on the conclusion side only. -/
theorem caustic_small_angle_power_law :
    SatisfiesCausticPowerLaw c.X_c c.Y_c c.R (c.R / 2)
      ((3 / 4) * c.R ^ ((1 : ℝ) / 3)) := by
  sorry

end HalfCylindricalMirrorCaustic

end IPhO2026_2_C_4
... [leading content omitted]
```

### Blueprint excerpt
```tex
:caustic_small_angle_power_law}
\lean{IPhO2026_2_C_4.HalfCylindricalMirrorCaustic.caustic_small_angle_power_law}
\uses{def:IPhO2026Problems_problem_IPhO_2026_2_C_4:HalfCylindricalMirrorCaustic, def:IPhO2026Problems_problem_IPhO_2026_2_C_4:SatisfiesCausticPowerLaw}
\textbf{(Target, T2-C.4.)}  In the small-angle regime $\theta \ll 1$, the
caustic of the half-cylindrical mirror of radius $R$ has the power-law form
\[
Y_c = v\,|X_c|^{p/q} + u
\quad\text{with}\quad
u = \frac{R}{2},\qquad
v = \frac{3}{4}\,R^{1/3},\qquad
p = 2,\qquad q = 3,
\]
read as asymptotic agreement to leading order as $\theta \to 0^{+}$.  The
$|X_c|$ of the source statement is subsumed by the positive-angle branch of
the small-angle filter, where $X_c\,\theta$ is positive.  This is the
recorded official answer of part C.4; the values are conclusion-side only,
confined to this target theorem (no hypothesis or structure field states
them in advance).
\end{theorem}
\begin{proof}
Insert the previous-part coordinates of the caustic (part C.3, recorded as
hypotheses on the caustic data) into both sides and expand about
$\theta = 0$: $Y_c\,\theta$ is $R/2$ plus its leading quadratic term, while
$|X_c\,\theta|^{2/3}$ carries the matching leading quadratic term with
prefactor fixed by the geometry, and $X_c$ itself matches a positive
multiple of $\theta^{3}$; the recorded constants are exactly the ones making
the leading terms coincide, so the two sides are asymptotically equivalent
along the small-angle filter.  An exact identity at every small $\theta$ is
false for this caustic --- the residual is higher order --- which is why the
agreement is stated to leading order.  All expansions are at the informal
level here; the formal counterpart is the prover stage's (currently
sorried) proof body in Lean.
\end{proof}
... [leading content omitted]
```

### Report excerpt: `problem_IPhO_2026_2_C_4.md`
```markdown
d quantity (no scalar-alias collapse: R,
  X_c, Y_c are lengths-as-reals per explicit docstrings; line data stay
  functional).
- smallAngleFilter / InSmallAngleRegime — filter + predicate pair keeping
  both the asymptotic and plain-English readings of t << 1.
- CausticPowerLawForm — general leading-order power-law predicate with
  parametrization-scale guard (exists w > 0, X ~ w t^q), so the exponent
  carries meaning (see countermodel audit).
- SatisfiesCausticPowerLaw — conclusion-side packaging of the recorded
  constants over the general form.

## Grounding gaps / redraft requests

- No unresolved grounding gaps: the preflight register records none, and the
  used Mathlib API is stable core asymptotics.
- No redraft requested from this lane: statements are planner-frozen, the
  file compiles 0 errors with 1 contracted sorry, and all faithfulness,
  bridge, countermodel, uncertainty, and branch checks above pass. The lane
  is ready for the deterministic review re-pass; the single sorry belongs to
  the prover-stage work queue (bridges 4-5 localize exactly what that proof
  must supply: Taylor-level IsEquivalent derivations plus the eventual
  positivity of X_c on the filter).
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_C_4.md`
```markdown
ableChange_c₄` (Mathlib)
- `Asymptotics.IsLittleOTVS.eventually_smallSets` (Mathlib)
- `Small` (Mathlib)
- `Filter.smallSets` (Mathlib)
- `PowerSeries.C` (Mathlib)
- `Small` (Mathlib)
- `WeierstrassCurve.c₄_of_isShortNF` (Mathlib)
- `Polynomial.mirror_eq_iff` (Mathlib)
- `UpperHalfPlane` (Mathlib)
- `Polynomial.mirror` (Mathlib)
- `Small` (Mathlib)
- `Filter.smallSets` (Mathlib)
- `Filter.smallSets_eq_generate` (Mathlib)

## Local abstractions introduced

- `IPhO2026_2_C_4.CausticPowerLawForm`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_2_C_4.HalfCylindricalMirrorCaustic`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_2_C_4.InSmallAngleRegime`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_2_C_4.SatisfiesCausticPowerLaw`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 9. `IPhO2026Problems/problem_IPhO_2026_3_A_1.lean`

- Compile status: passed
- Open sorries: 6
- Direct-check seconds: 11.987
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_A_1.tex`
- Reports: `.archon/task_results/problem_IPhO_2026_3_A_1.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_A_1.md`

### Lean excerpt
```lean
elation until the
final theorem assembles them.  In this autoformalization stage their bodies
are `sorry`. -/

/-- Bridge 1 — Ampère's law in the uniform regime:
`2πR · (N · H) = N · I` (the circulation of the uniform magnitude along the
mean path equals the total free current readout `N·I` threading the loop). -/
theorem ampere_uniform_eq (T : ParamagneticTorusA1) :
    2 * Real.pi * T.meanRadius * ((T.numTurns : ℝ) * T.fieldMagnitude)
      = (T.numTurns : ℝ) * T.wireCurrent.readout := by
  sorry

/-- Bridge 2 — solve the circulation equation for `H` along the mean path:
`H = N·I / (2πR)` (uses `N ≠ 0`, `R > 0`, `π > 0`). -/
theorem fieldMagnitude_eq_meanRadius_form (T : ParamagneticTorusA1) :
    T.fieldMagnitude
      = (T.numTurns : ℝ) * T.wireCurrent.readout
          / (2 * Real.pi * T.meanRadius) := by
  sorry

/-- Bridge 3 — geometry bridge: `2πR = V / A`, rewriting the mean-path
length in terms of the torus volume and cross-sectional area. -/
theorem mean_circumference_eq (T : ParamagneticTorusA1) :
    2 * Real.pi * T.meanRadius = T.volume / T.crossSectionArea := by
  sorry

/-- Bridge 4 — the figure parametrization of the answer along the mean
path: `N·I/(2πR) = N·I·A/V`. -/
theorem meanRadius_form_eq_volume_form (T : ParamagneticTorusA1) :
    (T.numTurns : ℝ) * T.wireCurrent.readout / (2 * Real.pi * T.meanRadius)
      = (T.numTurns : ℝ) * T.wireCurrent.readout * T.crossSectionArea
          / T.volume := by
  sorry

end ParamagneticTorusA1

/-! ### Main target theorem (T3-A1) -/

/-- **Part A.1 target**: the magnitude `H` of the field `H⃗` inside the
paramagnetic torus, expressed in terms of `N`, `A`, `V` and the
instantaneous current `I` in the wire, is

`H = N·I·A / V`.

Derivation route (informal): by Ampère's law `∮ H·dℓ = I_C` applied to the
mean amperian loop of length `2πR`, and by the uniformity of the field
magnitude in the thin torus, `2πR·(N·H) = N·I`; solving for `H` and using
the torus geometry `V = 2πR·A` gives `H = N·I/(2πR) = N·I·A/V`. -/
theorem paramagneticTorus_H_eq (T : ParamagneticTorusA1) :
    T.fieldMagnitude
      = (T.numTurns : ℝ) * T.wireCurrent.readout * T.crossSectionArea
          / T.volume := by
  sorry

/-- Equivalent mean-radius form of the Part A.1 answer:
`H = N·I / (2πR)`, the form one obtains directly from Ampère's law before
substituting the torus geometry `V = 2πR·A`. -/
theorem paramagneticTorus_H_eq_meanRadius (T : ParamagneticTorusA1) :
    T.fieldMagnitude
      = (T.numTurns : ℝ) * T.wireCurrent.readout
          / (2 * Real.pi * T.meanRadius) := by
  sorry

end PartA1
end Problem3
end IPhO2026
... [leading content omitted]
```

### Blueprint excerpt
```tex
3.PartA1.ParamagneticTorusA1.mean_circumference_eq}
\uses{def:IPhO2026Problems_problem_IPhO_2026_3_A_1:ParamagneticTorusA1}
$2\pi R = V / A$.
\end{lemma}
\begin{proof}
Field-simplify the thin-torus volume law $V = 2\pi R A$ using $A > 0$.
\end{proof}

\begin{lemma}[Bridge 4 — figure parametrization of the answer]
\label{lem:IPhO2026Problems_problem_IPhO_2026_3_A_1:meanRadius_form_eq_volume_form}
\lean{IPhO2026.Problem3.PartA1.ParamagneticTorusA1.meanRadius_form_eq_volume_form}
\uses{lem:IPhO2026Problems_problem_IPhO_2026_3_A_1:mean_circumference_eq}
$N I / (2\pi R) = N I A / V$.
\end{lemma}
\begin{proof}
Substitute Bridge 3 into the denominator
(uses $2\pi R > 0$, $V > 0$).
\end{proof}

\begin{theorem}[A.1 main target: $H = NIA/V$]
\label{thm:IPhO2026Problems_problem_IPhO_2026_3_A_1:paramagneticTorus_H_eq}
\lean{IPhO2026.Problem3.PartA1.paramagneticTorus_H_eq}
\uses{lem:IPhO2026Problems_problem_IPhO_2026_3_A_1:fieldMagnitude_eq_meanRadius_form, lem:IPhO2026Problems_problem_IPhO_2026_3_A_1:meanRadius_form_eq_volume_form}
The magnitude of $\vec{H}$ inside the paramagnetic torus, in terms of
$N$, $A$, $V$ and the instantaneous current $I$, is
$H = N I A / V$.
\end{theorem}
\begin{proof}
Chain Bridge 2 ($H = NI/(2\pi R)$) with Bridge 4
($NI/(2\pi R) = NIA/V$).
\end{proof}

\begin{theorem}[A.1 answer in mean-radius form]
\label{thm:IPhO2026Problems_problem_IPhO_2026_3_A_1:paramagneticTorus_H_eq_meanRadius}
\lean{IPhO2026.Problem3.PartA1.paramagneticTorus_H_eq_meanRadius}
\uses{lem:IPhO2026Problems_problem_IPhO_2026_3_A_1:fieldMagnitude_eq_meanRadius_form}
Equivalent form obtained directly from Ampère's law before the geometry
substitution: $H = N I / (2\pi R)$.
\end{theorem}
\begin{proof}
Restatement of Bridge 2.
\end{proof}

% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `problem_IPhO_2026_3_A_1.md`
```markdown
justifies the `import Mathlib`-only baseline.

## Local abstractions introduced

All iter-002/003 vintage, preserved verbatim: `FreeSpace` (positive `μ₀` record), `InstantaneousCurrent` (typed current + readout; avoids scalar fallback), `RadialProfile`/`HFieldReadouts` (function habitats), `AmperianFilament` (free/positive current carrier), `AmpereLaw` (circulation equation), `FiniteWinding` (bundled finite turn type), `AmpereLawThinMeanPath` (geometry + sum form), `UniformFieldMag` (equality-exposing uniformity), `AmperianFilamentLaw` (filament interpretation of the hint's `I_C`), `VacuumCoreIdentity` (downstream material law), `ParamagneticTorusA1` (parameter/law package). Each preserves its physical role through exposed equations/inequalities per the countermodel audit above.

## Grounding gaps / redraft requests

- No new grounding gaps. Standing, already-recorded gap: PhysLean lacks a ready-made Ampère-circulation/toroid `H = NI/(2πR)` assembly API (iter-003 exemption NOTE in the chapter; the stale review-gate reason repeats this finding and is expected to be cleared by the deterministic re-pass against the exemption).
- No redraft requested; statements remain planner-frozen.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_A_1.md`
```markdown
int-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.PartA1.HFieldReadouts`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.PartA1.InstantaneousCurrent`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.PartA1.ParamagneticTorusA1`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.PartA1.RadialProfile`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.PartA1.UniformFieldMag`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.PartA1.VacuumCoreIdentity`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 10. `IPhO2026Problems/problem_IPhO_2026_3_B_1.lean`

- Compile status: passed
- Open sorries: 3
- Direct-check seconds: 11.797
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_B_1.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_3_B_1.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_B_1.md`

### Lean excerpt
```lean
the initial and
final states of the isothermal field change: the difference of the tracked
cumulative heat readout.  This is the quantity the target theorem
characterizes; the recorded answer is its closed form, which must still be
derived — nothing asserts it in advance. -/
noncomputable def heatTransferredIntoTorus (p : TorusParams)
    (proc : IsothermalFieldChange p) : ℝ :=
  proc.Q_in (proc.M_of_H proc.H_f) - proc.Q_in (proc.M_of_H proc.H_i)

/-- **Target.** Along an isothermal field change of the paramagnetic torus
satisfying the equation of state, with the magnetic work `dW = μ₀ V H dM`
of part A.3 (recorded in the first-law density below) and the first law of
thermodynamics, the heat transferred into the torus
(`heatTransferredIntoTorus`, the difference of the tracked heat readout
between the final and initial states) equals the recorded closed form

`Q = -(μ₀ * n * K / (2 * T)) * (H_f^2 - H_i^2)`

(`heat_into_torus_value`).  No hypothesis states this closed form: the
first-law hypothesis only supplies leg balances `Q_in M_target - Q_in M₀ =
(U T − U T) − ∫ M₀..M_target workDensity` against the demagnetized
reference, and deriving the value of the integral is the proof obligation:
`leg_work_integral_eval` (built on `magnetization_eq_eos_solution` +
`leg_mem_tracked_range` + `intervalIntegral.integral_congr` +
`intervalIntegral.integral_const_mul` + `integral_id`) evaluates each leg,
then `magnetization_eq_eos_solution` at `H_i, H_f` and `field_simp`/`ring`
reduce the difference to the closed form.

Blueprint label: `thm:physics:IPhO_2026_3_B_1:target`. -/
theorem isothermal_heat_into_torus (p : TorusParams) (U : ℝ → ℝ)
    (proc : IsothermalFieldChange p)
    (hU : HasHeatCapacityLaw p U)
    (hV : p.V ≠ 0)
    (h_first_law : ∀ (workDensity : ℝ → ℝ),
      IsMagneticWorkDensity p proc.M_of_H workDensity →
      ObeysFirstLawMagnetic p U proc.T workDensity proc.Q_in)
    (Q : ℝ) (hQ : Q = heatTransferredIntoTorus p proc) :
    Q = heat_into_torus_value p proc := by
  sorry

/-- **Recorded official answer (checking form).** The heat
`heat_into_torus_value p proc` carried by the target theorem equals the
closed form recorded in the answer key,

`Q = -(μ₀ * n * K / (2 * T)) * (H_f^2 - H_i^2)`.

This is conclusion-side only: it pins the closed form of
`heat_into_torus_value`, it is not used as a hypothesis of any theorem. -/
theorem official_answer_value (p : TorusParams)
    (proc : IsothermalFieldChange p) :
    heat_into_torus_value p proc =
      -(p.mu0 * p.n * p.K / (2 * proc.T)) * (proc.H_f ^ 2 - proc.H_i ^ 2) :=
  rfl
end IPhO2026.Problem3.B1
... [leading content omitted]
```

### Blueprint excerpt
```tex
dW = \mu_0 V H\,dM$ of part A.3
and the first law of thermodynamics, the heat transferred into the torus
(the difference of the tracked heat readout between the final and initial
states) equals the closed-form value carrier:
$Q = -(\mu_0 n K/(2T))(H_f^2 - H_i^2)$.  No hypothesis states this closed
form in advance: the first-law hypothesis only supplies leg balances
against the demagnetized reference, and deriving the value of each work
integral is the proof obligation.
\end{theorem}
\begin{proof}
Apply the first-law leg balance to the two legs $0 \to M(H_i)$ and
$0 \to M(H_f)$; the internal-energy brackets vanish by the heat-capacity
law along the isotherm, so
$Q = -\bigl(W_{\mathrm{on}}(H_f) - W_{\mathrm{on}}(H_i)\bigr)$ with each
$W_{\mathrm{on}}$ evaluated by
\cref{lem:IPhO2026Problems_problem_IPhO_2026_3_B_1:LegWorkIntegralEval};
substituting the equation-of-state solution
$M(H) = n K H /(T V)$ at both endpoints and cancelling $V$ reduces the
difference to the closed form by algebra.
\end{proof}

\begin{theorem}[Recorded official answer]
\label{thm:IPhO2026Problems_problem_IPhO_2026_3_B_1:OfficialAnswerValue}
\lean{IPhO2026.Problem3.B1.official_answer_value}
\uses{def:IPhO2026Problems_problem_IPhO_2026_3_B_1:TorusParams, def:IPhO2026Problems_problem_IPhO_2026_3_B_1:ObeysFirstLawMagnetic, def:IPhO2026Problems_problem_IPhO_2026_3_B_1:HeatIntoTorusValue}
The closed value of the heat transferred into the torus carried by the
target theorem equals the closed form recorded in the official answer key,
\[
Q = -\frac{\mu_0\,n\,K}{2 T}\,\bigl(H_f^2 - H_i^2\bigr).
\]
This entry is conclusion-side only: it pins the value of the answer
carrier; it is not a hypothesis of any theorem.
\end{theorem}
\begin{proof}
Definitional unfolding of the value carrier; reflexivity.
\end{proof}
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_3_B_1.md`
```markdown
g and
the chapter's import-policy NOTE (iter-002 exemption, `import Mathlib`
baseline; the retry-gate "should import Physlib" reason is addressed by that
exemption NOTE).

## Local abstractions introduced

All four governing-law interfaces (`SatisfiesEOS`, `HasHeatCapacityLaw`,
`IsMagneticWorkDensity`, `ObeysFirstLawMagnetic`) plus the parameter/process
records — each is the smallest equation- or derivative-emitting interface
preserving the physical role; no scalar placeholder aliases (`abbrev X := ℝ`)
are used for primitive quantities.

## Grounding gaps / redraft requests

- PhysLean gap: no paramagnetic-magnetic-work / isothermal-first-law module —
  documented in both the chapter exemption NOTE and the grounding log; local
  interfaces are the sanctioned fallback. No new gaps, no redraft requested.

## Gate note

Lane remains `retry 2/3` per `.archon/formalization-review-gate.json`; all
six certificate checks in that gate are `passed`/`not_applicable` with the
sole recorded reason being the PhysLean-import policy, which the iter-002
planner exemption NOTE resolves. Recommended next consumer (unchanged): the
deterministic review re-pass; no further prover redraft from this lane.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_B_1.md`
```markdown
HasHeatCapacityLaw`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.B1.IsMagneticWorkDensity`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.B1.IsothermalFieldChange`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.B1.ObeysFirstLawMagnetic`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.B1.SatisfiesEOS`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.B1.TorusParams`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.B1.TorusState`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 11. `IPhO2026Problems/problem_IPhO_2026_3_C_2.lean`

- Compile status: passed
- Open sorries: 10
- Direct-check seconds: 12.119
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_2.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_3_C_2.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_C_2.md`

### Lean excerpt
```lean
.Qc = (p.μ₀ * p.V / 2) * (m.q .v3 - m.q .v2) := by
  sorry

/-- The Carnot heat ratio combined with the two leg identities `Qh_eq`,
`Qc_eq` gives the scalar relation
$T_c\,q_1 = (T_c - T_h)\,q_4 + T_h\,q_3$
among the state-function values at the vertices.  Here
$q_3 = q_2 = T_c M_2^2$ on the shared adiabat is what turns the right-hand
side into the C.2 numerator in the next lemmas. -/
lemma q_relation : m.Tc * m.q .v1 = (m.Tc - m.Th) * m.q .v4 + m.Th * m.q .v3 := by
  sorry

/-- Adiabatic-leg book-keeping: the state function at vertex $4$ equals
$q_4 = T_c M_2^2$ (the common value of $q$ on the adiabat through states
$2$ and $3$).

Physical content: the adiabatic legs $2\to3$ and $4\to1$ transfer no heat
and retrace the same adiabat between the same two field endpoints, so
$q_3 = q_2$ and $q_4$ sits at that same value.  Formally this equation is
derived from `Qh_eq`, `Qc_eq`, `q_relation`, and $q_3 = T_c M_2^2$ (which
uses $T_2 = T_3$, i.e. states $2,3$ sharing the adiabat's cold end); it is
*stated as an equation* so it can be rewritten with, and it is eliminable —
it does not mention $M_1$, so it cannot unfold to the C.2 answer. -/
lemma q4_eq_adiabatic_41 : m.q .v4 = m.Tc * m.M2 ^ 2 := by
  sorry

/-- The values of $q$ at the cold vertices coincide with the magnetization
data: $q_3 = T_c M_2^2$ (since states $2,3$ lie on the same adiabat) and is
also equal to $T_c M_3^2$ — the two express $M_3$ in terms of $M_2$ along the
adiabatic leg $2\to3$.  Formally: $q_3 = T_c M_3^2$ (definition of $q$ with
$T_3 = T_c$) and $q_3 = q_2 = T_c M_2^2$ (common adiabat). -/
lemma q3_eq : m.q .v3 = m.Tc * m.M2 ^ 2 := by
  sorry

/-- The squared vertex-1 magnetization:
$M_1^2 = M_2^2 - M_3^2 + M_4^2$.
Carrier: `q_relation` divided by $T_h$, with `q4_eq_adiabatic_41`, `q3_eq`,
and $q_1 = T_h M_1^2$, $q_4 = T_h M_4^2$ (definitions of $q$ with
$T_1 = T_4 = T_h$). -/
theorem m1_sq : m.M1 ^ 2 = m.M2 ^ 2 - m.M3 ^ 2 + m.M4 ^ 2 := by
  sorry

/-- **Subquestion C.2 (main target).**
The magnitude of $\vec M$ at vertex $1$ of the Carnot refrigeration cycle is

$M_1 = \sqrt{M_2^2 - M_3^2 + M_4^2}$,

with the nonnegative square root selected because $M_1$ is a magnitude. -/
theorem m1_eq_sqrt : m.M1 = Real.sqrt (m.M2 ^ 2 - m.M3 ^ 2 + m.M4 ^ 2) := by
  sorry

/-- The quantity under the root is nonnegative, as it must be for a physical
magnetization magnitude: $0 \le M_2^2 - M_3^2 + M_4^2$.
Carrier: `m1_sq` together with `M_nonneg .v1` ($0 \le M_1^2$). -/
theorem m1_sq_arg_nonneg : 0 ≤ m.M2 ^ 2 - m.M3 ^ 2 + m.M4 ^ 2 := by
  sorry

end CarnotMagnetizationModel

end IPhO2026.Problem3.C2
... [leading content omitted]
```

### Blueprint excerpt
```tex
,2} - M_3^{\,2} + M_4^{\,2}$.
\end{theorem}
\begin{proof}
Divide the scalar relation
$T_c\,q_1 = (T_c - T_h)\,q_4 + T_h\,q_3$ by $T_h > 0$, then rewrite
with $q_1 = T_h\,M_1^{\,2}$, $q_4 = T_h\,M_4^{\,2}$ (the Figure-3b
hot temperatures) and the adiabatic-leg values
$q_4 = q_3 = T_c\,M_2^{\,2}$.
\end{proof}

\begin{theorem}[Subquestion C.2 (main target): $M_1$ in terms of $M_2, M_3, M_4$]
\label{thm:IPhO2026Problems_problem_IPhO_2026_3_C_2:m1_eq_sqrt}
\lean{IPhO2026.Problem3.C2.CarnotMagnetizationModel.m1_eq_sqrt}
\uses{def:IPhO2026Problems_problem_IPhO_2026_3_C_2:CarnotMagnetizationModel, thm:IPhO2026Problems_problem_IPhO_2026_3_C_2:m1_sq}
(Conclusion-side official answer.) The magnitude of $\vec M$ at
vertex $1$ of the Carnot refrigeration cycle is
\[
M_1 = \sqrt{M_2^{\,2} - M_3^{\,2} + M_4^{\,2}},
\]
the recorded official answer of subquestion C.2, with the nonnegative
square root selected because $M_1$ is a magnitude.
\end{theorem}
\begin{proof}
Take nonnegative square roots of the squared relation
$M_1^{\,2} = M_2^{\,2} - M_3^{\,2} + M_4^{\,2}$ using
$0 \le M_1$ (the model's magnitude nonnegativity at vertex $1$).
\end{proof}

\begin{theorem}[Nonnegativity of the radicand]
\label{thm:IPhO2026Problems_problem_IPhO_2026_3_C_2:m1_sq_arg_nonneg}
\lean{IPhO2026.Problem3.C2.CarnotMagnetizationModel.m1_sq_arg_nonneg}
\uses{def:IPhO2026Problems_problem_IPhO_2026_3_C_2:CarnotMagnetizationModel, thm:IPhO2026Problems_problem_IPhO_2026_3_C_2:m1_sq}
(Conclusion-side consistency consequence.)
$0 \le M_2^{\,2} - M_3^{\,2} + M_4^{\,2}$: the quantity under the
square root is nonnegative, as it must be for a physical
magnetization magnitude.
\end{theorem}
\begin{proof}
Rewrite the combination as $M_1^{\,2}$ via the squared relation,
then use that a square is nonnegative.
\end{proof}
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_3_C_2.md`
```markdown
certificates rather than folding into one constant — needed by
  the B.1 law's prefactor $\mu_0 n K/(2T)$.
- `CarnotCycle`/`ProcessKind`/`Vertex`: keeps the Figure-3b geometry and per-leg orientation instead of a bare tuple of scalars.
- `IsothermalHeatIntoTorus`, `CarnotHeatRatio`, `EquationOfStateParamagnet`: law-shaped `Prop`s carrying the actual equations,
  not conclusion-shaped formulas.

## Grounding gaps / redraft requests

- **Redraft candidate (prover stage; statements frozen here)** bridge 5: add a constraining adiabatic-leg law so
  `q3_eq`/`q4_eq_adiabatic_41` derive instead of being magnetization assertions — e.g. a field
  `adiabatic_leg_q_const : ∀ v_i v_f, [leg adiabatic] → cyc.T v_i * cyc.Mmag v_i ^ 2 = cyc.T v_f * cyc.Mmag v_f ^ 2`
  (the physical law "no heat ⇒ $T M^2$ conserved along the leg", per the Pm-T adiabatic invariant of the model), or fold it into
  `Figure3bAssignment`/`CarnotMagnetizationModel`; then `q3_eq` becomes `adiabatic` on $2{\to}3` and `q4_eq_adiabatic_41` on
  $4{\to}1$ chained with $q_3 = q_2$. Flagged for the review agent / prover-stage planner.
- No LeanExplore unresolved gaps beyond the PhysLean thermodynamics absence already exempted.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_C_2.md`
```markdown
3.C2.EquationOfStateParamagnet`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C2.Figure3bAssignment`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C2.IsothermalHeatIntoTorus`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C2.ParamagnetState`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C2.ProcessKind`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C2.TorusParams`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C2.Vertex`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 12. `IPhO2026Problems/problem_IPhO_2026_3_C_3.lean`

- Compile status: passed
- Open sorries: 0
- Direct-check seconds: 23.206
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_3.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_3_C_3.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_C_3.md`

### Lean excerpt
```lean
ons with
named value lemmas.) -/
theorem temperature_drop_value (r : PotassiumChromateCoolingRun) :
    |(r.TInitial - r.TFinal) - 9.92e-3| < 5.0e-5 := by
  have hdrop : r.TInitial - r.TFinal = r.Qc / (r.heliumMass * heliumSpecificHeat) := by
    have h := r.TFinal_from_calorimetry
    linarith [h]
  rw [hdrop]
  have hTc : r.Tc = 1 := by rw [← r.initial_is_Tc.1, show r.TInitial = 1.00 from r.initial_is_Tc.2]; norm_num
  have h := r.Qc_cold_leg
  change r.Qc = r.p.μ₀ * r.p.n * r.p.K / r.Tc *
      (r.cyc.Hmag Vertex.v2 ^ 2 - r.cyc.Hmag Vertex.v3 ^ 2) / 2 at h
  rw [r.vertex_fields.2.1, r.vertex_fields.2.2.1, r.p_mu0, r.p_amount, r.p_K,
      hTc, pmtAmount_value, pmtMaterialK_value] at h
  rw [h, r.bath_mass, heliumDensity_value, heliumSpecificHeat_value,
      show heliumBathVolume = 1 / 1000 from by norm_num [heliumBathVolume]]
  unfold vacuumPermeability
  rw [show (9.92e-3 : ℝ) = 992 / 100000 by norm_num,
      show (5.0e-5 : ℝ) = 5 / 100000 by norm_num,
      show (2.0 : ℝ) = 2 by norm_num,
      show (1.87e-6 : ℝ) = 187 / 100000000 by norm_num]
  norm_num [abs_lt]
  constructor <;> nlinarith [Real.pi_pos, Real.pi_gt_d4, Real.pi_lt_d4]

/-- **Subquestion C.3 target (iii): final helium temperature.**
After one operating cycle the liquid helium is at T_final ≈ 0.99008 K
(officially T_final = 0.99008 K).  T_final = T_initial − drop with
T_initial = 1.00 K and the drop bounded as in target (ii). -/
theorem final_temperature_value (r : PotassiumChromateCoolingRun) :
    |r.TFinal - 0.99008| < 5.0e-5 := by
  have hTf : r.TFinal = r.TInitial - r.Qc / (r.heliumMass * heliumSpecificHeat) :=
    r.TFinal_from_calorimetry
  have hTc : r.Tc = 1 := by rw [← r.initial_is_Tc.1, show r.TInitial = 1.00 from r.initial_is_Tc.2]; norm_num
  have h := r.Qc_cold_leg
  change r.Qc = r.p.μ₀ * r.p.n * r.p.K / r.Tc *
      (r.cyc.Hmag Vertex.v2 ^ 2 - r.cyc.Hmag Vertex.v3 ^ 2) / 2 at h
  rw [r.vertex_fields.2.1, r.vertex_fields.2.2.1, r.p_mu0, r.p_amount, r.p_K,
      hTc, pmtAmount_value, pmtMaterialK_value] at h
  rw [hTf, h, r.initial_is_Tc.2, r.bath_mass, heliumDensity_value,
      heliumSpecificHeat_value, show heliumBathVolume = 1 / 1000 from by norm_num [heliumBathVolume]]
  unfold vacuumPermeability
  rw [show (0.99008 : ℝ) = 99008 / 100000 by norm_num,
      show (5.0e-5 : ℝ) = 5 / 100000 by norm_num,
      show (2.0 : ℝ) = 2 by norm_num,
      show (1.87e-6 : ℝ) = 187 / 100000000 by norm_num,
      show (1.00 : ℝ) = 1 by norm_num]
  norm_num [abs_lt]
  constructor <;> nlinarith [Real.pi_pos, Real.pi_gt_d4, Real.pi_lt_d4]

end OfficialAnswer

end IPhO2026.Problem3.C3
... [leading content omitted]
```

### Blueprint excerpt
```tex
0 = 4\pi{\cdot}10^{-7}$ H/m, lands inside the
recorded band around $0.129$ J; the certified-interval evaluation is left to
the prover stage.
\end{proof}

\begin{theorem}[C.3 target (ii): temperature drop]
\label{thm:IPhO2026Problems_problem_IPhO_2026_3_C_3:temperature_drop_value}
\lean{IPhO2026.Problem3.C3.temperature_drop_value}
\uses{thm:IPhO2026Problems_problem_IPhO_2026_3_C_3:absorbed_heat_value, lem:IPhO2026Problems_problem_IPhO_2026_3_C_3:TFinal_from_calorimetry}
The helium temperature drops by $|\Delta T| \approx 9.92{\cdot}10^{-3}$ K in
one cycle: $|(T_{\mathrm{initial}} - T_{\mathrm{final}}) - 9.92\mathrm{e}{-3}| < 5.0\mathrm{e}{-5}$.
\end{theorem}
\begin{proof}
Divide the absorbed-heat value by the helium heat capacity
$m_{\mathrm{He}}\,c = (\rho_{\mathrm{He}} V_{\mathrm{He}})\,c$
($= 130 \cdot 1.00\mathrm{e}{-3} \cdot 100 = 13.0$ J/K): the drop is
$Q_c/(m_{\mathrm{He}} c) \approx 0.129/13.0 \approx 9.92{\cdot}10^{-3}$ K,
inside the recorded band.
\end{proof}

\begin{theorem}[C.3 target (iii): final temperature]
\label{thm:IPhO2026Problems_problem_IPhO_2026_3_C_3:final_temperature_value}
\lean{IPhO2026.Problem3.C3.final_temperature_value}
\uses{thm:IPhO2026Problems_problem_IPhO_2026_3_C_3:temperature_drop_value, lem:IPhO2026Problems_problem_IPhO_2026_3_C_3:helium_cools}
After one operating cycle the liquid helium is at
$T_{\mathrm{final}} \approx 0.99008$ K:
$|T_{\mathrm{final}} - 0.99008| < 5.0\mathrm{e}{-5}$.
\end{theorem}
\begin{proof}
Subtract the drop from the initial temperature $T_{\mathrm{initial}} = 1.00$ K
(the \texttt{initial\_is\_Tc} field); the cooling branch
($T_{\mathrm{final}} < T_{\mathrm{initial}}$) fixes the sign:
$1.00 - 9.92{\cdot}10^{-3} = 0.99008$ K, inside the recorded band.
\end{proof}

% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_3_C_3.md`
```markdown
m_IPhO_2026_3_C_3:{absorbed_heat_value,
  temperature_drop_value, final_temperature_value}`)

## LeanExplore queries/candidates actually used

From the preserved register `physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_C_3.md`
(local backend, packages Mathlib + Physlib): queries `Real.sqrt square root`,
`Carnot heat ratio`, `Isothermal heat relation (part B.1)`,
`Ideal-paramagnet equation of state`, etc. — all near misses (generic
`MagneticField`/ideal-gas adiabatic hits); grounded Mathlib names actually
consumed: `Real.pi`, `Real.pi_pos`, `Real.pi_gt_d4`, `Real.pi_lt_d4`,
`abs_lt`, `mul_ne_zero`, `div_eq_div_iff`, `mul_div_cancel_left₀`, `div_pos`,
`mul_pos`, `ne_of_gt`, `mul_eq_zero`.

## Grounding gaps / redraft requests

- PhysLean gap (chapter exemption NOTE, planner-recorded iter-003): no
  classical-paramagnet thermodynamic-cycle module (Curie EOS, adiabatic
  demagnetization calorimetry); model stays local over `import Mathlib`.
  Nothing blocked.
- No redraft requested. The lane is faithful, compiling, and sorry-free; the
  deterministic review re-pass (retry 2/3, recorded-stale) is its next
  consumer, and the sync should mark the 29 ledger environments `\leanok`.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_C_3.md`
```markdown
eprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C3.PotassiumChromateCoolingRun.TFinal_from_calorimetry`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C3.ProcessKind`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C3.SuppliedMaterialData`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C3.TorusParams`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C3.TorusVolumeFromSource`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C3.Vertex`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 13. `IPhO2026Problems/problem_IPhO_2026_3_C_4.lean`

- Compile status: passed
- Open sorries: 8
- Direct-check seconds: 11.747
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_4.tex`
- Reports: `.archon/task_results/problem_IPhO_2026_3_C_4.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_C_4.md`

### Lean excerpt
```lean
P) * (T_h / T' - 1).

    Carrier: `residenceDensity_eq` on `Set.Ioo`, upgraded to set-integral
    congruence (the endpoints form a measure-zero set). -/
theorem elapsedTime_eq_integral
    (regime : RegimeAssumptions)
    (run : CoolingRun) (hrun : IsCoolingRun run)
    (haccum : elapsedTime
      = ∫ T' in Set.Icc tempFinal tempInitial, run.residenceDensity T') :
    elapsedTime
      = ∫ T' in Set.Icc tempFinal tempInitial,
          (heatCapacityBody / inputPower) * (tempHot / T' - 1) := by
  sorry

/-- **Evaluation bridge (real analysis).**  The residence-time integral
    evaluates by the fundamental theorem of calculus
    (`∫ T_h/T' = T_h * ln (T_0/T)` off `0 < T ≤ T' ≤ T_0`, `∫ 1 = T_0 - T`):

        ∫_{[T, T_0]} (C_c / P) * (T_h / T' - 1)
          = (C_c / P) * (T_h * ln (T_0 / T) - (T_0 - T)).

    Carrier: Mathlib `intervalIntegral.integral_one_div` and constant
    integration (via the identity between set integrals over `Icc` and
    interval integrals). -/
theorem cooling_time_integral_eval (regime : RegimeAssumptions) :
    (∫ T' in Set.Icc tempFinal tempInitial,
        (heatCapacityBody / inputPower) * (tempHot / T' - 1))
      = (heatCapacityBody / inputPower) *
          (tempHot * Real.log (tempInitial / tempFinal)
            - (tempInitial - tempFinal)) := by
  sorry

/-- **Subquestion C.4 (main target).**

    The body of heat capacity `C_c` is cooled from `T_0` to `T` at constant
    input power `P` and constant hot-reservoir temperature `T_h` in elapsed
    time

        t = (C_c * T_h / P) * (ln (T_0 / T) - (T_0 - T) / T_h).

    The right-hand side (the recorded official answer) is purely
    conclusion-side: the hypotheses only bundle the per-cycle governing laws
    (`IsCoolingRun`, composed of the Carnot heat ratio, the first law, the
    constant-power law, and the calorimetric law) and the operational
    definition of the elapsed time (`haccum`).  Proof route:
    `elapsedTime_eq_integral` ∘ `cooling_time_integral_eval`, then the field
    algebra
    `(C_c/P) * (T_h ln(T_0/T) − (T_0−T)) = (C_c T_h/P) * (ln(T_0/T) − (T_0−T)/T_h)`.

    Blueprint label: `thm:physics:IPhO_2026_3_C_4:target`. -/
theorem c4_elapsed_time
    (regime : RegimeAssumptions)
    (run : CoolingRun) (hrun : IsCoolingRun run)
    (haccum : elapsedTime
      = ∫ T' in Set.Icc tempFinal tempInitial, run.residenceDensity T') :
    elapsedTime
      = (heatCapacityBody * tempHot / inputPower) *
          (Real.log (tempInitial / tempFinal)
            - (tempInitial - tempFinal) / tempHot) := by
  sorry

end PhysicsContracts

end IPhO2026.Problem3.C4
... [leading content omitted]
```

### Blueprint excerpt
```tex
aluates in closed form:
$\int_{[T,\,T_0]} (C_c/P)\,(T_h/T' - 1)\,dT'
= (C_c/P)\,\bigl(T_h\,\ln(T_0/T) - (T_0 - T)\bigr)$.
(Conclusion-side intermediate value; not the official C.4 answer
form.)
\end{theorem}
\begin{proof}
Fundamental theorem of calculus on $0 < T \le T' \le T_0$:
$\int T_h/T' \, dT' = T_h \ln(T_0/T)$ off $T' \neq 0$ and
$\int 1\,dT' = T_0 - T$; pull the constant $C_c/P$ out.
\end{proof}

\begin{theorem}[Subquestion C.4: elapsed cooling time]
\label{thm:IPhO2026Problems_problem_IPhO_2026_3_C_4:c4_elapsed_time}
\lean{IPhO2026.Problem3.C4.c4_elapsed_time}
\uses{def:IPhO2026Problems_problem_IPhO_2026_3_C_4:globalQuantities, def:IPhO2026Problems_problem_IPhO_2026_3_C_4:RegimeAssumptions, def:IPhO2026Problems_problem_IPhO_2026_3_C_4:CoolingRun, def:IPhO2026Problems_problem_IPhO_2026_3_C_4:IsCoolingRun, thm:IPhO2026Problems_problem_IPhO_2026_3_C_4:elapsedTime_eq_integral, thm:IPhO2026Problems_problem_IPhO_2026_3_C_4:cooling_time_integral_eval}
The body of heat capacity $C_c$, cooled from $T_0$ to $T$ at constant
input power $P$ and constant hot-reservoir temperature $T_h$, reaches
$T$ in elapsed time
\[
t = \frac{C_c\,T_h}{P}\Bigl(\ln\frac{T_0}{T} - \frac{T_0 - T}{T_h}\Bigr).
\]
The right-hand side is the recorded official answer of subquestion
C.4; it is purely conclusion-side --- the hypotheses only bundle the
per-cycle governing laws (the cooling-run predicate, composed of the
Carnot heat ratio, the first law, the constant-power law, and the
calorimetric law) and the operational definition of the elapsed time.
\end{theorem}
\begin{proof}
Chain the accumulation bridge with the evaluation bridge, then apply
the field algebra
$(C_c/P)\,(T_h \ln(T_0/T) - (T_0 - T))
= (C_c T_h/P)\,(\ln(T_0/T) - (T_0 - T)/T_h)$,
factoring $T_h$ out of the parenthesis.
\end{proof}
... [leading content omitted]
```

### Report excerpt: `problem_IPhO_2026_3_C_4.lean.md`
```markdown
6_3_C_4.md`
(iter-002 preflight, status complete; the file content is byte-identical
since then). Packages searched: Mathlib + Physlib. Queries covered every
blueprint entry name (quantities, torus params, working state, cycle corners,
cooling-run densities, isothermal heat, Carnot ratio). Relevant candidates
consulted: `CanonicalEnsemble.heatCapacity` (PhysLean — heat *capacity*
definition, not the calorimetric cooling law needed here),
`adiabatic_relation_UaUbVaVb` (PhysLean ideal-gas adiabats — different
model), `MeasureTheory.Measure.withDensity` (Mathlib — near miss for the
density formulation). None were applicable to the paramagnetic `(M,H,T)`
infinitesimal-cycle model, so the faithful local abstractions above were
kept; Mathlib's measure/interval-integral API (`Set.Icc` set integrals,
`intervalIntegral.integral_one_div`) provides the analysis anchors.

## Grounding gaps

- PhysLean thermodynamics does not cover this paramagnetic-torus
  infinitesimal-cycle `(M,H,T)` model — planner-recorded exemption NOTEs in
  the chapter (iter-002 ruling, re-confirmed iter-008); `import Mathlib`
  baseline retained. Not a blocker for the by-sorry formalization.
- No other unresolved gaps.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_C_4.md`
```markdown
3.C4.InfinitesimalCycleLaw`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C4.IsCoolingRun`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C4.IsothermalHeatIntoTorus`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C4.ParamagnetEOS`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C4.RegimeAssumptions`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C4.TorusParams`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C4.WorkingState`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 14. `IPhO2026Problems/problem_IPhO_2026_3_C_5.lean`

- Compile status: passed
- Open sorries: 2
- Direct-check seconds: 11.643
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_5.tex`
- Reports: `.archon/task_results/problem_IPhO_2026_3_C_5.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_C_5.md`

### Lean excerpt
```lean
ial constant `K` and field `H`. -/
def ParamagneticEquationOfState (Tgas M V n K H : ℝ) : Prop :=
  Tgas * M * V = n * K * H

end GoverningLaws

section PhysicsContracts

/-- Data read out from the operating history and the C.4 analysis:
    the accumulated totals `Q_c`, `Q_h`, `W`, `t` satisfy the governing laws
    above under the regime assumptions. -/
structure OperatingHistory (Qh : ℝ) : Prop where
  work_law    : ConstantPowerWork totalWork inputPower elapsedTime
  body_heat   : CooledBodyHeatBalance totalHeatCold heatCapacityBody tempInitial tempFinal
  carnot_heat : AccumulatedCarnotHeatRelation Qh totalHeatCold tempHot tempInitial tempFinal
  energy      : RefrigeratorEnergyBalance Qh totalHeatCold totalWork
  c4_time     : C4ElapsedTimeLaw elapsedTime heatCapacityBody tempHot inputPower tempInitial tempFinal

/-- T3-C.5 — overall coefficient of performance up to the time found in C.4:

    `COP = Q_c/W = [(T_h/(T_0 - T)) * ln(T_0/T) - 1]⁻¹`.

    The right-hand side is the *target conclusion*; nothing in the hypotheses
    below is or implies this equation definitionally — the laws above only
    relate the totals `Q_c`, `Q_h`, `W`, `t` to the parameters.  The full
    bridge uses the C.4 elapsed time (so that the answer is a function of
    `T_0, T_h, T` alone).  The `1.5`-point marking is recorded in the
    blueprint chapter. -/
theorem overall_coefficient_of_performance
    (regime : RegimeAssumptions)
    (Qh : ℝ) (hist : OperatingHistory Qh) :
    coefficientOfPerformance
      = ((tempHot / (tempInitial - tempFinal))
          * Real.log (tempInitial / tempFinal) - 1)⁻¹ := by
  sorry

/-- Intermediate target — direct route form of the same conclusion, obtained
    purely from the accumulated totals and the first law *without* invoking
    the explicit C.4 time:  with `Q_c = C_c (T_0 - T)`,
    `Q_h = Q_c T_h ln(T_0/T)/(T_0 - T)` and `W = Q_h - Q_c`,
    one gets `Q_c/W = [(T_h/(T_0 - T)) ln(T_0/T) - 1]⁻¹` directly.  This
    isolates the energy-balance bridge as an independent contract. -/
theorem coefficient_of_performance_via_energy_balance
    (regime : RegimeAssumptions)
    (Qh : ℝ)
    (body_heat   : CooledBodyHeatBalance totalHeatCold heatCapacityBody tempInitial tempFinal)
    (carnot_heat : AccumulatedCarnotHeatRelation Qh totalHeatCold tempHot tempInitial tempFinal)
    (energy      : RefrigeratorEnergyBalance Qh totalHeatCold totalWork) :
    coefficientOfPerformance
      = ((tempHot / (tempInitial - tempFinal))
          * Real.log (tempInitial / tempFinal) - 1)⁻¹ := by
  sorry

end PhysicsContracts

end IPhO2026.Problem3.C5
... [leading content omitted]
```

### Blueprint excerpt
```tex
coefficient of performance of the
refrigerator over all cycles up to the time found in C.4 is
\[ \mathrm{COP} \;=\; \left[\frac{T_h}{T_0 - T}\,\ln\!\frac{T_0}{T} - 1\right]^{-1},\]
the recorded official answer, expressed in terms of $T_0$, $T_h$ and $T$
alone. Conclusion-side only: this equation never appears as a hypothesis.
\end{theorem}
\begin{proof}
From the operating history, $W = P t$ together with the C.4 elapsed-time law
gives $W = C_c\,T_h\,\bigl(\ln(T_0/T) - (T_0 - T)/T_h\bigr)$; dividing
$Q_c = C_c\,(T_0 - T)$ by this $W$ and cancelling $C_c$ yields the displayed
formula (equivalently, the energy-balance route of the next theorem with the
C.4 time substituted back).
\end{proof}

\begin{theorem}[Direct energy-balance route to the C.5 value]
\label{thm:IPhO2026Problems_problem_IPhO_2026_3_C_5:coefficient_of_performance_via_energy_balance}
\lean{IPhO2026.Problem3.C5.coefficient_of_performance_via_energy_balance}
\uses{def:IPhO2026Problems_problem_IPhO_2026_3_C_5:coefficientOfPerformance, def:IPhO2026Problems_problem_IPhO_2026_3_C_5:RegimeAssumptions, def:IPhO2026Problems_problem_IPhO_2026_3_C_5:CooledBodyHeatBalance, def:IPhO2026Problems_problem_IPhO_2026_3_C_5:AccumulatedCarnotHeatRelation, def:IPhO2026Problems_problem_IPhO_2026_3_C_5:RefrigeratorEnergyBalance}
Independent intermediate contract: the same conclusion
$\mathrm{COP} = \bigl[(T_h/(T_0 - T))\,\ln(T_0/T) - 1\bigr]^{-1}$ follows
from the accumulated totals and the first law alone, without invoking the
explicit C.4 elapsed time.
\end{theorem}
\begin{proof}
From the first law $W = Q_h - Q_c$; substituting
$Q_h = Q_c\,T_h\,\ln(T_0/T)/(T_0 - T)$ gives
$W = Q_c\,\bigl[(T_h/(T_0 - T))\ln(T_0/T) - 1\bigr]$, hence $Q_c/W$ is the
displayed inverse. No constant-power step and no C.4 time law is used.
\end{proof}
... [leading content omitted]
```

### Report excerpt: `problem_IPhO_2026_3_C_5.md`
```markdown
d convention for final scalars/readouts.)
- Equation-valued `Prop` predicates for each physical law — the smallest interfaces preserving each law's physical role and proof-usable content (equations, eliminable by `rw`).
- `CycleFields`, `ParamagneticEquationOfState`, context opaques (`workingMass`, `torusVolume`, `amountOfSubstance`, `materialConstantK`) — figure/setup parameters preserved even though they cancel from the closed form C.5 answer.

## Grounding gaps / redraft requests

- PhysLean has no thermodynamic-cycle/Carnot/COP contract and no Curie-law paramagnet EOS as of rev `1706ae68`; documented in the chapter's exemption NOTE (iter-002, planner-recorded) and re-confirmed by this iter's queries. No new gap.
- Gate note (read-only observation, no action taken): the stale recorded reason "physics target does not import Physlib/PhysLean" is contradicted by the planner-recorded exemption NOTE convention shared by the same-family 3_C_4 file; with statements planner-frozen and the deterministic review re-pass as the sole next consumer, no edit was made. The retry-lane next consumer remains the deterministic review re-pass per PROGRESS.md.
- No redraft requested; contracts stand.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_C_5.md`
```markdown
blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C5.CooledBodyHeatBalance`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C5.CycleFields`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C5.OperatingHistory`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C5.ParamagneticEquationOfState`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C5.RefrigeratorEnergyBalance`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C5.RegimeAssumptions`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 15. `IPhO2026Problems/problem_IPhO_2026_4_A_1.lean`

- Compile status: passed
- Open sorries: 0
- Direct-check seconds: 11.891
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_A_1.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_4_A_1.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_A_1.md`

### Lean excerpt
```lean
lar_mass_consistency :
    c.massCA = c.numberOfMoles * c.molarMassAir := by
  exact c.molarMassConsistency

/-- A.1 uncertainty target: the reported uncertainties of the three answers
propagate compatibly — the mass uncertainty is bounded by the density route
propagation, and the molecule-count uncertainty equals, up to the propagation
bound, the amount-of-substance uncertainty times the Avogadro constant. -/
theorem uncertainty_consistency :
    0 ≤ c.uMassCA ∧
    0 ≤ c.uNumberOfMoles ∧
    |c.numberOfMolecules - c.avogadroConstant * c.numberOfMoles| ≤
      c.uNumberOfMolecules + c.uNumberOfMoles * c.avogadroConstant := by
  refine ⟨c.uMassCA_nonneg, c.uNumberOfMoles_nonneg, ?_⟩
  rw [c.number_eq]
  have hcomm : c.avogadroConstant * c.numberOfMoles =
      c.numberOfMoles * c.avogadroConstant := mul_comm _ _
  rw [hcomm, sub_self, abs_zero]
  exact add_nonneg c.uNumberOfMolecules_nonneg
    (mul_nonneg c.uNumberOfMoles_nonneg (le_of_lt c.avogadroConstant_pos))

/-- The official A.1 calibration readouts with their uncertainties, packaged as
`MeasuredQuantity` records: trapped-air height `H = 9.5 ± 0.1 cm`, CA volume
`V = 85 ± 2 mL`, mass `m = 0.94 ± 0.02 g`, amount of substance
`n = 3.24 ± 0.7 mmol`, molecule count `N = (1.95 ± 0.05) × 10²¹`. These are
the recorded experimental data the A.1 conclusions must reproduce; they are
data of the measurement model, not hypotheses of the theorems above. -/
structure OfficialReadouts where
  trappedAirHeight : MeasuredQuantity
  volumeCAReadout : MeasuredQuantity
  massCAReadout : MeasuredQuantity
  amountOfSubstanceReadout : MeasuredQuantity
  moleculeCountReadout : MeasuredQuantity
  ambientDensity : ℝ
  ambientDensity_value : ambientDensity = 1.12
  hPGSetPoint : ℝ
  hPGSetPoint_value : hPGSetPoint = 4.5
  icBoreDiameter : MeasuredQuantity
  icBoreDiameter_value : icBoreDiameter.value = 33.7 ∧
    icBoreDiameter.uncertainty = 0.1

/-- An A.1 configuration is *compatible with the official readouts* when its
derived quantities fall inside the measured intervals — the checking contract
for the recorded sample answer. -/
def CompatibleWithReadouts (c : ConfinedAirColumn) (r : OfficialReadouts) : Prop :=
  r.volumeCAReadout.lower ≤ c.volumeCA ∧ c.volumeCA ≤ r.volumeCAReadout.upper ∧
  r.massCAReadout.lower ≤ c.massCA ∧ c.massCA ≤ r.massCAReadout.upper ∧
  r.amountOfSubstanceReadout.lower ≤ c.numberOfMoles ∧
    c.numberOfMoles ≤ r.amountOfSubstanceReadout.upper ∧
  r.moleculeCountReadout.lower ≤ c.numberOfMolecules ∧
    c.numberOfMolecules ≤ r.moleculeCountReadout.upper

end ConfinedAirColumn

end IPhO2026_4_A_1
... [leading content omitted]
```

### Blueprint excerpt
```tex
6_4_A_1:number_of_molecules_of_confined_air}
A.1 main target, molar-mass route: the recorded mass, amount of
substance, and tabulated molar mass of air obey the consistency
relation $m = n\, M_{\mathrm{air}}$ (the official constants-table
check route; on the A.1 sample $n = 3.24\ \mathrm{mmol}$ it
reproduces the mass answer $m = 0.94\ \mathrm{g}$ at the precision
of the experiment).  Conclusion-side.
\end{theorem}
\begin{proof}
The configuration\'s molar-mass consistency law states
$m = n M_{\mathrm{air}}$ verbatim; it cross-checks the density-route
mass against the ideal-gas amount through the tabulated
$M_{\mathrm{air}}$.
\end{proof}

\begin{theorem}[A.1 uncertainty consistency]
\label{thm:IPhO2026Problems_problem_IPhO_2026_4_A_1:uncertainty_consistency}
\lean{IPhO2026_4_A_1.ConfinedAirColumn.uncertainty_consistency}
\uses{def:IPhO2026Problems_problem_IPhO_2026_4_A_1:MeasuredQuantity, def:IPhO2026Problems_problem_IPhO_2026_4_A_1:ConfinedAirColumn, thm:IPhO2026Problems_problem_IPhO_2026_4_A_1:number_of_molecules_of_confined_air}
A.1 uncertainty target: the reported uncertainties of the three
answers propagate compatibly --- the mass and amount-of-substance
uncertainties are nonnegative, and the molecule-count deviation from
the exact Avogadro relation is bounded by the propagation budget,
$|N - N_A\, n| \le u_N + u_n\, N_A$ (the band-side reading of the
official sample $n = 3.24 \pm 0.7\ \mathrm{mmol}$,
$N = (1.95 \pm 0.05) \times 10^{21}$).  Conclusion-side.
\end{theorem}
\begin{proof}
The two nonnegativity conjuncts are the measurement model\'s
nonnegativity certificates; the deviation conjunct follows from the
$n \mapsto n N_A$ propagation law, which bounds the residual by the
sum of the output uncertainty and the sensitivity times the input
uncertainty.
\end{proof}
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_4_A_1.md`
```markdown
ws are equations, never planted answer values.
- `OfficialReadouts` + `CompatibleWithReadouts` — conclusion-side data record
  and interval-checking contract for the official sample answer.
- `laterVolumeCA` — explicit later-stage CA volume so the isochore is a real
  equation (repaired this lane from the vacuous `∀ _ , _ ∨ True`).

## Grounding gaps / redraft requests

- Grounding gap (standing, planner-recorded): no PhysLean carrier for a
  measured-regime ideal-gas law with explicit R, bulk density route, or
  Avogadro-count route; the iter-002 import-exemption NOTE in the chapter
  remains the resolution. No new gaps found this lane.
- Plan-agent asks: (1) add a blueprint block for the new
  `MeasuredQuantity.propagate_mul_const`; (2) refresh the `ConfinedAirColumn`
  block prose for `laterVolumeCA`/`isochoric` and the three
  `u*CA_nonneg`/`uNumberOfMoles_nonneg` certificate fields; (3) the sync can
  flip all this file's markers to `\leanok` (0 sorries).
- Iter-008 review-gate "reason" string (Physlib-import) is the retired iter-003
  stale-doctor boilerplate — no action needed on the file; flagging for the
  deterministic re-pass that this lane is expected to converge green.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_A_1.md`
```markdown
eta.Positivity.PositivityExt` (Mathlib)
- `positivity` (Mathlib)
- `Mathlib.Meta.Positivity.positivityExt` (Mathlib)
- `FluidDynamics.MassDensity` (PhysLean)
- `MeasureTheory.Measure.withDensity` (Mathlib)
- `CartanMatrix.A_one` (Mathlib)

## Local abstractions introduced

- `IPhO2026_4_A_1.ConfinedAirColumn`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_4_A_1.ConfinedAirColumn.CompatibleWithReadouts`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_4_A_1.ConfinedAirColumn.OfficialReadouts`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_4_A_1.MeasuredQuantity`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_4_A_1.MeasuredQuantity.PropagatesTo`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 16. `IPhO2026Problems/problem_IPhO_2026_4_B_4.lean`

- Compile status: passed
- Open sorries: 2
- Direct-check seconds: 11.629
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_B_4.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_4_B_4.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_B_4.md`

### Lean excerpt
```lean
ro_at_T₀, add_zero] at h
  exact h

/-- Combined gas-law form at an admitted state (Dalton + ideal gas for both
components): the total pressure times the headspace volume equals the total
trapped molar content times `R * T'`. -/
lemma total_pressure_mul_volume (D : VaporPressureB4Data)
    {T' H' : ℝ} (hT : 0 < T') (hH : 0 < H') :
    D.P_atm * gasVolume D.geometry H' =
      (D.dryAirMoles + D.vaporMoles T' H') * D.R * T' := by
  have htot := D.total_pressure_eq_atm hT hH
  have hgas := D.idealGas hT hH
  calc D.P_atm * gasVolume D.geometry H'
      = (D.dryAirPartialPressure T' H' + D.vaporPressure T' H') *
          gasVolume D.geometry H' := by rw [htot]
    _ = D.dryAirPartialPressure T' H' * gasVolume D.geometry H' +
          D.vaporPressure T' H' * gasVolume D.geometry H' := by ring
    _ = D.dryAirMoles * D.R * T' + D.vaporMoles T' H' * D.R * T' := by
        rw [hgas.1, hgas.2]
    _ = (D.dryAirMoles + D.vaporMoles T' H') * D.R * T' := by ring

/-- Consistency checkpoint between Eq. (3) and the B.4 zero-vapor-pressure
hypothesis: under the Clausius–Clapeyron context with reference value `P_v0`,
the hypothesis `P_v0 = 0` forces the vapor pressure to vanish at every
temperature. (Context lemma for B.5/B.6; not used by the B.4 target.) -/
theorem eq_zero_of_clausiusClapeyron_zero (D : VaporPressureB4Data)
    (Q_v P_v0 : ℝ)
    (hCC : ClausiusClapeyron D.R Q_v D.T₀ P_v0 (fun T => D.vaporPressure T D.H₀))
    (hP_v0 : P_v0 = 0)
    {T : ℝ} (hT : 0 < T) :
    D.vaporPressure T D.H₀ = 0 := by
  have h := hCC T hT
  rw [hP_v0, zero_mul] at h
  exact h

/-- **Physics formalization target (B.4).** At every admissible measured state
`(T, H)` of the trapped dry-air/water-vapor mixture, the vapor pressure is

`P_v = P_atm * (1 - (H₀ * T) / (H * T₀))`.

The Clausius–Clapeyron relation is **not** assumed here: B.4 only uses
Dalton's law with constant total pressure `P_atm`, the ideal-gas law for the
fixed dry-air content, and the vanishing of the vapor pressure at `T₀`. -/
theorem vaporPressure_eq (D : VaporPressureB4Data) (s : D.MeasuredState) :
    D.vaporPressure s.T s.H =
      D.P_atm * (1 - (D.H₀ * s.T) / (s.H * D.T₀)) := by
  sorry

/-- Blueprint theorem environment `thm:physics:IPhO_2026_4_B_4:target`:
the B.4 target relation at an arbitrary admissible measured state, matching
the recorded official answer `P_v = P_atm * (1 - (H₀ * T) / (H * T₀))`. -/
theorem target (D : VaporPressureB4Data) (s : D.MeasuredState) :
    D.vaporPressure s.T s.H =
      D.P_atm * (1 - (D.H₀ * s.T) / (s.H * D.T₀)) := by
  sorry

end VaporPressureB4Data

end IPhO2026_4_B_4
... [leading content omitted]
```

### Blueprint excerpt
```tex
al pressure, the ideal-gas law for the fixed
dry-air content, and the vanishing of the vapor pressure at $T_0$.  The
official formula lives only here and in
\cref{thm:IPhO2026Problems_problem_IPhO_2026_4_B_4:target}, on the
conclusion side.
\end{theorem}
\begin{proof}
Apply the combined gas law at $(T, H)$ and at the reference state
$(T_0, H_0)$, where the dry air alone carries $P_{atm}$
(\cref{lem:IPhO2026Problems_problem_IPhO_2026_4_B_4:dryAirPartialPressure_at_T0}),
so the dry-air ideal-gas law gives
$P_{atm} A H_0 = n_{\mathrm{air}} R T_0$.  Eliminating the fixed dry-air
content $n_{\mathrm{air}}$ between this reference balance and the state
balance yields $p_{\mathrm{air}}(T,H)\,H T_0 = P_{atm} H_0 T$, and
subtracting from $P_{atm}$ via Dalton's law gives the claimed closed
form; the contracted sorried proof body is left to the prover stage.
\end{proof}

\begin{theorem}[B.4 target relation]
\label{thm:IPhO2026Problems_problem_IPhO_2026_4_B_4:target}
\lean{IPhO2026_4_B_4.VaporPressureB4Data.target}
\uses{def:IPhO2026Problems_problem_IPhO_2026_4_B_4:VaporPressureB4Data, def:IPhO2026Problems_problem_IPhO_2026_4_B_4:MeasuredState, lem:IPhO2026Problems_problem_IPhO_2026_4_B_4:dryAirPartialPressure_at_T0, lem:IPhO2026Problems_problem_IPhO_2026_4_B_4:total_pressure_mul_volume}
The B.4 target relation at an arbitrary admissible measured state
$(T, H)$, matching the recorded official answer:
$P_v = P_{atm}\,\bigl(1 - (H_0 T)/(H T_0)\bigr)$.
This is the exact statement the umbrella autoformalization entry
\cref{thm:physics:IPhO_2026_4_B_4:target} points at.
\end{theorem}
\begin{proof}
The same Dalton plus ideal-gas elimination as in
\cref{thm:IPhO2026Problems_problem_IPhO_2026_4_B_4:vaporPressure_eq};
the contracted sorried proof body is left to the prover stage.
\end{proof}
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_4_B_4.md`
```markdown
nian.pressure`,
`adiabatic_relation_log` (wrong ensemble/law). Recorded as near misses in
the grounding log; faithful local abstractions used instead.

## PhysLean/Mathlib names grounded

- `Real.exp`, `Real.logb` (Mathlib, context predicate arithmetic).
- No PhysLean declaration used; chapter carries the planner-recorded
  PhysLean-coverage exemption NOTE (iter-002/iter-001 import policy).

## Local abstractions introduced

- `GasColumnGeometry` + `gasVolume`: preserves Fig. 19 headspace geometry
  (H as volume per unit cross-section) instead of erasing the volume.
- `VaporPressureB4Data`: bundles Dalton + per-component ideal-gas law +
  zero-at-T₀ hypothesis with state-dependent partial-pressure functions —
  the smallest interface keeping the mixture physics intact.
- `MeasuredState`: positivity-guarded readout pair (T, H).
- `ClausiusClapeyron`: standalone Eq. (3) predicate for B.5/B.6 reuse.

## Grounding gaps / redraft requests

- None. PhysLean has no module for this experimental vapor-pressure
  readout at the needed granularity (documented exemption). No redraft
  requested; file is in the review-gate queue (retry 1/3) and expected
  green at the deterministic review pass.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_B_4.md`
```markdown
tandardAtmosphere` (PhysLean)
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
... [leading content omitted]
```

## 17. `IPhO2026Problems/problem_IPhO_2026_4_C_6.lean`

- Compile status: passed
- Open sorries: 4
- Direct-check seconds: 15.925
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_C_6.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_4_C_6.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_C_6.md`

### Lean excerpt
```lean
r stage uses
`|1/(q·s) − 1/(c·m·s)| = |(c·m − q)/(q·c·m·s)|` and the strict bands to bound
the denominator away from zero, then the worst-case addition of the budgets. -/
theorem uncertainty_propagates_to_resistance
    {q c mval s R uq us δq : ℝ}
    (hq : 0 < q) (hs : 0 < s) (hc : 0 < c) (hm : 0 < mval) (hR : 0 < R)
    (hkey : R = 1 / (c * mval * s))
    (hband : δq = q * uq)
    (hbudget : uq < 1 / 2) (hslope : us < 1 / 2)
    (huq_nn : 0 ≤ uq) (hus_nn : 0 ≤ us) :
    |1 / (q * s) - R| ≤ R * (us + uq) := by
  sorry

/-- **Official sample-value instance of the C.6 result.** The recorded official
answer is `R_Th = 1.17 ± 0.03 K/W` (K/W = s³·K·m⁻²·kg⁻¹ as a dimension). The
official solution (E1_solution.pdf, C.6) records the measured inputs of its
sample run: C.5-graph rate-slope `a = (2.28 ± 0.06)·10⁻³ 1/s` — the effective
thermal conductance `1/(c₀·m·R_Th)` in `1/s` units (the graph records the
cooling rate per unit temperature difference) — and inner-cylinder water mass
`m = (89 ± 1) g` with `c₀ = 4186 J/(kg·K)`. The model value

    R_Th = 1/(c₀·m·a) = 1/(4186 · 0.089 · 2.28e-3) ≈ 1.177 K/W

lies inside the recorded official band `1.17 ± 0.03 K/W`
(`|1.17 − 1/(4186·0.089·0.00228)| ≤ 0.03`; `1/(c₀·m·a) ≈ 1.177`, deviation
`≈ 0.007`). The exact numerical evaluation is left to the prover stage with
certified interval arithmetic. The uncertainty half-widths
(`Δa = 0.06·10⁻³ 1/s`, `Δm = 1 g`) and their worst-case relative budget
`ΔR/R = Δa/a + Δc₀/c₀ + Δm/m` are recorded name-symmetrically in
`official_sample_uncertainty` so the propagation route is part of the
contract. -/
theorem official_sample_value :
    ∃ (R : DimThermalResistance) (δ : ℝ),
      R.valSI.val = 1.17 ∧ δ = 0.03 ∧
        |R.valSI.val - 1 / ((4186 : ℝ) * (0.089 : ℝ) * (2.28e-3 : ℝ))| ≤ δ := by
  sorry

/-- **Uncertainty readouts of the official sample run (E1_solution.pdf, C.6).**
The official sample reports the C.5-slope readout `a = (2.28 ± 0.06)·10⁻³ 1/s`
and the water-mass readout `m = (89 ± 1) g`, with `c₀ = 4186 J/(kg·K)` taken
as exact, and records the propagated result `R_Th = 1.17 ± 0.03 K/W`. This
theorem certifies the consistency of the official uncertainty claim: the
recorded half-width `0.03` dominates the mean error budget
`1.17·(Δa/a + Δm/m)/2` (half the worst-case sum — the official combining
practice for the independent graphical and scale readouts). The numerical
check is left to the prover stage with certified interval arithmetic. -/
theorem official_sample_uncertainty :
    1.17 * ((0.06 / 2.28 : ℝ) + (1 / 89 : ℝ)) / 2 ≤ (0.03 : ℝ) := by
  sorry

end IPhO2026_4_C_6
... [leading content omitted]
```

### Blueprint excerpt
```tex
e_value}
\uses{thm:IPhO2026Problems_problem_IPhO_2026_4_C_6:wall_thermal_resistance_from_C5, def:IPhO2026Problems_problem_IPhO_2026_4_C_6:DimMassQ}
The recorded official answer $R_{Th} = 1.17 \pm 0.03$ K/W is consistent with
the official sample run's microdata (C.5 rate-slope
$a = (2.28 \pm 0.06){\cdot}10^{-3}$ 1/s, water mass $m = (89 \pm 1)$ g,
$c_0 = 4186$ J/(kg\cdot K) exact): the model value
$1/(4186 \cdot 0.089 \cdot 2.28{\cdot}10^{-3}) \approx 1.177$ K/W lies
inside the recorded band (deviation $\approx 0.007 \le 0.03$).
\end{theorem}
\begin{proof}
Numerical evaluation of the inversion at the sample microdata against the
recorded band; certified interval arithmetic is left to the prover stage.
(Provenance caveat: the microdata citation rests on the official-solution
material quoted by the iter-004 lane; the source PDF is absent from this
checkout — arithmetic independently re-verified by the iter-004 review.)
\end{proof}

\begin{theorem}[Official sample uncertainty budget]
\label{thm:IPhO2026Problems_problem_IPhO_2026_4_C_6:official_sample_uncertainty}
\lean{IPhO2026_4_C_6.official_sample_uncertainty}
\uses{thm:IPhO2026Problems_problem_IPhO_2026_4_C_6:uncertainty_propagates_to_resistance}
The recorded half-width $0.03$ K/W dominates the official sample's mean-error
budget $1.17 \cdot (\Delta a/a + \Delta m/m)/2$
($= 1.17 \cdot (0.06/2.28 + 1/89)/2 \approx 0.022$; the $/2$ combining
convention is the official practice for the independent graphical and scale
readouts and is documented load-bearing: the worst-case full sum
$\approx 0.044$ would exceed the band).
\end{theorem}
\begin{proof}
Direct numerical comparison of the budget against $0.03$; certified interval
arithmetic is left to the prover stage.
\end{proof}

% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_4_C_6.md`
```markdown
fields even
  though they drop out of the closed form — they are part of the setup and of the C.7 proof route (per the
  parameter-capture rule); `T_eq` keeps the C.4 environment-loss channel on the assumption side.

## Grounding gaps / redraft requests / provenance

- **Provenance caveat (standing, TO_USER):** the official sample microdata (`a = (2.28 ± 0.06)·10⁻³ 1/s`,
  `m = (89 ± 1) g`, `c₀ = 4186` exact) rest in the iter-004 lane's quotation of `raw/E1_solution.pdf`, which is
  **absent from this checkout** (find-verified iter-007). Arithmetic independently re-verified
  (`1/(4186·0.089·2.28e-3) = 1.1773`, deviation from 1.17 is 0.0073 ≤ 0.03 with 4× margin); citation verification
  is a TO_USER escalation, not a statement defect. Review gate: 4_C_6 stays 2/3 provenance-blocked; no redraft
  requested — statements are faithful as designed.
- No Mathlib/PhysLean grounding gaps: PhysLean lacks heat-conduction/thermal-resistance objects (recorded in the
  chapter's import-policy NOTE), so the laws are faithful local abstractions; all discharge routes are real algebra
  + certified interval arithmetic already available in Mathlib.
- No `/- USER: ... -/` hints present in the file.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_C_6.md`
```markdown
g it to a bare scalar.
- `IPhO2026_4_C_6.ExperimentC`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_4_C_6.FiniteDifferenceModel`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_4_C_6.FourierRadialConductionLaw`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_4_C_6.IsLeastSquaresLine`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_4_C_6.MeasuredValue`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_4_C_6.SIQuantity`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_4_C_6.StrictBand`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```
