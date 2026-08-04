# Blueprint-Writer Directive

## Slug
1-b-2-helper-entries

## Chapter
`blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_1_B_2.tex` (only this file)

## Context
Iter-014 restored the iter-011 redrafted `1_B_2` Lean file: it now compiles
0 errors with 3 documented Kepler-bridge sorries (`orbit_eq_conic`,
`exists_asymptoticRelativeVelocity`, `signed_deflection_eq_formula`),
`eccentricity_sq_eq = 49/4` PROVED, and three new PROVED helper lemmas
(`arctan_poly_squeeze`, `arctan_deg_band`, `signed_deflection_certificate`).
The planner has ALREADY edited this chapter this iter: the statements around
`eccentricity_sq_eq`, `signed_deflection_eq_formula`, both main theorems and
`asymptote_factor_certificate` were re-keyed to the official chain
(`eps² = 49/4`, periapsis-referenced `arctan(1/√(eps²-1))`, signed
`-arctan(2/√45)`, factor `2/√45`), and three new lemma blocks were appended
at the END of the chapter under a subsection titled
`Rational rounding-band certificates (iter-014 transcription)`:
`arctan_poly_squeeze` (label `lem:…:arctan_poly_squeeze`),
`arctan_deg_band` (label `lem:…:arctan_deg_band`),
`signed_deflection_certificate` (label `lem:…:signed_deflection_certificate`).

## Task (cleanup + wiring only — do NOT rewrite statements)
1. Move the three new lemma blocks from the end of the chapter into the
   natural positions: `arctan_poly_squeeze` and `arctan_deg_band` inside the
   subsection "Official answer (conclusion side only)", AFTER
   `roundsToOfficialDegreesAbs` and BEFORE the main target theorem;
   `signed_deflection_certificate` immediately AFTER
   `signed_deflection_angle_T1_B2`. Keep their `\label`/`\lean` names
   byte-identical.
2. Wire the dependency edges into the ledger markup:
   - in `thm:IPhO2026Problems_problem_IPhO_2026_1_B_2:signed_deflection_angle_T1_B2`
     ensure the `\uses{...}` list includes
     `lem:IPhO2026Problems_problem_IPhO_2026_1_B_2:signed_deflection_certificate`
     (it currently lists the older certificate lemmas only — add the new one);
   - in `thm:IPhO2026Problems_problem_IPhO_2026_1_B_2:unsigned_deflection_angle_in_degrees_T1_B2`
     add `lem:IPhO2026Problems_problem_IPhO_2026_1_B_2:arctan_deg_band` to
     its `\uses{...}` list.
3. Statement-fidelity spot check (read-only): open
   `IPhO2026Problems/problem_IPhO_2026_1_B_2.lean` and verify the three new
   chapter statements match the Lean signatures
   (`arctan_poly_squeeze` is a conjunction with the `b^7/7` term on the left;
   `arctan_deg_band` concludes `< 16605/1000` strictly;
   `signed_deflection_certificate` takes `hdelta : signedDeflection u =
   -Real.arctan (2 / Real.sqrt 45)`). Report any mismatch in your report;
   fix wording only if the fix is clearly a transcription typo.
4. Do NOT add `\leanok` or `\mathlibok` markers anywhere (the deterministic
   sync owns `\leanok`; the review agent owns `\mathlibok`).
5. Do NOT touch any other chapter file. No reference retrieval needed.

## Out of scope
- No changes to the physics-modeling NOTE blocks or the iter-014 repair
  parentheticals.
- No edits to `2_B_2`/`3_B_2` chapters (already handled this iter).
