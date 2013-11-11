within Modelica_LinearSystems2.Math.Matrices;
function hessenberg "Transform a matrix to upper Hessenberg form"
  import Modelica;
  import Modelica_LinearSystems2.Math.Matrices;

  input Real A[:,:] "Square matrix A";

  output Real H[size(A, 1),size(A, 2)] "Hessenberg form of A";
  output Real U[size(A, 1),size(A, 2)] "Transformation matrix";

protected
  Real V[size(A, 1),size(A, 2)]
    "V=[v1,v2,..vn-1,0] with vi are vectors which define the elementary reflectors";
  Real tau[max(0,size(A, 1) - 1)] "Scalar factors of the elementary reflectors";

algorithm
  (H, V, tau) := Matrices.toUpperHessenberg(A, 1, size(A, 1));
   U := Matrices.LAPACK.dorghr(V,1,size(A, 1),tau);
  annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
     H = Matrices.<b>hessenberg</b>(A);
(H, U) = Matrices.<b>hessenberg</b>(A);
</pre></blockquote>

<h4>Description</h4>
<p>
Function <b>hessenberg</b> computes the Hessenberg matrix <b>H</b>
of matrix <b>A</b> as well as the orthogonal transformation matrix
<b>U</b> that holds <b>H</b> = <b>U</b>'*<b>A</b>*<b>U</b>.
The Hessenberg form of a matrix is computed by repeated Householder
similarity transformation. The elementary reflectors and the corresponding
scalar factors are provided by function \"Utilities.toUpperHessenberg()\".
The transformation matrix <b>U</b> is then computed by
<a href=\"modelica://Modelica.Math.Matrices.LAPACK.dorghr\">LAPACK.dorghr</a>.
</p>

<h4>Example</h4>
<blockquote><pre>
  A  = [1, 2,  3;
        6, 5,  4;
        1, 0,  0];

  (H, U) = hessenberg(A);

  results in:

  H = [1.0,  -2.466,  2.630;
      -6.083, 5.514, -3.081;
       0.0,   0.919, -0.514]

  U = [1.0,    0.0,      0.0;
       0.0,   -0.9864,  -0.1644;
       0.0,   -0.1644,   0.9864]

  and therefore,

  u*H*transpose(U) = [1.0, 2.0, 3.0;
                      6.0, 5.0, 4.0;
                      1.0, 0.0, 0.0]
</pre></blockquote>

<h4>See also</h4>
<p>
<a href=\"modelica://Modelica.Math.Matrices.Utilities.toUpperHessenberg\">Matrices.Utilities.toUpperHessenberg</a>
</p>
</html>",
        revisions="<html>
<table border=\"1\" cellspacing=\"0\" cellpadding=\"2\">
  <tr>
    <th>Date</th>
    <th>Author</th>
    <th>Comment</th>
  </tr>
  <tr>
    <td valign=\"top\">2010-05-31</td>
    <td valign=\"top\">Marcus Baur, DLR-RM</td>
    <td valign=\"top\">Realization</td>
  </tr>
</table>
</html>"));
end hessenberg;
