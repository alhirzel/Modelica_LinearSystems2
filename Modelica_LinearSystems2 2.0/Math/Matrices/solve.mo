within Modelica_LinearSystems2.Math.Matrices;
function solve
  "Solve real system of linear equations A*x=b with a b vector (Gaussian elemination with partial pivoting)"

  extends Modelica.Icons.Function;
  input Real A[:,size(A, 1)] "Matrix A of A*x = b";
  input Real b[size(A, 1)] "Vector b of A*x = b";
  output Real x[size(b, 1)] "Vector x such that A*x = b";

  annotation (Documentation(info="<HTML>
<h4>Syntax</h4>
<blockquote><pre>
Matrices.<b>solve</b>(A,b);
</pre></blockquote>
<h4>Description</h4>
<p>
This function call returns the
solution <b>x</b> of the linear system of equations
</p>
<blockquote>
<p>
<b>A</b>*<b>x</b> = <b>b</b>
</p>
</blockquote>
<p>
If a unique solution <b>x</b> does not exist (since <b>A</b> is singular),
an exception is raised.
</p>
<p>
Note, the solution is computed with the LAPACK function \"dgesv\",
i.e., by Gaussian elemination with partial pivoting.
</p>
<h4>Example</h4>
<blockquote><pre>
  Real A[3,3] = [1,2,3;
                 3,4,5;
                 2,1,4];
  Real b[3] = {10,22,12};
  Real x[3];
<b>algorithm</b>
  x := Matrices.solve(A,b);  // x = {3,2,1}
</pre></blockquote>
<h4>See also</h4>
<a href=\"Modelica://Modelica.Math.Matrices.LU\">Matrices.LU</a>,
<a href=\"Modelica://Modelica.Math.Matrices.LU_solve\">Matrices.LU_solve</a>
</HTML>"));

protected
  Integer info;
algorithm
  if size(A, 1) > 0 then
    (x,info) := Modelica.Math.Matrices.LAPACK.dgesv_vec(A, b);
    assert(info == 0, "Solving a linear system of equations with function
\"Matrices.solve\" is not possible, because the system has either
no or infinitely many solutions (A is singular).");
  else
    x := fill(0, 0);
  end if;
end solve;
