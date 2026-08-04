# Deterministic Plan Candidate Pack

Iteration: 010
Exact objective count: 1

The loop has already selected and written these objectives. Do not scan
the rest of the corpus and do not replace, reorder, add, or remove targets.
Use the excerpts below only to write a concise per-target proof strategy.

## 1. `IPhO2026Problems/problem_IPhO_2026_3_C_1.lean`

- Open placeholders: 2
- Proof Review: new; attempts=0
- Review reason: (none)
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_1.tex`

### Lean excerpt
```lean
... [prefix omitted]
voirTemperature reservoir ∧
          (cycle.state leg.final).temperature =
            cycle.reservoirTemperature reservoir
  /-- Refrigerator operation fixes the heat direction at either reservoir. -/
  heat_transfer_at_reservoir :
    ∀ (leg : CycleLeg) (reservoir : Reservoir),
      cycle.reservoirContact leg = some reservoir →
        cycle.heatTransfer leg =
          match reservoir with
          | .cold => .absorbedFromCold cycle.heatAbsorbedFromCold
          | .hot => .deliveredToHot cycle.heatDeliveredToHot
  /-- The qualitative transfer record agrees with signed heat into the torus. -/
  signed_heat_agrees_with_transfer : ∀ leg : CycleLeg,
    match cycle.heatTransfer leg with
    | .none => heatInJoules (cycle.signedHeatEntering leg) = 0
    | .absorbedFromCold magnitude =>
        heatInJoules (cycle.signedHeatEntering leg) =
          heatInJoules magnitude
    | .deliveredToHot magnitude =>
        heatInJoules (cycle.signedHeatEntering leg) =
          -heatInJoules magnitude

/-! ## Derived identification requested in C.1 -/

/--
The lower-temperature isothermal leg must contact the cold reservoir, while
the higher-temperature isothermal leg must contact the hot reservoir.
-/
theorem identify_isothermal_reservoir_contacts
    (cycle : Figure3bCarnotCycle)
    (figure : Figure3bGeometry cycle)
    (laws : SatisfiesCarnotRefrigeratorLaws cycle) :
    cycle.reservoirContact .twoToThree = some .cold ∧
      cycle.reservoirContact .fourToOne = some .hot := by
  sorry

/--
**IPhO 2026 Problem 3 C.1.**

States `1` and `4` are at `T_h`, states `2` and `3` are at `T_c`,
`Q_c` is absorbed on `2 → 3`, and `Q_h` is delivered on `4 → 1`.
-/
theorem identify_temperature_labels_and_heat_processes
    (cycle : Figure3bCarnotCycle)
    (figure : Figure3bGeometry cycle)
    (laws : SatisfiesCarnotRefrigeratorLaws cycle)
    (_equationOfState : SatisfiesParamagneticEquationOfState cycle)
    (_isothermalHeatRelation : SatisfiesIsothermalHeatRelation cycle) :
    ((cycle.state .one).temperature = cycle.hotReservoirTemperature ∧
      (cycle.state .four).temperature = cycle.hotReservoirTemperature) ∧
    ((cycle.state .two).temperature = cycle.coldReservoirTemperature ∧
      (cycle.state .three).temperature = cycle.coldReservoirTemperature) ∧
    (cycle.heatTransfer .twoToThree =
      .absorbedFromCold cycle.heatAbsorbedFromCold) ∧
    (cycle.heatTransfer .fourToOne =
      .deliveredToHot cycle.heatDeliveredToHot) ∧
    cycle.heatTransfer .oneToTwo = .none ∧
    cycle.heatTransfer .threeToFour = .none := by
  sorry

end

end ProblemIPhO2026_3_C_1
end IPhO2026Problems
```

### Blueprint excerpt
```tex
... [prefix omitted]
ture records positivity and the reusable isothermal equation for
  every leg classified as isothermal.
\end{proof}

\begin{definition}[Carnot refrigerator laws]
  \label{def:physics:IPhO_2026_3_C_1:aux021}
  \lean{IPhO2026Problems.ProblemIPhO2026_3_C_1.SatisfiesCarnotRefrigeratorLaws}
  \uses{def:physics:IPhO_2026_3_C_1:aux005, def:physics:IPhO_2026_3_C_1:aux006, def:physics:IPhO_2026_3_C_1:aux008, def:physics:IPhO_2026_3_C_1:aux009, def:physics:IPhO_2026_3_C_1:aux010, def:physics:IPhO_2026_3_C_1:aux011, def:physics:IPhO_2026_3_C_1:aux012, def:physics:IPhO_2026_3_C_1:aux013, def:physics:IPhO_2026_3_C_1:aux014, def:physics:IPhO_2026_3_C_1:aux016, def:physics:IPhO_2026_3_C_1:aux017}
  Both reservoir temperatures are positive, the cold temperature is strictly
  below the hot temperature, and the heat magnitudes are nonnegative.
  Isothermal legs have reservoir contacts, contacted endpoints equilibrate
  with that reservoir, and the contact fixes the heat direction.  Adiabatic
  legs have no contact and no transfer, and the qualitative transfer agrees
  with signed heat into the torus.
\end{definition}
\begin{proof}
  Each stated thermodynamic consequence is an explicit field of the
  refrigerator-law interface, uniformly quantified over the cycle legs.
\end{proof}

\begin{lemma}[Identify the two reservoir contacts]
  \label{lem:physics:IPhO_2026_3_C_1:aux022}
  \lean{IPhO2026Problems.ProblemIPhO2026_3_C_1.identify_isothermal_reservoir_contacts}
  \uses{def:physics:IPhO_2026_3_C_1:aux005, def:physics:IPhO_2026_3_C_1:aux007, def:physics:IPhO_2026_3_C_1:aux008, def:physics:IPhO_2026_3_C_1:aux012, def:physics:IPhO_2026_3_C_1:aux016, def:physics:IPhO_2026_3_C_1:aux017, def:physics:IPhO_2026_3_C_1:aux018, def:physics:IPhO_2026_3_C_1:aux021}
  The isothermal leg \(2\to3\) contacts the cold reservoir, and the
  isothermal leg \(4\to1\) contacts the hot reservoir.
\end{lemma}
\begin{proof}
  The figure and the isothermal-contact law give one of the two finite
  reservoir labels for each isotherm.  If both contacts used the same
  reservoir, endpoint equilibrium would make the temperatures of states 2
  and 1 equal, contradicting the strict figure ordering.  If \(2\to3\)
  contacted the hot reservoir and \(4\to1\) the cold reservoir, endpoint
  equilibrium would turn the figure ordering into \(T_h<T_c\), contradicting
  \(T_c<T_h\).  The only remaining assignment is cold on \(2\to3\) and hot
  on \(4\to1\).
\end{proof}
% --- Archon physics formalization source end ---
```
