within Modelica_LinearSystems2.Utilities.Plot.Examples;
function rootLocusOfPIDDrive

algorithm
     Modelica_LinearSystems2.Utilities.Plot.rootLocusOfModel(
          "Modelica.Blocks.Examples.PID_Controller",
          {Modelica_LinearSystems2.Records.ParameterVariation(
               Name="PI.k", Value=100, Min=0, Max=1e+100, Unit="1"),
           Modelica_LinearSystems2.Records.ParameterVariation(
               Name="PI.Ti", nVar=100, logVar=true, Value=0.1, Min=1e-3, Max=10, Unit="s")});
end rootLocusOfPIDDrive;