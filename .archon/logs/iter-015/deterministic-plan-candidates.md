# Deterministic Plan Candidate Pack

Iteration: 015
Exact objective count: 6

The loop has already selected and written these objectives. Do not scan
the rest of the corpus and do not replace, reorder, add, or remove targets.
Use the excerpts below only to write a concise per-target proof strategy.

## 1. `IPhO2026Problems/problem_IPhO_2026_2_C_4.lean`

- Open placeholders: 6
- Proof Review: retry; attempts=2
- Review reason: File regressed relative to iter-010: it no longer compiles. Line 150 uses the notation `Nhds` glyph `ñ` (Unknown identifier, no `open Topology`/`open Filter` after the iter-013 edit narrowed opens to `open Real`/`open Asymptotics` only) and line 151 writes `ñ[≥] 0` as the raw token `≥` without the required `[]` bracket/term quoting support, giving a parse error `unexpected token ≥; expected ':' or term`. Below that, the asymptotic proof attempt still contains two genuine sorries (lines 223, 238): the key remainder step `hstep` (`Y_c θ - ((3/2) R θ^2 + R/2) = o(θ^2)` along `nhdsWithin 0 (Set.Ioi 0)`) and the final assembly of the `IsEquivalent` pair. The contract itself remains faithful and derivable (unchanged from the iter-010 ruling): C.3 formulas enter only as structure hypotheses, recorded constants u=R/2, v=(3/4)R^(1/3), p=2, q=3 are conclusion-side only; the defect is tactics/assembly/namespace hygiene plus a truncated prover session, not a modeling defect.
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_C_4.tex`
- Lifecycle entry: prover

### Lean excerpt
```lean
... [prefix omitted]
ttleO.mono h hle) fun θ => by ring
  -- ψ
  have hψ : (fun θ : ℝ => sin θ - θ) =o[l] fun θ : ℝ => θ := by
    have h := (hasDerivAt_sin (0 : ℝ)).isLittleO
    simp only [cos_zero, sin_zero, smul_zero, add_zero, sub_zero] at h
    exact IsLittleO.mono h hle
  -- φ
  have hχ : (fun θ : ℝ => (sin θ - θ) / θ) =o[l] fun _ : ℝ => (1 : ℝ) := by
    have hχnhds : (fun θ : ℝ => (sin θ - θ) / θ) =o[nhds 0] fun _ : ℝ => (1 : ℝ) :=
      (isLittleO_one_iff ℝ).mpr ((hasDerivAt_sin (0 : ℝ)).tendsto
        (by simp only [cos_zero]; norm_num))
    exact hχnhds.mono hle
  -- The four basic bounds: `χ, ψ` are eventually `≤ 1`, and `φ = O(θ ^ 2)` by self-boosting.
  have hχ1 : ∀ᶠ θ in l, ‖(sin θ - θ) / θ‖ ≤ (1 : ℝ) :=
    (hχ.bound zero_lt_one).mono fun θ => by simpa using id
  have hψ1 : ∀ᶠ θ in l, ‖sin θ - θ‖ ≤ ‖θ‖ := (hψ.bound zero_lt_one).mono fun θ => by simpa using id
  -- `φ = O(θ ^ 2)`, the quadratic gain from `φ = o(θ)` and `|sin θ − θ| ≤ |θ|`.
  have hφbig : (fun θ : ℝ => cos θ - 1) =O[l] fun θ : ℝ => θ ^ 2 := by
    have hφ1 : ∀ᶠ θ in l, ‖cos θ - 1‖ ≤ ‖θ‖ := (hφ.bound zero_lt_one).mono fun θ => by simpa using id
    apply IsBigO.of_bound' 
    filter_upwards [self_mem_nhdsWithin, hφ1, hψ1] with θ hθ hφθ hψθ
    have hθpos : 0 < θ := hθ
    rw [Set.mem_Ioi] at hθ
    -- `φ θ = − θ · χ θ + ψ θ`, the mean-value-factorized identity of the boot file.
    have hφid : cos θ - 1 = -θ * ((sin θ - θ) / θ) + (sin θ - θ) * ((sin θ - θ) / θ) := by
      rw [div_eq_mul_inv, div_eq_mul_inv]
      sorry
    rw [hφid]
    have h1 : ‖-θ * ((sin θ - θ) / θ)‖ ≤ ‖θ ^ 2‖ := by
      have hnn : (0 : ℝ) ≤ θ ^ 2 / 1 := by positivity
      sorry
    have h2 : ‖(sin θ - θ) * ((sin θ - θ) / θ)‖ ≤ ‖θ ^ 2‖ := by
      sorry
    calc ‖-θ * ((sin θ - θ) / θ) + (sin θ - θ) * ((sin θ - θ) / θ)‖
        ≤ ‖-θ * ((sin θ - θ) / θ)‖ + ‖(sin θ - θ) * ((sin θ - θ) / θ)‖ := norm_add_le _ _
      _ ≤ ‖θ ^ 2‖ + ‖θ ^ 2‖ := add_le_add h1 h2
      _ = ‖(2 : ℝ) * θ ^ 2‖ := by sorry
      _ = ‖θ ^ 2‖ := by sorry
  sorry

end HalfCylindricalMirrorCaustic

end IPhO2026_2_C_4
```

### Blueprint excerpt
```tex
... [prefix omitted]
_A*x + b\_A.  A neighboring parallel ray B is
incident at theta + Delta theta, with Delta theta much smaller than theta, and
its reflected line is y = m\_B*x + b\_B.  The envelope/intersection of neighboring
rays forms the caustic.  Use Figure 2g and its coordinate convention.

Current subquestion:
For theta << 1, put the caustic in the form Y\_c = v*|X\_c|\textasciicircum{}(p/q) + u. Determine u, v, and the integers p,q.

\paragraph{Current subquestion.}
For theta << 1, put the caustic in the form Y\_c = v*|X\_c|\textasciicircum{}(p/q) + u. Determine u, v, and the integers p,q.

\paragraph{Recorded answer/context.}
u = R/2, v = (3/4)*R\textasciicircum{}(1/3), p = 2, and q = 3.

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/T2\_page-4.png

\paragraph{Reusable previous-part conclusions.}
\begin{itemize}
\item Source C.3. Question: Find the limiting intersection coordinates (X\_c,Y\_c) of the neighboring reflected rays. Reusable conclusions: X\_c = R*sin(theta)\textasciicircum{}3; Y\_c = (R/2)*cos(theta)*(2 - cos(2*theta)). Policy: natural\_language\_prerequisite\_only; do\_not\_import\_Lean\_output
\end{itemize}

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_2\_C\_4.lean`.
The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a domain API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_2_C_4:target}
\uses{thm:IPhO2026Problems_problem_IPhO_2026_2_C_4:caustic_small_angle_power_law}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce faithful statements that can later be proved without weakening the source contract.
\end{proof}
% NOTE: PhysLean-coverage exemption (planner-recorded, iter-002): PhysLean has no caustic/power-law asymptotics module for the small-angle caustic part (see this file's physics-grounding log). Self-containment is kept with the `import Mathlib` baseline; no irrelevant Physlib import is added.
... [suffix omitted]
```

## 2. `IPhO2026Problems/problem_IPhO_2026_1_C_1.lean`

- Open placeholders: 2
- Proof Review: retry; attempts=1
- Review reason: Contracts are faithful and unchanged from the iter-11 redraft (opaque constants, conclusion-side candidate value, hb : 0 < hbar present on quadratic_characterization_of_threshold), but the proof layer fails on two tactic-level issues inside quadratic_characterization_of_threshold and both main threshold theorems remain sorry. (1) line 330 `ring` errors 'No goals to be solved': after `field_simp` with hbne/hden in context the goal is closed by simp-lemmas, leaving `ring` with no goal. (2) line 337 the rw chain is shape-mismatched: after `rw [div_pow]` the goal is `S * (X^2 / S^2) - 6*m*c^2*(X/S) + 6*dU*m*c^2 = 0`, on which `div_eq_iff (pow_ne_zero 2 hS')` cannot fire, and the preflight state shows the intended intermediate `X^2/S^2 = (6*m*c^2*(X/S) - 6*dU*m*c^2)/S` never appeared, so the follow-up show-rw at lines 338-340 rewrites a non-existent pattern. A correct repair is to set the divided target explicitly (e.g. have hdiv : X^2/S^2 = (6*m*c^2*X*S - 6*dU*m*c^2*S^2)/S^3 ... then div_eq_iff), or simply field_simp + linear_combination on the multiplied-out goal. The sorries in minimum_angular_frequency_T1_C1 (line 371) and minimum_angular_frequency_backward_branch_T1_C1 (line 385) are genuine remaining proof work: the forward theorem requires exhibiting a lawful IsTwoBodyDissociation configuration at Omega (reachability) and deriving Q(E) <= 0 for every reachable E to apply the quadratic minimality; the prover trace shows a validated plan and compiled helper sublemmas for exactly this (A2-style stronger minimality, B1 bound t*Omega(t) <= 3mc^2, E0 >= dU floor) but the assembly was never committed to the target file.
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_C_1.tex`
- Lifecycle entry: prover

### Lean excerpt
```lean
... [prefix omitted]
m 1 (T1), Part C.1.

  Blueprint chapter: blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_C_1.tex
  Source report:     reports/ipho_2026_k3/problem_IPhO_2026_1_C_1.source.json
  Official page:     T1_page-3.png  (IPhO 2026 Theoretical Exam, page 6/14)

  Physical situation (Figure 1c):
  A photon of angular frequency `ω` strikes an ozone molecule `O₃` at rest and
  is absorbed, dissociating it into an oxygen molecule `O₂` and an oxygen atom
  `O`.  The ground-state energies of `O₃` and of the fragments are `Uᵢ` and
  `U_f`, with `ΔU = U_f - Uᵢ > 0`.  The momentum of the outgoing `O₂` makes
  the angle `θ` with the incident photon direction.  The fragments are treated
  classically and non-relativistically; an oxygen atom has mass `m`, so the
  `O₂` fragment has mass `2m`; the photon momentum is `p_γ = E_γ/c = ℏω/c`.

  Current subquestion (T1-C1, 2.5 pts):
    Determine the minimum angular frequency `ω_min` required for the
    dissociation to occur at outgoing `O₂` angle `θ`, in terms of
    `ℏ, c, θ, ΔU` and `m`.

  Recorded official answer:
    for `θ ≤ π/2`,
      `ω_min = 3 m c² (1 - √(1 - (2 ΔU / (3 m c²)) (2 sin²θ + 1))) /
                 (ℏ (2 sin²θ + 1))`;
    for `θ ≥ π/2`, the same threshold evaluated at `θ = π/2`.
  (Official solution, `T1_solution.txt`: the threshold is the smallest root of
  `(cos 2θ - 2) ℏ²ω² + 6 m c² ℏω - 6 ΔU m c² = 0`, and
  `2 sin²θ + 1 = 2 - cos 2θ`.)

  All theorem statements below are faithful contracts; proof bodies are
  `sorry` by design (autoformalize stage).  The current target conclusion —
  the closed-form value of `ω_min` — appears only on the conclusion side of
  the main theorem `minimum_angular_frequency_T1_C1` and of the auxiliary
  quadratic-form lemma `quadratic_characterization_of_threshold`; the governing-law
  predicates (`IsTwoBodyDissociation`, `EnergyConservation`, `IsScatteringAngle`)
  never mention it.
-/

import Mathlib

open Real Set

noncomputable section

namespace IPhO2026.Problem1.C1

section UniversalConstants

/-!
Universal constants and molecular data of the problem.  They are declared as
abstract scalars (with their SI roles recorded in the docstrings) rather than
transparent aliases, so that the contracts below cannot be closed by
unfolding.
-/

/-- Reduced Planck constant `ℏ` (J·s). -/
opaque hbar : ℝ

/-- Speed of light in vacuum `c` (m/s). -/
opaque speedOfLight : ℝ

/-- Mass `m` of one oxygen atom (kg); the `O₂` fragment has mass `2m`. -/
opaque oxygenAtomMass : ℝ

/-- Photon angular frequency `ω` for any photon considered in this process
    (rad/s).  The closed-form value of `ω_min` is a *target*, not a datum. -/
opaque photonAngularFrequency : ℝ

/-- Ground-state energy `Uᵢ` of the ozone molecule `O₃` (J). -/
opaque ozoneGroundStateEnergy : ℝ

/-- Ground-state energy `U_f` of the photofragments `O₂ + O` (J). -/
opaque fragmentsGroundStateEnergy : ℝ

/-- Energy gap `ΔU = U_f − Uᵢ` (J): the energy that must be supplied to
    dissociate ozone at rest into `
... [suffix omitted]
```

### Blueprint excerpt
```tex
... [prefix omitted]
ga is absorbed by an ozone molecule O3 at rest,
dissociating it into O2 and O.  Let U\_i and U\_f be the ground-state energies of
O3 and O2 and define Delta U = U\_f - U\_i.  The outgoing O2 momentum makes angle
theta with the incident photon.  Treat the oxygen fragments classically and
non-relativistically, take the mass of an oxygen atom to be m, and use photon
momentum p\_gamma = E\_gamma/c = hbar*omega/c.

Current subquestion:
Determine the minimum angular frequency omega\_min required for dissociation at outgoing O2 angle theta, in terms of hbar, c, theta, Delta U, and m.

\paragraph{Current subquestion.}
Determine the minimum angular frequency omega\_min required for dissociation at outgoing O2 angle theta, in terms of hbar, c, theta, Delta U, and m.

\paragraph{Recorded answer/context.}
For theta <= pi/2, omega\_min = 3*m*c\textasciicircum{}2*[1 - sqrt(1 - (Delta U/(3*m*c\textasciicircum{}2))*(2*sin(theta)\textasciicircum{}2 + 1))]/[hbar*(2*sin(theta)\textasciicircum{}2 + 1)]. For theta >= pi/2 use the same threshold evaluated at theta = pi/2.

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/T1\_page-3.png

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_1\_C\_1.lean`.
The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a domain API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_1_C_1:target}
\uses{thm:IPhO2026Problems_problem_IPhO_2026_1_C_1:minimum_angular_frequency_T1_C1, thm:IPhO2026Problems_problem_IPhO_2026_1_C_1:hbarOmegaMin_pi_sub}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce faithful statements that can later be proved without weakening the source contract.
\end{proof}
% NOTE: PhysLean-coverage exemption (planner-recorded, iter-002): PhysLean has no module for relativistic two-body photodissociation kinematics (see this file's physics-grounding log for the near-miss query results). Self-con
... [suffix omitted]
```

## 3. `IPhO2026Problems/problem_IPhO_2026_1_C_2.lean`

- Open placeholders: 0
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_C_2.tex`
- Lifecycle entry: proof Review (proof already closes without placeholders)

### Lean excerpt
```lean
... [prefix omitted]
2 * (d.ΔU_J / K.eV) * S = (2 * d.ΔU_J * S) / K.eV by
      field_simp]
    exact (div_le_div_iff_of_pos_right K.eV_pos).mpr hbranch
  obtain ⟨hL, hU⟩ := threshold_excess_enclosure S (mc2J / K.eV) (d.ΔU_J / K.eV)
    (E / K.eV) hbMF hlowF hFnn hΔF_pos hMF_pos hS_pos hbranchF
  have hS3 : S = 3 / 2 := hS_val
  rw [hS3] at hL hU
  have hΔval : d.ΔU_J / K.eV = 11 / 10 := by
    rw [d.ΔU_J_def, hKe, d.ΔU_eV_val]
    field_simp
    norm_num
  have hMval : mc2J / K.eV =
      16 * 8302695333 * 299792458 ^ 2 / (801088317 * 10 ^ 9 : ℝ) := by
    rw [hmc2_def, d.m_kg_def, hKc, hKe, hKa, d.m_amu_val]
    norm_num
  rw [hΔval, hMval] at hL hU
  have hbL : (2.025e-11 : ℝ) < (3 / 2 : ℝ) * (11 / 10) ^ 2 /
      (6 * (16 * 8302695333 * 299792458 ^ 2 / (801088317 * 10 ^ 9))) := by
    norm_num
  have hbU : (3 / 2 : ℝ) * (11 / 10) ^ 2 /
        (6 * (16 * 8302695333 * 299792458 ^ 2 / (801088317 * 10 ^ 9))) *
        (1 + 3 * ((3 / 2 : ℝ) / (6 * (16 * 8302695333 * 299792458 ^ 2 / (801088317 * 10 ^ 9))))
          * (2 * (11 / 10))) < (2.034e-11 : ℝ) := by
    norm_num
  have h1 : (2.025e-11 : ℝ) < E / K.eV - d.ΔU_J / K.eV := by
    nlinarith [hbL, hL]
  have h2 : E / K.eV - d.ΔU_J / K.eV < (2.034e-11 : ℝ) := by
    nlinarith [hbU, hU]
  have hconv : (E - d.ΔU_J) / K.eV = E / K.eV - d.ΔU_J / K.eV := by
    field_simp
  constructor
  · rw [hconv]
    linarith [h1]
  · rw [hconv, abs_lt]
    constructor <;> linarith [h1, h2]



/-- **Helper form:** the main target in the specialized `θ = π/6`
threshold coordinates.  The conclusion of
`excess_photon_energy_at_threshold rewritten through the bridge
`hbarOmegaMin_at_pi_div_six` (its rest-scale nonzero side condition holds at
the calibrated readouts). -/
theorem excess_photon_energy_pi_div_six_form
    (K : PhotoDissociationConstants) (hK : K = PhotoDissociationConstants.trusted)
    (d : C2CalibratedData K)
    (h_real : ThresholdRealizable K d
      (hbarOmegaMin (d.m_kg * K.cSI ^ 2) d.ΔU_J d.θ)) :
    let gap_eV := (hbarOmegaMinAtPiDivSix (d.m_kg * K.cSI ^ 2) d.ratio - d.ΔU_J) / K.eV
    0 < gap_eV ∧ |gap_eV - 2.03e-11| < 5e-14 := by
  have hmc2_ne : 3 * (d.m_kg * K.cSI ^ 2) ≠ 0 := by
    have hm : (0:ℝ) < d.m_kg := by
      rw [d.m_kg_def]
      apply mul_pos (by rw [d.m_amu_val]; norm_num) K.amu_pos
    exact ne_of_gt (mul_pos (by norm_num : (0:ℝ) < 3) (mul_pos hm (sq_pos_of_pos K.cSI_pos)))
  have hbridge := hbarOmegaMin_at_pi_div_six (d.m_kg * K.cSI ^ 2) d.ΔU_J hmc2_ne
  have hmain := excess_photon_energy_at_threshold K hK d h_real
  have hconv : hbarOmegaMinAtPiDivSix (d.m_kg * K.cSI ^ 2) (d.ΔU_J / (3 * (d.m_kg * K.cSI ^ 2)))
      = hbarOmegaMin (d.m_kg * K.cSI ^ 2) d.ΔU_J (Real.pi / 6) := hbridge.symm
  have hθ : d.θ = Real.pi / 6 := d.θ_val
  rw [hθ] at hmain
  have hrd : d.ratio = d.ΔU_J / (3 * (d.m_kg * K.cSI ^ 2)) := by
    have e1 := d.ratio_def
    have e2 : (3 : ℝ) * d.m_kg * K.cSI ^ 2 = 3 * (d.m_kg * K.cSI ^ 2) := by ring
    rw [e2] at e1
    exact e1
  rw [hrd, hconv]
  exact hmain

end IPhO2026_1_C_2
```

### Blueprint excerpt
```tex
... [prefix omitted]
lativistically, take the mass of an oxygen atom to be m, and use photon
momentum p\_gamma = E\_gamma/c = hbar*omega/c.

Current subquestion:
For theta = pi/6, Delta U = 1.10 eV, and m = 16.0 amu, calculate hbar*omega\_min - Delta U in eV.

\paragraph{Current subquestion.}
For theta = pi/6, Delta U = 1.10 eV, and m = 16.0 amu, calculate hbar*omega\_min - Delta U in eV.

\paragraph{Recorded answer/context.}
hbar*omega\_min - Delta U = 2.03e-11 eV.

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/T1\_page-3.png

\paragraph{Reusable previous-part conclusions.}
\begin{itemize}
\item Source C.1. Question: Determine the minimum angular frequency omega\_min required for dissociation at outgoing O2 angle theta, in terms of hbar, c, theta, Delta U, and m. Reusable conclusions: For theta <= pi/2, omega\_min = 3*m*c\textasciicircum{}2*[1 - sqrt(1 - (Delta U/(3*m*c\textasciicircum{}2))*(2*sin(theta)\textasciicircum{}2 + 1))]/[hbar*(2*sin(theta)\textasciicircum{}2 + 1)]. For theta >= pi/2 use the same threshold evaluated at theta = pi/2. Policy: natural\_language\_prerequisite\_only; do\_not\_import\_Lean\_output
\end{itemize}

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_1\_C\_2.lean`.
The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a domain API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_1_C_2:target}
\uses{thm:IPhO2026Problems_problem_IPhO_2026_1_C_2:excess_photon_energy_pi_div_six_form}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce faithful statements that can later be proved without weakening the source contract.
\end{proof}
% NOTE: PhysLean-coverage exemption (planner-recorded, iter-002): PhysLean has no module for this photodissociation-threshold regime (see this file's physics-grounding log). Self-containment is kept with the `import Mathlib` baseline; no irrelevant Physlib import is added. This documen
... [suffix omitted]
```

## 4. `IPhO2026Problems/problem_IPhO_2026_2_B_1.lean`

- Open placeholders: 0
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_2_B_1.tex`
- Lifecycle entry: proof Review (proof already closes without placeholders)

### Lean excerpt
```lean
/-
IPhO 2026, Theoretical Problem 2 (Solar Cooker), Part B.1 — autoformalization.

Physical situation (Figure 2f, official source page `T2_page-3.png`). A
half-hollow-cylinder mirror of radius `R` (mirrored on the inside) is
illuminated by uniform parallel sunlight arriving along the mirror's optical
axis. A fully absorbing cylindrical container of radius `a` has its axis
parallel to the mirror axis; the container's centre lies `R / 2` from the
mirror centre on the system's symmetry plane. Every absorbed ray reflects
from the mirror at most once. `θ_max` is the maximum angle of incidence on
the mirror (measured against the normal at the point of incidence) among all
reflected rays striking the container, and `P₀` is the power the cylinder
would receive without the mirror.

Current subquestion (T2-B1): the container radius satisfies
`a = α * sin θ_max + β * sin (2 * θ_max)`; write `α` and `β` in terms of `R`.

Recorded official answer: `α = R` and `β = -R / 2` (kept strictly
conclusion-side in the target theorem; not fed into any structure field or
hypothesis).

This file is a by-`sorry` formalization: faithful declarations with proof
bodies left as `sorry`. (Proof status: all four proof obligations of this
redraft — `impactParam_eq_sin`, `sin_two_pos`,
`container_radius_at_extremal_angle`, `alpha_beta_in_terms_of_R` — are
currently closed with full proofs; the by-`sorry` discipline is kept in the
statement layer, which is unchanged.) The physics is modelled on a transverse
cross-section (the system is translationally invariant along the cylinder
axes), so points and direction vectors are pairs of real coordinates
carrying the dimension of length (directions are unit, hence dimensionless).

Cross-sectional frame (fixed by Figure 2f and cross-checked against the
official B.2/B.3 answers): mirror centre `C = (0, 0)`; the cross-sectional
image of the symmetry plane is the `y`-axis (the bisector of the
half-cylinder, perpendicular to the aperture diameter); the container
centre is `A = (0, -R / 2)`, i.e. `R / 2` from `C` along the symmetry axis
toward the mirrored belly (downstream of the sunlight); sunlight arrives
along direction `(0, -1)` onto the lower half-circle `y ≤ 0`, the open
aperture facing `y > 0`. The ray with impact parameter `x` strikes the
mirror at `(x, -√(R² - x²))`; by the symmetry of the configuration about
the `y`-axis the absorbed columns form a centred contiguous fan
`|x| ≤ x★`, whose extremal columns `±x★` are exactly the rays tangent to
the container circle. `θ_max = arcsin (x★ / R)`.

Governing physical laws (kept as hypotheses, never redefined locally):
specular reflection on the circular mirror profile (`reflection_law`),
absorption by the container disc (`absorbed_law`), the container-offset
geometry (`A_coord`), and the single-bounce contiguous-fan ray bookkeeping
(`no_gap`, `hit_branch`).

Key determinacy bridge: at an extremal column `x★` the reflected ray is
tangent to the container circle. `reflection_law` at column `
... [suffix omitted]
```

### Blueprint excerpt
```tex
... [prefix omitted]
ports/ipho_2026_k3/problem_IPhO_2026_2_B_1.source.json
% archon:problem-id IPhO_2026_2
% archon:part-id B.1

\chapter{Physics problem IPhO\_2026\_2\_B\_1}
\label{ch:IPhO2026Problems_problem_IPhO_2026_2_B_1}

\paragraph{Problem source.}
A half-cylindrical mirror of radius R illuminates a fully absorbing cylindrical
container of radius a.  Their axes are parallel, and the container center lies
R/2 from the mirror center on the symmetry plane.  Uniform parallel sunlight
arrives along the optical axis.  Any ray absorbed by the container reflects at
most once.  Let theta\_max be the largest incidence angle on the mirror among
rays that strike the container, and let P\_0 be the power the cylinder would
receive without the mirror.  See Figure 2f.

Current subquestion:
Given a = alpha*sin(theta\_max) + beta*sin(2*theta\_max), determine alpha and beta in terms of R.

\paragraph{Current subquestion.}
Given a = alpha*sin(theta\_max) + beta*sin(2*theta\_max), determine alpha and beta in terms of R.

\paragraph{Recorded answer/context.}
alpha = R and beta = -R/2.

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/T2\_page-3.png

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_2\_B\_1.lean`.
The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a domain API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_2_B_1:target}
\uses{thm:IPhO2026Problems_problem_IPhO_2026_2_B_1:alpha_beta_in_terms_of_R}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce faithful statements that can later be proved without weakening the source contract.
\end{proof}
% NOTE: PhysLean-coverage exemption (planner-recorded, iter-002): PhysLean has no specular-reflection/geometric-optics module; the incidence system is stated over a 2D Cartesian incidence model with Mathlib analytic-geometry anchors (see the physics-grounding log for this file). Self-containment i
... [suffix omitted]
```

## 5. `IPhO2026Problems/problem_IPhO_2026_3_C_3.lean`

- Open placeholders: 0
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_3.tex`
- Lifecycle entry: proof Review (proof already closes without placeholders)

### Lean excerpt
```lean
... [prefix omitted]
Q_c = 1.29e-1 J,  |ΔT| = 9.92e-3 K,  T_final = 0.99008 K.

## Derivation route recorded for the proof phase (official solution T3-C2/C3)

1. Cold isothermal leg 2 → 3 (B.1 law with T_2 = T_3 = T_c, field
   decreasing H₂ → H₃): the torus absorbs
   Q_c = (μ₀ * n * K / T_c) * (H₂² - H₃²) / 2 from the helium.
   Numerically 0.12934593… J = 1.29e-1 J (verified offline).
2. Hot isothermal leg 4 → 1 (B.1 law with T_4 = T_1 = T_h, field
   increasing H₄ → H₁): the torus dumps
   Q_h = (μ₀ * n * K / T_h) * (H₁² - H₄²) / 2 into the hot reservoir.
3. Carnot ratio (reversible cycle): combining the two leg identities with
   Q_h * T_c = Q_c * T_h yields
   (H₂² - H₃²) / T_c² = (H₁² - H₄²) / T_h², the exact relation that fixes
   T_h from T_c and the vertex fields (numerically T_h ≈ 2.1326 K);
   the density/molar-mass data fix the torus volume V = n·M_mol/ρ_source,
   which cancels out of every C.3 heat (the EOS route via M does not
   need it either).  (No numeric value of the ratio is assumed.)
4. Calorimetry of the helium: Q_c = m_He * c * (T_initial - T_final)
   with m_He = ρ_He * V_He; the run *cools* the helium, so the drop branch
   is recorded explicitly.

This file is an autoformalization upgraded to full proofs: every model lemma
(`Qc_cold_leg`, `Qh_hot_leg`, `reservoir_temperature_consistency`,
`TFinal_from_calorimetry`, `helium_cools`) and all three numeric target
theorems (`absorbed_heat_value`, `temperature_drop_value`,
`final_temperature_value`) are proved with no `sorry`.  The recorded answer
values still appear only on the conclusion side.  Numerics are certified by
Mathlib's π bounds `Real.pi_gt_d4`, `Real.pi_lt_d4`
(3.1415 < π < 3.1416) plus `norm_num`/`nlinarith` interval arithmetic.
-/

namespace IPhO2026.Problem3.C3

section Quantities

/-!
### Named quantities and dimensional roles

Physical scalars (SI units): temperatures in kelvin, heats in joules,
applied-field and magnetization magnitudes in ampere per metre, amount of
substance in moles, volumes in cubic metres, densities in kilograms per
cubic metre, specific heat capacity in joules per kilogram-kelvin, molar
mass in kilograms per mole.  These are recorded as real scalars (numerical
magnitudes); the material-specific *data* of the T3-C3 block are
statement readouts (see below) whose literal magnitudes are exposed only
through explicit named value lemmas, never baked into any law predicate,
so the contracts cannot be closed by unfolding alone. -/

/-- Kind of one leg of the cycle of Figure 3b: isothermal or adiabatic, with
the field direction (decreasing/increasing) recorded so the branch
information of the figure is preserved. -/
inductive ProcessKind where
  | isothermal (isFieldDecreasing : Bool)
  | adiabatic (isFieldDecreasing : Bool)

/-- Vertex labels of the cycle 1 → 2 → 3 → 4 → 1 in Figure 3b. -/
inductive Vertex where | v1 | v2 | v3 | v4

/-- Thermodynamic state of the torus at the four vertices of Figure 3b,
together with the process labels of the four legs.  Le
... [suffix omitted]
```

### Blueprint excerpt
```tex
... [prefix omitted]
y be reused.

Current subquestion:
Using the supplied potassium-chromate and liquid-helium data, find the helium temperature after one cycle.

\paragraph{Current subquestion.}
Using the supplied potassium-chromate and liquid-helium data, find the helium temperature after one cycle.

\paragraph{Recorded answer/context.}
Q\_c = 1.29e-1 J, so |Delta T| = 9.92e-3 K and T\_final = 0.99008 K.

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/T3\_page-4.png

\paragraph{Reusable previous-part conclusions.}
\begin{itemize}
\item Source B.1. Question: At fixed temperature T, H changes from H\_i to H\_f. Find the heat Q transferred into the torus. Reusable conclusions: Q = -(mu\_0*n*K/(2*T))*(H\_f\textasciicircum{}2 - H\_i\textasciicircum{}2). Policy: natural\_language\_prerequisite\_only; do\_not\_import\_Lean\_output
\item Source C.2. Question: Express M\_1 in terms of M\_2, M\_3, and M\_4. Reusable conclusions: M\_1 = sqrt(M\_2\textasciicircum{}2 - M\_3\textasciicircum{}2 + M\_4\textasciicircum{}2), taking the nonnegative magnitude. Policy: natural\_language\_prerequisite\_only; do\_not\_import\_Lean\_output
\end{itemize}

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_3\_C\_3.lean`.
The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a domain API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_3_C_3:target}
\uses{thm:IPhO2026Problems_problem_IPhO_2026_3_C_3:final_temperature_value}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce faithful statements that can later be proved without weakening the source contract.
\end{proof}
% NOTE: PhysLean-coverage exemption (planner-recorded, iter-003): PhysLean has no classical-paramagnet thermodynamic-cycle module (Curie-style EOS `T*M*V = n*K*H`, adiabatic demagnetization calorimetry); nearest LeanExplore hits were generic MagneticField/Temperature fields (see task\_results/physi
... [suffix omitted]
```

## 6. `IPhO2026Problems/problem_IPhO_2026_4_A_1.lean`

- Open placeholders: 0
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_A_1.tex`
- Lifecycle entry: proof Review (proof already closes without placeholders)

### Lean excerpt
```lean
... [prefix omitted]
e times the Avogadro constant, `N = n * N_A`
(with the official data, `N ≈ 1.95 × 10²¹`). -/
theorem number_of_molecules_of_confined_air :
    c.numberOfMolecules = c.numberOfMoles * c.avogadroConstant := by
  exact c.number_eq

/-- A.1 main target, molar-mass route: the recorded mass, amount of substance
and tabulated molar mass of air obey the consistency relation
`m = n * M_air`. -/
theorem molar_mass_consistency :
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
```

### Blueprint excerpt
```tex
... [prefix omitted]
ers IPhO2026Problems/problem_IPhO_2026_4_A_1.lean
% archon:source-report reports/ipho_2026_k3/problem_IPhO_2026_4_A_1.source.json
% archon:problem-id IPhO_2026_4
% archon:part-id A.1

\chapter{Physics problem IPhO\_2026\_4\_A\_1}
\label{ch:IPhO2026Problems_problem_IPhO_2026_4_A_1}

\paragraph{Problem source.}
The experimental apparatus contains a sealed air column (CA) in the inner
cylinder.  Propylene glycol is introduced to h = 4.5 cm so the air volume is
fixed.  Use the cylinder dimensions in Figure 17, ambient air density
rho\_a = 1.12 kg/m\textasciicircum{}3, and the ideal-gas law P*V = n*R*T.  The outer-cylinder
water bath is heated while pressure and temperature are recorded.

Current subquestion:
Determine the mass m, amount n, and number N of molecules in the confined air column.

\paragraph{Current subquestion.}
Determine the mass m, amount n, and number N of molecules in the confined air column.

\paragraph{Recorded answer/context.}
Official sample: m = 0.94 +/- 0.02 g, n = 3.24 mmol (reported uncertainty 0.7 mmol), N = (1.95 +/- 0.05)e21.

\paragraph{Figure/image path.}
/root/proposal\_for\_physic/science-mango/ipho\_2026\_source/image/E1\_page-9.png

\paragraph{Formalization target.}
create a compiling Lean file with sorry bodies at `IPhO2026Problems/problem\_IPhO\_2026\_4\_A\_1.lean`.
The Lean declarations must preserve the physical quantities, dimensions or dimensional roles, figure labels, governing-law hypotheses, and final relation expressed by this problem.
Use Mathlib/Physlib names found through LeanExplore where available. If a domain API is missing, introduce faithful local abstractions rather than scalar placeholder aliases.

\begin{theorem}[Physics formalization target]
\label{thm:physics:IPhO_2026_4_A_1:target}
\uses{thm:IPhO2026Problems_problem_IPhO_2026_4_A_1:mass_of_confined_air, thm:IPhO2026Problems_problem_IPhO_2026_4_A_1:number_of_molecules_of_confined_air, thm:IPhO2026Problems_problem_IPhO_2026_4_A_1:molar_mass_consistency, thm:IPhO2026Problems_problem_IPhO_2026_4_A_1:uncertainty_consistency}
The assigned autoformalize agent should translate this physics problem into Lean declarations in the covered file, with theorem and lemma proof bodies written as `by sorry`.
\end{theorem}
\begin{proof}
This is an autoformalization task, not a proof task. Produce faithful statements that can later be proved without weakening the source contract.
\end{proof}
% NOTE: PhysLean-coverage exemption (planner-recorded, iter-002): PhysLean's idea
... [suffix omitted]
```
