within Modelica_LinearSystems2.Examples.StateSpace;
function designKalmanFilter "Example for Kalman filter design"
  import Modelica_LinearSystems2.Math.Complex;
  import Modelica_LinearSystems2.StateSpace;
  import Modelica_LinearSystems2.TransferFunction;
  extends Modelica.Icons.Function;

  input StateSpace ss=Modelica_LinearSystems2.StateSpace(TransferFunction(n={1},
      d={1,2,3,4}));
  input Real Q[:, :]=identity(size(ss.A, 1));
  input Real R[:, :]=identity(size(ss.C, 1));
  output Real L[:, :];
  output StateSpace kss(
    redeclare Real A[size(ss.A, 1), size(ss.A, 1)],
    redeclare Real B[size(ss.B, 1), size(ss.B, 2) + size(ss.C, 1)],
    redeclare Real C[size(ss.A, 1), size(ss.A, 2)],
    redeclare Real D[size(ss.A, 1), size(ss.B, 2) + size(ss.C, 1)]);
algorithm
  (L,kss) := StateSpace.Design.kalmanFilter(
    ss,
    Q,
    R);

  annotation (__Dymola_interactive=true, Documentation(info="<html>
This example demonstrates the computatrion of a  Kalman filter by calling function <b>StateSpace.Design.kalmanFilter()</b>
</html>"));
end designKalmanFilter;
