within Modelica_LinearSystems2.Math.Matrices;
function dare "Solution of discrete-time algebraic Riccati equations"
  import Modelica_LinearSystems2.Math.Matrices;
  import Modelica_LinearSystems2.Math.Complex;

  input Real A[:,size(A, 1)];
  input Real B[size(A, 1),:];
  input Real R[size(B, 2),size(B, 2)]=identity(size(B, 2));
  input Real Q[size(A, 1),size(A, 1)]=identity(size(A, 1));
protected
  Integer n=size(A, 1);
  Real G[size(A, 1),size(A, 1)]=B*Modelica.Math.Matrices.solve2(R, transpose(B));
  Real invAT[:,:]=transpose(Modelica.Math.Matrices.inv(A));
  Real H[:,:]=[A + G*invAT*Q,-G*invAT; -invAT*Q,invAT];
  Real H_RSF[:,:]=H;
  Real Z[size(H, 1),size(H, 2)];
  Real Z11[size(A, 1),size(A, 2)];
  Real Z21[size(A, 1),size(A, 2)];
  Real alphaReal[size(H, 1)] "Real part of eigenvalue=alphaReal+i*alphaImag";
  Real alphaImag[size(H, 1)]
    "Imaginary part of eigenvalue=(alphaReal+i*alphaImag";

  Integer info;
  Integer evSize;
  Complex j = Modelica_LinearSystems2.Math.Complex.j();
public
  output Real S[size(A, 1),size(A, 2)]
    "orthogonal matrix of the Schur vectors associated to ordered rsf";
  output Complex ev[size(A, 1)] "eigenvalues of the closed loop system";

algorithm
  (H_RSF,Z,alphaReal,alphaImag) := Matrices.rsf(H);// put H to Schur form
  (H_RSF,Z,alphaReal,alphaImag) := Matrices.Internal.reorderRSF(
    false,
    H_RSF,
    Z,
    alphaReal,
    alphaImag);// ordered Schur form
    evSize := size(ev, 1);
  for i in 1:evSize loop
    ev[i] := alphaReal[i] + j*alphaImag[i];
  end for;

  Z11 := Z[1:n, 1:n];
  Z21 := Z[n + 1:2*n, 1:n];
  if size(Z11, 1) > 0 then
//  S := transpose(Matrices.solve2(transpose(Z11), transpose(Z21)));
    (S,info) := Matrices.LAPACK.dgesvx(Z11, transpose(Z21));//function does not need to transpose Z11 as solve2 does
    S := transpose(S);
    assert(info == 0, "Solving a linear system of equations with function
\"Matrices.LAPACK.dgesvx\" is not possible, because the system has either
no or infinitely many solutions (input A is singular).");
  else
    S := fill(
      0,
      size(Z21, 1),
      size(Z11, 1));
  end if;

  annotation (Documentation(info="<html>
Function <b>dare</b> computes the solution <b>X</b> of the discrete-time algebraic Riccati equation
<blockquote><pre>
                                 -1
 <b>X</b> = <b>A</b>'*<b>X</b>*<b>A</b> - <b>A</b>'*<b>X</b>*<b>B</b>*(<b>R</b> + <b>B</b>'*<b>X</b>*<b>B</b>)  *<b>B</b>'*<b>X</b>*<b>A</b> + <b>Q</b>
</pre>
</blockquote>
using the Schur vector approach proposed by Laub [1].
<p>
It is assumed that <b>Q</b> is symmetric and positve semidefinite and <b>R</b> is symmetric, nonsingular and positive definite,
(<b>A</b>,<b>B</b>) is stabilizable and (<b>A</b>,<b>Q</b>) is detectable.
<p><b>
The assumptions are not checked in this function
</b>

<p>
The assumptions guarantee that the Hamiltonian matrix
<blockquote><pre>
      -1  -1       -1        -1
<b>H</b> = [<b>A</b>, -<b>A</b>  *<b>G</b>; <b>Q</b>*<b>A</b>, <b>A</b>' + <b>Q</b>*<b>A</b>  *<b>G</b> ]
</pre></blockquote>
with
<blockquote><pre>
       -1
<b>G</b> = <b>B</b>*<b>R</b> *<b>B</b>'
</pre>
</blockquote>
has no eigenvalue on the unit circle and can be put
to an ordered real Schur form
<blockquote><pre>
<b>U</b>'*<b>H</b>*<b>U</b> = <b>S</b> = [<b>S11</b>, <b>S12</b>; <b>0</b>, <b>S22</b>]
</pre></blockquote>
with orthogonal similarity transformation <b>U</b>. <b>S</b> is ordered in such a way,
that <b>S11</b> contains the n stable eigenvalues of the closed loop system with system matrix
<blockquote><pre>
                  -1
<b>A</b> - <b>B</b>*(<b>R</b> + <b>B</b>'*<b>X</b>*<b>B</b>)  *<b>B</b>'*<b>X</b>*<b>A</b>
</pre>
</blockquote>
If <b>U</b> is partitioned to
<blockquote><pre>
<b>U</b> = [<b>U11</b>, <b>U12</b>; <b>U21</b>, <b>U22</b>]
</pre></blockquote>
according to <b>S</b>, the solution <b>X</b> can be calculated by
<blockquote><pre>
<b>X</b>*<b>U11</b> = <b>U21</b>.
</pre></blockquote>

The algorithm uses LAPACK routines dgehrd (to compute the upper Hessenberg matrix of <b>H</b>), dorghr (to calculate the orthogonal
matrix from the elementary reflectors as returned from dgehrd), dhseqr (to put transformed <b>H</b> to Schur form and to calculate the eigenvalues
of the closed loop system) and dtrsen (to compute the ordered real Schur form and matrix <b>U</b>).
<p>

<A name=\"References\"><B><FONT SIZE=\"+1\">References</FONT></B></A>
<PRE>
  [1] Laub, A.J.
      A Schur Method for Solving Algebraic Riccati equations.
      IEEE Trans. Auto. Contr., AC-24, pp. 913-921, 1979.
</PRE>
</html>"));
end dare;
