# Blueprint Writer Report: 1-c-2-rest

**Status:** COMPLETE

## Changes

- Kept all prior content (source paragraphs, target theorem, iter-008 structure entries, exemption NOTE).
- Added `\subsection*{Threshold calibration and the $\pi/6$ official value}` with 8 blocks in directive dependency order; statements/proofs restated first-hand from the .lean docstrings; every official numeric kept conclusion-side only:
  - `def:...:C2CalibratedData` (`\uses PhotoDissociationConstants`): theta=pi/6, DeltaU=1.10 eV / DeltaU_J=DeltaU_eV*eV, m=16.0 amu / m_kg, ratio=DeltaU_J/(3 m_kg cSI^2) with equation certificates.
  - `def:...:hbarOmegaMin`: C.1 formula `3mc2(1-sqrt(1-(DeltaU/(3mc2))(2sin^2+1)))/(2sin^2+1)`; derivation-sketch proof (energy+momentum conservation, eliminate O momentum, d/dP=0 minimum condition).
  - `lem:...:angular_factor_at_pi_div_six`: `2sin^2(pi/6)+1 = 3/2` from `sin(pi/6)=1/2` (proved on disk).
  - `def:...:hbarOmegaMinAtPiDivSix` (`\uses angular_factor`): `(1/(3/2))(3mc2)(1-sqrt(1-3r/2))`.
  - `thm:...:hbarOmegaMin_at_pi_div_six` (`\uses hbarOmegaMin, angular_factor, hbarOmegaMinAtPiDivSix`): bridge at `3mc2 != 0` (proved on disk).
  - `def:...:ThresholdRealizable` (`\uses` all four structures): exists lawful state at calibrated theta, m, DeltaU with `hbar*omega = E`.
  - `thm:...:excess_photon_energy_at_threshold` (`\uses` constants, data, hbarOmegaMin, ThresholdRealizable, rest_energy_gap_nonneg): `0 < gap_eV /\ |gap_eV - 2.03e-11| < 5e-14` (sorry on disk; recorded value conclusion-side).
  - `thm:...:excess_photon_energy_pi_div_six_form` (`\uses` + AtPiDivSix, bridge, at-threshold thm).
- Wired `thm:physics:IPhO_2026_1_C_2:target` `\uses{}` to `thm:...:excess_photon_energy_pi_div_six_form`.

## Pins / verification

- leandag (run from `science-mango/.venv`; tool absent from this repo PATH): 0 conflicts, 0 unknown_uses (single project-wide residual `..._4_A_5:main` predates this edit, other chapter), 0 unmatched `IPhO2026_1_C_2.*` decls, 0 isolated nodes in chapter; LaTeX envs balanced.
- Note (informational, no action): disk `hbarOmegaMin` has no literal factor 2 inside the sqrt, so its docstring's leading-term gap-scale reading is a series-only reading; the transcribed statements match the disk exactly and the target theorems remain `sorry` on disk.
