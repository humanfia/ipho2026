# Refactor directive — `3-b-2-redraft-invariant-fix` (iter-014, mandatory statement redraft, formalization-gate retry 3/3)

**Target file (only file you may edit):** `IPhO2026Problems/problem_IPhO_2026_3_B_2.lean`
**Report to:** `.archon/task_results/refactor-3-b-2-redraft-invariant-fix.md`

## Why (gate ruling, verbatim basis)
The iter-013 formalization Review ruled this contract **missing_foundational_bridge / physically false**:
- `IsAdiabaticPath` encodes `Cm·T' = -w`, but the official T3-B.2 first law is `dU = dW` (δQ = 0), i.e. `Cm·T' = +w`;
- `adiabaticInvariant` uses `T²·(λ + μ₀·K·H²)`, but the quantity actually conserved (official solution) is `(λ + μ₀·K·H²)/T²`;
- `endpoint_relation` consequently has the two brackets on swapped sides (frozen as `Tf²·B = Ti²·A`, derivable only from the wrong invariant);
- bridge lemma 1 (`adiabatic_invariant_along_path`) is refuted by a smooth premise-satisfying countermodel under the stated law;
- the main theorem's closing algebra currently fails to compile at L363 (`linear_combination e` with the wrong-shaped `e`) and is underivable from the frozen `endpoint_relation` even with bridge 1 sorried through.

## Source of truth (just read locally — quote exactly, do not paraphrase)
Official solution, T3-B.2, p. 10 of `references/raw/T3_solution.pdf` (same text in `references/text/T3_solution.txt`, lines 23–59). Verbatim core:
> "For adiabatic processes, the first law yields to dU = dW and then (nλ/2T²)·dT... i.e. (nλ/T³)dT = µ₀V H dM = µ₀V (nKH/(TM V)) dM" — the txt extraction shows the separated form `nλ dT / T³ = µ₀ V² M dM / (nK)`, then integration from (Ti, Mi) to (Tf, Mf) gives `(nλ/2)(1/Ti² − 1/Tf²) = µ₀(V²/(2nK))(Mf² − Mi²)`, and with `M = nKH/(TV)` this simplifies to `λ/Ti² − λ/Tf² = µ₀K(Hf²/Tf² − Hi²/Ti²)`, from which `Tf²/Ti² = (λ + µ₀KHf²)/(λ + µ₀KHi²)`.

Consequences you must encode exactly:
- First-law balance: `Cm(t)·deriv T t = +w t` (sign is PLUS; `dU = dW`, work entering the torus positive).
- Conserved invariant: `(lam + mu0·K·H²)/T²`. Integration route: separated derivative identity `deriv t ↦ (lam + mu0·K·H(t)²)/T(t)² = 0`; equivalent intermediate the official uses: `n·lam·Ṫ/T³ = µ₀·n·K·H·Ḣ/T²`.
- Endpoint relation (correct side placement): `Tf²·(lam + mu0·K·Hi²) = Ti²·(lam + mu0·K·Hf²)` — the INITIAL bracket multiplies Tf², the FINAL bracket multiplies Ti². From this, `(Tf/Ti)² = (lam + mu0·K·Hf²)/(lam + mu0·K·Hi²)`, and the frozen main-theorem conclusion follows with UNCHANGED hygiene (`positivity`, `Real.sqrt_sq`, `field_simp`, `linarith`).

## Required edits (statement redraft — signatures/bodies, no new theorems, no weakening of the main conclusion)
1. `IsAdiabaticPath`: flip the balance sign — last clause becomes `Cm t * deriv (fun s => (p s).temperature) t = w t`. Update the docstring: first law `dU = dW` for zero heat transfer, with the verbatim official line quoted in a `--` comment.
2. `adiabaticInvariant`: body becomes `(params.lam + params.mu0 * params.K * (H:ℝ) ^ 2) / T ^ 2`. Update the docstring (conserved quantity `(λ + μ₀KH²)/T²`).
3. `adiabatic_invariant_along_path`: conclusion unchanged in shape (`adiabaticInvariant … t₁ = adiabaticInvariant … t₂` — it now means the corrected invariant). REUSE the entire existing derivation context (fields `temp_differentiable`/`mag_differentiable`, differentiated-EOS computation `e2`, first-law `e1`) — the in-file REDRAFT BLOCKER comment says exactly this; replace the `sorry` with the best honest attempt: with `Cm = nλ/T²`, `w = µ₀VH Ṁ`, EOS `M = nKH/(TV)`, and the corrected sign, the balance gives `nλṪ/T² = +µ₀VHṀ`; differentiating the EOS and substituting yields `deriv ((λ + µ₀KH²)/T²) = (2nλ/T⁴)·(λṪ − µ₀KH²Ṫ… )` — the clean route is: show `deriv (fun t => (params.lam + params.mu0 * params.K * H(t)^2) / T(t)^2) t = (2 * params.n * params.lam / T(t)^4) * (T(t) * Ṫ... )` reduces to a multiple of the first-law balance `(nλ/T²)Ṫ − µ₀VHṀ = 0`, hence identically zero; MVT-constancy closes it. If the full term-mode assembly does not close within your budget, leave ONE well-marked `sorry` at the final vanishing-derivative step with a comment recording the identity `deriv [(λ+µ₀KH²)/T²] = (2µ₀KHT/T⁴)·(H Ṫ... )` you reduced it to — DO NOT weaken the lemma statement, and remove the stale REDRAFT BLOCKER comment block since the contract is now repaired.
4. `endpoint_relation`: swap the two brackets — conclusion becomes `Tf ^ 2 * (params.lam + params.mu0 * params.K * Hi ^ 2) = Ti ^ 2 * (params.lam + params.mu0 * params.K * Hf ^ 2)`. Body: same proof pattern (`obtain` endpoints, apply `adiabatic_invariant_along_path params p laws hadiabatic tf t0`, `simp only [adiabaticInvariant, ...] at h`, then `field_simp`-style division-normalization — the invariant now divides by `T²`, so `h` will be `A/Tf² = B/Ti²`-shaped; cross-multiply with `temp_pos`-derived `Ti ≠ 0`, `Tf ≠ 0` hypotheses — note you'll need `0 < Tf`, which follows from `laws.temp_pos tf`; obtain it there). Update the docstring.
5. `adiabatic_temperature_change` (main target, statement MUST NOT change): repair the proof for the corrected `hrel`. The existing algebra comments must be re-keyed: now `hrel : Tf²·A = Ti²·B` with `A = lam + µ₀K·Hi²`, `B = lam + µ₀K·Hf²`, giving `Tf² = Ti²·B/A`, `(Tf/Ti)² = B/A` — the intended quotient. Fix the L354–L368 block accordingly (the `e`/`linear_combination e` shape changes; `hratio_sq` now follows from `field_simp [ha, hb, (pow_pos hTi 2).ne']` + `linear_combination hrel.symm` or equivalent). The downstream `hratio_nonneg`/`Real.sqrt_sq`/final `linarith` steps are unchanged.
6. Delete or rewrite every stale comment that still describes the old (false) contract: the `Cm·T' = −w` docstring line, the `T²·(λ + μ₀·K·H²)` invariant docstring, the REDRAFT BLOCKER comment (~L270–285), and any derivation-sketch comments near the top of the file that now misdescribe the physics.

## Acceptance criteria (all mandatory)
- `lake env lean IPhO2026Problems/problem_IPhO_2026_3_B_2.lean` (fresh process): 0 errors. Run it and paste the tail of the output into your report.
- Main theorem statement (`adiabatic_temperature_change`) byte-identical in its hypotheses and conclusion: `ParamagneticTorusLaws`, `IsAdiabaticPath`, `AdiabaticEndpoints`, final-state witness, `hTf_pos`, conclusion `Tf - Ti = Ti * (Real.sqrt ((lam + mu0·K·Hf²)/(lam + mu0·K·Hi²)) - 1)`.
- No new axioms, no `sorry` in `endpoint_relation` / `lam_add_mu0_K_sq_pos` / the main theorem. At most the single documented `sorry` in `adiabatic_invariant_along_path` if the integration assembly genuinely does not close.
- Sorry count ≤ 1 in the whole file (it is currently 3; the gate expects the repaired contract to make 2 of them closable immediately).
- Do NOT touch `TorusParameters`, `ParamagneticTorusState`, `StatePath`, `AdiabaticEndpoints`, `ParamagneticTorusLaws` (the iter-012 differentiability fields stay), `lam_add_mu0_K_sq_pos`.

## Report format
Standard refactor report; include: exact diffs applied per declaration, fresh `lake env lean` output tail, remaining sorry coordinates + reason, and any derivation step you believe belongs in the blueprint chapter (the plan agent transcribes it — you do not touch tex).
