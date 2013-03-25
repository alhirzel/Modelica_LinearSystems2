within Modelica_LinearSystems2.Math.Matrices;
function QR
  "QR decomposition of a square matrix without column pivoting (A = Q*R)"

  input Real A[:,:] "Rectangular matrix with size(A,1) >= size(A,2)";
  output Real Q[size(A, 1),size(A, 2)]
    "Rectangular matrix with orthonormal columns such that Q*R=A[:,p]";
  output Real R[min(size(A,1),size(A, 2)),size(A, 2)]
    "Square upper triangular matrix";

  output Real tau[min(size(A, 1), size(A, 2))];
  output Real Q2[:,:]
  annotation ( Documentation(info="<HTML>
<h4>Syntax</h4>
<blockquote><pre>
(Q,R,p) = Matrices.<b>QR</b>(A);
</pre></blockquote>
<h4>Description</h4>
<p>
This function returns the QR decomposition of
a rectangular matrix <b>A</b> (the number of columns of <b>A</b>
must be less than or equal to the number of rows):
</p>
<blockquote>
<p>
<b>Q</b>*<b>R</b> = <b>A</b>[:,<b>p</b>]
</p>
</blockquote>
<p>
where <b>Q</b> is a rectangular matrix that has orthonormal columns and
has the same size as A (<b>Q</b><sup>T</sup><b>Q</b>=<b>I</b>),
<b>R</b> is a square, upper triangular matrix and <b>p</b> is a permutation
vector. Matrix <b>R</b> has the following important properties:
</p>
<ul>
<li> The absolute value of a diagonal element of <b>R</b> is the largest
     value in this row, i.e.,
     abs(R[i,i]) &ge; abs(R[i,j]).</li>
<li> The diagonal elements of <b>R</b> are sorted according to size, such that
     the largest absolute value is abs(R[1,1]) and
     abs(R[i,i]) &ge; abs(R[j,j]) with i &lt; j. </li>
</ul>
<p>
This means that if abs(R[i,i]) &le; &epsilon; then abs(R[j,k]) &le; &epsilon;
for j &ge; i, i.e., the i-th row up to the last row of <b>R</b> have
small elements and can be treated as being zero.
This allows to, e.g., estimate the row-rank
of <b>R</b> (which is the same row-rank as <b>A</b>). Furthermore,
<b>R</b> can be partitioned in two parts
</p>
<blockquote>
<pre>
   <b>A</b>[:,<b>p</b>] = <b>Q</b> * [<b>R</b><sub>1</sub>, <b>R</b><sub>2</sub>;
                 <b>0</b>,  <b>0</b>]
</pre>
</blockquote>
<p>
where <b>R</b><sub>1</sub> is a regular, upper triangular matrix.
</p>
<p>
Note, the solution is computed with the LAPACK functions \"dgeqp3\"
and \"dorgqr\", i.e., by Housholder transformations with
column pivoting. If <b>Q</b> is not needed, the function may be
called as: <code>(,R,p) = QR(A)</code>.
</p>
<h4>Example</h4>
<blockquote><pre>
  Real A[3,3] = [1,2,3;
                 3,4,5;
                 2,1,4];
  Real R[3,3];
<b>algorithm</b>
  (,R) := Matrices.QR(A);  // R = [-7.07.., -4.24.., -3.67..;
                                    0     , -1.73.., -0.23..;
                                    0     ,  0     ,  0.65..];
</pre></blockquote>
</HTML>"));

protected
  Integer nrow=size(A, 1);
  Integer ncol=size(A, 2);
  Integer minrowcol=min(nrow,ncol);
  Integer lwork=Internal.dgeqrf_workdim(A);

algorithm
  if minrowcol > 0 then

    (Q,tau) := Modelica_LinearSystems2.Math.Matrices.LAPACK.dgeqrf(A, lwork);

  // determine R
    R := zeros(minrowcol, ncol);
    for i in 1:minrowcol loop
      for j in i:ncol loop
        R[i, j] := Q[i, j];
      end for;
    end for;

//  Q2 := Modelica.Math.Matrices.LAPACK.dorgqr(Q, tau);
//  Q2 := Modelica_LinearSystems2.Math.Matrices.LAPACK.dorgqr(Q, tau);
    Q2 := Modelica_LinearSystems2.Math.Matrices.LAPACK.dorgqr_x(Q, tau);
  else
    Q := fill(
      1,
      size(A, 1),
      0);
    R := fill(
      0,
      0,
      0);
  end if;
end QR;
