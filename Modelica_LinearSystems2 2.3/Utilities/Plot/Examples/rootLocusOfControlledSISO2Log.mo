within Modelica_LinearSystems2.Utilities.Plot.Examples;
function rootLocusOfControlledSISO2Log
algorithm
   Modelica_LinearSystems2.Utilities.Plot.rootLocusOfModel(
        "Modelica_LinearSystems2.Utilities.Plot.Examples.Utilities.ControlledSISO2",
        modelParam={Modelica_LinearSystems2.Records.ParameterVariation(
                      Name="k", grid=Modelica_LinearSystems2.Types.Grid.Logarithmic, nPoints=100, Min=0.0001, Max=10)});
annotation(__Dymola_interactive=true);
end rootLocusOfControlledSISO2Log;
