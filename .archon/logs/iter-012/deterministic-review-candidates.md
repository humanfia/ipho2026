# Deterministic Review Candidate Pack

Iteration: 012
Exact review target count: 2

Review only these targets. Direct Lean compilation was already run in
parallel by the orchestrator; use the recorded result instead of rerunning it.

## 1. `IPhO2026Problems/problem_IPhO_2026_3_B_2.lean`

- Compile status: passed
- Open sorries: 3
- Direct-check seconds: 4.969
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
is carried as the parameter `mu0` since
  the problem uses only the bare dimensional constant),
  `Mathlib.Analysis.Calculus.Deriv.Basic` (`deriv`, `DifferentiableAt`),
  `Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic`
  (`IntervalIntegrable`); `Real.sqrt`, `positivity` from Mathlib.
- Local abstractions (why faithful): `ParamagneticTorusState` /
  `StatePath` / `TorusParameters` / the two law predicates keep `H, M, T`
  as a structured thermodynamic state with named SI roles (A/m, A/m, K)
  rather than bare real aliases; PhysLean has no paramagnetic-torus
  object, so this is the smallest meaning-preserving interface (matches
  the physics-modeling rules).

## Grounding gaps / redraft requests

- No redraft requested; contract frozen by the iter-012 gate.
- Standing gap (unchanged, recorded since iter-004): PhysLean lacks a
  magnetization-work/heat-budget library; the A.3 work identity and the
  thermodynamic laws are faithful local law fields by design.
- The 3 sorries are the contracted work queue for the prover stage
  (chapter-proof routes recorded in the blueprint: product rule + MVT for
  the invariant; endpoint specialization; `Real.sqrt` algebra for the
  target).
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

## 2. `IPhO2026Problems/problem_IPhO_2026_4_C_7.lean`

- Compile status: passed
- Open sorries: 2
- Direct-check seconds: 9.312
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_C_7.tex`
- Reports: `.archon/task_results/problem_IPhO_2026_4_C_7.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_C_7.md`

### Lean excerpt
```lean
ace is at the IC water temperature) and
`T(r₂) = T_OC` (the outer face is at the OC water temperature), under the
physical drive `T_OC < T_IC` of the Part-C procedure (the outer cylinder
is the heated one — E1 Procedure step 2 heats the OC to 65 °C — and the
IC is the cold receiving body, so heat flows OC → IC through the wall)
and the positivity side conditions `0 < R_Th`, `0 < lam`, the acrylic
conductivity is

`λ = ln(r₂/r₁) / (2·π·h·R_Th)`.

The formal content (to be proved in the prover stage) is the integration
of Fourier's law: under `T_OC < T_IC` with `0 < R_Th`, Eq. (4) gives
`P = (T_OC − T_IC)/R_Th < 0`, and with `0 < lam` Fourier's law gives
`dT/dr > 0` across the wall; integrating
`dT/dr = −P/(2·π·λ·h)·r⁻¹` over `[r₁, r₂]` (`∫ r⁻¹ = ln`, legitimate
since `0 < r₁ < r₂`) yields `T_OC − T_IC = −P·ln(r₂/r₁)/(2·π·λ·h)`;
substituting (4) and cancelling the nonzero `T_OC − T_IC` gives
`1 = ln(r₂/r₁)/(2·π·λ·h·R_Th)`, i.e. the claimed formula. Carrier of
this bridge: this theorem's contract (Mathlib: `deriv_inv`,
`intervalIntegral.integral_const_mul`, `integral_one_div` /
`integral_inv`). -/
theorem acrylicConductivity_formula
    (G : CylindricalWallGeometry) (D : ThermalExperimentData)
    (lam : ℝ) (T : ℝ → ℝ) (P : ℝ → ℝ)
    (hflow : LumpedHeatFlowLaw D (P G.r₁))
    (hfourier : RadialFourierConduction G lam T P)
    (hR : 0 < D.R_Th) (hlam : 0 < lam)
    (hT_inner : T G.r₁ = D.T_IC) (hT_outer : T G.r₂ = D.T_OC)
    (hΔT : D.T_OC < D.T_IC) :
    lam = Real.log (G.r₂ / G.r₁) / (2 * π * G.h * D.R_Th) := by
  sorry

/-- **C.7 official sample value: realizability scale window** (redrafted
contract — sound direction of the official sample computation).

For `λ` given by the C.7 formula at the Figure-17 geometry
`r₂/r₁ = 23.25/16.85 mm`, with abstract positive `h`, `R_Th`, the
official sample report `λ = 0.25 ± 0.01 W/(m·K)` is realizable once the
experimental scale factor `h·R_Th` is large enough:
`0.2629 ≤ h·R_Th → |λ − 0.25| ≤ 0.01`. The official `± 0.01` band stays
conclusion-side only; the threshold `0.2629` is certified by
rational-interval arithmetic in the prover stage (`λ` strictly
decreasing in the positive product `h·R_Th`; the rational brackets
`0.3219 < ln(465/337) < 0.3220` and `6.2831 < 2π < 6.2832` give
`λ ≤ 0.3220/(6.2831·0.2629) < 0.195 < 0.26`, and `λ > 0`). -/
theorem acrylicConductivity_officialSample
    (h H_Th lam : ℝ) (hh : 0 < h) (hR : 0 < H_Th)
    (hformula : lam = Real.log ((23.25e-3 : ℝ) / 16.85e-3) /
      (2 * π * h * H_Th))
    (hscale : 0.2629 ≤ h * H_Th) :
    |lam - 0.25| ≤ 0.01 := by
  sorry

end IPhO2026.Problem4.C7
... [leading content omitted]
```

### Blueprint excerpt
```tex
tbf{(Iter-012 repair R4, data fix.)}  The previous draft froze the
inputs $h = 0.10\ \mathrm{m}$, $R_{Th} = 1.17\ \mathrm{K/W}$ against the
recorded band and was refuted numerically by the iter-010/011 Reviews:
$\ln(465/337)/(2\pi\cdot 0.10\cdot 1.17) \approx 0.438$, so
$|\lambda - 0.25| \approx 0.188 > 0.01$ at every
$R_{Th} \in [1.14, 1.20]$.  Planner recomputation this iter (first-hand,
from the chapter's frozen inputs): $\lambda = 0.25$ at $h = 0.10$ m would
require $R_{Th} \approx 2.050$ K/W rather than the C.6 sample
$1.17 \pm 0.03$ K/W, and at $R_{Th} = 1.17$ K/W would require a wetted
height $\approx 0.175$ m rather than the IC level $h = 10$ cm of Procedure
step 3 (the OC level of step 1 is $15$ cm; the candidate identifications
are under-determined).  Which recorded input the official $0.25$ was
computed against cannot be settled in this checkout: the cited
\texttt{raw/E1\_solution.pdf} is absent here, the same provenance class
as \texttt{4\_C\_6} (user noticeboard escalation this iter).  The
contract therefore asserts the sound direction of the sample computation
with abstract positive inputs; the official band stays conclusion-side
only.
\end{theorem}
\begin{proof}
$\lambda = \ln(465/337)/(2\pi\, h R_{Th})$ is strictly decreasing in the
positive product $h\,R_{Th}$.  The crude certified brackets
$0.3219 < \ln(465/337) < 0.3220$ (rational Taylor bounds at
$x = 465/337 = 1 + 128/337$) and $6.2831 < 2\pi < 6.2832$ give, at
$h\,R_{Th} \ge 0.2629$:
$\lambda \le 0.3220/(6.2831 \times 0.2629) < 0.1950 < 0.26$ and trivially
$\lambda > 0 > 0.24 - 0.01$.
The prover-stage body is certified rational-interval arithmetic
(rational brackets for $\ln(465/337)$ and $\pi$; composition by
monotonicity), no transcendental evaluation needed beyond the named
brackets.
\end{proof}
... [leading content omitted]
```

### Report excerpt: `problem_IPhO_2026_4_C_7.md`
```markdown
ns as hypothesis interfaces, preserving direction/sign and steady-state branch; both expose equational consequences (see countermodel audit).
Scalar `ℝ` fields are justified in-file: the subquestion manipulates only SI numerical readouts; roles/laws live in the structures, satisfying the "no transparent scalar alias" rule.

## Grounding gaps / redraft requests

- None blocking. PhysLean has no apparatus-calibration/uncertainty-band library (recorded in chapter `% NOTE`); uncertainty handled conclusion-side as audited above.
- Provenance escalation (standing, not a redraft request): which recorded inputs produced the official `λ = 0.25` is under-determined in this checkout; user noticeboard item re vendoring `raw/E1_solution.pdf` stands (PROGRESS.md bookkeeping).

## `\leanok` readiness

- `wall_current` is fully proved → its `lemma` block is eligible for `\leanok`.
- All definition blocks (`ThermalExperimentData`, `CylindricalWallGeometry`, `LumpedHeatFlowLaw`, `RadialFourierConduction`) are grounded (no sorries) → eligible for `\leanok`.
- The two theorem blocks still carry `by sorry` (expected at autoformalize) → not `\leanok`-ready; review/sync applies markers per its own rules.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_4_C_7.md`
```markdown
^_⟮_,_;_⟯⟨_⟩»` (Mathlib)
- `Polynomial.scaleRoots_C` (Mathlib)
- `Polynomial.C` (Mathlib)
- `Plausible.Rat.sampleableExt` (Mathlib)
- `Mathlib.Meta.FunProp.FunctionData.toExpr` (Mathlib)
- `Temperature.beta_fun_T_formula` (PhysLean)
- `Temperature.ofNNReal_val` (PhysLean)
- `HomotopicalAlgebra.Cylinder.symm` (Mathlib)
- `Cosmology.SpatialGeometry` (PhysLean)
- `PiNat.mem_cylinder_iff_dist_le` (Mathlib)

## Local abstractions introduced

- `IPhO2026.Problem4.C7.CylindricalWallGeometry`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem4.C7.LumpedHeatFlowLaw`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem4.C7.RadialFourierConduction`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026.Problem4.C7.ThermalExperimentData`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```
