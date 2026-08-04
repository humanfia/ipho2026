# Deterministic Review Candidate Pack

Iteration: 010
Exact review target count: 1

Review only these targets. Direct Lean compilation was already run in
parallel by the orchestrator; use the recorded result instead of rerunning it.

## 1. `IPhO2026Problems/problem_IPhO_2026_3_C_1.lean`

- Compile status: passed
- Open sorries: 0
- Direct-check seconds: 9.008
- Blueprint: `blueprint/src/chapters/IPhO2026Problems_problem_IPhO_2026_3_C_1.tex`
- Reports: `.archon/task_results/physics-grounding-IPhO2026Problems_problem_IPhO_2026_3_C_1.md`

### Lean excerpt
```lean
).temperature = cycle.hotReservoirTemperature) ∧
    ((cycle.state .two).temperature = cycle.coldReservoirTemperature ∧
      (cycle.state .three).temperature = cycle.coldReservoirTemperature) ∧
    (cycle.heatTransfer .twoToThree =
      .absorbedFromCold cycle.heatAbsorbedFromCold) ∧
    (cycle.heatTransfer .fourToOne =
      .deliveredToHot cycle.heatDeliveredToHot) ∧
    cycle.heatTransfer .oneToTwo = .none ∧
    cycle.heatTransfer .threeToFour = .none := by
  obtain ⟨contact₂₃, contact₄₁⟩ :=
    identify_isothermal_reservoir_contacts cycle figure laws
  have temperatures₂₃ :=
    laws.endpoint_temperatures_at_reservoir
      .twoToThree .cold contact₂₃
  have temperatures₄₁ :=
    laws.endpoint_temperatures_at_reservoir
      .fourToOne .hot contact₄₁
  have state₁_at_hot :
      (cycle.state .one).temperature =
        cycle.hotReservoirTemperature := by
    simpa [CycleLeg.final,
      Figure3bCarnotCycle.reservoirTemperature] using temperatures₄₁.2
  have state₄_at_hot :
      (cycle.state .four).temperature =
        cycle.hotReservoirTemperature := by
    simpa [CycleLeg.initial,
      Figure3bCarnotCycle.reservoirTemperature] using temperatures₄₁.1
  have state₂_at_cold :
      (cycle.state .two).temperature =
        cycle.coldReservoirTemperature := by
    simpa [CycleLeg.initial,
      Figure3bCarnotCycle.reservoirTemperature] using temperatures₂₃.1
  have state₃_at_cold :
      (cycle.state .three).temperature =
        cycle.coldReservoirTemperature := by
    simpa [CycleLeg.final,
      Figure3bCarnotCycle.reservoirTemperature] using temperatures₂₃.2
  have heat₂₃ :
      cycle.heatTransfer .twoToThree =
        .absorbedFromCold cycle.heatAbsorbedFromCold := by
    simpa using
      laws.heat_transfer_at_reservoir .twoToThree .cold contact₂₃
  have heat₄₁ :
      cycle.heatTransfer .fourToOne =
        .deliveredToHot cycle.heatDeliveredToHot := by
    simpa using
      laws.heat_transfer_at_reservoir .fourToOne .hot contact₄₁
  have no_heat₁₂ : cycle.heatTransfer .oneToTwo = .none :=
    laws.no_reservoir_contact_has_no_heat_transfer .oneToTwo
      (laws.adiabatic_has_no_reservoir_contact
        .oneToTwo figure.one_to_two_adiabatic)
  have no_heat₃₄ : cycle.heatTransfer .threeToFour = .none :=
    laws.no_reservoir_contact_has_no_heat_transfer .threeToFour
      (laws.adiabatic_has_no_reservoir_contact
        .threeToFour figure.three_to_four_adiabatic)
  exact
    ⟨⟨state₁_at_hot, state₄_at_hot⟩,
      ⟨state₂_at_cold, state₃_at_cold⟩,
      heat₂₃, heat₄₁, no_heat₁₂, no_heat₃₄⟩

end

end ProblemIPhO2026_3_C_1
end IPhO2026Problems
... [leading content omitted]
```

### Blueprint excerpt
```tex
equilibrium would make the temperatures of states 2
  and 1 equal, contradicting the strict figure ordering.  If \(2\to3\)
  contacted the hot reservoir and \(4\to1\) the cold reservoir, endpoint
  equilibrium would turn the figure ordering into \(T_h<T_c\), contradicting
  \(T_c<T_h\).  The only remaining assignment is cold on \(2\to3\) and hot
  on \(4\to1\).
\end{proof}

\begin{theorem}[IPhO 2026 Problem 3 C.1]
  \label{thm:physics:IPhO_2026_3_C_1}
  \lean{IPhO2026Problems.ProblemIPhO2026_3_C_1.identify_temperature_labels_and_heat_processes}
  \uses{def:physics:IPhO_2026_3_C_1:aux018, def:physics:IPhO_2026_3_C_1:aux019, def:physics:IPhO_2026_3_C_1:aux020, def:physics:IPhO_2026_3_C_1:aux021, lem:physics:IPhO_2026_3_C_1:aux022}
  For a Figure 3b Carnot refrigerator satisfying the paramagnetic equation
  of state, the isothermal heat relation, and the refrigerator laws, states
  \(1\) and \(4\) have temperature \(T_h\), while states \(2\) and \(3\)
  have temperature \(T_c\).  The torus absorbs \(Q_c\) on \(2\to3\),
  delivers \(Q_h\) on \(4\to1\), and has no heat transfer on the adiabatic
  legs \(1\to2\) and \(3\to4\).
\end{theorem}
\begin{proof}
  Apply the reservoir-contact lemma to identify the two isotherms.  Endpoint
  equilibrium at those contacts gives the four temperature labels, and the
  reservoir heat-direction law gives absorption on \(2\to3\) and delivery
  on \(4\to1\).  Finally, the two adiabatic classifications read from the
  figure and the adiabatic isolation law give no heat transfer on the
  remaining legs.  The equation of state and isothermal heat relation remain
  part of the physical contract; the refrigerator-law interface already
  packages the qualitative consequences needed here.
\end{proof}
% --- Archon physics formalization source end ---
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
