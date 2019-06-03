!** STBMV
SUBROUTINE STBMV(Uplo,Trans,Diag,N,K,A,Lda,X,Incx)
  !>
  !  Multiply a real vector by a real triangular band matrix.
  !***
  ! **Library:**   SLATEC (BLAS)
  !***
  ! **Category:**  D1B4
  !***
  ! **Type:**      SINGLE PRECISION (STBMV-S, DTBMV-D, CTBMV-C)
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
  !  STBMV  performs one of the matrix-vector operations
  !
  !     x := A*x,   or   x := A'*x,
  !
  !  where x is an n element vector and  A is an n by n unit, or non-unit,
  !  upper or lower triangular band matrix, with ( k + 1) diagonals.
  !
  !  Parameters
  !  ==========
  !
  !  UPLO   - CHARACTER*1.
  !           On entry, UPLO specifies whether the matrix is an upper or
  !           lower triangular matrix as follows:
  !
  !              UPLO = 'U' or 'u'   A is an upper triangular matrix.
  !
  !              UPLO = 'L' or 'l'   A is a lower triangular matrix.
  !
  !           Unchanged on exit.
  !
  !  TRANS  - CHARACTER*1.
  !           On entry, TRANS specifies the operation to be performed as
  !           follows:
  !
  !              TRANS = 'N' or 'n'   x := A*x.
  !
  !              TRANS = 'T' or 't'   x := A'*x.
  !
  !              TRANS = 'C' or 'c'   x := A'*x.
  !
  !           Unchanged on exit.
  !
  !  DIAG   - CHARACTER*1.
  !           On entry, DIAG specifies whether or not A is unit
  !           triangular as follows:
  !
  !              DIAG = 'U' or 'u'   A is assumed to be unit triangular.
  !
  !              DIAG = 'N' or 'n'   A is not assumed to be unit
  !                                  triangular.
  !
  !           Unchanged on exit.
  !
  !  N      - INTEGER.
  !           On entry, N specifies the order of the matrix A.
  !           N must be at least zero.
  !           Unchanged on exit.
  !
  !  K      - INTEGER.
  !           On entry with UPLO = 'U' or 'u', K specifies the number of
  !           super-diagonals of the matrix A.
  !           On entry with UPLO = 'L' or 'l', K specifies the number of
  !           sub-diagonals of the matrix A.
  !           K must satisfy  0 .le. K.
  !           Unchanged on exit.
  !
  !  A      - REAL             array of DIMENSION ( LDA, n ).
  !           Before entry with UPLO = 'U' or 'u', the leading ( k + 1 )
  !           by n part of the array A must contain the upper triangular
  !           band part of the matrix of coefficients, supplied column by
  !           column, with the leading diagonal of the matrix in row
  !           ( k + 1 ) of the array, the first super-diagonal starting at
  !           position 2 in row k, and so on. The top left k by k triangle
  !           of the array A is not referenced.
  !           The following program segment will transfer an upper
  !           triangular band matrix from conventional full matrix storage
  !           to band storage:
  !
  !                 DO 20, J = 1, N
  !                    M = K + 1 - J
  !                    DO 10, I = MAX( 1, J - K ), J
  !                       A( M + I, J ) = matrix( I, J )
  !              10    CONTINUE
  !              20 CONTINUE
  !
  !           Before entry with UPLO = 'L' or 'l', the leading ( k + 1 )
  !           by n part of the array A must contain the lower triangular
  !           band part of the matrix of coefficients, supplied column by
  !           column, with the leading diagonal of the matrix in row 1 of
  !           the array, the first sub-diagonal starting at position 1 in
  !           row 2, and so on. The bottom right k by k triangle of the
  !           array A is not referenced.
  !           The following program segment will transfer a lower
  !           triangular band matrix from conventional full matrix storage
  !           to band storage:
  !
  !                 DO 20, J = 1, N
  !                    M = 1 - J
  !                    DO 10, I = J, MIN( N, J + K )
  !                       A( M + I, J ) = matrix( I, J )
  !              10    CONTINUE
  !              20 CONTINUE
  !
  !           Note that when DIAG = 'U' or 'u' the elements of the array A
  !           corresponding to the diagonal elements of the matrix are not
  !           referenced, but are assumed to be unity.
  !           Unchanged on exit.
  !
  !  LDA    - INTEGER.
  !           On entry, LDA specifies the first dimension of A as declared
  !           in the calling (sub) program. LDA must be at least
  !           ( k + 1 ).
  !           Unchanged on exit.
  !
  !  X      - REAL             array of dimension at least
  !           ( 1 + ( n - 1 )*abs( INCX ) ).
  !           Before entry, the incremented array X must contain the n
  !           element vector x. On exit, X is overwritten with the
  !           transformed vector x.
  !
  !  INCX   - INTEGER.
  !           On entry, INCX specifies the increment for the elements of
  !           X. INCX must not be zero.
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
  INTEGER Incx, K, Lda, N
  CHARACTER :: Diag, Trans, Uplo
  !     .. Array Arguments ..
  REAL(SP) A(Lda,*), X(*)
  !     .. Parameters ..
  REAL(SP), PARAMETER :: ZERO = 0.0E+0
  !     .. Local Scalars ..
  REAL(SP) temp
  INTEGER i, info, ix, j, jx, kplus1, kx, l
  LOGICAL nounit
  !     .. Intrinsic Functions ..
  INTRINSIC MAX, MIN
  !* FIRST EXECUTABLE STATEMENT  STBMV
  !
  !     Test the input parameters.
  !
  info = 0
  IF ( .NOT.LSAME(Uplo,'U').AND..NOT.LSAME(Uplo,'L') ) THEN
    info = 1
  ELSEIF ( .NOT.LSAME(Trans,'N').AND..NOT.LSAME(Trans,'T').AND.&
      .NOT.LSAME(Trans,'C') ) THEN
    info = 2
  ELSEIF ( .NOT.LSAME(Diag,'U').AND..NOT.LSAME(Diag,'N') ) THEN
    info = 3
  ELSEIF ( N<0 ) THEN
    info = 4
  ELSEIF ( K<0 ) THEN
    info = 5
  ELSEIF ( Lda<(K+1) ) THEN
    info = 7
  ELSEIF ( Incx==0 ) THEN
    info = 9
  END IF
  IF ( info/=0 ) THEN
    CALL XERBLA('STBMV ',info)
    RETURN
  END IF
  !
  !     Quick return if possible.
  !
  IF ( N==0 ) RETURN
  !
  nounit = LSAME(Diag,'N')
  !
  !     Set up the start point in X if the increment is not unity. This
  !     will be  ( N - 1 )*INCX   too small for descending loops.
  !
  IF ( Incx<=0 ) THEN
    kx = 1 - (N-1)*Incx
  ELSEIF ( Incx/=1 ) THEN
    kx = 1
  END IF
  !
  !     Start the operations. In this version the elements of A are
  !     accessed sequentially with one pass through A.
  !
  IF ( LSAME(Trans,'N') ) THEN
    !
    !         Form  x := A*x.
    !
    IF ( LSAME(Uplo,'U') ) THEN
      kplus1 = K + 1
      IF ( Incx==1 ) THEN
        DO j = 1, N
          IF ( X(j)/=ZERO ) THEN
            temp = X(j)
            l = kplus1 - j
            DO i = MAX(1,j-K), j - 1
              X(i) = X(i) + temp*A(l+i,j)
            END DO
            IF ( nounit ) X(j) = X(j)*A(kplus1,j)
          END IF
        END DO
      ELSE
        jx = kx
        DO j = 1, N
          IF ( X(jx)/=ZERO ) THEN
            temp = X(jx)
            ix = kx
            l = kplus1 - j
            DO i = MAX(1,j-K), j - 1
              X(ix) = X(ix) + temp*A(l+i,j)
              ix = ix + Incx
            END DO
            IF ( nounit ) X(jx) = X(jx)*A(kplus1,j)
          END IF
          jx = jx + Incx
          IF ( j>K ) kx = kx + Incx
        END DO
      END IF
    ELSEIF ( Incx==1 ) THEN
      DO j = N, 1, -1
        IF ( X(j)/=ZERO ) THEN
          temp = X(j)
          l = 1 - j
          DO i = MIN(N,j+K), j + 1, -1
            X(i) = X(i) + temp*A(l+i,j)
          END DO
          IF ( nounit ) X(j) = X(j)*A(1,j)
        END IF
      END DO
    ELSE
      kx = kx + (N-1)*Incx
      jx = kx
      DO j = N, 1, -1
        IF ( X(jx)/=ZERO ) THEN
          temp = X(jx)
          ix = kx
          l = 1 - j
          DO i = MIN(N,j+K), j + 1, -1
            X(ix) = X(ix) + temp*A(l+i,j)
            ix = ix - Incx
          END DO
          IF ( nounit ) X(jx) = X(jx)*A(1,j)
        END IF
        jx = jx - Incx
        IF ( (N-j)>=K ) kx = kx - Incx
      END DO
    END IF
    !
    !        Form  x := A'*x.
    !
  ELSEIF ( LSAME(Uplo,'U') ) THEN
    kplus1 = K + 1
    IF ( Incx==1 ) THEN
      DO j = N, 1, -1
        temp = X(j)
        l = kplus1 - j
        IF ( nounit ) temp = temp*A(kplus1,j)
        DO i = j - 1, MAX(1,j-K), -1
          temp = temp + A(l+i,j)*X(i)
        END DO
        X(j) = temp
      END DO
    ELSE
      kx = kx + (N-1)*Incx
      jx = kx
      DO j = N, 1, -1
        temp = X(jx)
        kx = kx - Incx
        ix = kx
        l = kplus1 - j
        IF ( nounit ) temp = temp*A(kplus1,j)
        DO i = j - 1, MAX(1,j-K), -1
          temp = temp + A(l+i,j)*X(ix)
          ix = ix - Incx
        END DO
        X(jx) = temp
        jx = jx - Incx
      END DO
    END IF
  ELSEIF ( Incx==1 ) THEN
    DO j = 1, N
      temp = X(j)
      l = 1 - j
      IF ( nounit ) temp = temp*A(1,j)
      DO i = j + 1, MIN(N,j+K)
        temp = temp + A(l+i,j)*X(i)
      END DO
      X(j) = temp
    END DO
  ELSE
    jx = kx
    DO j = 1, N
      temp = X(jx)
      kx = kx + Incx
      ix = kx
      l = 1 - j
      IF ( nounit ) temp = temp*A(1,j)
      DO i = j + 1, MIN(N,j+K)
        temp = temp + A(l+i,j)*X(ix)
        ix = ix + Incx
      END DO
      X(jx) = temp
      jx = jx + Incx
    END DO
  END IF
  !
  !
  !     End of STBMV .
  !
END SUBROUTINE STBMV
