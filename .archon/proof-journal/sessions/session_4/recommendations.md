# Recommendations — session 4 (iter-004 review)

## 0. Routing decision for `IPhO2026Problems/problem_IPhO_2026_4_C_6.lean`
**Re-review (attempt 2/3). Do NOT redraft, do NOT re-dispatch a statement lane.**
The file compiles clean with the 4 contracted sorries; every mandatory structured
check passes at statement level; the iter-002 numerical defect is verifiably closed
(0.00727 ≤ 0.03; budget 0.02197 ≤ 0.03). The two fail-carriers are a systematic
grounding-log defect and a provenance gap, both fixable outside the Lean statement.
CONSIDERED and rejected: (a) revert to the iter-004 quarantine-delete — wasteful if
the microdata is genuine, and it erases a now-true theorem; (b) pass on faith — the
review gate forbids passing while the deterministic grounding log is noise-only and
while a conclusion-side physics claim rests on data no reviewer can verify.

## 1. Provenance obligation (unblocks check (ii), highest value)
Get the C.6 sample microdata into a reviewer-verifiable artifact:
- restore `raw/E1_solution.pdf` into the checkout (the `formalization_input_policy`'s
  own marking field cites it: "Official experimental solution: raw/E1_solution.pdf"),
  or
- add an extraction note under `reports/ipho_2026_k3/` quoting the official C.6 page's
  slope `a = (2.28 ± 0.06)·10⁻³ 1/s`, mass `m = (89 ± 1) g`, and final
  `R_Th = (1.17 ± 0.03) K/W` lines.
If verification fails (the lane's quote was fabricated or mis-OCR'd), fall back to the
iter-004 quarantine-delete directive exactly as written (delete
`official_sample_value`, keep the documented quarantine comment).

## 2. Blueprint chapter NOTE is stale — rewrite at next chapter pass
The iter-003 NOTE in `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_4_C_6.tex`
still asserts the sample microdata "cannot be recovered from the C.5 source page" and
describes a quarantine that the on-disk file no longer implements. Rewrite it as the
recovery note (microdata recovered; band membership now true; exponent-sign ambiguity
resolved by band-center consistency) or align the chapter with whichever provenance
verdict (1) produces. Chapters are outside prover lanes' write domain — this is
planner-side.

## 3. Systematic grounding-log noise (26-file blocker, loop-level, unrouted for 3 iters)
The deterministic grounding preflight continues to emit noise hits
(`Path.target`/`semiformal_result`/`stereographic_target`) keyed to the umbrella
chapter node and `None detected` for local abstractions, on a file with 7 abstraction
families. Durable ruling (iter-002 → re-affirmed): the task report's grounded-names
section is the register of record. But the gate keeps consuming this as a blocker. Fix
one of: (a) the preflight's query construction (currently queries the literal blueprint
node text "Physics formalization target"); (b) write the reconciled log into the
preflight path so the gate reads real data; (c) amend the review-prompt blocker rule to
accept the task-report register when the preflight fingerprint predates the lane. Any
of the three unwedges all 26 gate-queue files at once; none involves touching Lean
statements.

## 4. Also on the loop radar (no action demanded by this target, recorded for the plan)
- The 19 remaining `missing-physlib-import` doctor findings are the exemption-NOTE
  cohort (4_C_6 correctly NOT flagged — the patched doctor recognizes its genuine 6
  Physlib imports). The iter-003 upstream patch propagation is still user-confirmed
  pending; keep the escalation item.
- `1_B_1` (reviews 3/3, gate-exhausted) was iter-004's other lane but is NOT in this
  review's candidate set; its compile repair lands in the next preflight.
- Helper-blueprint transcription (~471-debt) and umbrella-node `\lean{}`/`\uses{}`
  wiring stay scheduled for iter-005 per the plan; 4_C_6's helper list is recorded in
  its task report under "Declarations created".

## 5. What NOT to do
- Do not re-`lake env lean` this file for the review — preflight status was `passed`.
- Do not let a lane re-derive or re-guess sample microdata; only sourced data may
  appear in `official_sample_*`.
- Do not weaken `official_sample_value` (e.g. dropping `δ = 0.03` or the 1.17 anchor)
  to make the provenance problem disappear — that would destroy the checkable
  contract; the honest fix is provenance or quarantine.
