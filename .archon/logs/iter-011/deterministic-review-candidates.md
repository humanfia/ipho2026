# Deterministic Review Candidate Pack

Iteration: 011
Exact review target count: 13

Review only these targets. Direct Lean compilation was already run in
parallel by the orchestrator; use the recorded result instead of rerunning it.

## 1. `IPhO2026Problems/problem_IPhO_2026_1_A_1.lean`

- Compile status: passed
- Open sorries: 12
- Direct-check seconds: 13.273
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_A_1.tex`
- Reports: `.archon/task_results/problem_IPhO_2026_1_A_1.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_A_1.md`

### Lean excerpt
```lean
trical).** The arm of the
pressure couple is one quarter of the figure's diagonal readout `a√2`:
`4 · (a/(2√2)) = 4 · (a√2/4) = a√2`, since the face centroids lie `a/2`
up the sides from O, i.e. at one quarter of the vertical diagonal.
A purely geometrical Figure-1a trace of where the couple acts,
consistently with the top face sitting flush at the slot's upper lip. -/
lemma pressure_couple_position_trace (ha : 0 < a) :
    4 * pressureFigureArm = a * Real.sqrt 2 := by
  sorry

/-- **Step 7 (algebra).** From the critical balance equation and positivity
of the parameters, `a = Δh/(2√2)` follows by cancelling `ρ₀·g·a³` and using
`√2² = 2`. -/
lemma side_length_eq_delta_h_over (hp : 0 < rho0) (ha : 0 < a)
    (hΔ : 0 < DeltaH) (hg : 0 < g)
    (hbal : rho0 * g * a ^ 4 / Real.sqrt 2 = rho0 * g * DeltaH * a ^ 3 / 4) :
    a = DeltaH / (2 * Real.sqrt 2) := by
  sorry

/-- **Numerical evaluation.** For the design value `Δh = 1.41 m`, the closed
form gives `a = 0.50 m` to the stated precision; this records the
arithmetic final readout `a ≈ 0.50`. -/
lemma numerical_value (hp : 0 < rho0) (ha : 0 < a) (hg : 0 < g)
    (hΔ : DeltaH = 1.41)
    (ha_eq : a = DeltaH / (2 * Real.sqrt 2)) :
    a = 0.50 ∨ |a - 0.50| < 1 / 200 := by
  sorry

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
  sorry

/-- Balance-law consistency: the existence hypothesis bundled in
`HydrostaticGateSetup` indeed gives the scalar moment balance used by the
target theorem (it only re-expresses the law `IsCriticalTorqueBalance`
with the derived force magnitude; the substantive case split of the target
is unaffected). -/
lemma torque_balance_contract (S : HydrostaticGateSetup)
    (hbal : restoringMoment = pressureCoupleMagnitude) :
    IsCriticalTorqueBalance pressureCoupleMagnitude netImmersedWeight := by
  sorry

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

### Report excerpt: `problem_IPhO_2026_1_A_1.md`
```markdown
ches.
- `\leanok` readiness flagged for the review agent: all 12 sorried
  declarations compile with expected sorry warnings only.

## LeanExplore queries / grounding

Queries: "hydrostatic pressure fluid statics torque lever arm moment
balance", "Archimedes buoyancy force submerged body" (packages Mathlib +
Physlib). Candidates found: `DimPressure` (kept as the existing type-level
anchor `example : Type := DimPressure`), `FluidDynamics.FluidState`,
`RigidBody`. Mismatches: PhysLean has no hydrostatics / rigid-body torque
module, so the linear depth law, buoyancy, and moment balance stay local
`Prop` predicates/defs (see grounding register
`task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_A_1.md`).
Mathlib names available for later proofs: `Real.sin_pi_div_four`,
`Real.sq_sqrt`.

## Grounding gaps / redraft requests

- PhysLean hydrostatics/torque gap stands (exemption NOTE in chapter).
- Blueprint ledger needs the four new declaration blocks and the three
  restated blocks above (plan agent owns `.tex`).
- Verification: fresh
  `lake env lean IPhO2026Problems/problem_IPhO_2026_1_A_1.lean`
  => 0 errors, 12 `declaration uses sorry` warnings, no other diagnostics.
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

- Compile status: passed
- Open sorries: 5
- Direct-check seconds: 15.63
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_B_2.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_1_B_2.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_B_2.md`

### Lean excerpt
```lean
ith the sign from the
  --     strict branch and `signedDeflection_eq_neg_angle`;
  --   * the degree band needs tight rational bounds on
  --     `arctan(2/√45)·180/π` — a numerical-analysis side computation
  --     (tangent double-angle: `tan δ = 4√45/41`, so
  --     `δ = arctan(4√45/41)` and monotonicity squeezes δ between
  --     rational bounds inside `[16.595, 16.615)` degrees).
  sorry

/-- Algebraic certificate for the equal-mass eccentricity value: the
hyperbola `eps^2 = 49/4` makes the scattering asymptote factor
`1/sqrt(eps^2-1) = 2/sqrt(45)`, so the exact signed deflection in
`signed_deflection_angle_T1_B2` has the stated closed form.  Pure
algebra up to the square-root identity `sqrt(45/4) = sqrt 45 / 2`.
(ITER-011 REDRAFT: previously the false `67/4` / `2/sqrt 63` pair.) -/
theorem asymptote_factor_certificate :
    1 / Real.sqrt ((49 / 4 : ℝ) - 1) = 2 / Real.sqrt 45 := by
  have h454 : (45 / 4 : ℝ) = (Real.sqrt 45 / 2) ^ 2 := by
    rw [div_pow, Real.sq_sqrt (by norm_num)]
    norm_num
  have halg : (49 / 4 : ℝ) - 1 = 45 / 4 := by norm_num
  rw [halg, h454, Real.sqrt_sq (by positivity)]
  field_simp

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
  -- Assembly blocked on the same Kepler-layer bridges and band bounds as
  -- `signed_deflection_angle_T1_B2`: existence of `u_inf`, the formula
  -- `angleBetween = arctan(1/sqrt(eps^2-1))` with `eps^2 = 49/4` (proved
  -- above) and the certificate `2/√45` (proved below), and the tight
  -- degree-band bounds on `arctan(2/√45)*180/pi`.
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

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_1_B_2.md`
```markdown
Deflection_eq_neg_angle`, `asymptote_factor_certificate`
  (restated 49/4 to 2/sqrt 45, proved).
- By-sorry (Kepler layer + band bounds): `orbit_eq_conic` (L493),
  `exists_asymptoticRelativeVelocity` (L544),
  `signed_deflection_eq_formula` (L574, restated),
  `signed_deflection_angle_T1_B2` (L647, restated),
  `unsigned_deflection_angle_in_degrees_T1_B2` (L696, restated).

## LeanExplore / Mathlib grounding

Grounding register reused:
`.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_B_2.md`
(queries for Coulomb/scattering, sqrt, arctan monotonicity,
EuclideanSpace). Mathlib names actually used in the new proof:
`Real.sq_sqrt`, `Real.sqrt_sq`, `div_pow`, `eq_div_iff`,
`mul_ne_zero`, `pow_ne_zero`, `div_ne_zero`, `field_simp`,
`ring_nf`, `linear_combination`, `nlinarith`, `norm_num`. PhysLean:
none applicable (iter-003 PhysLean exemption NOTE in the chapter
stands -- no Coulomb/Rutherford module).

## Grounding gaps (unchanged)

No Mathlib/PhysLean Kepler-orbit / Rutherford-scattering API; the
conic bridge, the Tendsto existence of `u_inf`, and the
asymptote-angle lemma remain honest sorries, exactly as before (their
statements are now the correct ones).
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

- Compile status: passed
- Open sorries: 3
- Direct-check seconds: 13.399
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_C_1.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_1_C_1.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_1_C_1.md`

### Lean excerpt
```lean
t E₀ := hbar * hbarOmegaMin m c dU θ
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

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_1_C_1.md`
```markdown
f`, `Real.cos_two_mul`, `Real.sin_pi_sub`,
  `Real.sin_sq_add_cos_sq` — all confirmed present in this Mathlib pin
  (the file's three complete proofs compile against them).
- New this iter (compile repair): verified `le_or_lt` is **absent** from the
  pin (`rg 'theorem le_or_lt' .lake/packages/mathlib/Mathlib/` → only the
  unrelated `le_or_lt_of_mul_le_mul`); confirmed
  `real_inner_sub_sub_self` at
  `Mathlib/Analysis/InnerProductSpace/Basic.lean:269`. No new Mathlib/
  PhysLean API was needed for the redraft.

## Grounding gaps

- None new. Standing iter-002 exemption (chapter NOTE): PhysLean has no
  module for relativistic two-body photodissociation kinematics; file stays
  on the `import Mathlib` baseline.

## Notes for planner/review

- The chapter lemma block `lem:…:quadratic_characterization_of_threshold`
  should mention positive $\hbar$ in its prose (one-clause doc sync; the
  `\lean{}` pin itself is unchanged and still resolves).
- This lane's gate entry (`1_C_1` 2/3, recorded-stale) is expected to flip
  at the deterministic review re-pass: both reported defects (refutable
  lemma; non-compiling file) are removed and the file compiles fresh with
  3 contracted sorries.
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

- Compile status: passed
- Open sorries: 6
- Direct-check seconds: 13.932
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_B_2.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_2_B_2.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_B_2.md`

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

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_2_B_2.md`
```markdown
cy NOTE and all other exemption text unchanged (Mathlib-only
   baseline stands).

## LeanExplore / Mathlib grounding

Per the iter-002 grounding log (local backend, packages Mathlib+Physlib —
`physics-grounding-...2_B_2.md`): usable hits were `EuclideanSpace` /
inner-product API and order/`sSup` tools; PhysLean has no specular-reflection
or geometrical-optics module (chapter import-exemption NOTE stands).
Mathlib names in use: `EuclideanSpace ℝ (Fin 2)`, `@inner ℝ _ _`,
`Metric.sphere`, `Metric.closedBall`, `Set.MapsTo`, `Set.Ioo`, `sSup`,
`sInf`, `Real.arccos`, `Real.sin_arccos`, `Real.sin_two_mul`,
`Real.sin_pos_of_pos_of_lt_pi`, `mul_div_mul_right`, `div_eq_div_iff`.

## Grounding gaps / redraft requests

- PhysLean gap (documented in chapter NOTE): no optics module —
  `AbsorbedRays.reflected_point_law` is the faithful local abstraction of
  the specular law.
- Chapter ledger reconciliation requested above (planner-owned).
- For the prover stage: the only physics-heavy sorry is
  `yOff_eq_R_sin_thetaMax` (tangency of extreme rays + monotonicity);
  `abs_hitOffset_eq` and the width/`sSup` lemmas are routine once the
  ON-pair decomposition of the plane along `(e, n)` is set up.
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

- Compile status: passed
- Open sorries: 2
- Direct-check seconds: 14.741
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_C_2.tex`
- Reports: `.archon/task_results/problem_IPhO_2026_2_C_2.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_2_C_2.md`

### Lean excerpt
```lean
ide).
  obtain ⟨db, hdb⟩ := s.B_first_order
  -- The C.1 recorded value fixes the zeroth order.
  have hB : s.B s.θ = s.R / (2 * cos s.θ) := by rw [← s.b_A_eq, s.b_A_formula]
  -- Coefficient identification as in the slope half: the bridge carrier
  -- `intercept_deriv_value` plus the chain-rule evaluation
  -- `deriv_specularInterceptFamily`; the specular-family contract is the
  -- marked honesty-discount `sorry` (second of two in the file).
  have hfam : interceptFamily_deriv s := by
    -- BLOCKED at the modeling bridge (see task result): `deriv s.B s.θ`
    -- of the abstract family must be contracted to the specular C.1 law
    -- it is the derivative of.  Consequences, never premises.
    sorry
  have hdbval : db = s.R / (2 * cos s.θ) * tan s.θ :=
    intercept_deriv_value s hdb hfam
  have htend : Tendsto (fun Δθ : ℝ ↦ s.θ + Δθ) (𝓝 0) (𝓝 (s.θ + 0))
      := (tendsto_const_nhds (x := s.θ)).add tendsto_id
  rw [add_zero] at htend
  have hcomp := hdb.isLittleO.comp_tendsto htend
  have hfun : ((fun x' ↦ s.B x' - s.B s.θ - (x' - s.θ) • db)
        ∘ fun Δθ ↦ s.θ + Δθ)
      = fun Δθ ↦ s.B (s.θ + Δθ) - s.B s.θ - db * Δθ := by
    ext y
    simp [Function.comp_apply, smul_eq_mul, mul_comm]
  have hvg : ((fun x' : ℝ ↦ x' - s.θ) ∘ fun Δθ ↦ s.θ + Δθ)
      = fun Δθ ↦ Δθ := by
    ext y
    simp [Function.comp_apply]
  rw [hfun, hvg] at hcomp
  apply hcomp.congr' _ (EventuallyEq.refl _ _)
  refine Eventually.of_forall fun Δθ ↦ ?_
  -- Sieve step: the expanded defect equals the recorded target defect.
  show s.B (s.θ + Δθ) - s.B s.θ - db * Δθ
      = s.b_B s.θ Δθ - (s.R / (2 * cos s.θ)) * (1 + tan s.θ * Δθ)
  rw [hB, hdbval, s.b_B_eq]
  ring

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

### Report excerpt: `problem_IPhO_2026_2_C_2.md`
```markdown
y stays an abstract `ℝ → ℝ` pair tied to rays A/B by membership fields; concrete closed forms appear only as the C.1-derived `specularSlopeFamily`/`specularInterceptFamily` used to *evaluate* derivatives. No scalar-alias collapse.

## Grounding gaps / redraft requests

- Grounding gap: no direct `deriv`/`HasDerivAt` lemma for `Real.cot` in this Mathlib pin — worked around via the quotient characterization (`cos/sin`) which is definitionally `cot`.
- Residual redraft request to the planner/review: the two bridge sorries (`slopeFamily_deriv s`, `interceptFamily_deriv s` discharged locally) need a structure-level first-order family contract (either the two `...Family_deriv` hypothesis fields, or the stronger pointwise C.1-family equality fields). With either field added, both target theorems become fully `sorry`-free with **zero further changes** (`slope_deriv_value`/`intercept_deriv_value` already take those contracts as hypotheses). The lane deliberately did **not** add structure fields, because the current-objective text marks statements as planner-frozen and the review ledger counted this lane's convergence on the frozen decl set; flagged here for the deterministic review re-pass.
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

## 6. `IPhO2026Problems/problem_IPhO_2026_3_A_1.lean`

- Compile status: passed
- Open sorries: 0
- Direct-check seconds: 13.238
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_A_1.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_3_A_1.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_A_1.md`

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

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_3_A_1.md`
```markdown
inset.card_univ`, `nsmul_eq_mul`,
`Fintype.card_congr`, `Fintype.card_fin`, `eq_div_iff`,
`div_mul_cancel0`, `mul_ne_zero`, `ne_of_gt`, `mul_pos`, `Real.pi_pos`,
`exact_mod_cast`, `ring`, `field_simp`.

## Local abstractions introduced and physical meaning

- `HPerimeter` (in `AmpereLawThinMeanPath`) and `fieldMagnitudePerimeter`
  (in `ParamagneticTorusA1`): the uniform value of `H` along the
  once-traversed amperian curve, the quantity that genuinely enters
  `circ_C H . dl`. This preserves the loop-vs-filament distinction that
  the summed field side had collapsed; it is tied to the interior
  magnitude only through the physical uniformity law
  `perimeter_eq_interior`, never by definition.
- `AmpereLawThinMeanPath.circulation`: quoted elimination of the law field.
No other new abstractions.

## Grounding gaps / redraft requests

- Grounding gaps: none new (PhysLean exemption NOTE stands).
- Blueprint redraft requested planner-side (items 1-4 above); chapter left
  untouched per write-permission rules.
- Gate: the iter-010 `underdetermined_contract` defect is removed at its
  root; `3_A_1` is ready for the deterministic review re-pass and the
  autoformalize exit-gate re-count.
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

## 7. `IPhO2026Problems/problem_IPhO_2026_3_B_1.lean`

- Compile status: passed
- Open sorries: 7
- Direct-check seconds: 13.559
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_B_1.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_3_B_1.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_B_1.md`

### Lean excerpt
```lean
sorry

/-- The physical heat transferred into the torus between the initial and
final states of the isothermal field change: the difference of the tracked
cumulative heat readout between the final and initial states,
`Q_in(H_f) − Q_in(H_i)`.  This is the quantity the target theorem
characterizes; the recorded answer is its closed form, which must still be
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
  sorry

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

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_3_B_1.md`
```markdown
dd_adjacent_intervals`, `integral_id`,
`Set.uIcc` (no longer used), `decide`. PhysLean: none applicable — the
chapter carries the iter-002 planner exemption NOTE for
`missing-physlib-import` (paramagnetic magnetic-work thermodynamics is not in
PhysLean; see grounding log).

## Local abstractions introduced and why they preserve physical meaning

- `TorusState`/`TorusParams` records — physical scalars with named roles and
  units recorded in docstrings (no scalar-alias collapse).
- Four `Prop`-valued governing-law predicates, each delivering equations or
  derivative certificates (see audit above), per the physics-formalize rule
  that abstract `Prop` relations must expose consequences.
- `IsothermalFieldChange` process record with neq-guards and calibration —
  matches the experimental readout workflow (reference-state normalization).

## Grounding gaps / redraft requests

- Blueprint chapter redraft requested (see table note).
- No Mathlib grounding gaps: every proof route uses verified names.
- `T_iso` parameter of `ObeysFirstLawMagnetic` is intentionally present
  (documents the isotherm the predicate belongs to) but unused in the body;
  named `_T_iso` to keep the linter clean.
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

## 8. `IPhO2026Problems/problem_IPhO_2026_3_B_2.lean`

- Compile status: passed
- Open sorries: 3
- Direct-check seconds: 5.21
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_B_2.tex`
- Reports: `.archon/task_results/problem_IPhO_2026_3_B_2.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_B_2.md`

### Lean excerpt
```lean
params : TorusParameters)
    (p : StatePath) (laws : ParamagneticTorusLaws params p)
    (hadiabatic : IsAdiabaticPath params p laws) (t₁ t₂ : ℝ) :
    adiabaticInvariant params (p t₁).temperature (p t₁).field
      = adiabaticInvariant params (p t₂).temperature (p t₂).field := by
  sorry

/-- **Bridge lemma 2 — endpoint to endpoint.**
Specialized to the recorded endpoints `(H_i, T_i)` and `(H_f, T_f)` of the
ramp, the invariant equality gives
`T_f²·(λ + μ₀·K·H_f²) = T_i²·(λ + μ₀·K·H_i²)`. -/
theorem endpoint_relation (params : TorusParameters) (p : StatePath)
    (laws : ParamagneticTorusLaws params p)
    (hadiabatic : IsAdiabaticPath params p laws)
    {Hi Hf Ti Tf : ℝ}
    (hendpoints : AdiabaticEndpoints p Hi Ti)
    (hfinal : ∃ tf, (p tf).field = Hf ∧ (p tf).temperature = Tf) :
    Tf ^ 2 * (params.lam + params.mu0 * params.K * Hf ^ 2)
      = Ti ^ 2 * (params.lam + params.mu0 * params.K * Hi ^ 2) := by
  sorry

/-- Positive bracket: `λ + μ₀·K·H² > 0` for the positive parameters of the
problem and any signed field `H` — records why the square root and the
quotient in the final answer are well-defined for either ramp direction. -/
theorem lam_add_mu0_K_sq_pos (params : TorusParameters) (H : ℝ) :
    0 < params.lam + params.mu0 * params.K * H ^ 2 := by
  have hK : 0 < params.K := params.K_pos
  have hmu : 0 < params.mu0 := params.mu0_pos
  have hlam : 0 < params.lam := params.lam_pos
  positivity

/-- **Main target (B.2).**  For an adiabatic change `H_i → H_f` of the
paramagnetic torus starting at temperature `T_i`, the temperature change is
    `ΔT = T_f − T_i
        = T_i·(√((λ + μ₀·K·H_f²)/(λ + μ₀·K·H_i²)) − 1)`.

The final relation is only on the conclusion side: the hypotheses are the
governing laws (`ParamagneticTorusLaws`), the first-law adiabatic balance
(`IsAdiabaticPath`), positive parameters (`TorusParameters`), endpoint and
readout data (`AdiabaticEndpoints` and the final-state witness), and the
direction/regularity data `H_i ≥ 0`, `T_i > 0`, `T_f > 0`.  The square-root
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
  sorry

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
OTE, the `FreeSpace`/`mu0` constant being the referenced PhysLean object).
- `Mathlib.Analysis.Calculus.Deriv.Basic` — `deriv` used in `work_rate` and `IsAdiabaticPath`.
- `Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic` — `IntervalIntegrable`, `MeasureTheory.volume` in the regularity clauses.
- `Mathlib.Analysis.Real.Sqrt` (via existing imports) — `Real.sqrt` in the target conclusion; `Real.sqrt_lt'` grounded for the proof stage.

## Local abstractions introduced (and why meaning-preserving)

`ParamagneticTorusState`, `StatePath`, `TorusParameters`, `ParamagneticTorusLaws`, `IsAdiabaticPath`, `adiabaticInvariant`, `AdiabaticEndpoints` — see the abstraction audit above; each keeps the physical quantity as a named real component with its law as an equation rather than an alias or `True`-like predicate. All were introduced in earlier iterations; retained unchanged.

## Grounding gaps / redraft requests

- PhysLib has no paramagnetic-torus heat-budget, cyclic-magnetization-work, or adiabatic-invariant module — recorded in the chapter's reconciliation NOTE and the grounding register; local laws are the intended faithful substitute. No further grounding gaps; no redraft requests.
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

## 9. `IPhO2026Problems/problem_IPhO_2026_3_C_2.lean`

- Compile status: passed
- Open sorries: 1
- Direct-check seconds: 14.832
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_2.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_3_C_2.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_C_2.md`

### Lean excerpt
```lean
2 + m.M4 ^ 2 := by
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
  -- The remaining step: `q_relation` rewritten with the definitional
  -- values and these two leg equations.  Note the leg equations alone
  -- close the goal by substitution; `q_relation` (still `sorry` upstream)
  -- supplies the consistency constraint $T_h M_4^2 = T_c M_2^2$ of the
  -- amplitude, which is not needed for this final rewrite.
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

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_3_C_2.md`
```markdown
were restated to
  their corrected forms under the same blueprint-pinned Lean names —
  chapter docstrings should be updated to the corrected prefactor and
  the square-difference shapes; (iii) `q_relation`'s recorded proof
  sketch should route through `q3_eq` for the collision term (bridge
  7). `\leanok` marking: all entries except lem:...:q_relation are
  proof-complete.

## Tactic pitfalls recorded for the prover stage

- Term-style nested `mul_pos two_pos (mul_pos p.n_pos p.K_pos)` fails with
  a confusing application type mismatch (its product form unifies
  against the wrong arguments); split the positivity chain into steps
  (`have hA : 0 < 2 * p.n := mul_pos two_pos p.n_pos`, then
  `mul_pos hA p.K_pos`, then `div_pos`).
- `ring`/`ring_nf` can leave a mirrored-subtraction goal of the shape
  `A * X = -(A * X)` unproved instead of failing; the robust pattern for
  negating an equality of products is `rw [neg_eq_iff_eq_neg] at h`,
  then `rw [h, neg_mul, neg_neg]`.
- `linear_combination` on goals whose left/right sides are syntactic
  negations collapses to `x * 2 = 0`-shaped residuals; prefer explicit
  rewriting through `neg_eq_iff_eq_neg`/`congrArg Neg.neg` + `neg_neg`.
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

## 10. `IPhO2026Problems/problem_IPhO_2026_3_C_4.lean`

- Compile status: passed
- Open sorries: 0
- Direct-check seconds: 14.356
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_4.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_3_C_4.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_C_4.md`

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

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_3_C_4.md`
```markdown
s not reach this paramagnetic-torus (M,H,T)
infinitesimal-cycle model (exemption NOTE in the chapter, iter-002 ruling);
the closest candidates (IdealGas.ideal_gas_law, CanonicalEnsemble.heatCapacity,
adiabatic_relation_UaUbVaVb) are ideal-gas/canonical-ensemble objects that
do not model this cycle, so the faithful local law predicates stand.
Mathlib names grounded in the proofs: setIntegral_congr_ae, ae_iff,
measure_mono_null, (Set.countable_singleton _).insert _ |>.measure_zero,
intervalIntegral.integral_of_le, Ioc_ae_eq_Icc, continuousOn_inv₀,
intervalIntegral.integral_const_mul, intervalIntegral.integral_sub,
integral_inv, integral_one.

## Local abstractions

CoolingRun (four ℝ → ℝ density fields) and the equation-valued law
predicates are the smallest interface preserving the per-cycle physics; the
density-per-unit-drop formulation encodes the cooling branch in the data,
not in the conclusion.

## Grounding gaps / redraft requests

None remaining for this file. Note for the gate ledger: the recorded *_eq
bridge-lemma signatures now take (regime : RegimeAssumptions); the
blueprint chapter's \lean{} pins (names only, no signatures) are
unaffected, so no chapter edit is required.
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

## 11. `IPhO2026Problems/problem_IPhO_2026_4_A_5.lean`

- Compile status: passed
- Open sorries: 0
- Direct-check seconds: 14.055
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_A_5.tex`
- Reports: `.archon/task_results/problem_IPhO_2026_4_A_5.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_A_5.md`

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

### Report excerpt: `problem_IPhO_2026_4_A_5.md`
```markdown
tic sync.
- All other declarations (18 ledger entries) are unchanged and proved/
  definitional as before; the file has **0 sorries** (was 1 at the old
  line 446).

## LeanExplore / grounding

- No new API was needed: the repair uses only Mathlib tactics already in
  the file (`mul_left_inj'`, `mul_eq_zero`, `sub_ne_zero`,
  `linear_combination`, `field_simp`) and the existing local bridges
  (`IsIsochoricLinear.slope_eq_div`, `IsIdealGasLaw.state_eq`). No new
  LeanExplore queries were required; prior grounding (Physlib
  `Temperature.toReal` etc.) is unchanged.
- PhysLean/Mathlib names grounded (unchanged): `Temperature`,
  `Temperature.toReal`, `NNReal.coe_nonneg`, `sq_eq_sq_iff_eq_or_eq_neg`
  (no longer used — removed with the sorry branch), `mul_left_inj'`,
  `le_of_mul_le_mul_left`, `div_mul_cancel₀`.

## Redraft requests / hand-back

- The chapter block for `beta0_close_to_ideal` should record the added
  premise (∃ t₁ t₂, T t₁ ≠ T t₂) and retire/mark-discharged the
  iter-010 NOTE; per write permissions this lane did not edit the
  chapter. The Lean statement is now the proof-reviewed target:
  component theorem derivable, `main` unchanged, **zero sorries in the
  file**.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_A_5.md`
```markdown
prover stream `logs/iter-00*/provers/IPhO2026Problems_problem_IPhO_2026_4_A_5.jsonl`)
### Query: `IdealGas pressure volume state`
- (candidates as returned by the local LeanExplore index; see the prover stream `logs/iter-00*/provers/IPhO2026Problems_problem_IPhO_2026_4_A_5.jsonl`)

## Grounded Mathlib/PhysLean names

- `A.2`
- `A.3`
- `A.4`
- `A.5`
- `IsIdealGasLaw.pressure_pos_of_temp_pos`
- `IsIdealGasLaw.pressure_ratio_eq_temp_ratio`
- `IsIsochoricLinear.slope_eq_div`
- `IsIsochoricLinear.thermalPressureCoefficient`
- `IsReferenceState.referencePressure`
- `IsReferenceState.referenceTemperature`
- `Or.inl`
- `Or.inr`
- `Physlib.Thermodynamics.Basic`
- `Physlib.Thermodynamics.Temperature.Basic`
- `Temperature.toReal`

## Local abstractions introduced

- See the file header + structure docstrings (faithful local abstractions where the domain API is absent; assumption/target split recorded in the chapter).

## Grounding gaps

- None blocking: targeted Physlib imports retained (`Physlib.Thermodynamics.Basic`, `Physlib.Thermodynamics.Temperature.Basic`, `Physlib.StatisticalMechanics.MicroCanonicalEnsemble.IdealGas`); remaining gaps covered by local abstractions per the chapter NOTE.
... [leading content omitted]
```

## 12. `IPhO2026Problems/problem_IPhO_2026_4_B_6.lean`

- Compile status: passed
- Open sorries: 2
- Direct-check seconds: 13.91
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_B_6.tex`
- Reports: `.archon/task_results/problem_IPhO_2026_4_B_6.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_B_6.md`

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

### Report excerpt: `problem_IPhO_2026_4_B_6.md`
```markdown
y unfolding.
- `SatisfiesClausiusClapeyron`/`IsClausiusClapeyronSlope`: the governing
  law as a universally quantified equation plus slope elimination — the
  smallest hypothesis interface preserving the physical law.
- `PartB6Input`, `InnerCylinderExperiment`, `PartB5Measurements`: readout
  packages with `neq`-free but value-pinned fields (`*_eq`), matching the
  figure/data cocContract.

## Grounding gaps / redraft requests

- Grounding gaps (unchanged from iter-004 preflight): PhysLean has no
  amount-of-substance dimension and no experimental-calibration graph
  readouts; both are carried by documented local abstractions. No new gap.
- Redraft requests: **none open** — the iter-010 Proof-Review finding is
  discharged by this redraft; the contract is now determined (countermodel
  audit re-run, see above). Re-review should re-grade
  `latent_heat_per_unit_mass_target` as faithful-with-2-honest-sorries.
- Not applicable notes: `input : PartB6Input` remains intentionally unused
  by the arithmetic closures of the auxiliary theorems (the catalog field
  equations are what get rewritten); this matches the blueprint policy
  `natural_language_prerequisite_only` for the B.5 import.
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

## 13. `IPhO2026Problems/problem_IPhO_2026_4_C_7.lean`

- Compile status: passed
- Open sorries: 4
- Direct-check seconds: 13.182
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_C_7.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_4_C_7.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_C_7.md`

### Lean excerpt
```lean
0 < 2 * π * G.h * D.R_Th` is the precise
  -- point the redraft must supply.
  rcases lt_or_gt_of_ne hR with hRneg | hRpos
  · sorry
  · sorry

/-- **C.7 official sample value with propagated uncertainty.**

The official sample takes `R_Th = 1.17 ± 0.03 K/W` (the C.6 measurement,
used here as the interval `R_Th ∈ [1.14, 1.20]`), the Figure-17 geometry
`r₂/r₁ = 23.25/16.85` and wetted height `h = 0.10 m`, and reports
`λ = 0.25 ± 0.01 W/(m·K)`. The theorem contract preserves the uncertainty
as stated: the input window is the hypothesis `hR_central /
hR_uncert` (the C.6 measurement lies in `1.17 ± 0.03 K/W`), and deriving
the `± 0.01` output window from the `± 0.03` resistance window is
interval arithmetic/refinement through the (already separate) derivation
formula, which is taken as the hypothesis `hformula` here because
`acrylicConductivity_formula` is proved independently. -/
theorem acrylicConductivity_officialSample
    (lam R_Th : ℝ)
    (hformula : lam = Real.log ((23.25e-3 : ℝ) / 16.85e-3) /
      (2 * π * (0.10 : ℝ) * R_Th))
    (hR_central : R_Th = 1.17) (hR_uncert : |R_Th - 1.17| ≤ 0.03) :
    |lam - 0.25| ≤ 0.01 := by
  -- PROVER REPORT (redraft requested — see task_results/IPhO_2026_4_C_7.md).
  -- The conclusion is numerically FALSE at the stated inputs: substituting
  -- `R_Th = 1.17` (which satisfies `|R_Th - 1.17| ≤ 0.03`) gives
  -- `lam = log(465/337) / (2π·0.10·1.17) ≈ 0.43795`, so
  -- `|lam - 0.25| ≈ 0.18795 > 0.01`.
  -- Machine-checked refutation chain (used to build this report):
  -- `Real.lt_log_one_add_of_pos` gives `128/401 < log(465/337)`
  -- (with `2·(128/337)/((128/337)+2) = 128/401` by `field_simp; ring`),
  -- `Real.pi_lt_d20` gives `π < 3.141592654`, hence
  -- `lam > (128/401)/(2·3.141592654·0.10·1.17) > 0.43 > 0.26`,
  -- so `|lam - 0.25| > 0.01` — the negation of the goal is provable.
  -- Root cause: with heights in metres as stated, the official answer
  -- `0.25 W/(m·K)` requires `R_Th ≈ 2.05 K/W` or `h ≈ 0.175 m`;
  -- the frozen geometric inputs `r₂/r₁ = 465/337`, `h = 0.10`,
  -- `R_Th = 1.17` are inconsistent with the recorded band at any sign
  -- convention; a redraft must change the numeric inputs (e.g. the wetted
  -- height in the correct SI value or the C.6 resistance) or weaken the
  -- conclusion window. Partial progress: substitute the central value and
  -- split `|·| ≤` into the two one-sided bounds; the upper half
  -- `lam - 0.25 ≤ 0.01` is exactly the disprovable one (see above).
  rw [hR_central] at hformula
  rw [hformula]
  rw [abs_le]
  constructor
  · sorry
  · sorry

end IPhO2026.Problem4.C7
... [leading content omitted]
```

### Blueprint excerpt
```tex
\;=\; \frac{\ln(r_2/r_1)}{2\pi h\,R_{Th}}. \]
This is the recorded C.7 answer formula --- the conclusion of the
derivation, never a hypothesis.
\end{theorem}
\begin{proof}
Constancy and positivity of $P = (T_{OC}-T_{IC})/R_{Th} > 0$ give
$\mathrm{d}T/\mathrm{d}r < 0$ (outward-decreasing profile, so the
derivative exists almost everywhere on $(r_1, r_2)$); integrating
$P/(2\pi\lambda h r) = -\mathrm{d}T/\mathrm{d}r$ over $[r_1, r_2]$ yields
$P\ln(r_2/r_1)/(2\pi\lambda h) = T_{IC} - T_{OC}$ via
$\int r^{-1} = \ln$; substituting Eq.\ (4) for $P$ and solving for
$\lambda$ gives the claimed formula. The certified integration is the
sorried proof body left to the prover stage.
\end{proof}

\begin{theorem}[C.7 official sample value with propagated uncertainty]
\label{thm:IPhO2026Problems_problem_IPhO_2026_4_C_7:acrylicConductivity_officialSample}
\lean{IPhO2026.Problem4.C7.acrylicConductivity_officialSample}
For $\lambda$ given by the C.7 formula at the official sample inputs ---
the C.6 central measurement $R_{Th} = 1.17\ \mathrm{K/W}$, the Figure-17
geometry $r_2/r_1 = 23.25/16.85$ and wetted height $h = 0.10$
m --- the official sample report
$\lambda = 0.25 \pm 0.01\ \mathrm{W/(m\cdot K)}$ holds:
$\lvert \lambda - 0.25 \rvert \le 0.01$. The official band lives only
here, on the conclusion side; the formula itself is taken as the
hypothesis \texttt{hformula} because
\cref{thm:IPhO2026Problems_problem_IPhO_2026_4_C_7:acrylicConductivity_formula}
is proved independently.
\end{theorem}
\begin{proof}
Direct numerical evaluation of the formula at $R_{Th} = 1.17$:
$\ln(23.25/16.85)/(2\pi \cdot 0.10 \cdot 1.17) \approx 0.25$
W/(m$\cdot$K), inside the recorded $\pm 0.01$ window; certified
interval/refinement arithmetic is the sorried proof body left to the
prover stage.
\end{proof}
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_4_C_7.md`
```markdown
ause only numerical values are manipulated downstream.
- `LumpedHeatFlowLaw` — Eq. (4) as relation on a given current.
- `RadialFourierConduction` — Eq. (6) + steady-state branch with real
  `deriv`; exposes eliminable content.
No scalar-placeholder aliases (no `abbrev Conductivity := ℝ`-style
shortcuts) were introduced.

## Grounding gaps / redraft requests

- PhysLean has no apparatus-calibration or uncertainty-band library —
  recorded in the iter-004 planner NOTE; local interval hypotheses used
  instead.
- Redraft requests (standing, upstream-owned): (1) sign convention in
  `acrylicConductivity_formula` (drive direction or positivity side
  conditions); (2) numeric inconsistency of the official sample inputs in
  `acrylicConductivity_officialSample` (≈ 0.438 vs 0.25 ± 0.01). Both are
  documented in-file with machine-checked refutation sketches; statement
  text is frozen for this stage and was left untouched per faithfulness
  rules.

## Note for the plan agent

The chapter is fully fleshed out (8 pinned environments, `\uses{}` wiring
intact); nothing to add. `\leanok` markers were intentionally left to the
sync phase per the role spec; all 8 environments are ready-markable.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_C_7.md`
```markdown
ysLean)
- `Derivation` (Mathlib)
- `Polynomial.derivation_C` (Mathlib)
- `Derivation.«termC^_⟮_,_;_⟯⟨_⟩»` (Mathlib)
- `Polynomial.C` (Mathlib)
- `spectralValue_X_sub_C` (Mathlib)
- `LinearPMap.state_uncertainty_squared_with_covariance_of_raw_commutator` (PhysLean)
- `Mathlib.Meta.FunProp.FunctionData.toExpr` (Mathlib)
- `Temperature.beta_fun_T_formula` (PhysLean)
- `Temperature.ofNNReal_val` (PhysLean)

## Local abstractions introduced

- `IPhO2026.Problem4.C7.CylindricalWallGeometry`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem4.C7.LumpedHeatFlowLaw`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem4.C7.RadialFourierConduction`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem4.C7.ThermalExperimentData`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```
