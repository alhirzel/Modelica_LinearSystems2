within Modelica_LinearSystems2.Math.Matrices.LAPACK;
function dgees
  "Computes real Schur form T of  real nonsymmetric matrix A, and, optionally, the matrix of Schur vectors Z as well as the eigenvalues"

  input Real A[:,size(A,1)] "Square matrix";
  output Real T[size(A, 1), size(A, 2)]=A "Real Schur form with A = Z*T*Z'";
  output Real Z[size(A, 1), size(A, 1)] "orthogonal matrix Z of Schur vectors";
  output Real eval_real[size(A, 1)] "real part of the eigenvectors of A";
  output Real eval_imag[size(A, 1)] "imaginary part of the eigenvectors of A";
  output Integer info;

protected
  Integer n=size(A, 1) "Row dimension of A";
  Integer lda=max(1,n);
  Integer sdim=0;
  Boolean bwork[n];

  external "FORTRAN 77" c_inter_dgees("V", "N", n, T, lda, sdim, eval_real, eval_imag, Z, lda, bwork, info) 
  annotation (Include=" 
#include<f2c.h>
logical select_(doublereal *par1, doublereal *par2)
{
return false;
};
  #include<f2c.h>

extern  int dgees_(char *, char *, L_fp, integer *, doublereal *, integer *, integer *, doublereal *, doublereal *,
                   doublereal *, integer *, doublereal *, integer *, logical *, integer *);
extern logical select_(doublereal *par1, doublereal *par2);   

int c_inter_dgees_(char *jobvs, char *sort, integer *n, doublereal *a, integer *lda, integer *sdim, doublereal *wr, 
        doublereal *wi, doublereal *z, integer *ldz, logical *bwork, integer *info) 
{
                
  
  doublereal *work;
  integer nn=*n;
  integer lwork=-1;
  
  
   work = (doublereal *) malloc((3*nn+1)*sizeof(doublereal));
   dgees_(jobvs, sort, (L_fp)select_, n, a, lda, sdim, wr, wi, z, ldz, work, &lwork, bwork, info);
   lwork=(int)(work[0]);
   free(work);
   work = (doublereal *) malloc((lwork+1)*sizeof(doublereal));
   dgees_(jobvs, sort, (L_fp)select_, n, a, lda, sdim, wr, wi, z, ldz, work, &lwork, bwork, info);
  free(work);
  return 0;
  }", Library={"lapack"});

  annotation (Documentation(info="
   Purpose   
    =======   

    DGEES computes for an N-by-N real nonsymmetric matrix A, the   
    eigenvalues, the real Schur form T, and, optionally, the matrix of   
    Schur vectors Z.  This gives the Schur factorization A = Z*T*(Z**T).   

    Optionally, it also orders the eigenvalues on the diagonal of the   
    real Schur form so that selected eigenvalues are at the top left.   
    The leading columns of Z then form an orthonormal basis for the   
    invariant subspace corresponding to the selected eigenvalues.   

    A matrix is in real Schur form if it is upper quasi-triangular with   
    1-by-1 and 2-by-2 blocks. 2-by-2 blocks will be standardized in the   
    form   
            [  a  b  ]   
            [  c  a  ]   

    where b*c < 0. The eigenvalues of such a block are a +- sqrt(bc).   

    Arguments   
    =========   

    JOBVS   (input) CHARACTER*1   
            = 'N': Schur vectors are not computed;   
            = 'V': Schur vectors are computed.   

    SORT    (input) CHARACTER*1   
            Specifies whether or not to order the eigenvalues on the   
            diagonal of the Schur form.   
            = 'N': Eigenvalues are not ordered;   
            = 'S': Eigenvalues are ordered (see SELECT).   

    SELECT  (external procedure) LOGICAL FUNCTION of two DOUBLE PRECISION arguments   
            SELECT must be declared EXTERNAL in the calling subroutine.   
            If SORT = 'S', SELECT is used to select eigenvalues to sort   
            to the top left of the Schur form.   
            If SORT = 'N', SELECT is not referenced.   
            An eigenvalue WR(j)+sqrt(-1)*WI(j) is selected if   
            SELECT(WR(j),WI(j)) is true; i.e., if either one of a complex   
            conjugate pair of eigenvalues is selected, then both complex   
            eigenvalues are selected.   
            Note that a selected complex eigenvalue may no longer   
            satisfy SELECT(WR(j),WI(j)) = .TRUE. after ordering, since   
            ordering may change the value of complex eigenvalues   
            (especially if the eigenvalue is ill-conditioned); in this   
            case INFO is set to N+2 (see INFO below).   

    N       (input) INTEGER   
            The order of the matrix A. N >= 0.   

    A       (input/output) DOUBLE PRECISION array, dimension (LDA,N)   
            On entry, the N-by-N matrix A.   
            On exit, A has been overwritten by its real Schur form T.   

    LDA     (input) INTEGER   
            The leading dimension of the array A.  LDA >= max(1,N).   

    SDIM    (output) INTEGER   
            If SORT = 'N', SDIM = 0.   
            If SORT = 'S', SDIM = number of eigenvalues (after sorting)   
                           for which SELECT is true. (Complex conjugate   
                           pairs for which SELECT is true for either   
                           eigenvalue count as 2.)   

    WR      (output) DOUBLE PRECISION array, dimension (N)   
    WI      (output) DOUBLE PRECISION array, dimension (N)   
            WR and WI contain the real and imaginary parts,   
            respectively, of the computed eigenvalues in the same order   
            that they appear on the diagonal of the output Schur form T.   
            Complex conjugate pairs of eigenvalues will appear   
            consecutively with the eigenvalue having the positive   
            imaginary part first.   

    VS      (output) DOUBLE PRECISION array, dimension (LDVS,N)   
            If JOBVS = 'V', VS contains the orthogonal matrix Z of Schur   
            vectors.   
            If JOBVS = 'N', VS is not referenced.   

    LDVS    (input) INTEGER   
            The leading dimension of the array VS.  LDVS >= 1; if   
            JOBVS = 'V', LDVS >= N.   

    WORK    (workspace/output) DOUBLE PRECISION array, dimension (MAX(1,LWORK))   
            On exit, if INFO = 0, WORK(1) contains the optimal LWORK.   

    LWORK   (input) INTEGER   
            The dimension of the array WORK.  LWORK >= max(1,3*N).   
            For good performance, LWORK must generally be larger.   

            If LWORK = -1, then a workspace query is assumed; the routine   
            only calculates the optimal size of the WORK array, returns   
            this value as the first entry of the WORK array, and no error   
            message related to LWORK is issued by XERBLA.   

    BWORK   (workspace) LOGICAL array, dimension (N)   
            Not referenced if SORT = 'N'.   

    INFO    (output) INTEGER   
            = 0: successful exit   
            < 0: if INFO = -i, the i-th argument had an illegal value.   
            > 0: if INFO = i, and i is   
               <= N: the QR algorithm failed to compute all the   
                     eigenvalues; elements 1:ILO-1 and i+1:N of WR and WI   
                     contain those eigenvalues which have converged; if   
                     JOBVS = 'V', VS contains the matrix which reduces A   
                     to its partially converged Schur form.   
               = N+1: the eigenvalues could not be reordered because some   
                     eigenvalues were too close to separate (the problem   
                     is very ill-conditioned);   
               = N+2: after reordering, roundoff changed values of some   
                     complex eigenvalues so that leading eigenvalues in   
                     the Schur form no longer satisfy SELECT=.TRUE.  This   
                     could also be caused by underflow due to scaling.   
"));
end dgees;
