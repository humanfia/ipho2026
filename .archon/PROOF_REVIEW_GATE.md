# Proof Review Gate

- State version: 2
- Maximum reviewed proof attempts per target: 6
- Solved: 26
- Retry proof: 0
- Needs statement redraft: 1
- Infrastructure blocked: 0
- Review exhausted: 0

## Return to autoformalize

- `IPhO2026Problems/problem_IPhO_2026_4_C_7.lean` — attempts 1/6; Both theorem contracts are wrong (provably false), not merely unproved: (1) acrylicConductivity_officialSample is numerically false at its frozen inputs -- substituting hR_central R_Th=1.17 into hformula gives lam = log(465/337)/(2*pi*0.10*1.17) ~= 0.43795, so |lam - 0.25| ~= 0.188 > 0.01; independent recomputation confirms lambda ~= 0.427-0.450 over the whole R_Th in [1.14,1.20] window, so the band cannot reach 0.25 under any sign convention; (2) acrylicConductivity_formula is sign-inconsistent -- hDeltaT : T_IC < T_OC forces inward heat flow (dT/dr < 0), hence lam < 0 by Fourier's law, while the claimed RHS log(r2/r1)/(2*pi*h*R_Th) is positive for R_Th > 0; a constructive countermodel (lam = -1, T r = (2pi)^{-1} log r on wall [1,2]) satisfies every hypothesis yet violates the conclusion. The 4 sorries sit at exactly the unprovable goals.; kind=wrong_or_weakened_target
