within Modelica_LinearSystems2.Examples.StateSpace;
function analysisPolesAndZeros_SISO
  "Compute poles and invariant zeros of a SISO state space system by transformation to a minmal system"
  import Modelica_LinearSystems2.StateSpace;
  import Modelica_LinearSystems2.Math.Complex;

  input String fileName="NoName" "file where matrix [A, B; C, D] is stored" annotation(Dialog(group="system data definition",loadSelector(filter="MAT files (*.mat);; All files (*.*)",
                      caption="state space system data file"),enable = systemOnFile));
  input String matrixName="ABCD" "Name of the state space system matrix"   annotation(Dialog(group="system data definition",enable = systemOnFile));

  input Real A[:,:]=[-1.0,0.0,0.0; 0.0,-2.0,0.0; 0.0,0.0,-3.0] annotation(Dialog(group="system matrices",enable = not systemOnFile));
  input Real B[:,:]=[1.0; 1.0; 0.0] annotation(Dialog(group="system matrices",enable = not systemOnFile));
  input Real C[:,:]=[1.0,1.0,1.0] annotation(Dialog(group="system matrices",enable = not systemOnFile));
  input Real D[:,:]=[0.0] annotation(Dialog(group="system matrices",enable = not systemOnFile));

  output Boolean ok;

protected
  Boolean systemOnFile=fileName <> "NoName";

  Modelica_LinearSystems2.StateSpace ss=if systemOnFile then
      Modelica_LinearSystems2.StateSpace.Import.fromFile(  fileName, matrixName) else
      Modelica_LinearSystems2.StateSpace(
      A=A,
      B=B,
      C=C,
      D=D);
  StateSpace ssm=Modelica_LinearSystems2.StateSpace.Transformation.toIrreducibleForm(
                                                                 ss);
  Complex poles[:];
  Complex zeros[:];

algorithm
  poles := Complex.eigenValues(ssm.A);

  for i in 1:size(poles, 1) loop

    Modelica.Utilities.Streams.print("pole_" + String(i) + " = " + String(poles[i]));
  end for;

  zeros := Modelica_LinearSystems2.StateSpace.Analysis.invariantZeros(
                                      ssm);

  for i in 1:size(zeros, 1) loop
     Modelica.Utilities.Streams.print("zero_" + String(i) + " = " + String(zeros[i]));
  end for;

  ok := true;

end analysisPolesAndZeros_SISO;
