!** DSYMV
SUBROUTINE DSYMV(Uplo,N,Alpha,A,Lda,X,Incx,Beta,Y,Incy)
  !>
  !  Perform the matrix-vector operation.
  !***
  ! **Library:**   SLATEC (BLAS)
  !***
  ! **Category:**  D1B4
  !***
  ! **Type:**      DOUBLE PRECISION (SSYMV-S, DSYMV-D, CSYMV-C)
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
  !  DSYMV  performs the matrix-vector  operation
  !
  !     y := alpha*A*x + beta*y,
  !
  !  where alpha and beta are scalars, x and y are n element vectors and
  !  A is an n by n symmetric matrix.
  !
  !  Parameters
  !  ==========
  !
  !  UPLO   - CHARACTER*1.
  !           On entry, UPLO specifies whether the upper or lower
  !           triangular part of the array A is to be referenced as
  !           follows:
  !
  !              UPLO = 'U' or 'u'   Only the upper triangular part of A
  !                                  is to be referenced.
  !
  !              UPLO = 'L' or 'l'   Only the lower triangular part of A
  !                                  is to be referenced.
  !
  !           Unchanged on exit.
  !
  !  N      - INTEGER.
  !           On entry, N specifies the order of the matrix A.
  !           N must be at least zero.
  !           Unchanged on exit.
  !
  !  ALPHA  - DOUBLE PRECISION.
  !           On entry, ALPHA specifies the scalar alpha.
  !           Unchanged on exit.
  !
  !  A      - DOUBLE PRECISION array of DIMENSION ( LDA, n ).
  !           Before entry with  UPLO = 'U' or 'u', the leading n by n
  !           upper triangular part of the array A must contain the upper
  !           triangular part of the symmetric matrix and the strictly
  !           lower triangular part of A is not referenced.
  !           Before entry with UPLO = 'L' or 'l', the leading n by n
  !           lower triangular part of the array A must contain the lower
  !           triangular part of the symmetric matrix and the strictly
  !           upper triangular part of A is not referenced.
  !           Unchanged on exit.
  !
  !  LDA    - INTEGER.
  !           On entry, LDA specifies the first dimension of A as declared
  !           in the calling (sub) program. LDA must be at least
  !           max( 1, n ).
  !           Unchanged on exit.
  !
  !  X      - DOUBLE PRECISION array of dimension at least
  !           ( 1 + ( n - 1 )*abs( INCX ) ).
  !           Before entry, the incremented array X must contain the n
  !           element vector x.
  !           Unchanged on exit.
  !
  !  INCX   - INTEGER.
  !           On entry, INCX specifies the increment for the elements of
  !           X. INCX must not be zero.
  !           Unchanged on exit.
  !
  !  BETA   - DOUBLE PRECISION.
  !           On entry, BETA specifies the scalar beta. When BETA is
  !           supplied as zero then Y need not be set on input.
  !           Unchanged on exit.
  !
  !  Y      - DOUBLE PRECISION array of dimension at least
  !           ( 1 + ( n - 1 )*abs( INCY ) ).
  !           Before entry, the incremented array Y must contain the n
  !           element vector y. On exit, Y is overwritten by the updated
  !           vector y.
  !
  !  INCY   - INTEGER.
  !           On entry, INCY specifies the increment for the elements of
  !           Y. INCY must not be zero.
  !           Unchanged on exit.
  !
  !***
  ! **References:**  Dongarra, J. J., Du Croz, J., Hammarling, S., and
  !                 Hanson, R. J.  An extended set of Fortran basic linear
  !                 algebra subprograms.  ACM TOMS, Vol. 14, No. 1,
  !                 pp. 1-17, March 1988.
  !***
  ! **Routines called:**  LSAME, XERBLA

  !* REVISION HISTORY  (YYMMDD)
  !   861022  DATE WRITTEN
  !   910605  Modified to meet SLATEC prologue standards.  Only comment
  !           lines were modified.  (BKS)
  USE service, ONLY : XERBLA
  !     .. Scalar Arguments ..
  REAL(DP) :: Alpha, Beta
  INTEGER Incx, Incy, Lda, N
  CHARACTER :: Uplo
  !     .. Array Arguments ..
  REAL(DP) :: A(Lda,*), X(*), Y(*)
  !     .. Parameters ..
  REAL(DP), PARAMETER :: ONE = 1.0D+0, ZERO = 0.0D+0
  !     .. Local Scalars ..
  REAL(DP) :: temp1, temp2
  INTEGER i, info, ix, iy, j, jx, jy, kx, ky
  !     .. Intrinsic Functions ..
  INTRINSIC MAX
  !* FIRST EXECUTABLE STATEMENT  DSYMV
  !
  !     Test the input parameters.
  !
  info = 0
  IF ( .NOT.LSAME(Uplo,'U').AND..NOT.LSAME(Uplo,'L') ) THEN
    info = 1
  ELSEIF ( N<0 ) THEN
    info = 2
  ELSEIF ( Lda<MAX(1,N) ) THEN
    info = 5
  ELSEIF ( Incx==0 ) THEN
    info = 7
  ELSEIF ( Incy==0 ) THEN
    info = 10
  END IF
  IF ( info/=0 ) THEN
    CALL XERBLA('DSYMV ',info)
    RETURN
  END IF
  !
  !     Quick return if possible.
  !
  IF ( (N==0).OR.((Alpha==ZERO).AND.(Beta==ONE)) ) RETURN
  !
  !     Set up the start points in  X  and  Y.
  !
  IF ( Incx>0 ) THEN
    kx = 1
  ELSE
    kx = 1 - (N-1)*Incx
  END IF
  IF ( Incy>0 ) THEN
    ky = 1
  ELSE
    ky = 1 - (N-1)*Incy
  END IF
  !
  !     Start the operations. In this version the elements of A are
  !     accessed sequentially with one pass through the triangular part
  !     of A.
  !
  !     First form  y := beta*y.
  !
  IF ( Beta/=ONE ) THEN
    IF ( Incy/=1 ) THEN
      iy = ky
      IF ( Beta==ZERO ) THEN
        DO i = 1, N
          Y(iy) = ZERO
          iy = iy + Incy
        END DO
      ELSE
        DO i = 1, N
          Y(iy) = Beta*Y(iy)
          iy = iy + Incy
        END DO
      END IF
    ELSEIF ( Beta==ZERO ) THEN
      DO i = 1, N
        Y(i) = ZERO
      END DO
    ELSE
      DO i = 1, N
        Y(i) = Beta*Y(i)
      END DO
    END IF
  END IF
  IF ( Alpha==ZERO ) RETURN
  IF ( LSAME(Uplo,'U') ) THEN
    !
    !        Form  y  when A is stored in upper triangle.
    !
    IF ( (Incx==1).AND.(Incy==1) ) THEN
      DO j = 1, N
        temp1 = Alpha*X(j)
        temp2 = ZERO
        DO i = 1, j - 1
          Y(i) = Y(i) + temp1*A(i,j)
          temp2 = temp2 + A(i,j)*X(i)
        END DO
        Y(j) = Y(j) + temp1*A(j,j) + Alpha*temp2
      END DO
    ELSE
      jx = kx
      jy = ky
      DO j = 1, N
        temp1 = Alpha*X(jx)
        temp2 = ZERO
        ix = kx
        iy = ky
        DO i = 1, j - 1
          Y(iy) = Y(iy) + temp1*A(i,j)
          temp2 = temp2 + A(i,j)*X(ix)
          ix = ix + Incx
          iy = iy + Incy
        END DO
        Y(jy) = Y(jy) + temp1*A(j,j) + Alpha*temp2
        jx = jx + Incx
        jy = jy + Incy
      END DO
    END IF
    !
    !        Form  y  when A is stored in lower triangle.
    !
  ELSEIF ( (Incx==1).AND.(Incy==1) ) THEN
    DO j = 1, N
      temp1 = Alpha*X(j)
      temp2 = ZERO
      Y(j) = Y(j) + temp1*A(j,j)
      DO i = j + 1, N
        Y(i) = Y(i) + temp1*A(i,j)
        temp2 = temp2 + A(i,j)*X(i)
      END DO
      Y(j) = Y(j) + Alpha*temp2
    END DO
  ELSE
    jx = kx
    jy = ky
    DO j = 1, N
      temp1 = Alpha*X(jx)
      temp2 = ZERO
      Y(jy) = Y(jy) + temp1*A(j,j)
      ix = jx
      iy = jy
      DO i = j + 1, N
        ix = ix + Incx
        iy = iy + Incy
        Y(iy) = Y(iy) + temp1*A(i,j)
        temp2 = temp2 + A(i,j)*X(ix)
      END DO
      Y(jy) = Y(jy) + Alpha*temp2
      jx = jx + Incx
      jy = jy + Incy
    END DO
  END IF
  !
  !
  !     End of DSYMV .
  !
END SUBROUTINE DSYMV
