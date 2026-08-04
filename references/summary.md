# References

<!-- archon:references-summary -->
<!-- One row per file. Agents append/update rows as they discover what -->
<!-- actually works. The `How to read` column is a LIVING LOG, not a -->
<!-- static cheat-sheet — fill it in the first time you successfully -->
<!-- ingest a file, and correct it if a later attempt finds a better way. -->

## File inventory

| File | Description | How to read (confirmed working) |
| ---- | ----------- | ------------------------------- |
| `raw/T3_solution.pdf` | Official T1–T3 solutions (IPhO 2026, 10 pp, English). T3-B.2 on p. 10 carries the adiabatic first-law derivation. | `pdftotext -f 10 -l 10 -layout raw/T3_solution.pdf -` (poppler at /usr/bin/pdftotext); the pre-extracted sibling `text/T3_solution.txt` is the same text, plain `Read`. vendored iter-014 from sibling upload; full citation in tex needs only the local file. |
| `raw/T2_solution.pdf` | Official T2 (Problem 2) solution PDF (optics: hit band, specular families, caustic). | `pdftotext raw/T2_solution.pdf -`; vendored iter-014 from sibling upload `hf-IPHO2026-upload/ipho_2026_source/raw/`. Text export at `text/T2_solution.txt`. |
| `text/T1_solution.txt` | Official T1 solution, plain-text extraction (Rutherford scattering; B.2 deflection arctan result). | plain `Read` (pre-extracted, vendored iter-014 from sibling upload). |
| `text/T2_solution.txt` | Official T2 solution, plain-text extraction (B.2 hit band, C.2 specular families, C.4 caustic). | plain `Read`. |
| `text/T3_solution.txt` | Official T3 solution, plain-text extraction (B.2 adiabatic invariant). | plain `Read`. |
| `text/E1_solution.txt` | Official E1 solution, plain-text extraction (C.7 acrylic conductivity). | plain `Read`. |
<!-- Example row (delete once you have real entries):                   -->
<!-- | `paper.pdf` | Source paper for chapter 3 | `Read` with `pages: "1-12"` (poppler installed); for the appendix tables, `pdftotext paper.pdf - \| sed -n '120,180p'` was clearer. |  -->

<!-- Rules of thumb when filling in `How to read`:                       -->
<!--   * If `Read` worked out of the box, write `Read` (and any options   -->
<!--     you needed, e.g. `pages: "1-5"` for long PDFs).                  -->
<!--   * If `Read` failed and you fell back to a shell command, record   -->
<!--     the exact command (e.g. `pdftotext file.pdf -`, `pandoc … -t    -->
<!--     markdown`, `unzip -p archive.zip path/inside.tex`).             -->
<!--   * If a file is binary / opaque (e.g. a Mathematica notebook with  -->
<!--     no useful plain-text export), say so — that saves the next      -->
<!--     agent from trying.                                              -->
<!--   * When in doubt, prefer the cheapest tool that gives you the part -->
<!--     you actually need (a page range, a single table) over loading   -->
<!--     the whole file.                                                 -->
