within Modelica_LinearSystems2.Utilities.Import.Examples;
function linearizeDoublePendulum "Linearize double pendulum"
  output Real A[:,:] "A-matrix";
  output Real B[:,:] "B-matrix";
  output Real C[:,:] "C-matrix";
  output Real D[:,:] "D-matrix";
  output String inputNames[:] "Modelica names of inputs";
  output String outputNames[:] "Modelica names of outputs";
  output String stateNames[:] "Modelica names of states";
algorithm
  (A,B,C,D,inputNames,outputNames,stateNames) :=
    Modelica_LinearSystems2.Utilities.Import.linearize(
    "Modelica_LinearSystems2.Utilities.Plants.DoublePendulum",
    1.0);
  annotation(__Dymola_interactive=true);
end linearizeDoublePendulum;
