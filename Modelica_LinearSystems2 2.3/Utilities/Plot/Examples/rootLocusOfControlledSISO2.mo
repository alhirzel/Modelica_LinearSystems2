within Modelica_LinearSystems2.Utilities.Plot.Examples;
function rootLocusOfControlledSISO2
algorithm
   Modelica_LinearSystems2.Utilities.Plot.rootLocusOfModel(
        "Modelica_LinearSystems2.Utilities.Plot.Examples.Utilities.ControlledSISO2",
        modelParam={Modelica_LinearSystems2.Records.ParameterVariation(
                      Name="k", grid=Modelica_LinearSystems2.Types.Grid.Equidistant, nPoints=100, Min=0, Max=10)});
annotation(__Dymola_interactive=true);
end rootLocusOfControlledSISO2;
