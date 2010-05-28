within Modelica_LinearSystems2.Math.Matrices.Internal;
function solve2rSym
  "Solve real system of linear equations X*A=B where A is symmetrix positive definite"

  extends Modelica.Icons.Function;
  import Modelica;
  import Modelica_LinearSystems2;
  import Modelica_LinearSystems2.Math.Matrices.LAPACK;
  input Real A[:,size(A, 1)] "Matrix A of X*A = B";
  input Real B[:,:] "Matrix B of X*op(A) = B";
  input Boolean isTriangular=false "True if the A is already lower triangular";
  input Boolean upper=false "True if A is upper triAngular";
  output Real X[size(B, 1),size(B, 2)]=B "Matrix X such that X*A = B";

protected
  Real H[size(A, 1),size(A, 2)];
  Real AA[size(A,1),size(A,1)]=if upper then A else transpose(A);

algorithm
  if not isTriangular then
    H := Matrices.cholesky(AA);
  else
    H := AA;
  end if;
  H := symmetric(H);
  X := LAPACK.dtrsm(H, X, 1, true, true, false, false);
  X := LAPACK.dtrsm(H, X, 1, true, false, false, false);

  annotation (Documentation(info="<HTML>

</HTML>"));
end solve2rSym;
