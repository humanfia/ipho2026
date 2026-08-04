# Deterministic Review Candidate Pack

Iteration: 009
Exact review target count: 1

Review only these targets. Direct Lean compilation was already run in
parallel by the orchestrator; use the recorded result instead of rerunning it.

## 1. `IPhO2026Problems/problem_IPhO_2026_3_C_1.lean`

- Compile status: passed
- Open sorries: 2
- Direct-check seconds: 8.611
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_1.tex`
- Reports: `.archon/task_results/IPhO2026Problems_problem_IPhO_2026_3_C_1.lean.md`, `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_C_1.md`

### Lean excerpt
```lean
e reservoir ∧
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
... [leading content omitted]
```

### Blueprint excerpt
```tex
servoir temperatures are positive, the cold temperature is strictly
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
... [leading content omitted]
```

### Report excerpt: `IPhO2026Problems_problem_IPhO_2026_3_C_1.lean.md`
```markdown
Physlib currently lacks an amount-of-substance base dimension in this model,
  so amount and the Curie constant remain explicitly named coherent-SI scalar
  readouts. This is a documented projection compromise, not a collapse of
  volume, field strength, magnetization, permeability, temperature, or heat.

## Grounding gaps and redraft requests

- **Physics/library grounding:** no unresolved gap. The retained local
  abstractions expose all mathematical consequences needed by the C.1
  derivation.
- **DAG navigation:** the prompt states that `archon` is on `PATH`, but
  invoking `archon dag-query ...` returns `command not found`. The blueprint
  itself supplies the exact dependency list, so this did not block the
  formalization audit.
- **Lake target registration:** the requested dotted module is not registered
  as a Lake target. If target-level `lake build
  IPhO2026Problems.problem_IPhO_2026_3_C_1` is mandatory for later automation,
  the project configuration must register `IPhO2026Problems` as a library
  root or the automation must validate the file with `lake env lean`. No
  configuration edit was made because this lane may edit only the assigned
  Lean file and this report.
... [leading content omitted]
```

### Report excerpt: `physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_C_1.md`
```markdown
`IPhO2026Problems.ProblemIPhO2026_3_C_1.ProcessKind`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.ProblemIPhO2026_3_C_1.Reservoir`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.ProblemIPhO2026_3_C_1.SatisfiesCarnotRefrigeratorLaws`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.ProblemIPhO2026_3_C_1.SatisfiesIsothermalHeatRelation`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.ProblemIPhO2026_3_C_1.SatisfiesParamagneticEquationOfState`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.
- `IPhO2026Problems.ProblemIPhO2026_3_C_1.TorusState`: blueprint-local physics/modeling abstraction; must preserve the physical role instead of erasing it to a bare scalar.

## Grounding gaps

- No unresolved LeanExplore grounding gaps were recorded by this preflight.
... [leading content omitted]
```
