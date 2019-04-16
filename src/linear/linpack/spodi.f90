!** SPODI
SUBROUTINE SPODI(A,Lda,N,Det,Job)
  !>
  !***
  !  Compute the determinant and inverse of a certain real
  !            symmetric positive definite matrix using the factors
  !            computed by SPOCO, SPOFA or SQRDC.
  !***
  ! **Library:**   SLATEC (LINPACK)
  !***
  ! **Category:**  D2B1B, D3B1B
  !***
  ! **Type:**      SINGLE PRECISION (SPODI-S, DPODI-D, CPODI-C)
  !***
  ! **Keywords:**  DETERMINANT, INVERSE, LINEAR ALGEBRA, LINPACK, MATRIX,
  !             POSITIVE DEFINITE
  !***
  ! **Author:**  Moler, C. B., (U. of New Mexico)
  !***
  ! **Description:**
  !
  !     SPODI computes the determinant and inverse of a certain
  !     real symmetric positive definite matrix (see below)
  !     using the factors computed by SPOCO, SPOFA or SQRDC.
  !
  !     On Entry
  !
  !        A       REAL(LDA, N)
  !                the output  A  from SPOCO or SPOFA
  !                or the output  X  from SQRDC.
  !
  !        LDA     INTEGER
  !                the leading dimension of the array  A .
  !
  !        N       INTEGER
  !                the order of the matrix  A .
  !
  !        JOB     INTEGER
  !                = 11   both determinant and inverse.
  !                = 01   inverse only.
  !                = 10   determinant only.
  !
  !     On Return
  !
  !        A       If SPOCO or SPOFA was used to factor  A, then
  !                SPODI produces the upper half of INVERSE(A) .
  !                If SQRDC was used to decompose  X, then
  !                SPODI produces the upper half of INVERSE(TRANS(X)*X),
  !                where TRANS(X) is the transpose.
  !                Elements of  A  below the diagonal are unchanged.
  !                If the units digit of JOB is zero,  A  is unchanged.
  !
  !        DET     REAL(2)
  !                determinant of  A  or of  TRANS(X)*X  if requested.
  !                Otherwise not referenced.
  !                Determinant = DET(1) * 10.0**DET(2)
  !                with  1.0 .LE. DET(1) .LT. 10.0
  !                or  DET(1) .EQ. 0.0 .
  !
  !     Error Condition
  !
  !        A division by zero will occur if the input factor contains
  !        a zero on the diagonal and the inverse is requested.
  !        It will not occur if the subroutines are called correctly
  !        and if SPOCO or SPOFA has set INFO .EQ. 0 .
  !
  !***
  ! **References:**  J. J. Dongarra, J. R. Bunch, C. B. Moler, and G. W.
  !                 Stewart, LINPACK Users' Guide, SIAM, 1979.
  !***
  ! **Routines called:**  SAXPY, SSCAL

  !* REVISION HISTORY  (YYMMDD)
  !   780814  DATE WRITTEN
  !   890831  Modified array declarations.  (WRB)
  !   890831  REVISION DATE from Version 3.2
  !   891214  Prologue converted to Version 4.0 format.  (BAB)
  !   900326  Removed duplicate information from DESCRIPTION section.
  !           (WRB)
  !   920501  Reformatted the REFERENCES section.  (WRB)

  INTEGER Lda, N, Job
  REAL A(Lda,*)
  REAL Det(2)
  !
  REAL t
  REAL s
  INTEGER i, j, jm1, k, kp1
  !* FIRST EXECUTABLE STATEMENT  SPODI
  !
  !     COMPUTE DETERMINANT
  !
  IF ( Job/10/=0 ) THEN
    Det(1) = 1.0E0
    Det(2) = 0.0E0
    s = 10.0E0
    DO i = 1, N
      Det(1) = A(i,i)**2*Det(1)
      IF ( Det(1)==0.0E0 ) EXIT
      DO WHILE ( Det(1)<1.0E0 )
        Det(1) = s*Det(1)
        Det(2) = Det(2) - 1.0E0
      END DO
      DO WHILE ( Det(1)>=s )
        Det(1) = Det(1)/s
        Det(2) = Det(2) + 1.0E0
      END DO
    END DO
  END IF
  !
  !     COMPUTE INVERSE(R)
  !
  IF ( MOD(Job,10)/=0 ) THEN
    DO k = 1, N
      A(k,k) = 1.0E0/A(k,k)
      t = -A(k,k)
      CALL SSCAL(k-1,t,A(1,k),1)
      kp1 = k + 1
      IF ( N>=kp1 ) THEN
        DO j = kp1, N
          t = A(k,j)
          A(k,j) = 0.0E0
          CALL SAXPY(k,t,A(1,k),1,A(1,j),1)
        END DO
      END IF
    END DO
    !
    !        FORM  INVERSE(R) * TRANS(INVERSE(R))
    !
    DO j = 1, N
      jm1 = j - 1
      IF ( jm1>=1 ) THEN
        DO k = 1, jm1
          t = A(k,j)
          CALL SAXPY(k,t,A(1,j),1,A(1,k),1)
        END DO
      END IF
      t = A(j,j)
      CALL SSCAL(j,t,A(1,j),1)
    END DO
  END IF
END SUBROUTINE SPODI
