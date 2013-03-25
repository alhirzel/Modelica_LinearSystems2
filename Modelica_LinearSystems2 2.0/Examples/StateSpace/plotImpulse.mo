within Modelica_LinearSystems2.Examples.StateSpace;
function plotImpulse "Impulse plot example"

  annotation (interactive=true, Documentation(info="<html>
<p>
Computes the impulse response of the system
StateSpace <i>sc = StateSpace(A=[-1,1;0,-2],B=[1, 0;0, 1],C=[1,0; 0,1],D=[0, 0; 0, 0])</i>.
</html>"));

  input Modelica_LinearSystems2.StateSpace ss=Modelica_LinearSystems2.StateSpace(
      A=[-1,1; 0,-2],
      B=[4,0; 0,2],
      C=[2,0; 0,3],
      D=[0,0; 0,0]);

algorithm
  Modelica_LinearSystems2.StateSpace.Plot.impulse(    ss=ss);

end plotImpulse;
