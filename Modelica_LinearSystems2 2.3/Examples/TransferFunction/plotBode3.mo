within Modelica_LinearSystems2.Examples.TransferFunction;
function plotBode3
  "Construct 2 transfer functions and plot the Bode diagram with automatic determination of the frequency range to plot"

  import Modelica.Utilities.Streams.print;
  import Modelica_LinearSystems2.Math.Complex;
  import Modelica_LinearSystems2.TransferFunction;

  output Boolean ok;
protected
  TransferFunction tf=TransferFunction({1}, {1,0,1});

algorithm
  Modelica_LinearSystems2.TransferFunction.Plot.bode(    tf);
  ok := true;

  annotation (__Dymola_interactive=true);
end plotBode3;
