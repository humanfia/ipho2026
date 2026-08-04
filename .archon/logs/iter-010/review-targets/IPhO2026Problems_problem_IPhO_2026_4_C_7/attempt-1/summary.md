# Review: problem_IPhO_2026_4_C_7 (iter-010) — status: blocked, route: needs_redraft (wrong_or_weakened_target)

Preflight: compiles rc=0, 4 sorries (warnings at lines 172, 242); no admit/axiom/native_decide; statements match blueprint verbatim.
Checks 1, 2, 5 pass: honest partial proofs, signatures preserved, no laundering; prover trace (biui-0724, session_end 2026-07-28T05:00:57Z) agrees with on-disk file; empty task-result list = process warning only.
Checks 3, 4 fail — both value theorems are provably FALSE as stated, not merely unproved:
- acrylicConductivity_formula: hΔT : T_IC < T_OC forces dT/dr < 0, hence lam < 0 via Fourier's law, while RHS log(r₂/r₁)/(2πhR_Th) > 0. Constructive countermodel (lam=-1, T=(2π)⁻¹log r on [1,2]) documented in-file and independently checked.
- acrylicConductivity_officialSample: at R_Th = 1.17, lam = log(465/337)/(2π·0.10·1.17) ≈ 0.43795, so |lam−0.25| ≈ 0.188 > 0.01; reviewer recomputation gives λ ∈ [0.427, 0.450] across the whole R_Th ∈ [1.14,1.20] window — the ±0.01 band around 0.25 is unreachable.
Supporting structures (geometry, laws, wall_current) are faithful and proved; the defects sit only in the two conclusion-side contracts.
Repair: blueprint-writer redraft — (a) officialSample: fix frozen inputs (h ≈ 0.175 m, or R_Th ≈ 2.05 K/W) and drop redundant hR_central; (b) formula: flip drive to T_OC < T_IC or add 0 < R_Th ∧ 0 < lam; sync tex+Lean, then reprove.
Absolute log path: /root/proposal_for_physic/science-mango-ipho-2026-k3-run/.archon/logs/iter-010/review-targets/IPhO2026Problems_problem_IPhO_2026_4_C_7/attempt-1/
