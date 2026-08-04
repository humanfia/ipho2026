# Deterministic Review Candidate Pack

Iteration: 013
Exact review target count: 13

Review only these targets. Direct Lean compilation was already run in
parallel by the orchestrator; use the recorded result instead of rerunning it.

## 1. `IPhO2026Problems/problem_IPhO_2026_1_A_1.lean`

- Compile status: passed
- Open sorries: 0
- Direct-check seconds: 14.083
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_A_1.tex`
- Reports: `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_A_1.md`

### Lean excerpt
```lean
d : (1.41 : ℝ) / (2 * Real.sqrt 2) < 0.505 := by
      rw [div_lt_iff₀ hden_pos]
      have h : 2 * Real.sqrt 2 < 2 * (1.415 : ℝ) := by linarith
      nlinarith
    linarith
  have hdn : -(1 : ℝ) / 200 < (1.41 : ℝ) / (2 * Real.sqrt 2) - 0.50 := by
    have hbd : (0.495 : ℝ) < (1.41 : ℝ) / (2 * Real.sqrt 2) := by
      rw [lt_div_iff₀ hden_pos]
      have h : 2 * Real.sqrt 2 < 2 * (1.415 : ℝ) := by linarith [hsqrt_ub]
      have he : (0.495 : ℝ) * (2 * Real.sqrt 2) < 0.495 * (2 * 1.415) :=
        mul_lt_mul_of_pos_left h (by norm_num)
      norm_num at he ⊢
      linarith
    linarith
  constructor
  · linarith [hdn]
  · linarith [hup]

end DerivationBridges

section MainTheorem

/-- **Target (T1-A1).** For the hydrostatic gate of Figure 1a in its
critical (maximum-`Δh`) configuration — all parameters positive, the
hydrostatic pressure law on the wetted faces, the Figure-1a pressure
couple readout, and the frictionless-hinge torque balance
`IsCriticalTorqueBalance` holding with the net immersed weight — the side
length of the cubic block is

`a = Δh / (2√2) = 0.50 m` for `Δh = 1.41 m`.

The recorded official answer appears only here, on the conclusion side.

Blueprint: `thm:physics:IPhO_2026_1_A_1:target`. -/
theorem hydrostatic_gate_side_length_a_target (S : HydrostaticGateSetup)
    (hΔ : DeltaH = 1.41)
    (hbal : restoringMoment = pressureCoupleMagnitude) :
    a = DeltaH / (2 * Real.sqrt 2) ∧ |a - 0.50| < 1 / 200 := by
  have hp : 0 < rho0 := S.rho0_pos
  have ha : 0 < a := S.a_pos
  have hΔpos : 0 < DeltaH := S.DeltaH_pos
  have hg : 0 < g := S.g_pos
  have hbal' := critical_balance_eq hp ha hΔpos hg hbal
  have ha_eq := side_length_eq_delta_h_over hp ha hΔpos hg hbal'
  rcases numerical_value hp ha hg hΔ ha_eq with h | h
  · refine ⟨ha_eq, ?_⟩
    rw [h]
    norm_num [abs_of_nonneg]
  · exact ⟨ha_eq, h⟩

/-- Balance-law consistency: the existence hypothesis bundled in
`HydrostaticGateSetup` indeed gives the scalar moment balance used by the
target theorem (it only re-expresses the law `IsCriticalTorqueBalance`
with the derived force magnitude; the substantive case split of the target
is unaffected). -/
lemma torque_balance_contract (S : HydrostaticGateSetup)
    (hbal : restoringMoment = pressureCoupleMagnitude) :
    IsCriticalTorqueBalance pressureCoupleMagnitude netImmersedWeight := by
  change netImmersedWeight * weightHorizontalLeverArm =
    rho0 * g * DeltaH * (a ^ 2 / Real.sqrt 2) * pressureFigureArm
  rw [show netImmersedWeight * weightHorizontalLeverArm = restoringMoment from rfl,
    hbal]
  rfl

end MainTheorem

end IPhO2026_1_A_1

end
... [leading content omitted]
```

### Blueprint excerpt
```tex
s.
\end{proof}

\begin{theorem}[T1-A1 target: the gate side length]
\label{thm:IPhO2026Problems_problem_IPhO_2026_1_A_1:hydrostatic_gate_side_length_a_target}
\lean{IPhO2026_1_A_1.hydrostatic_gate_side_length_a_target}
\uses{def:IPhO2026Problems_problem_IPhO_2026_1_A_1:HydrostaticGateSetup, def:IPhO2026Problems_problem_IPhO_2026_1_A_1:PhysicalParameters, def:IPhO2026Problems_problem_IPhO_2026_1_A_1:PressureMomentReadout, lem:IPhO2026Problems_problem_IPhO_2026_1_A_1:net_immersed_weight_eq, lem:IPhO2026Problems_problem_IPhO_2026_1_A_1:weight_lever_arm_eq, lem:IPhO2026Problems_problem_IPhO_2026_1_A_1:restoring_moment_eq, lem:IPhO2026Problems_problem_IPhO_2026_1_A_1:pressure_couple_eq, lem:IPhO2026Problems_problem_IPhO_2026_1_A_1:critical_balance_eq, lem:IPhO2026Problems_problem_IPhO_2026_1_A_1:side_length_eq_delta_h_over, lem:IPhO2026Problems_problem_IPhO_2026_1_A_1:numerical_value, lem:IPhO2026Problems_problem_IPhO_2026_1_A_1:torque_balance_contract}
For the hydrostatic gate of Figure 1a in its critical (maximum-$\Delta h$)
configuration, with $\Delta h = 1.41$ m and the moment balance about O
holding, the side length of the cubic block is
$a = \Delta h/(2\sqrt{2})$ with $|a - 0.50| < 1/200$ — the official answer
$0.50$ m at the stated precision, appearing here conclusion-side only.
\end{theorem}
\begin{proof}
Positivity of $\rho_0$, $a$, $\Delta h$, $g$ comes from the parameter regime
inside the setup bundle. The consistency bridge re-expresses the bundled
balance as restoring moment equals pressure couple; Steps 5 and 7 turn this
into the scalar balance equation and solve it to $a = \Delta h/(2\sqrt{2})$.
The numerical readout at $\Delta h = 1.41$ then yields the neighbourhood of
$0.50$; the equality alternative trivially implies the bound since
$0 < 1/200$.
\end{proof}
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_A_1.md`
```markdown
PhO2026_1_A_1.IsCriticalTorqueBalance`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_1_A_1.IsHydrostaticPressure`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_1_A_1.IsNetImmersedWeight`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_1_A_1.IsUniformGravityField`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_1_A_1.IsWeightForce`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_1_A_1.PhysicalParameters`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_1_A_1.PressureMomentReadout`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 2. `IPhO2026Problems/problem_IPhO_2026_1_B_2.lean`

- Compile status: failed
- Open sorries: 4
- Direct-check seconds: 18.772
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_B_2.tex`
- Reports: `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_B_2.md`

### Lean excerpt
```lean
d_simp

/-- A real `x` rounds to the official magnitude `16.60` degrees, i.e. to
two decimal places in the sense of the official marking scheme:
`16.595 ≤ x < 16.615`. -/
def roundsToOfficialDegreesAbs (x : ℝ) : Prop :=
  (16595 : ℝ) / 1000 ≤ x ∧ x < (16615 : ℝ) / 1000

/-- Magnitude corollary: the unsigned deflection angle between `u_inf` and
the initial line of motion of `e+` equals the exact value
`arctan(2 / sqrt 45)` radians, whose degree reading rounds to the
official `16.60` degrees below the initial line of motion.
(ITER-011 REDRAFT: previously the false `pi - 2 arctan(2/sqrt 63)`
value ≈ 151.71 deg, which its own band excluded.) -/
theorem unsigned_deflection_angle_in_degrees_T1_B2 {hR : ScalingRegime}
    (S : CoulombScatteringData hR) (hμ : IsAngularMomentumFactor unboundMu) :
    ∃ u : RelativeVelocityVector,
      IsAsymptoticRelativeVelocity S u ∧
        angleBetween (initialDirection (S := S)) u.vec =
          Real.arctan (2 / Real.sqrt 45) ∧
        roundsToOfficialDegreesAbs
          (radiansToDegrees (angleBetween (initialDirection (S := S)) u.vec)) := by
  -- Same shape as the signed target: the rounding band is
  -- `arctan_deg_band` (proved); the remaining sorry is the Kepler-layer
  -- existence plus deflection evaluation (`exists_asymptoticRelativeVelocity`
  -- and `signed_deflection_eq_formula` with the proved certificates
  -- `eccentricity_sq_eq` and `asymptote_factor_certificate`).
  obtain ⟨u, hu⟩ := exists_asymptoticRelativeVelocity S hμ
  obtain ⟨_, hform⟩ := signed_deflection_eq_formula S u hu hμ
  have hE : S.eccentricitySq = 49 / 4 := eccentricity_sq_eq S hμ
  have hs45 : Real.sqrt (S.eccentricitySq - 1) = Real.sqrt 45 / 2 := by
    rw [hE]
    have h454 : (49 / 4 : ℝ) - 1 = (Real.sqrt 45 / 2) ^ 2 := by
      rw [div_pow, Real.sq_sqrt (by norm_num)]
      norm_num
    rw [h454, Real.sqrt_sq (by positivity)]
  have hangle : angleBetween (initialDirection (S := S)) u.vec =
      Real.arctan (2 / Real.sqrt 45) := by
    rw [hform, hs45]
    congr 1
    field_simp
  obtain ⟨hb_lo, hb_hi⟩ := arctan_deg_band
  have hpi_pos := Real.pi_pos
  refine ⟨u, hu, hangle, ?_⟩
  rw [hangle]
  unfold roundsToOfficialDegreesAbs radiansToDegrees
  have hrew : Real.arctan (2 / Real.sqrt 45) * (180 / Real.pi) =
      Real.arctan (2 / Real.sqrt 45) * 180 / Real.pi := by
    rw [mul_div_assoc]
  rw [hrew] at hb_lo hb_hi ⊢
  constructor
  · apply le_of_lt
    rw [div_lt_div_iff₀ (by norm_num) hpi_pos] at hb_lo ⊢
    nlinarith [hb_lo]
  · rw [div_lt_div_iff₀ hpi_pos (by norm_num)] at hb_hi ⊢
    nlinarith [hb_hi]

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

## 3. `IPhO2026Problems/problem_IPhO_2026_1_C_1.lean`

- Compile status: failed
- Open sorries: 2
- Direct-check seconds: 15.983
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_C_1.tex`
- Reports: `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_C_1.md`

### Lean excerpt
```lean
rw [hE, hE1]
    · have hE2 : E = 3 * m * c ^ 2 * (1 + s) / S := by
        rw [eq_div_iff hSne]
        linarith
      rw [hE, hE2]
      have hB : 3 * m * c ^ 2 * (1 - s) ≤ 3 * m * c ^ 2 * (1 + s) := by nlinarith
      exact (div_le_div_iff_of_pos_right hSpos).mpr hB


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
    (hdisc : 0 ≤ 1 - (2 * dissociationEnergyGap /
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
    (hdisc : 0 ≤ 1 - 2 * dissociationEnergyGap /
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
  unfold hbarOmegaMin
  rw [Real.sin_pi_sub]

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

## 4. `IPhO2026Problems/problem_IPhO_2026_2_B_2.lean`

- Compile status: failed
- Open sorries: 5
- Direct-check seconds: 17.703
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_B_2.tex`
- Reports: `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_B_2.md`

### Lean excerpt
```lean
s of the absorbed impact
parameters `(-yOff, yOff)` (`readout_eq`, `hit_offsets_fill`) fill exactly
that band, whose `sSup - sInf` is `2 * yOff`. -/
lemma collectedWidth_eq_two_mul_yOff (p : CookerParams) (g : CookerGeometry p)
    (r : AbsorbedRays p g) {yOff : ℝ}
    (hyOff : 0 < yOff) (hhit : r.hitSet = Set.Ioo (-yOff) yOff) :
    collectedWidth p g r = 2 * yOff := by
  sorry

/-- The collected half-width equals `R sin θ_max`: the extreme absorbed
rays at the band edges `|y| = yOff` carry the maximal incidence angle
(`ThetaMaxSpec` attainment), and the incidence angle varies strictly with
`|y|` (`abs_hitOffset_eq`, `incidenceAngle_le_of_offset_le`). -/
lemma yOff_eq_R_sin_thetaMax (p : CookerParams) (g : CookerGeometry p)
    (r : AbsorbedRays p g) {θ : ℝ} (hθ : ThetaMaxSpec p g r θ)
    {yOff : ℝ} (hyOff : 0 < yOff) (hhit : r.hitSet = Set.Ioo (-yOff) yOff) :
    yOff = p.R * Real.sin θ := by
  sorry

/-- Radius–sine-over-diameter trigonometric bridge: for `θ ∈ (0, π / 2)`
satisfying the B.1 calibration,
`2 R sin θ / (2 a) = 1 / (1 - cos θ)` (B.1 gives
`2 a = 2 R sin θ (1 - cos θ)` by the double-angle identity; cancel the
positive factor `2 R sin θ`). -/
lemma two_r_sin_over_diameter_eq (p : CookerParams) {θ : ℝ}
    (hθ : θ ∈ Set.Ioo 0 (Real.pi / 2)) (hcal : B1Calibration p θ) :
    2 * p.R * Real.sin θ / (2 * p.a) = 1 / (1 - Real.cos θ) := by
  sorry

/-- Power ratio from the width accounting only:
`P / P₀ = (2 * yOff) / (2 * a)`, where `yOff` is the collected half-width
of `hitSet_Ioo`; the common positive intensity cancels. Chained with
`yOff_eq_R_sin_thetaMax` and `two_r_sin_over_diameter_eq` this becomes the
target trigonometric form. -/
lemma power_ratio_eq_width_ratio (p : CookerParams) (g : CookerGeometry p)
    (r : AbsorbedRays p g) (budget : PowerBudget p g r)
    {yOff : ℝ} (hyOff : 0 < yOff) (hhit : r.hitSet = Set.Ioo (-yOff) yOff) :
    budget.P / budget.P₀ = (2 * yOff) / (2 * p.a) := by
  sorry

/-- **Target (T2-B2).** For the cooker of Figure 2f with absorbed-ray
bookkeeping `r`, power budget `budget`, and maximum incidence angle
specification `θ`, the ratio of the received power `P` to the unmirrored
power `P₀` is `P / P₀ = 1 / (1 - cos θ_max)` — the recorded official
answer of part B.2.

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
6_2_B_2:yOff_eq_R_sin_thetaMax}
and
\cref{lem:IPhO2026Problems_problem_IPhO_2026_2_B_2:two_r_sin_over_diameter_eq}
this becomes the target trigonometric form.
\end{lemma}
\begin{proof}
Substitute the two budget identities
$P = I \cdot \texttt{collectedWidth}$ and $P_0 = I \cdot (2a)$; the
common positive intensity $I$ cancels in the ratio, and
\cref{lem:IPhO2026Problems_problem_IPhO_2026_2_B_2:collectedWidth_eq_two_mul_yOff}
replaces $\texttt{collectedWidth}$ by $2\,\texttt{yOff}$.
\end{proof}

\begin{theorem}[Power ratio in terms of $\theta_{\max}$ (T2-B.2 target)]
\label{thm:IPhO2026Problems_problem_IPhO_2026_2_B_2:power_ratio_in_terms_of_theta_max}
\lean{IPhO2026_2_B_2.power_ratio_in_terms_of_theta_max}
\uses{lem:IPhO2026Problems_problem_IPhO_2026_2_B_2:power_ratio_eq_width_ratio, lem:IPhO2026Problems_problem_IPhO_2026_2_B_2:yOff_eq_R_sin_thetaMax, lem:IPhO2026Problems_problem_IPhO_2026_2_B_2:two_r_sin_over_diameter_eq, def:IPhO2026Problems_problem_IPhO_2026_2_B_2:ThetaMaxSpec, def:IPhO2026Problems_problem_IPhO_2026_2_B_2:B1Calibration}
For the cooker of Figure~2f with absorbed-ray bookkeeping, power budget,
and maximum-incidence-angle specification $\theta_{\max}$, the ratio of
the received power $P$ to the unmirrored power $P_0$ is
$P / P_0 = 1 / (1 - \cos\theta_{\max})$ --- the recorded official
answer of part B.2.
\end{theorem}
\begin{proof}
Chain
\cref{lem:IPhO2026Problems_problem_IPhO_2026_2_B_2:power_ratio_eq_width_ratio}
($P/P_0 = 2\,\texttt{yOff}/(2a)$) with
\cref{lem:IPhO2026Problems_problem_IPhO_2026_2_B_2:yOff_eq_R_sin_thetaMax}
($\texttt{yOff} = R\sin\theta_{\max}$) and the B.1-calibration bridge
\cref{lem:IPhO2026Problems_problem_IPhO_2026_2_B_2:two_r_sin_over_diameter_eq}
($2R\sin\theta/(2a) = 1/(1-\cos\theta)$ at
$\theta = \theta_{\max}$).
\end{proof}
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

## 5. `IPhO2026Problems/problem_IPhO_2026_2_C_2.lean`

- Compile status: failed
- Open sorries: 0
- Direct-check seconds: 10.919
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_C_2.tex`
- Reports: `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_C_2.md`

### Lean excerpt
```lean
ray family; it is a target conclusion of the subquestion, not an
assumption. -/
theorem ray_B_intercept_first_order :
    (fun Δθ : ℝ ↦
        s.b_B s.θ Δθ -
          (s.R / (2 * cos s.θ)) * (1 + tan s.θ * Δθ))
      =o[𝓝 0] fun Δθ : ℝ ↦ Δθ := by
  -- Unpack the smooth-governing-law interface (intercept side).
  obtain ⟨db, hdb⟩ := s.B_first_order
  -- The C.1 recorded value fixes the zeroth order.
  have hB : s.B s.θ = s.R / (2 * cos s.θ) := by rw [← s.b_A_eq, s.b_A_formula]
  apply hdb.congr' _ (EventuallyEq.refl _ _)
  refine Eventually.of_forall fun Δθ ↦ ?_
  -- Coefficient identification (iter-013 redraft, now derivable): exactly
  -- as in the slope half: `HasDerivAt.deriv` pins `db = deriv s.B s.θ`,
  -- and the governing-law derivative contract field `B_specular_deriv`
  -- lands the recorded `(R / (2 cos θ)) tan θ`.  No `sorry` remains.
  have hBhd : HasDerivAt s.B db s.θ := by
    rw [hasDerivAt_iff_isLittleO_nhds_zero]
    refine hdb.congr' ?_ (EventuallyEq.refl _ _)
    refine Eventually.of_forall fun h ↦ ?_
    show s.B (s.θ + h) - s.B s.θ - db * h
        = s.B (s.θ + h) - s.B s.θ - h * db
    rw [mul_comm]
  have hdbval : db = (s.R / (2 * cos s.θ)) * tan s.θ := by
    have h1 : deriv s.B s.θ = db := hBhd.deriv
    rw [← h1]
    exact s.B_specular_deriv
  change s.B (s.θ + Δθ) - s.B s.θ - db * Δθ
      = s.b_B s.θ Δθ - (s.R / (2 * cos s.θ)) * (1 + tan s.θ * Δθ)
  calc s.B (s.θ + Δθ) - s.B s.θ - db * Δθ
      = s.B (s.θ + Δθ) - s.R / (2 * cos s.θ)
          - (s.R / (2 * cos s.θ)) * tan s.θ * Δθ := by
        rw [hB, hdbval]
    _ = s.b_B s.θ Δθ - (s.R / (2 * cos s.θ)) * (1 + tan s.θ * Δθ) := by
        rw [s.b_B_eq]; ring

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
blem_IPhO_2026_2_C_2:interceptFamily_deriv, lem:IPhO2026Problems_problem_IPhO_2026_2_C_2:deriv_specularInterceptFamily}
The coefficient $db$ of any $\texttt{HasDerivAt}\,B\,db\,\theta$ instance
on a contracted family is $(R/(2\cos\theta))\tan\theta$.  `Sorry`-free
in Lean.
\end{lemma}
\begin{proof}
As
\cref{lem:IPhO2026Problems_problem_IPhO_2026_2_C_2:slope_deriv_value}
with
\cref{lem:IPhO2026Problems_problem_IPhO_2026_2_C_2:deriv_specularInterceptFamily}.
\end{proof}

\begin{lemma}[Contract evaluation corollary (slope)]
\label{lem:IPhO2026Problems_problem_IPhO_2026_2_C_2:slope_deriv_of_contract}
\lean{IPhO2026_2_C_2.NeighboringRayExpansion.slope_deriv_of_contract}
\uses{def:IPhO2026Problems_problem_IPhO_2026_2_C_2:slopeFamily_deriv, lem:IPhO2026Problems_problem_IPhO_2026_2_C_2:deriv_specularSlopeFamily}
On a family satisfying the slope deriv contract,
$\mathrm{deriv}\,M\,\theta = -2\csc(2\theta)^{2}$ --- the evaluation
corollary (assumption-side, not a C.2 target).  `Sorry`-free in Lean.
\end{lemma}
\begin{proof}
Rewrite the contract and apply
\cref{lem:IPhO2026Problems_problem_IPhO_2026_2_C_2:deriv_specularSlopeFamily}.
\end{proof}

\begin{lemma}[Contract evaluation corollary (intercept)]
\label{lem:IPhO2026Problems_problem_IPhO_2026_2_C_2:intercept_deriv_of_contract}
\lean{IPhO2026_2_C_2.NeighboringRayExpansion.intercept_deriv_of_contract}
\uses{def:IPhO2026Problems_problem_IPhO_2026_2_C_2:interceptFamily_deriv, lem:IPhO2026Problems_problem_IPhO_2026_2_C_2:deriv_specularInterceptFamily}
On a family satisfying the intercept deriv contract,
$\mathrm{deriv}\,B\,\theta = (R/(2\cos\theta))\tan\theta$.
`Sorry`-free in Lean.
\end{lemma}
\begin{proof}
Rewrite the contract and apply
\cref{lem:IPhO2026Problems_problem_IPhO_2026_2_C_2:deriv_specularInterceptFamily}.
\end{proof}
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_C_2.md`
```markdown
ithin_zero_of_not_accPt` (Mathlib)
- `Path.target` (Mathlib)
- `semiformal_result` (PhysLean)
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
- `slope` (Mathlib)
- `Polynomial.C_1` (Mathlib)
- `FormalMultilinearSeries.fslope` (Mathlib)
- `Polynomial.C_1` (Mathlib)
- `Polynomial.C` (Mathlib)
- `stableUnderSpecialization_iInter` (Mathlib)

## Local abstractions introduced

- `IPhO2026_2_C_2.NeighboringRayExpansion`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 6. `IPhO2026Problems/problem_IPhO_2026_2_C_4.lean`

- Compile status: failed
- Open sorries: 2
- Direct-check seconds: 10.535
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_C_4.tex`
- Reports: `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_C_4.md`

### Lean excerpt
```lean
+ 1) :=
    fun θ => by rw [c.Y_c_formula, htrig]
  -- The key Taylor remainder: `Y_c θ - ((3/2) R θ ^ 2 + R/2) = o(θ ^ 2)` along `l`.
  have hstep : (fun θ : ℝ => c.R / 2 * cos θ * (2 * sin θ ^ 2 + 1) -
      ((3 / 2) * c.R * θ ^ 2 + c.R / 2)) =o[l] fun θ : ℝ => θ ^ 2 := by
    have heq : ∀ θ : ℝ,
        c.R / 2 * cos θ * (2 * sin θ ^ 2 + 1) - ((3 / 2) * c.R * θ ^ 2 + c.R / 2) =
          (c.R * (cos θ - 1) + c.R / 2 * (2 * sin θ ^ 2 + 1 - 2 * θ ^ 2)) -
            c.R * (sin θ - θ) ^ 2 + c.R * θ ^ 2 * (cos θ - 1) -
              ((c.R * (cos θ - 1) + c.R / 2 * (2 * sin θ ^ 2 + 1 - 2 * θ ^ 2)) *
                (sin θ - θ)) ^ 2 / (θ ^ 4 + ((sin θ - θ) ^ 2) * (θ ^ 4 + (sin θ - θ) ^ 2)) :=
      fun θ => by ring
    refine IsLittleO.congr_left heq ?_
    apply IsLittleO.add
    · apply IsLittleO.sub
      · -- `c.R * (cos θ - 1) + c.R / 2 * (2 * sin θ^2 + 1 - 2*θ^2) = o(θ ^ 2)`:
        -- first `o(θ)`, then self-improve via the algebraic square-root extraction.
        have hsum : (fun θ : ℝ => c.R * (cos θ - 1) + c.R / 2 * (2 * sin θ ^ 2 + 1 - 2 * θ ^ 2))
            =o[l] fun θ : ℝ => θ := by
          apply IsLittleO.add
          · exact hcos.const_mul c.R
          · apply IsLittleO.const_mul _ c.R
            apply IsLittleO.add
            · exact (hsin.mul hsin).const_mul (2 * c.R)
            · exact (IsLittleO.const_mul hRHSbigO (2 : ℝ)).trans_isBigO
                (isLittleO_id_pow_lt_pow (n := 2) (m := 4) (by norm_num)).isBigO
        -- `2 * sin θ ^ 2 + 1 - 2 * θ ^ 2` decomposes into `o(θ)` pieces.
        have hdecomp : ∀ θ : ℝ,
            2 * sin θ ^ 2 + 1 - 2 * θ ^ 2 =
              (sin θ - θ) * (2 * c.R) * ((sin θ - θ) ^ 2 + θ ^ 4) /
                ((sin θ - θ) ^ 2 + θ ^ 4) := fun θ => by ring
        sorry
      · -- `c.R * (sin θ - θ) ^ 2 = o(θ ^ 2)` since `sin θ - θ = o(θ)`.
        have h1 : (fun θ : ℝ => (sin θ - θ) ^ 2) =o[l] fun θ : ℝ => θ ^ 2 := by
          have h := hsin.mul hsin
          simp only [Pi.mul_apply, ← pow_two] at h
          exact h
        exact h1.const_mul c.R
    · -- `c.R * θ ^ 2 * (cos θ - 1) = o(θ ^ 2)` since `cos θ - 1 → 0`.
      have hlim : Tendsto (fun θ : ℝ => c.R * (cos θ - 1)) l (𝓝 0) := by
        have h := ((Real.continuousAt_cos).tendsto.mono_left hle).sub_const 1
        simpa using (h.const_mul c.R)
      have h1 : (fun θ : ℝ => θ ^ 2 * (c.R * (cos θ - 1))) =o[l] fun θ : ℝ => θ ^ 2 :=
        (isLittleO_one_iff ℝ).mpr hlim |>.mul_isBigO (isBigO_refl _ _)
      simp only [mul_comm] at h1
      exact h1.congr_left fun θ => by ring
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

## 7. `IPhO2026Problems/problem_IPhO_2026_3_A_1.lean`

- Compile status: passed
- Open sorries: 0
- Direct-check seconds: 10.75
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_A_1.tex`
- Reports: `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_A_1.md`

### Lean excerpt
```lean
* T.wireCurrent.readout
          / (2 * Real.pi * T.meanRadius) := by
  have key := T.ampere_uniform_eq
  have hD : 2 * Real.pi * T.meanRadius ≠ 0 :=
    mul_ne_zero (mul_ne_zero (ne_of_gt two_pos) (ne_of_gt Real.pi_pos))
      (ne_of_gt T.meanRadius_pos)
  rw [eq_div_iff hD, mul_comm T.fieldMagnitude]
  exact key

/-- Bridge 3 — geometry bridge: `2πR = V / A`, rewriting the mean-path
length in terms of the torus volume and cross-sectional area. -/
theorem mean_circumference_eq (T : ParamagneticTorusA1) :
    2 * Real.pi * T.meanRadius = T.volume / T.crossSectionArea := by
  have hA : T.crossSectionArea ≠ 0 := ne_of_gt T.crossSectionArea_pos
  rw [T.volume_eq]
  field_simp

/-- Bridge 4 — the figure parametrization of the answer along the mean
path: `N·I/(2πR) = N·I·A/V`. -/
theorem meanRadius_form_eq_volume_form (T : ParamagneticTorusA1) :
    (T.numTurns : ℝ) * T.wireCurrent.readout / (2 * Real.pi * T.meanRadius)
      = (T.numTurns : ℝ) * T.wireCurrent.readout * T.crossSectionArea
          / T.volume := by
  have hR : 2 * Real.pi * T.meanRadius ≠ 0 :=
    mul_ne_zero (mul_ne_zero (ne_of_gt two_pos) (ne_of_gt Real.pi_pos))
      (ne_of_gt T.meanRadius_pos)
  have hV : T.volume ≠ 0 := ne_of_gt T.volume_pos
  have hA : T.crossSectionArea ≠ 0 := ne_of_gt T.crossSectionArea_pos
  rw [T.mean_circumference_eq]
  field_simp

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
  exact T.fieldMagnitude_eq_meanRadius_form.trans T.meanRadius_form_eq_volume_form

/-- Equivalent mean-radius form of the Part A.1 answer:
`H = N·I / (2πR)`, the form one obtains directly from Ampère's law before
substituting the torus geometry `V = 2πR·A`. -/
theorem paramagneticTorus_H_eq_meanRadius (T : ParamagneticTorusA1) :
    T.fieldMagnitude
      = (T.numTurns : ℝ) * T.wireCurrent.readout
          / (2 * Real.pi * T.meanRadius) := by
  exact T.fieldMagnitude_eq_meanRadius_form

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

## 8. `IPhO2026Problems/problem_IPhO_2026_3_B_1.lean`

- Compile status: passed
- Open sorries: 0
- Direct-check seconds: 10.383
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_B_1.tex`
- Reports: `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_B_1.md`

### Lean excerpt
```lean
rm, which must still be
derived — nothing asserts it in advance. -/
noncomputable def heatTransferredIntoTorus (p : TorusParams)
    (proc : IsothermalFieldChange p) : ℝ :=
  proc.Q_in proc.H_f - proc.Q_in proc.H_i

/-- **Target.** Along an isothermal field change of the paramagnetic torus
satisfying the equation of state, with the magnetic work `dW = μ₀ V H dM`
of part A.3 (recorded as `IsMagneticWorkDensity` in the field
parametrization) and the first law of thermodynamics, the heat transferred
into the torus (`heatTransferredIntoTorus`) equals the recorded closed form

`Q = -(μ₀ * n * K / (2 * T)) * (H_f^2 - H_i^2)`

(`heat_into_torus_value`).  No hypothesis states this closed form: the
first-law hypothesis only supplies per-leg balances
`Q_in H₁ − Q_in H₀ = −∫_{H₀..H₁} workOnDensity` over arbitrary endpoint
pairs, and deriving the value of each leg integral is the proof obligation:
`leg_work_integral_eval` (built on `magnetization_eq_eos_solution`,
`magnetization_deriv`, `workOnDensity_eq_linear`, and FTC) evaluates each
leg, `q_in_eq_neg_integral` identifies the readout, and `field_simp`/`ring`
with `proc.hV, proc.hT` reduce the difference to the closed form.

Blueprint label: `thm:physics:IPhO_2026_3_B_1:target`. -/
theorem isothermal_heat_into_torus (p : TorusParams) (U : ℝ → ℝ)
    (proc : IsothermalFieldChange p)
    (hU : HasHeatCapacityLaw p U)
    (workOnDensity : ℝ → ℝ)
    (hwork : IsMagneticWorkDensity p proc.M_of_H workOnDensity)
    (h_first_law : ObeysFirstLawMagnetic p U proc.T workOnDensity proc.Q_in)
    (Q : ℝ) (hQ : Q = heatTransferredIntoTorus p proc) :
    Q = heat_into_torus_value p proc := by
  rw [hQ, heatTransferredIntoTorus, heat_into_torus_value]
  rw [q_in_eq_neg_integral p proc U hU workOnDensity h_first_law proc.H_f,
    q_in_eq_neg_integral p proc U hU workOnDensity h_first_law proc.H_i,
    leg_work_integral_eval p proc workOnDensity hwork proc.H_f,
    leg_work_integral_eval p proc workOnDensity hwork proc.H_i]
  ring

/-- **Recorded official answer (checking form).** The heat
`heat_into_torus_value p proc` carried by the target theorem equals the
closed form recorded in the answer key,

`Q = -(μ₀ * n * K / (2 * T)) * (H_f^2 - H_i^2)`.

This is conclusion-side only: it pins the closed form of
`heat_into_torus_value` by definitional unfolding; it is not used as a
hypothesis of any theorem. -/
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

## 9. `IPhO2026Problems/problem_IPhO_2026_3_B_2.lean`

- Compile status: failed
- Open sorries: 1
- Direct-check seconds: 5.708
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_B_2.tex`
- Reports: `.archon/task_results/problem_IPhO_2026_3_B_2.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_B_2.md`

### Lean excerpt
```lean
> 0`.  The square-root
answer expression appears nowhere in the premises. -/
theorem adiabatic_temperature_change (params : TorusParameters)
    (p : StatePath) (laws : ParamagneticTorusLaws params p)
    (hadiabatic : IsAdiabaticPath params p laws)
    {Hi Hf Ti Tf : ℝ}
    (hendpoints : AdiabaticEndpoints p Hi Ti)
    (hfinal : ∃ tf, (p tf).field = Hf ∧ (p tf).temperature = Tf)
    (hTf_pos : 0 < Tf) :
    Tf - Ti
      = Ti * (Real.sqrt
          ((params.lam + params.mu0 * params.K * Hf ^ 2)
            / (params.lam + params.mu0 * params.K * Hi ^ 2)) - 1) := by
  have hTi : 0 < Ti := hendpoints.Ti_pos
  have hrel := endpoint_relation params p laws hadiabatic hendpoints hfinal
  have ha_pos : 0 < params.lam + params.mu0 * params.K * Hi ^ 2 :=
    lam_add_mu0_K_sq_pos params Hi
  have hb_pos : 0 < params.lam + params.mu0 * params.K * Hf ^ 2 :=
    lam_add_mu0_K_sq_pos params Hf
  have ha : params.lam + params.mu0 * params.K * Hi ^ 2 ≠ 0 := ha_pos.ne'
  -- From the endpoint relation, `(Tf/Ti)² = (λ+μ₀KH_f²)/(λ+μ₀KH_i²)`.
  have hratio_sq : (Tf / Ti) ^ 2
      = (params.lam + params.mu0 * params.K * Hf ^ 2)
          / (params.lam + params.mu0 * params.K * Hi ^ 2) := by
    have hTi' : Ti ≠ 0 := hTi.ne'
    have hb : params.lam + params.mu0 * params.K * Hf ^ 2 ≠ 0 := hb_pos.ne'
    rw [show (Tf / Ti) ^ 2 = Tf ^ 2 / Ti ^ 2 from div_pow Tf Ti 2]
    -- From the relation read off `Tf² = Ti²·A/B` with `A` the Hi-bracket
    -- and `B` the Hf-bracket (`hrel : Tf²·B = Ti²·A`), substitute, and
    -- cancel `Ti²` and `A⁻¹` on both sides.
    have hTf2 : Tf ^ 2
        = Ti ^ 2 * (params.lam + params.mu0 * params.K * Hi ^ 2)
            / (params.lam + params.mu0 * params.K * Hf ^ 2) := by
      rw [← hrel]
      field_simp [hb]
    rw [hTf2]
    rw [hTf2]
    have e : Ti ^ 2 * (params.lam + params.mu0 * params.K * Hi ^ 2)
        = Tf ^ 2 * (params.lam + params.mu0 * params.K * Hf ^ 2) := hrel.symm
    rw [e]
    field_simp [ha, hb, (pow_pos hTi 2).ne']
    linear_combination e
  -- Both sides are nonnegative, so `Tf/Ti` equals the square root.
  have hratio_nonneg : 0 ≤ Tf / Ti := by
    apply div_nonneg hTf_pos.le hTi.le
  have hratio : Tf / Ti = Real.sqrt
      ((params.lam + params.mu0 * params.K * Hf ^ 2)
        / (params.lam + params.mu0 * params.K * Hi ^ 2)) := by
    rw [← hratio_sq]
    symm
    exact Real.sqrt_sq hratio_nonneg
  have : Tf = Ti * Real.sqrt
      ((params.lam + params.mu0 * params.K * Hf ^ 2)
        / (params.lam + params.mu0 * params.K * Hi ^ 2)) := by
    rw [← hratio]
    field_simp [hTi.ne']
  linarith [this]

end IPhO2026_3_B_2
... [leading content omitted]
```

### Blueprint excerpt
```tex
$ and $\mu_0, K > 0$ make $\mu_0 K H^2 \ge 0$; adding $\lambda > 0$
forces the sum to be strictly positive.
\end{proof}

\subsection*{Target value theorem}

\begin{theorem}[Adiabatic temperature change]
\label{thm:IPhO2026Problems_problem_IPhO_2026_3_B_2:adiabatic_temperature_change}
\lean{IPhO2026_3_B_2.adiabatic_temperature_change}
\uses{def:IPhO2026Problems_problem_IPhO_2026_3_B_2:ParamagneticTorusLaws, def:IPhO2026Problems_problem_IPhO_2026_3_B_2:IsAdiabaticPath, def:IPhO2026Problems_problem_IPhO_2026_3_B_2:AdiabaticEndpoints, lem:IPhO2026Problems_problem_IPhO_2026_3_B_2:endpoint_relation, lem:IPhO2026Problems_problem_IPhO_2026_3_B_2:lam_add_mu0_K_sq_pos}
\textbf{(Target, T3-B.2.)}  For an adiabatic change $H_i \to H_f$ of the
paramagnetic torus starting at temperature $T_i$, with final temperature
$T_f > 0$, the temperature change is
\[
\Delta T = T_f - T_i
  = T_i\,\biggl(\sqrt{\frac{\lambda + \mu_0 K H_f^2}
                          {\lambda + \mu_0 K H_i^2}} - 1\biggr),
\]
the recorded official answer of part B.2.  The relation is conclusion-side
only: the hypotheses carry the governing laws, the adiabatic balance, the
positive parameters, and the endpoint and regularity data $H_i \ge 0$,
$T_i > 0$, $T_f > 0$ --- the square-root expression appears in no premise.
\end{theorem}
\begin{proof}
From the endpoint relation of
\cref{lem:IPhO2026Problems_problem_IPhO_2026_3_B_2:endpoint_relation},
$T_f^2 = T_i^2\,(\lambda + \mu_0 K H_f^2)/(\lambda + \mu_0 K H_i^2)$; the
denominator is strictly positive by
\cref{lem:IPhO2026Problems_problem_IPhO_2026_3_B_2:lam_add_mu0_K_sq_pos}, so
taking square roots with $T_i > 0$ and the assumed $T_f > 0$ gives
$T_f = T_i\,\sqrt{(\lambda + \mu_0 K H_f^2)/(\lambda + \mu_0 K H_i^2)}$,
hence $T_f - T_i$ has the displayed form.
\end{proof}
... [leading content omitted]
```

### Report excerpt: `problem_IPhO_2026_3_B_2.md`
```markdown
re.)

## Partial-progress kept in the file

Everything above the L283 `sorry` in `adiabatic_invariant_along_path` (field-as-function `hHfun`, differentiability of `H` via EOS, product-rule expansions `hderiv_expand`, the differentiated-EOS chain `e2`, and the balance instance `e1`) is exactly the derivation context a repaired contract needs; the blocker comment now records explicitly that the residual goal reduces to `4μ₀KH²T·Ṫ = 0`, irreducible from the stated premises, plus the countermodel and repair pointer. No `sorry` was added, removed, or moved; no signature, hypothesis, conclusion, or docstring-changing edit was made; no axioms/admits introduced.

## Files checked / artifacts

- Assigned file: `IPhO2026Problems/problem_IPhO_2026_3_B_2.lean` (comment-only edit inside the proof body of `adiabatic_invariant_along_path`, above the remaining `sorry`).
- Official source: `…/hf-IPHO2026-upload/ipho_2026_source/text/T3_solution.txt` ll. 23–60 (`(nλ/T²)dT = µ₀VH dM`, invariant, final formula).
- Proof-review gate state (read-only): `.archon/proof-review-gate.json` — retry, attempts 0/3.
- All scratch verification files under `.archon/tmp/` were deleted after use; no repo pollution.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_B_2.md`
```markdown
` (Mathlib)
- `adiabatic_relation_log` (PhysLean)
- `MeasureTheory.stoppedProcess` (Mathlib)
- `adiabatic_relation_UaUbVaVb` (PhysLean)

## Local abstractions introduced

- `IPhO2026_3_B_2.AdiabaticEndpoints`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_3_B_2.IsAdiabaticPath`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_3_B_2.ParamagneticTorusLaws`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_3_B_2.ParamagneticTorusState`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_3_B_2.StatePath`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_3_B_2.TorusParameters`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 10. `IPhO2026Problems/problem_IPhO_2026_3_C_2.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 11.425
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_2.tex`
- Reports: `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_C_2.md`

### Lean excerpt
```lean
$,
$q_4 = T_h M_4^2$, $q_3 = T_c M_3^2$ (definitions of $q$ with the
Figure-3b temperatures) and the two adiabatic-leg equalities
`q4_eq_adiabatic_41`, `q3_eq`. -/
theorem m1_sq : m.M1 ^ 2 = m.M2 ^ 2 - m.M3 ^ 2 + m.M4 ^ 2 := by
  -- Honest partial progress: the definitional values of the state
  -- function at the hot and cold vertices follow from Figure 3b:
  obtain ⟨hT1, hT4, hT2, hT3, -⟩ := m.figure3b
  have hq1 : m.q .v1 = m.Th * m.M1 ^ 2 := by
    change m.cyc.T .v1 * m.cyc.Mmag .v1 ^ 2 = _
    rw [hT1]
  have hq4 : m.q .v4 = m.Th * m.M4 ^ 2 := by
    change m.cyc.T .v4 * m.cyc.Mmag .v4 ^ 2 = _
    rw [hT4]
  have hq3 : m.q .v3 = m.Tc * m.M3 ^ 2 := by
    change m.cyc.T .v3 * m.cyc.Mmag .v3 ^ 2 = _
    rw [hT3]
  have hq2 : m.q .v2 = m.Tc * m.M2 ^ 2 := by
    change m.cyc.T .v2 * m.cyc.Mmag .v2 ^ 2 = _
    rw [hT2]
  have hTh : m.Th ≠ 0 := ne_of_gt m.Th_pos
  have hTc : m.Tc ≠ 0 := ne_of_gt m.Tc_pos
  -- The adiabatic-leg square-differences (prefactor nonzero):
  have hA : (p.μ₀ * p.V ^ 2 / (2 * p.n * p.K)) ≠ 0 := by
    have hAn : (0:ℝ) < (2:ℝ) * p.n := mul_pos two_pos p.n_pos
    have hBn : (0:ℝ) < (2:ℝ) * p.n * p.K := mul_pos hAn p.K_pos
    have hCn : (0:ℝ) < p.μ₀ * p.V ^ 2 := mul_pos p.μ₀_pos (pow_pos p.V_pos 2)
    exact ne_of_gt (div_pos hCn hBn)
  have leg41 : m.M1 ^ 2 = m.M4 ^ 2 :=
    sub_eq_zero.mp ((mul_eq_zero.mp m.q4_eq_adiabatic_41).resolve_left hA)
  have leg23 : m.M3 ^ 2 = m.M2 ^ 2 :=
    sub_eq_zero.mp ((mul_eq_zero.mp m.q3_eq).resolve_left hA)
  -- The two adiabatic-leg square-differences alone close the goal by
  -- substitution (`q_relation` is not needed for the target chain).
  rw [leg41, leg23]
  ring

/-- **Subquestion C.2 (main target).**
The magnitude of $\vec M$ at vertex $1$ of the Carnot refrigeration cycle
is

$M_1 = \sqrt{M_2^2 - M_3^2 + M_4^2}$,

with the nonnegative square root selected because $M_1$ is a magnitude. -/
theorem m1_eq_sqrt : m.M1 = Real.sqrt (m.M2 ^ 2 - m.M3 ^ 2 + m.M4 ^ 2) := by
  -- Take nonnegative square roots of the squared relation `m1_sq` using
  -- $0 \le M_1$ (the model's magnitude nonnegativity at vertex $1$):
  -- $M_1 = \sqrt{M_1^2} = \sqrt{M_2^2 - M_3^2 + M_4^2}$.
  have hM1 : 0 ≤ m.M1 := m.M_nonneg .v1
  rw [← m.m1_sq, Real.sqrt_sq hM1]

/-- The quantity under the root is nonnegative, as it must be for a
physical magnetization magnitude:
$0 \le M_2^2 - M_3^2 + M_4^2$.
Carrier: `m1_sq` together with $0 \le M_1^2$ (`sq_nonneg`). -/
theorem m1_sq_arg_nonneg : 0 ≤ m.M2 ^ 2 - m.M3 ^ 2 + m.M4 ^ 2 := by
  rw [← m.m1_sq]
  exact sq_nonneg _

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

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_C_2.md`
```markdown
roblem3.C2.Figure3bAssignment`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C2.IsothermalHeatIntoTorus`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C2.IsothermalHeatQForm`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C2.ParamagnetState`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C2.ProcessKind`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C2.TorusParams`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem3.C2.Vertex`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 11. `IPhO2026Problems/problem_IPhO_2026_3_C_4.lean`

- Compile status: passed
- Open sorries: 0
- Direct-check seconds: 10.789
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_4.tex`
- Reports: `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_C_4.md`

### Lean excerpt
```lean
heatCapacityBody / inputPower) * (tempHot / T' - 1) from by
    rw [intervalIntegral.integral_of_le hle]
    exact setIntegral_congr_set Ioc_ae_eq_Icc.symm]
  have hcont : ContinuousOn (fun x => tempHot * x⁻¹) (Set.uIcc tempFinal tempInitial) :=
    continuousOn_const.mul (continuousOn_inv₀.mono (Set.subset_compl_singleton_iff.mpr hb))
  have hsplit : IntervalIntegrable (fun x => tempHot * x⁻¹) volume tempFinal tempInitial :=
    hcont.intervalIntegrable
  have hsplit1 : IntervalIntegrable (fun _x => (1:ℝ)) volume tempFinal tempInitial :=
    intervalIntegral.intervalIntegrable_const
  have step1 : (∫ T' in tempFinal..tempInitial, (heatCapacityBody / inputPower) * (tempHot / T' - 1))
      = ∫ T' in tempFinal..tempInitial, (heatCapacityBody / inputPower) * (tempHot * T'⁻¹ - 1) := by
    apply intervalIntegral.integral_congr
    intro x _
    simp only [div_eq_mul_inv]
  rw [step1,
      intervalIntegral.integral_const_mul (heatCapacityBody / inputPower) (fun x => tempHot * x⁻¹ - 1),
      intervalIntegral.integral_sub hsplit hsplit1,
      intervalIntegral.integral_const_mul tempHot (fun x => x⁻¹),
      integral_inv hb,
      integral_one]

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
  rw [elapsedTime_eq_integral regime run hrun haccum,
      cooling_time_integral_eval regime]
  have hTh : tempHot ≠ 0 := ne_of_gt regime.tempHot_pos
  field_simp

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

## 12. `IPhO2026Problems/problem_IPhO_2026_4_A_5.lean`

- Compile status: passed
- Open sorries: 0
- Direct-check seconds: 11.19
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_A_5.tex`
- Reports: `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_A_5.md`

### Lean excerpt
```lean
e proc ref := ref.hP₀
  rw [div_mul_cancel₀ _ hP₀.ne']

/-- Component of `main`: uncertainty propagation. If the two-readout
pressure increment deviates from the ideal-gas increment
`P0 * Delta T / T0` by at most `P0 * |Delta T| * sigma`, then the measured
coefficient satisfies the propagated bound `|beta0 - 1 / T0| <= sigma`.
Formalizes the official sample statement `beta0 = 0.0034 ± 0.0007 K^-1`
covering the ideal-gas reference `0.0037 K^-1`. -/
theorem beta0_uncertainty_bound
    (proc : IsochoricProcess)
    (law : IsIdealGasLaw proc)
    (linear : IsIsochoricLinear proc)
    (ref : IsReferenceState proc)
    (T₀ β₀ : ℝ)
    (hT₀ : T₀ = IsReferenceState.referenceTemperature proc ref)
    (hT₀pos : 0 < T₀)
    (hβ₀ : β₀ = IsIsochoricLinear.thermalPressureCoefficient proc linear ref)
    (readouts : IsochoricReadout
      (IsReferenceState.referencePressure proc ref) T₀ β₀)
    (σ : ℝ) (hσ : 0 < σ)
    (hdev :
      |(readouts.measuredPressure readouts.T₂ (Or.inr rfl)) -
          (readouts.measuredPressure readouts.T₁ (Or.inl rfl)) -
        IsReferenceState.referencePressure proc ref *
          (readouts.T₂ - readouts.T₁) / T₀|
        ≤ IsReferenceState.referencePressure proc ref *
            |readouts.T₂ - readouts.T₁| * σ) :
    |β₀ - 1 / T₀| ≤ σ := by
  have hP₀ : 0 < IsReferenceState.referencePressure proc ref := ref.hP₀
  have hdev_eq :
      |(readouts.measuredPressure readouts.T₂ (Or.inr rfl)) -
          (readouts.measuredPressure readouts.T₁ (Or.inl rfl)) -
        IsReferenceState.referencePressure proc ref *
          (readouts.T₂ - readouts.T₁) / T₀|
        = IsReferenceState.referencePressure proc ref *
            |readouts.T₂ - readouts.T₁| * |β₀ - 1 / T₀| := by
    rw [readouts.measured_hP₂, readouts.measured_hP₁]
    have hfactor :
        IsReferenceState.referencePressure proc ref + β₀ *
            IsReferenceState.referencePressure proc ref * (readouts.T₂ - T₀) -
          (IsReferenceState.referencePressure proc ref + β₀ *
            IsReferenceState.referencePressure proc ref * (readouts.T₁ - T₀)) -
        IsReferenceState.referencePressure proc ref * (readouts.T₂ - readouts.T₁) / T₀
        = IsReferenceState.referencePressure proc ref * (readouts.T₂ - readouts.T₁) *
            (β₀ - 1 / T₀) := by
      field_simp
      ring
    rw [hfactor, abs_mul, abs_mul, abs_of_pos hP₀]
  have hfac : 0 < IsReferenceState.referencePressure proc ref * |readouts.T₂ - readouts.T₁| :=
    mul_pos hP₀ (abs_pos.mpr (sub_ne_zero.mpr readouts.hT12.symm))
  rw [hdev_eq] at hdev
  exact le_of_mul_le_mul_left hdev hfac

end

end IPhO2026_4_A_5
... [leading content omitted]
```

### Blueprint excerpt
```tex
$|\beta_0 - 1/T_0| \le \sigma$.
\end{proof}

\begin{theorem}[A.5 main target: value, consistency, and uncertainty]
\label{thm:IPhO2026Problems_problem_IPhO_2026_4_A_5:main}
\lean{IPhO2026_4_A_5.main}
\uses{thm:IPhO2026Problems_problem_IPhO_2026_4_A_5:beta0_close_to_ideal, thm:IPhO2026Problems_problem_IPhO_2026_4_A_5:beta0_eq_ideal_of_linear, thm:IPhO2026Problems_problem_IPhO_2026_4_A_5:beta0_uncertainty_bound, def:IPhO2026Problems_problem_IPhO_2026_4_A_5:IsochoricReadout, def:IPhO2026Problems_problem_IPhO_2026_4_A_5:idealThermalPressureCoefficient}
The A.5 target conjunction for a process with reference state
$(T_0, P_0)$, $T_0 > 0$, a non-degenerate temperature history, and a
two-readout dataset: (1) $\beta_0 = 1/T_0$, the ideal-gas prediction,
numerically $1/273.15\ \mathrm{K} = 0.0037\ \mathrm{K^{-1}}$ at
$T_0 = 273.15\ \mathrm{K}$; (2) the finite-difference bridge
$\mathrm{slope}\cdot\Delta T = \beta_0\,P_0\,\Delta T$ between any two
recorded temperatures; (3) the uncertainty bound
$|\beta_0 - 1/T_0| \le \sigma$ whenever the readout deviation is
$\le P_0\,|\Delta T|\,\sigma$.  The official sample band
$0.0034 \pm 0.0007\ \mathrm{K^{-1}}$ is the A.5-band-side reading of (3):
the reported band covers the ideal reference since
$|0.0034 - 0.0037| = 0.0003 \le 0.0007$.  All numeric answer values
appear only here, in conclusions.
\end{theorem}
\begin{proof}
Conjoin the three component theorems:
\cref{thm:IPhO2026Problems_problem_IPhO_2026_4_A_5:beta0_close_to_ideal},
\cref{thm:IPhO2026Problems_problem_IPhO_2026_4_A_5:beta0_eq_ideal_of_linear},
and
\cref{thm:IPhO2026Problems_problem_IPhO_2026_4_A_5:beta0_uncertainty_bound}
--- each is available under the packaged hypotheses by verbatim
transcription (the formal proof is the prover stage's remaining
obligation).
\end{proof}
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_A_5.md`
```markdown
Ideal` (Mathlib)
- `IdealGas` (PhysLean)
- `ordinaryHypergeometricCoefficient` (Mathlib)
- `Ideal` (Mathlib)
- `Polynomial.coeff_mem_contentIdeal` (Mathlib)
- `MeasureTheory.stoppedProcess` (Mathlib)
- `MeasureTheory.IsProgressive.inv` (Mathlib)
- `WittVector.isocrystal_classification` (Mathlib)

## Local abstractions introduced

- `IPhO2026_4_A_5.IsIdealGasLaw`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_4_A_5.IsIsochoricLinear`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_4_A_5.IsReferenceState`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_4_A_5.IsochoricProcess`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026_4_A_5.IsochoricReadout`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```

## 13. `IPhO2026Problems/problem_IPhO_2026_4_B_6.lean`

- Compile status: passed
- Open sorries: 0
- Direct-check seconds: 10.505
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_B_6.tex`
- Reports: `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_B_6.md`

### Lean excerpt
```lean
0⁻³ kg/mol) ≈ 2190 kJ/kg`,

within the official uncertainty `±110 kJ/kg`. This is the formula the
subquestion asks to state. -/
theorem latent_heat_per_unit_mass_formula :
    ∃ Lv Qv M0 : ℝ,
      Qv = catalogQvValue ∧
      M0 = catalogMolarMassWaterValue ∧
      Lv = Qv / M0 ∧
      |Lv - officialSpecificLatentHeatValue.central_kJ_per_kg| ≤
        officialSpecificLatentHeatValue.uncertainty_kJ_per_kg := by
  refine ⟨catalogQvValue / catalogMolarMassWaterValue, catalogQvValue,
    catalogMolarMassWaterValue, rfl, rfl, rfl, ?_⟩
  show |(catalogQvValue / catalogMolarMassWaterValue : ℝ) - 2190| ≤ 110
  rw [catalogQvValue, catalogMolarMassWaterValue, abs_le]
  constructor <;> norm_num

/-- **Uncertainty preservation (B.6).** The uncertainty propagated to `Lᵥ`
from the B.5 uncertainty `Qᵥ = 39 ± 2 kJ/mol` (relative uncertainty
`2/39 ≈ 5.1%`, with `M₀` treated as exact) is `±110 kJ/kg` about the central
value `2190 kJ/kg`: the computed central value
`Lᵥ = 39 kJ/mol / 18.0 × 10⁻³ kg/mol ≈ 2167 kJ/kg` lies within the official
interval `2190 ± 110 kJ/kg`. -/
theorem computed_value_within_official_uncertainty :
    |(catalogQvValue / catalogMolarMassWaterValue) -
        officialSpecificLatentHeatValue.central_kJ_per_kg| ≤
      officialSpecificLatentHeatValue.uncertainty_kJ_per_kg := by
  show |(39 / 18.0e-3 : ℝ) - 2190| ≤ 110
  rw [abs_le]
  constructor <;> norm_num

/-- Bridge lemma: the B.5 slope determination `s = −4700 ± 200 K` together
with the reference value `R = 8.31 J/(mol·K)` fixes the molar latent heat
input to B.6 through `Qᵥ = −s · R ≈ 39.1 kJ/mol`, which is consistent with
the official `Qᵥ = 39 ± 2 kJ/mol`. This is the natural-language
previous-part prerequisite recorded in Lean form; it does not state the B.6
conclusion. -/
theorem qv_from_clausius_clapeyron_slope
    (input : PartB6Input) :
    ∃ Qv_computed_kJ_per_mol : ℝ,
      Qv_computed_kJ_per_mol = -input.slope_K * input.R_J_per_mol_K / 1000 ∧
      |Qv_computed_kJ_per_mol - input.Qv_kJ_per_mol| ≤
        input.Qv_uncertainty_kJ_per_mol := by
  refine ⟨-input.slope_K * input.R_J_per_mol_K / 1000, rfl, ?_⟩
  rw [input.slope_K_eq, input.R_J_per_mol_K_eq, input.Qv_kJ_per_mol_eq,
    input.Qv_uncertainty_kJ_per_mol_eq, abs_le]
  constructor <;> norm_num

/-- The reference temperature calibration `T₀ = 273.15 K` at which the
extrapolated vapor pressure vanishes, captured for the setup even though B.6
does not use it directly. -/
theorem reference_temperature_calibration
    (input : PartB6Input) :
    input.T₀_value_K = 273.15 := by
  exact input.T₀_value_K_eq

end Problem4

end IPhO2026

end
... [leading content omitted]
```

### Blueprint excerpt
```tex
rtainty}
\lean{IPhO2026.Problem4.computed_value_within_official_uncertainty}
\uses{def:IPhO2026Problems_problem_IPhO_2026_4_B_6:SpecificLatentHeatValue}
The computed central value $L_v = 39/(18.0 \times 10^{-3}) \approx 2167$
kJ/kg lies within the official interval $2190 \pm 110$ kJ/kg.
\end{theorem}
\begin{proof}
Same scalar evaluation:
$|2166.\overline{6} - 2190| = 23.\overline{3} \le 110$.
\end{proof}

\begin{lemma}[B.5 bridge: $Q_v$ from the Clausius--Clapeyron slope]
\label{lem:IPhO2026Problems_problem_IPhO_2026_4_B_6:qv_from_clausius_clapeyron_slope}
\lean{IPhO2026.Problem4.qv_from_clausius_clapeyron_slope}
\uses{def:IPhO2026Problems_problem_IPhO_2026_4_B_6:PartB5Measurements, def:IPhO2026Problems_problem_IPhO_2026_4_B_6:SatisfiesClausiusClapeyron}
The B.5 slope $s = -4700 \pm 200$ K with $R = 8.31$ J/(mol$\cdot$K) fixes
the molar latent heat at $Q_v = -s \cdot R \approx 39.1$ kJ/mol, consistent
with the official $Q_v = 39 \pm 2$ kJ/mol:
$Q_v = -\mathtt{slope\_K}\cdot\mathtt{R}/1000$ and
$|Q_v^{\mathrm{computed}} - Q_v^{\mathrm{input}}| \le \Delta Q_v$.
\end{lemma}
\begin{proof}
Substitute the recorded field equations: $-(-4700)\cdot 8.31/1000 = 39.057$
kJ/mol and $|39.057 - 39| = 0.057 \le 2$.
\end{proof}

\begin{lemma}[Reference-temperature calibration]
\label{lem:IPhO2026Problems_problem_IPhO_2026_4_B_6:reference_temperature_calibration}
\lean{IPhO2026.Problem4.reference_temperature_calibration}
\uses{def:IPhO2026Problems_problem_IPhO_2026_4_B_6:PartB5Measurements}
The reference temperature readout of the setup is
$T_0 = 273.15$ K, captured for the formalization even though B.6 does not
use it directly.
\end{lemma}
\begin{proof}
Immediate from the recorded field equation
\texttt{T\_0\_value\_K\_eq}.
\end{proof}

% --- Archon physics formalization source end ---
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_B_6.md`
```markdown
`IPhO2026.Problem4.MolarMass`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem4.PartB5Measurements`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem4.PartB6Input`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem4.Pressure`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem4.SatisfiesClausiusClapeyron`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem4.SpecificLatentHeat`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem4.SpecificLatentHeatValue`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```
