# Review: IPhO2026Problems/problem_IPhO_2026_2_B_2.lean (iter-013)
Status: partial | Route: retry_proof (redraft_kind: not_applicable)

Contract: the iter-011 two-sided-band redraft is faithful and derivable — hit band
(-yOff, yOff) gives collectedWidth = 2*yOff = 2*R*sin theta_max, and the B.1
calibration 2a = 2R sinθ(1-cosθ) forces P/P0 = 1/(1-cosθ_max), the recorded
official answer. No underdetermination remains from the iter-010 review.

Failure is mechanistic, not semantic: preflight compiles=false, sorry_count=5
(target theorem + 4 chain lemmas). First error at 279:4: the Parseval step in
abs_hitOffset_eq hands the quadratic identity (v.e)^2+(v.n)^2 = v0^2+v1^2 to
linarith/nlinarith without a ring-normal-form hypothesis; downstream abs/sqrt
(295:8, 309:8) and field-normalization (299:69) rewrites also fail.

Prover trace (294 events) ends 13:48:16Z on a 429 rate-limit abort mid-repair,
before the patched Parseval lemma was recompiled or any sorry addressed.
No matching task-results artifact exists ([]); trace used as primary evidence
(process warning only). The 429 abort is recorded as a contributing budget
cause, not blocked_infrastructure — plain tactic/lemma work remains.
