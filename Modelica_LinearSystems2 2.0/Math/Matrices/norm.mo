within Modelica_LinearSystems2.Math.Matrices;
function norm "Returns the norm of a matrix"
  extends Modelica.Icons.Function;
  input Real A[:,:] "Input matrix";
  input Real p(min=1) = 2
    "Type of p-norm (only allowed: 1, 2 or Modelica.Constants.inf)";
  output Real result=0.0 "p-norm of matrix A";

  annotation (Documentation(info="<HTML>
<h4>Syntax</h4>
<blockquote><pre>
Matrices.<b>norm</b>(A);
Matrices.<b>norm</b>(A, p=2);
</pre></blockquote>
<h4>Description</h4>
<p>
The function call \"<code>Matrices.norm(A)</code>\" returns the
2-norm of matrix A, i.e., the largest singular value of A.<br>
The function call \"<code>Matrices.norm(A, p)</code>\" returns the
p-norm of matrix A. The only allowed values for p are</p>
<ul>
<li> \"p=1\": the largest column sum of A</li>
<li> \"p=2\": the largest singular value of A</li>
<li> \"p=Modelica.Constants.inf\": the largest row sum of A</li>
</ul>
<p>
Note, for any matrices A1, A2 the following inequality holds:
</p>
<blockquote><pre>
Matrices.<b>norm</b>(A1+A2,p) &le; Matrices.<b>norm</b>(A1,p) + Matrices.<b>norm</b>(A2,p)
</pre></blockquote>
<p>
Note, for any matrix A and vector v the following inequality holds:
</p>
<blockquote><pre>
Vectors.<b>norm</b>(A*v,p) &le; Matrices.<b>norm</b>(A,p)*Vectors.<b>norm</b>(A,p)
</pre></blockquote>
</HTML>"));
algorithm
  if p == 1 then
    // column sum norm
    for i in 1:size(A, 2) loop
      result := max(result, sum(abs(A[:, i])));
    end for;
  elseif p == 2 then
    // largest singular value
    result := if min(size(A)) > 0 then max(
      Modelica.Math.Matrices.singularValues(A)) else 0;
  elseif p == Modelica.Constants.inf then
    // row sum norm
    for i in 1:size(A, 1) loop
      result := max(result, sum(abs(A[i, :])));
    end for;
  else
    assert(false, "Optional argument \"p\" of function \"norm\" must be
1, 2 or Modelica.Constants.inf");
  end if;
end norm;
