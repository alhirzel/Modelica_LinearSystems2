within Modelica_LinearSystems2.Internal;
function printComplexVector "Print elements of vector of complex numbers"
  import Modelica.Utilities.Streams.print;
  import Modelica_LinearSystems2.Math.Complex;

  input String name "Name of vector c";
  input Complex c[:] "Vector of complex numbers";

algorithm
  print(name + " =");
  for i in 1:size(c, 1) loop
    print("   " + String(c[i]));
  end for;
end printComplexVector;
