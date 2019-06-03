!** SSIDI
SUBROUTINE SSIDI(A,Lda,N,Kpvt,Det,Inert,Work,Job)
  !>
  !  Compute the determinant, inertia and inverse of a real
  !            symmetric matrix using the factors from SSIFA.
  !***
  ! **Library:**   SLATEC (LINPACK)
  !***
  ! **Category:**  D2B1A, D3B1A
  !***
  ! **Type:**      SINGLE PRECISION (SSIDI-S, DSIDI-D, CHIDI-C, CSIDI-C)
  !***
  ! **Keywords:**  DETERMINANT, INVERSE, LINEAR ALGEBRA, LINPACK, MATRIX,
  !             SYMMETRIC
  !***
  ! **Author:**  Bunch, J., (UCSD)
  !***
  ! **Description:**
  !
  !     SSIDI computes the determinant, inertia and inverse
  !     of a real symmetric matrix using the factors from SSIFA.
  !
  !     On Entry
  !
  !        A       REAL(LDA,N)
  !                the output from SSIFA.
  !
  !        LDA     INTEGER
  !                the leading dimension of the array A.
  !
  !        N       INTEGER
  !                the order of the matrix A.
  !
  !        KPVT    INTEGER(N)
  !                the pivot vector from SSIFA.
  !
  !        WORK    REAL(N)
  !                work vector.  Contents destroyed.
  !
  !        JOB     INTEGER
  !                JOB has the decimal expansion  ABC  where
  !                   If  C .NE. 0, the inverse is computed,
  !                   If  B .NE. 0, the determinant is computed,
  !                   If  A .NE. 0, the inertia is computed.
  !
  !                For example, JOB = 111  gives all three.
  !
  !     On Return
  !
  !        Variables not requested by JOB are not used.
  !
  !        A      contains the upper triangle of the inverse of
  !               the original matrix.  The strict lower triangle
  !               is never referenced.
  !
  !        DET    REAL(2)
  !               determinant of original matrix.
  !               Determinant = DET(1) * 10.0**DET(2)
  !               with 1.0 .LE. ABS(DET(1)) .LT. 10.0
  !               or DET(1) = 0.0.
  !
  !        INERT  INTEGER(3)
  !               the inertia of the original matrix.
  !               INERT(1)  =  number of positive eigenvalues.
  !               INERT(2)  =  number of negative eigenvalues.
  !               INERT(3)  =  number of zero eigenvalues.
  !
  !     Error Condition
  !
  !        A division by zero may occur if the inverse is requested
  !        and  SSICO  has set RCOND .EQ. 0.0
  !        or  SSIFA  has set  INFO .NE. 0 .
  !
  !***
  ! **References:**  J. J. Dongarra, J. R. Bunch, C. B. Moler, and G. W.
  !                 Stewart, LINPACK Users' Guide, SIAM, 1979.
  !***
  ! **Routines called:**  SAXPY, SCOPY, SDOT, SSWAP

  !* REVISION HISTORY  (YYMMDD)
  !   780814  DATE WRITTEN
  !   890531  Changed all specific intrinsics to generic.  (WRB)
  !   890831  Modified array declarations.  (WRB)
  !   891107  Modified routine equivalence list.  (WRB)
  !   891107  REVISION DATE from Version 3.2
  !   891214  Prologue converted to Version 4.0 format.  (BAB)
  !   900326  Removed duplicate information from DESCRIPTION section.
  !           (WRB)
  !   920501  Reformatted the REFERENCES section.  (WRB)

  INTEGER Lda, N, Job
  REAL(SP) A(Lda,*), Work(*)
  REAL(SP) Det(2)
  INTEGER Kpvt(*), Inert(3)
  !
  REAL(SP) akkp1, temp
  REAL(SP) ten, d, t, ak, akp1
  INTEGER j, jb, k, km1, ks, kstep
  LOGICAL noinv, nodet, noert
  !* FIRST EXECUTABLE STATEMENT  SSIDI
  noinv = MOD(Job,10)==0
  nodet = MOD(Job,100)/10==0
  noert = MOD(Job,1000)/100==0
  !
  IF ( .NOT.(nodet.AND.noert) ) THEN
    IF ( .NOT.(noert) ) THEN
      Inert(1) = 0
      Inert(2) = 0
      Inert(3) = 0
    END IF
    IF ( .NOT.(nodet) ) THEN
      Det(1) = 1.0E0
      Det(2) = 0.0E0
      ten = 10.0E0
    END IF
    t = 0.0E0
    DO k = 1, N
      d = A(k,k)
      !
      !           CHECK IF 1 BY 1
      !
      IF ( Kpvt(k)<=0 ) THEN
        !
        !              2 BY 2 BLOCK
        !              USE DET (D  S)  =  (D/T * C - T) * T ,  T = ABS(S)
        !                      (S  C)
        !              TO AVOID UNDERFLOW/OVERFLOW TROUBLES.
        !              TAKE TWO PASSES THROUGH SCALING.  USE  T  FOR FLAG.
        !
        IF ( t/=0.0E0 ) THEN
          d = t
          t = 0.0E0
        ELSE
          t = ABS(A(k,k+1))
          d = (d/t)*A(k+1,k+1) - t
        END IF
      END IF
      !
      IF ( .NOT.(noert) ) THEN
        IF ( d>0.0E0 ) Inert(1) = Inert(1) + 1
        IF ( d<0.0E0 ) Inert(2) = Inert(2) + 1
        IF ( d==0.0E0 ) Inert(3) = Inert(3) + 1
      END IF
      !
      IF ( .NOT.(nodet) ) THEN
        Det(1) = d*Det(1)
        IF ( Det(1)/=0.0E0 ) THEN
          DO WHILE ( ABS(Det(1))<1.0E0 )
            Det(1) = ten*Det(1)
            Det(2) = Det(2) - 1.0E0
          END DO
          DO WHILE ( ABS(Det(1))>=ten )
            Det(1) = Det(1)/ten
            Det(2) = Det(2) + 1.0E0
          END DO
        END IF
      END IF
    END DO
  END IF
  !
  !     COMPUTE INVERSE(A)
  !
  IF ( .NOT.(noinv) ) THEN
    k = 1
    DO WHILE ( k<=N )
      km1 = k - 1
      IF ( Kpvt(k)<0 ) THEN
        !
        !              2 BY 2
        !
        t = ABS(A(k,k+1))
        ak = A(k,k)/t
        akp1 = A(k+1,k+1)/t
        akkp1 = A(k,k+1)/t
        d = t*(ak*akp1-1.0E0)
        A(k,k) = akp1/d
        A(k+1,k+1) = ak/d
        A(k,k+1) = -akkp1/d
        IF ( km1>=1 ) THEN
          CALL SCOPY(km1,A(1,k+1),1,Work,1)
          DO j = 1, km1
            A(j,k+1) = SDOT(j,A(1,j),1,Work,1)
            CALL SAXPY(j-1,Work(j),A(1,j),1,A(1,k+1),1)
          END DO
          A(k+1,k+1) = A(k+1,k+1) + SDOT(km1,Work,1,A(1,k+1),1)
          A(k,k+1) = A(k,k+1) + SDOT(km1,A(1,k),1,A(1,k+1),1)
          CALL SCOPY(km1,A(1,k),1,Work,1)
          DO j = 1, km1
            A(j,k) = SDOT(j,A(1,j),1,Work,1)
            CALL SAXPY(j-1,Work(j),A(1,j),1,A(1,k),1)
          END DO
          A(k,k) = A(k,k) + SDOT(km1,Work,1,A(1,k),1)
        END IF
        kstep = 2
      ELSE
        !
        !              1 BY 1
        !
        A(k,k) = 1.0E0/A(k,k)
        IF ( km1>=1 ) THEN
          CALL SCOPY(km1,A(1,k),1,Work,1)
          DO j = 1, km1
            A(j,k) = SDOT(j,A(1,j),1,Work,1)
            CALL SAXPY(j-1,Work(j),A(1,j),1,A(1,k),1)
          END DO
          A(k,k) = A(k,k) + SDOT(km1,Work,1,A(1,k),1)
        END IF
        kstep = 1
      END IF
      !
      !           SWAP
      !
      ks = ABS(Kpvt(k))
      IF ( ks/=k ) THEN
        CALL SSWAP(ks,A(1,ks),1,A(1,k),1)
        DO jb = ks, k
          j = k + ks - jb
          temp = A(j,k)
          A(j,k) = A(ks,j)
          A(ks,j) = temp
        END DO
        IF ( kstep/=1 ) THEN
          temp = A(ks,k+1)
          A(ks,k+1) = A(k,k+1)
          A(k,k+1) = temp
        END IF
      END IF
      k = k + kstep
    END DO
  END IF
END SUBROUTINE SSIDI
