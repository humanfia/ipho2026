# Parallel Lean Review Preflight

- Iteration: 013
- Jobs: 13
- Duration: 18.794s
- Result: 7 passed / 6 failed

| Target | Compile | Sorries | Seconds |
| --- | ---: | ---: | ---: |
| `IPhO2026Problems/problem_IPhO_2026_1_A_1.lean` | passed | 0 | 14.083 |

## `IPhO2026Problems/problem_IPhO_2026_1_A_1.lean` diagnostics
```text
IPhO2026Problems/problem_IPhO_2026_1_A_1.lean:325:36: warning: Variable name `hp` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
IPhO2026Problems/problem_IPhO_2026_1_A_1.lean:325:52: warning: Variable name `ha` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
IPhO2026Problems/problem_IPhO_2026_1_A_1.lean:326:5: warning: Variable name `hΔ` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
IPhO2026Problems/problem_IPhO_2026_1_A_1.lean:326:23: warning: Variable name `hg` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
IPhO2026Problems/problem_IPhO_2026_1_A_1.lean:414:23: warning: Variable name `hp` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
IPhO2026Problems/problem_IPhO_2026_1_A_1.lean:414:39: warning: Variable name `ha` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
IPhO2026Problems/problem_IPhO_2026_1_A_1.lean:414:52: warning: Variable name `hg` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
IPhO2026Problems/problem_IPhO_2026_1_A_1.lean:484:31: warning: Variable name `S` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
```
| `IPhO2026Problems/problem_IPhO_2026_1_B_2.lean` | failed | 4 | 18.772 |

## `IPhO2026Problems/problem_IPhO_2026_1_B_2.lean` diagnostics
```text
IPhO2026Problems/problem_IPhO_2026_1_B_2.lean:336:5: warning: Variable name `hμ` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
IPhO2026Problems/problem_IPhO_2026_1_B_2.lean:402:5: warning: Variable name `hμ` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
IPhO2026Problems/problem_IPhO_2026_1_B_2.lean:493:8: warning: declaration uses `sorry`
IPhO2026Problems/problem_IPhO_2026_1_B_2.lean:544:8: warning: declaration uses `sorry`
IPhO2026Problems/problem_IPhO_2026_1_B_2.lean:574:8: warning: declaration uses `sorry`
IPhO2026Problems/problem_IPhO_2026_1_B_2.lean:794:5: warning: Variable name `hu` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
IPhO2026Problems/problem_IPhO_2026_1_B_2.lean:795:5: warning: Variable name `hbranch` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
IPhO2026Problems/problem_IPhO_2026_1_B_2.lean:884:53: error: unsolved goals
hR : ScalingRegime
S : CoulombScatteringData hR
hμ : IsAngularMomentumFactor unboundMu
u : RelativeVelocityVector
hu : IsAsymptoticRelativeVelocity S u
left✝ : ‖u.vec‖ = √(2 * S.total_energy / S.reduced_mass)
hform : angleBetween (initialDirection S) u.vec = arctan (1 / √(S.eccentricitySq - 1))
hE : S.eccentricitySq = 49 / 4
hs45 : √(S.eccentricitySq - 1) = √45 / 2
hangle : angleBetween (initialDirection S) u.vec = arctan (2 / √45)
hA_pos : 0 < arctan (2 / √45)
hz : perp (initialDirection S) u.vec = 0
ha_ne : initialDirection S ≠ 0
hu_ne : u.vec ≠ 0
ha_norm : 0 < ‖initialDirection S‖
hu_norm : 0 < ‖u.vec‖
⊢ ‖(initialDirection S).ofLp 0‖ ^ 2 + ‖(initialDirection S).ofLp 1‖ ^ 2 =
    (initialDirection S).ofLp 0 ^ 2 + (initialDirection S).ofLp 1 ^ 2
IPhO2026Problems/problem_IPhO_2026_1_B_2.lean:886:67: error: unsolved goals
hR : ScalingRegime
S : CoulombScatteringData hR
hμ : IsAngularMomentumFactor unboundMu
u : RelativeVelocityVector
hu : IsAsymptoticRelativeVelocity S u
left✝ : ‖u.vec‖ = √(2 * S.total_energy / S.reduced_mass)
hform : angleBetween (initialDirection S) u.vec = arctan (1 / √(S.eccentricitySq - 1))
hE : S.eccentricitySq = 49 / 4
hs45 : √(S.eccentricitySq - 1) = √45 / 2
hangle : angleBetween (initialDirection S) u.vec = arctan (2 / √45)
hA_pos : 0 < arctan (2 / √45)
hz : perp (initialDirection S) u.vec = 0
ha_ne : initialDirection S ≠ 0
hu_ne : u.vec ≠ 0
ha_norm : 0 < ‖initialDirection S‖
hu_norm : 0 < ‖u.vec‖
hu0s : ‖initialDirection S‖ ^ 2 = (initialDirection S).ofLp 0 ^ 2 + (initialDirection S).ofLp 1 ^ 2
⊢ ‖u.vec.ofLp 0‖ ^ 2 + ‖u.vec.ofLp 1‖ ^ 2 = u.vec.ofLp 0 ^ 2 + u.vec.ofLp 1 ^ 2
IPhO2026Problems/problem_IPhO_2026_1_B_2.lean:901:21: error: Tactic `rewrite` failed: Did not find an occurrence of the pattern in the current goal

hR : ScalingRegime
S : CoulombScatteringData hR
hμ : IsAngularMomentumFactor unboundMu
u : RelativeVelocityVector
hu : IsAsymptoticRelativeVelocity S u
left✝ : ‖u.vec‖ = √(2 * S.total_energy / S.reduced_mass)
hform : angleBetween (initialDirection S) u.vec = arctan (1 / √(S.eccentricitySq - 1))
hE : S.eccentricitySq = 49 / 4
hs45 : √(S.eccentricitySq - 1) = √45 / 2
hangle : angleBetween (initialDirection S) u.vec = arctan (2 / √45)
hA_pos : 0 < arctan (2 / √45)
hz : perp (initialDirection S) u.vec = 0
ha_ne : initialDirection S ≠ 0
hu_ne : u.vec ≠ 0
ha_norm : 0 < ‖initialDirection S‖
hu_norm : 0 < ‖u.vec‖
hL : dot (initialDirection S) u.vec ^ 2 = ‖initialDirection S‖ ^ 2 * ‖u.vec‖ ^ 2
⊢ dot (initialDirection S) u.vec ^ 2 / (‖initialDirection S‖ * ‖u.vec‖) ^ 2 = 1
```
| `IPhO2026Problems/problem_IPhO_2026_1_C_1.lean` | failed | 2 | 15.983 |

## `IPhO2026Problems/problem_IPhO_2026_1_C_1.lean` diagnostics
```text
IPhO2026Problems/problem_IPhO_2026_1_C_1.lean:330:4: error: No goals to be solved
IPhO2026Problems/problem_IPhO_2026_1_C_1.lean:337:17: error: Tactic `rewrite` failed: Did not find an occurrence of the pattern
  ?m.1339 / S ^ 2 = ?m.1341
in the target expression
  S * (X ^ 2 / S ^ 2) - 6 * m * c ^ 2 * (X / S) + 6 * dU * m * c ^ 2 = 0

case refine_2
m c dU θ : ℝ
hm : 0 < m
hc : 0 < c
hdU : 0 < dU
hb : 0 < hbar
hθ : IsForwardBranch θ
hθpos : 0 < θ
hfac : 2 - cos (2 * θ) ≠ 0
hmc : 0 < 3 * m * c ^ 2
hmcne : 3 * m * c ^ 2 ≠ 0
S : ℝ := 2 * sin θ ^ 2 + 1
hSdef : S = 2 * sin θ ^ 2 + 1
hS : 1 ≤ S
hSpos : 0 < S
hSne : S ≠ 0
D : ℝ := 1 - 2 * dU / (3 * m * c ^ 2) * S
hdisc : 0 ≤ D
hDdef : D = 1 - 2 * dU / (3 * m * c ^ 2) * S
s : ℝ := √D
hsdef : s = √D
hs_nonneg : 0 ≤ s
hs_sq : s ^ 2 = D
hfracS : 2 * dU / (3 * m * c ^ 2) * (3 * m * c ^ 2) = 2 * dU
hsq3 : s ^ 2 * (3 * m * c ^ 2) = 3 * m * c ^ 2 - 2 * dU * S
hfrac : 0 < 2 * dU / (3 * m * c ^ 2)
hDlt : 0 < 1 - D
hsq_lt : s ^ 2 < 1 ^ 2
hs_lt_one : s < 1
hone_sub : 0 < 1 - s
hfac_S : 2 - cos (2 * θ) = S
hS' : S ≠ 0
X : ℝ := 3 * m * c ^ 2 * (1 - s)
hΩ : hbarOmegaMin m c dU θ = X / (hbar * S)
hE : hbar * hbarOmegaMin m c dU θ = X / S
hXdef : X = 3 * m * c ^ 2 * (1 - s)
⊢ S * (X ^ 2 / S ^ 2) - 6 * m * c ^ 2 * (X / S) + 6 * dU * m * c ^ 2 = 0
IPhO2026Problems/problem_IPhO_2026_1_C_1.lean:371:8: warning: declaration uses `sorry`
IPhO2026Problems/problem_IPhO_2026_1_C_1.lean:385:8: warning: declaration uses `sorry`
```
| `IPhO2026Problems/problem_IPhO_2026_2_B_2.lean` | failed | 5 | 17.703 |

## `IPhO2026Problems/problem_IPhO_2026_2_B_2.lean` diagnostics
```text
IPhO2026Problems/problem_IPhO_2026_2_B_2.lean:279:4: error: linarith failed to find a contradiction
case h1
p : CookerParams
g : CookerGeometry p
r : AbsorbedRays p g
y : ℝ
hy : y ∈ r.hitSet
h0e : g.e.ofLp 0 ^ 2 + g.e.ofLp 1 ^ 2 = 1
h0n : g.n.ofLp 0 ^ 2 + g.n.ofLp 1 ^ 2 = 1
hpen : g.n.ofLp 0 * g.e.ofLp 0 + g.n.ofLp 1 * g.e.ofLp 1 = 0
hdote : ∀ (v : Plane), inner ℝ v g.e = v.ofLp 0 * g.e.ofLp 0 + v.ofLp 1 * g.e.ofLp 1
hdotn : ∀ (v : Plane), inner ℝ v g.n = v.ofLp 0 * g.n.ofLp 0 + v.ofLp 1 * g.n.ofLp 1
hnormsq : ∀ (v : Plane), ‖v‖ ^ 2 = v.ofLp 0 ^ 2 + v.ofLp 1 ^ 2
v : Plane
a✝ :
  (v.ofLp 0 * g.e.ofLp 0 + v.ofLp 1 * g.e.ofLp 1) ^ 2 + (v.ofLp 0 * g.n.ofLp 0 + v.ofLp 1 * g.n.ofLp 1) ^ 2 <
    v.ofLp 0 ^ 2 + v.ofLp 1 ^ 2
⊢ False
failed
IPhO2026Problems/problem_IPhO_2026_2_B_2.lean:295:8: error: Tactic `rewrite` failed: Did not find an occurrence of the pattern in the current goal

p : CookerParams
g : CookerGeometry p
r : AbsorbedRays p g
y : ℝ
hy : y ∈ r.hitSet
h0e : g.e.ofLp 0 ^ 2 + g.e.ofLp 1 ^ 2 = 1
h0n : g.n.ofLp 0 ^ 2 + g.n.ofLp 1 ^ 2 = 1
hpen : g.n.ofLp 0 * g.e.ofLp 0 + g.n.ofLp 1 * g.e.ofLp 1 = 0
hdote : ∀ (v : Plane), inner ℝ v g.e = v.ofLp 0 * g.e.ofLp 0 + v.ofLp 1 * g.e.ofLp 1
hdotn : ∀ (v : Plane), inner ℝ v g.n = v.ofLp 0 * g.n.ofLp 0 + v.ofLp 1 * g.n.ofLp 1
hnormsq : ∀ (v : Plane), ‖v‖ ^ 2 = v.ofLp 0 ^ 2 + v.ofLp 1 ^ 2
hparseval : ∀ (v : Plane), inner ℝ v g.e ^ 2 + inner ℝ v g.n ^ 2 = ‖v‖ ^ 2
hon : r.incidentPt y ∈ halfMirrorArc p g
hmem : r.incidentPt y ∈ mirrorCircle p g
hnorm : ‖r.incidentPt y - g.C‖ = p.R
ue : ℝ := inner ℝ (r.incidentPt y - g.C) g.e
hue : ue = inner ℝ (r.incidentPt y - g.C) g.e
wn : ℝ := inner ℝ (r.incidentPt y - g.C) g.n
hpv : ue ^ 2 + wn ^ 2 = p.R ^ 2
hwn : wn = inner ℝ (r.incidentPt y - g.C) g.n
⊢ |ue| ≤ p.R
Try this:
  [apply] ring_nf
  
  The `ring` tactic failed to close the goal. Use `ring_nf` to obtain a normal form.
    
  Note that `ring` works primarily in *commutative* rings. If you have a noncommutative ring, abelian group or module, consider using `noncomm_ring`, `abel` or `module` instead.
IPhO2026Problems/problem_IPhO_2026_2_B_2.lean:299:69: error: unsolved goals
p : CookerParams
g : CookerGeometry p
r : AbsorbedRays p g
y : ℝ
hy : y ∈ r.hitSet
h0e : g.e.ofLp 0 ^ 2 + g.e.ofLp 1 ^ 2 = 1
h0n : g.n.ofLp 0 ^ 2 + g.n.ofLp 1 ^ 2 = 1
hpen : g.n.ofLp 0 * g.e.ofLp 0 + g.n.ofLp 1 * g.e.ofLp 1 = 0
hdote : ∀ (v : Plane), inner ℝ v g.e = v.ofLp 0 * g.e.ofLp 0 + v.ofLp 1 * g.e.ofLp 1
hdotn : ∀ (v : Plane), inner ℝ v g.n = v.ofLp 0 * g.n.ofLp 0 + v.ofLp 1 * g.n.ofLp 1
hnormsq : ∀ (v : Plane), ‖v‖ ^ 2 = v.ofLp 0 ^ 2 + v.ofLp 1 ^ 2
hparseval : ∀ (v : Plane), inner ℝ v g.e ^ 2 + inner ℝ v g.n ^ 2 = ‖v‖ ^ 2
hon : r.incidentPt y ∈ halfMirrorArc p g
hmem : r.incidentPt y ∈ mirrorCircle p g
hnorm : ‖r.incidentPt y - g.C‖ = p.R
ue : ℝ := inner ℝ (r.incidentPt y - g.C) g.e
hue : ue = inner ℝ (r.incidentPt y - g.C) g.e
wn : ℝ := inner ℝ (r.incidentPt y - g.C) g.n
hpv : ue ^ 2 + wn ^ 2 = p.R ^ 2
hwn : wn = inner ℝ (r.incidentPt y - g.C) g.n
habsue : |ue| ≤ p.R
h1 : |wn| ^ 2 = wn ^ 2
⊢ p.R ^ 2 - p.R ^ 2 * |ue| ^ 2 * p.R⁻¹ ^ 2 = p.R ^ 2 - |ue| ^ 2
IPhO2026Problems/problem_IPhO_2026_2_B_2.lean:309:8: error: Tactic `rewrite` failed: Did not find an occurrence of the pattern
  |wn| ^ 2
in the target expression
  √(wn ^ 2) = p.R * √(1 - (|ue| / p.R) ^ 2)

p : CookerParams
g : CookerGeometry p
r : AbsorbedRays p g
y : ℝ
hy : y ∈ r.hitSet
h0e : g.e.ofLp 0 ^ 2 + g.e.ofLp 1 ^ 2 = 1
h0n : g.n.ofLp 0 ^ 2 + g.n.ofLp 1 ^ 2 = 1
hpen : g.n.ofLp 0 * g.e.ofLp 0 + g.n.ofLp 1 * g.e.ofLp 1 = 0
hdote : ∀ (v : Plane), inner ℝ v g.e = v.ofLp 0 * g.e.ofLp 0 + v.ofLp 1 * g.e.ofLp 1
hdotn : ∀ (v : Plane), inner ℝ v g.n = v.ofLp 0 * g.n.ofLp 0 + v.ofLp 1 * g.n.ofLp 1
hnormsq : ∀ (v : Plane), ‖v‖ ^ 2 = v.ofLp 0 ^ 2 + v.ofLp 1 ^ 2
hparseval : ∀ (v : Plane), inner ℝ v g.e ^ 2 + inner ℝ v g.n ^ 2 = ‖v‖ ^ 2
hon : r.incidentPt y ∈ halfMirrorArc p g
hmem : r.incidentPt y ∈ mirrorCircle p g
hnorm : ‖r.incidentPt y - g.C‖ = p.R
ue : ℝ := inner
... [truncated]
```
| `IPhO2026Problems/problem_IPhO_2026_2_C_2.lean` | failed | 0 | 10.919 |

## `IPhO2026Problems/problem_IPhO_2026_2_C_2.lean` diagnostics
```text
IPhO2026Problems/problem_IPhO_2026_2_C_2.lean:182:40: error: unexpected token '/--'; expected 'lemma'
```
| `IPhO2026Problems/problem_IPhO_2026_2_C_4.lean` | failed | 2 | 10.535 |

## `IPhO2026Problems/problem_IPhO_2026_2_C_4.lean` diagnostics
```text
IPhO2026Problems/problem_IPhO_2026_2_C_4.lean:151:22: error: unexpected token '≥'; expected ':' or term
IPhO2026Problems/problem_IPhO_2026_2_C_4.lean:150:17: error(lean.unknownIdentifier): Unknown identifier `𝓝`
```
| `IPhO2026Problems/problem_IPhO_2026_3_A_1.lean` | passed | 0 | 10.750 |
| `IPhO2026Problems/problem_IPhO_2026_3_B_1.lean` | passed | 0 | 10.383 |
| `IPhO2026Problems/problem_IPhO_2026_3_B_2.lean` | failed | 1 | 5.708 |

## `IPhO2026Problems/problem_IPhO_2026_3_B_2.lean` diagnostics
```text
IPhO2026Problems/problem_IPhO_2026_3_B_2.lean:163:8: warning: declaration uses `sorry`
IPhO2026Problems/problem_IPhO_2026_3_B_2.lean:363:8: error: Tactic `rewrite` failed: Did not find an occurrence of the pattern
  Tf ^ 2
in the target expression
  Ti ^ 2 * (params.lam + params.mu0 * params.K * Hi ^ 2) / (params.lam + params.mu0 * params.K * Hf ^ 2) / Ti ^ 2 =
    (params.lam + params.mu0 * params.K * Hf ^ 2) / (params.lam + params.mu0 * params.K * Hi ^ 2)

params : TorusParameters
p : StatePath
laws : ParamagneticTorusLaws params p
hadiabatic : IsAdiabaticPath params p laws
Hi Hf Ti Tf : ℝ
hendpoints : AdiabaticEndpoints p Hi Ti
hfinal : ∃ tf, (p tf).field = Hf ∧ (p tf).temperature = Tf
hTf_pos : 0 < Tf
hTi : 0 < Ti
hrel : Tf ^ 2 * (params.lam + params.mu0 * params.K * Hf ^ 2) = Ti ^ 2 * (params.lam + params.mu0 * params.K * Hi ^ 2)
ha_pos : 0 < params.lam + params.mu0 * params.K * Hi ^ 2
hb_pos : 0 < params.lam + params.mu0 * params.K * Hf ^ 2
ha : params.lam + params.mu0 * params.K * Hi ^ 2 ≠ 0
hTi' : Ti ≠ 0
hb : params.lam + params.mu0 * params.K * Hf ^ 2 ≠ 0
hTf2 : Tf ^ 2 = Ti ^ 2 * (params.lam + params.mu0 * params.K * Hi ^ 2) / (params.lam + params.mu0 * params.K * Hf ^ 2)
⊢ Ti ^ 2 * (params.lam + params.mu0 * params.K * Hi ^ 2) / (params.lam + params.mu0 * params.K * Hf ^ 2) / Ti ^ 2 =
    (params.lam + params.mu0 * params.K * Hf ^ 2) / (params.lam + params.mu0 * params.K * Hi ^ 2)
```
| `IPhO2026Problems/problem_IPhO_2026_3_C_2.lean` | passed | 1 | 11.425 |

## `IPhO2026Problems/problem_IPhO_2026_3_C_2.lean` diagnostics
```text
IPhO2026Problems/problem_IPhO_2026_3_C_2.lean:370:6: warning: declaration uses `sorry`
```
| `IPhO2026Problems/problem_IPhO_2026_3_C_4.lean` | passed | 0 | 10.789 |
| `IPhO2026Problems/problem_IPhO_2026_4_A_5.lean` | passed | 0 | 11.190 |

## `IPhO2026Problems/problem_IPhO_2026_4_A_5.lean` diagnostics
```text
IPhO2026Problems/problem_IPhO_2026_4_A_5.lean:158:37: warning: Variable name `ht₂` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
IPhO2026Problems/problem_IPhO_2026_4_A_5.lean:479:5: warning: Variable name `law` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
IPhO2026Problems/problem_IPhO_2026_4_A_5.lean:483:5: warning: Variable name `hT₀` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
IPhO2026Problems/problem_IPhO_2026_4_A_5.lean:484:5: warning: Variable name `hT₀pos` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
IPhO2026Problems/problem_IPhO_2026_4_A_5.lean:502:5: warning: Variable name `law` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
IPhO2026Problems/problem_IPhO_2026_4_A_5.lean:506:5: warning: Variable name `hT₀` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
IPhO2026Problems/problem_IPhO_2026_4_A_5.lean:508:5: warning: Variable name `hβ₀` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
IPhO2026Problems/problem_IPhO_2026_4_A_5.lean:511:13: warning: Variable name `hσ` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
```
| `IPhO2026Problems/problem_IPhO_2026_4_B_6.lean` | passed | 0 | 10.505 |

## `IPhO2026Problems/problem_IPhO_2026_4_B_6.lean` diagnostics
```text
IPhO2026Problems/problem_IPhO_2026_4_B_6.lean:322:5: warning: Variable name `input` is not explicitly referenced.

The binding can be removed (if unused) or named `_` (if used implicitly).

Note: This linter can be disabled with `set_option linter.unusedVariables false`
```
