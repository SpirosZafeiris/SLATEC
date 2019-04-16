!** TRED1
SUBROUTINE TRED1(Nm,N,A,D,E,E2)
  !>
  !***
  !  Reduce a real symmetric matrix to symmetric tridiagonal
  !            matrix using orthogonal similarity transformations.
  !***
  ! **Library:**   SLATEC (EISPACK)
  !***
  ! **Category:**  D4C1B1
  !***
  ! **Type:**      SINGLE PRECISION (TRED1-S)
  !***
  ! **Keywords:**  EIGENVALUES, EIGENVECTORS, EISPACK
  !***
  ! **Author:**  Smith, B. T., et al.
  !***
  ! **Description:**
  !
  !     This subroutine is a translation of the ALGOL procedure TRED1,
  !     NUM. MATH. 11, 181-195(1968) by Martin, Reinsch, and Wilkinson.
  !     HANDBOOK FOR AUTO. COMP., VOL.II-LINEAR ALGEBRA, 212-226(1971).
  !
  !     This subroutine reduces a REAL SYMMETRIC matrix
  !     to a symmetric tridiagonal matrix using
  !     orthogonal similarity transformations.
  !
  !     On Input
  !
  !        NM must be set to the row dimension of the two-dimensional
  !          array parameter, A, as declared in the calling program
  !          dimension statement.  NM is an INTEGER variable.
  !
  !        N is the order of the matrix A.  N is an INTEGER variable.
  !          N must be less than or equal to NM.
  !
  !        A contains the real symmetric input matrix.  Only the lower
  !          triangle of the matrix need be supplied.  A is a two-
  !          dimensional REAL array, dimensioned A(NM,N).
  !
  !     On Output
  !
  !        A contains information about the orthogonal transformations
  !          used in the reduction in its strict lower triangle.  The
  !          full upper triangle of A is unaltered.
  !
  !        D contains the diagonal elements of the symmetric tridiagonal
  !          matrix.  D is a one-dimensional REAL array, dimensioned D(N).
  !
  !        E contains the subdiagonal elements of the symmetric
  !          tridiagonal matrix in its last N-1 positions.  E(1) is set
  !          to zero.  E is a one-dimensional REAL array, dimensioned
  !          E(N).
  !
  !        E2 contains the squares of the corresponding elements of E.
  !          E2 may coincide with E if the squares are not needed.
  !          E2 is a one-dimensional REAL array, dimensioned E2(N).
  !
  !     Questions and comments should be directed to B. S. Garbow,
  !     APPLIED MATHEMATICS DIVISION, ARGONNE NATIONAL LABORATORY
  !     ------------------------------------------------------------------
  !
  !***
  ! **References:**  B. T. Smith, J. M. Boyle, J. J. Dongarra, B. S. Garbow,
  !                 Y. Ikebe, V. C. Klema and C. B. Moler, Matrix Eigen-
  !                 system Routines - EISPACK Guide, Springer-Verlag,
  !                 1976.
  !***
  ! **Routines called:**  (NONE)

  !* REVISION HISTORY  (YYMMDD)
  !   760101  DATE WRITTEN
  !   890831  Modified array declarations.  (WRB)
  !   890831  REVISION DATE from Version 3.2
  !   891214  Prologue converted to Version 4.0 format.  (BAB)
  !   920501  Reformatted the REFERENCES section.  (WRB)

  !
  INTEGER i, j, k, l, N, ii, Nm, jp1
  REAL A(Nm,*), D(*), E(*), E2(*)
  REAL f, g, h, scalee
  !
  !* FIRST EXECUTABLE STATEMENT  TRED1
  DO i = 1, N
    D(i) = A(i,i)
  END DO
  !     .......... FOR I=N STEP -1 UNTIL 1 DO -- ..........
  DO ii = 1, N
    i = N + 1 - ii
    l = i - 1
    h = 0.0E0
    scalee = 0.0E0
    IF ( l>=1 ) THEN
      !     .......... SCALE ROW (ALGOL TOL THEN NOT NEEDED) ..........
      DO k = 1, l
        scalee = scalee + ABS(A(i,k))
      END DO
      !
      IF ( scalee/=0.0E0 ) THEN
        !
        DO k = 1, l
          A(i,k) = A(i,k)/scalee
          h = h + A(i,k)*A(i,k)
        END DO
        !
        E2(i) = scalee*scalee*h
        f = A(i,l)
        g = -SIGN(SQRT(h),f)
        E(i) = scalee*g
        h = h - f*g
        A(i,l) = f - g
        IF ( l/=1 ) THEN
          f = 0.0E0
          !
          DO j = 1, l
            g = 0.0E0
            !     .......... FORM ELEMENT OF A*U ..........
            DO k = 1, j
              g = g + A(j,k)*A(i,k)
            END DO
            !
            jp1 = j + 1
            IF ( l>=jp1 ) THEN
              !
              DO k = jp1, l
                g = g + A(k,j)*A(i,k)
              END DO
            END IF
            !     .......... FORM ELEMENT OF P ..........
            E(j) = g/h
            f = f + E(j)*A(i,j)
          END DO
          !
          h = f/(h+h)
          !     .......... FORM REDUCED A ..........
          DO j = 1, l
            f = A(i,j)
            g = E(j) - h*f
            E(j) = g
            !
            DO k = 1, j
              A(j,k) = A(j,k) - f*E(k) - g*A(i,k)
            END DO
          END DO
        END IF
        !
        DO k = 1, l
          A(i,k) = scalee*A(i,k)
        END DO
        GOTO 50
      END IF
    END IF
    E(i) = 0.0E0
    E2(i) = 0.0E0
    !
    50  h = D(i)
    D(i) = A(i,i)
    A(i,i) = h
  END DO
  !
END SUBROUTINE TRED1
