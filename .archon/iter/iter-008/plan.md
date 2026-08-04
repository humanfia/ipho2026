# Iteration 008 bounded plan

## State reconciliation

- Session 7 reviewed zero targets and requested no retries; no unmerged prover result changes the pending/done ledgers.
- The live frontier names `1_B_2` and `2_B_1`, but both files are proof-Review-exhausted 3/3. Direct contract inspection confirms the missing outgoing velocity/branch identity and tangent-path/radius consequence remain absent.
- `4_B_6` remains placeholder-free but Review-exhausted: its conclusion still tests central-value band membership without propagating the supplied molar uncertainty.
- Iteration 007 declares no silent-user fallback.

## Decision made

- Dispatch no prover. This is the retry gate’s mechanical hard stop, not an undecided strategy fork; reassigning either frontier file is forbidden.
- Keep `STRATEGY.md`, blueprints, and task ledgers unchanged. The cheapest reversing signal is a user-authored contract revision adding the two general physics bridges and an explicit propagated-uncertainty conclusion. That restores Review eligibility at an expected ~60–300 proof LOC; absent it, any agent-side signature change violates faithfulness.
