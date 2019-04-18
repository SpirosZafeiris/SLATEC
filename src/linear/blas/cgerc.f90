!** CGERC
SUBROUTINE CGERC(M,N,Alpha,X,Incx,Y,Incy,A,Lda)
  !>
  !  Perform conjugated rank 1 update of a complex general
  !            matrix.
  !***
  ! **Library:**   SLATEC (BLAS)
  !***
  ! **Category:**  D1B4
  !***
  ! **Type:**      COMPLEX (SGERC-S, DGERC-D, CGERC-C)
  !***
  ! **Keywords:**  LEVEL 2 BLAS, LINEAR ALGEBRA
  !***
  ! **Author:**  Dongarra, J. J., (ANL)
  !           Du Croz, J., (NAG)
  !           Hammarling, S., (NAG)
  !           Hanson, R. J., (SNLA)
  !***
  ! **Description:**
  !
  !  CGERC  performs the rank 1 operation
  !
  !     A := alpha*x*conjg( y') + A,
  !
  !  where alpha is a scalar, x is an m element vector, y is an n element
  !  vector and A is an m by n matrix.
  !
  !  Parameters
  !  ==========
  !
  !  M      - INTEGER.
  !           On entry, M specifies the number of rows of the matrix A.
  !           M must be at least zero.
  !           Unchanged on exit.
  !
  !  N      - INTEGER.
  !           On entry, N specifies the number of columns of the matrix A.
  !           N must be at least zero.
  !           Unchanged on exit.
  !
  !  ALPHA  - COMPLEX         .
  !           On entry, ALPHA specifies the scalar alpha.
  !           Unchanged on exit.
  !
  !  X      - COMPLEX          array of dimension at least
  !           ( 1 + ( m - 1 )*abs( INCX ) ).
  !           Before entry, the incremented array X must contain the m
  !           element vector x.
  !           Unchanged on exit.
  !
  !  INCX   - INTEGER.
  !           On entry, INCX specifies the increment for the elements of
  !           X. INCX must not be zero.
  !           Unchanged on exit.
  !
  !  Y      - COMPLEX          array of dimension at least
  !           ( 1 + ( n - 1 )*abs( INCY ) ).
  !           Before entry, the incremented array Y must contain the n
  !           element vector y.
  !           Unchanged on exit.
  !
  !  INCY   - INTEGER.
  !           On entry, INCY specifies the increment for the elements of
  !           Y. INCY must not be zero.
  !           Unchanged on exit.
  !
  !  A      - COMPLEX          array of DIMENSION ( LDA, n ).
  !           Before entry, the leading m by n part of the array A must
  !           contain the matrix of coefficients. On exit, A is
  !           overwritten by the updated matrix.
  !
  !  LDA    - INTEGER.
  !           On entry, LDA specifies the first dimension of A as declared
  !           in the calling (sub) program. LDA must be at least
  !           max( 1, m ).
  !           Unchanged on exit.
  !
  !***
  ! **References:**  Dongarra, J. J., Du Croz, J., Hammarling, S., and
  !                 Hanson, R. J.  An extended set of Fortran basic linear
  !                 algebra subprograms.  ACM TOMS, Vol. 14, No. 1,
  !                 pp. 1-17, March 1988.
  !***
  ! **Routines called:**  XERBLA

  !* REVISION HISTORY  (YYMMDD)
  !   861022  DATE WRITTEN
  !   910605  Modified to meet SLATEC prologue standards.  Only comment
  !           lines were modified.  (BKS)
  USE service, ONLY : XERBLA
  !     .. Scalar Arguments ..
  COMPLEX Alpha
  INTEGER Incx, Incy, Lda, M, N
  !     .. Array Arguments ..
  COMPLEX A(Lda,*), X(*), Y(*)
  !     .. Parameters ..
  COMPLEX, PARAMETER :: ZERO = (0.0E+0,0.0E+0)
  !     .. Local Scalars ..
  COMPLEX temp
  INTEGER i, info, ix, j, jy, kx
  !     .. Intrinsic Functions ..
  INTRINSIC CONJG, MAX
  !* FIRST EXECUTABLE STATEMENT  CGERC
  !
  !     Test the input parameters.
  !
  info = 0
  IF ( M<0 ) THEN
    info = 1
  ELSEIF ( N<0 ) THEN
    info = 2
  ELSEIF ( Incx==0 ) THEN
    info = 5
  ELSEIF ( Incy==0 ) THEN
    info = 7
  ELSEIF ( Lda<MAX(1,M) ) THEN
    info = 9
  END IF
  IF ( info/=0 ) THEN
    CALL XERBLA('CGERC ',info)
    RETURN
  END IF
  !
  !     Quick return if possible.
  !
  IF ( (M==0).OR.(N==0).OR.(Alpha==ZERO) ) RETURN
  !
  !     Start the operations. In this version the elements of A are
  !     accessed sequentially with one pass through A.
  !
  IF ( Incy>0 ) THEN
    jy = 1
  ELSE
    jy = 1 - (N-1)*Incy
  END IF
  IF ( Incx==1 ) THEN
    DO j = 1, N
      IF ( Y(jy)/=ZERO ) THEN
        temp = Alpha*CONJG(Y(jy))
        DO i = 1, M
          A(i,j) = A(i,j) + X(i)*temp
        END DO
      END IF
      jy = jy + Incy
    END DO
  ELSE
    IF ( Incx>0 ) THEN
      kx = 1
    ELSE
      kx = 1 - (M-1)*Incx
    END IF
    DO j = 1, N
      IF ( Y(jy)/=ZERO ) THEN
        temp = Alpha*CONJG(Y(jy))
        ix = kx
        DO i = 1, M
          A(i,j) = A(i,j) + X(ix)*temp
          ix = ix + Incx
        END DO
      END IF
      jy = jy + Incy
    END DO
  END IF
  !
  !
  !     End of CGERC .
  !
END SUBROUTINE CGERC
