!** SCHDC
SUBROUTINE SCHDC(A,Lda,P,Work,Jpvt,Job,Info)
  IMPLICIT NONE
  !>
  !***
  !  Compute the Cholesky decomposition of a positive definite
  !            matrix.  A pivoting option allows the user to estimate the
  !            condition number of a positive definite matrix or determine
  !            the rank of a positive semidefinite matrix.
  !***
  ! **Library:**   SLATEC (LINPACK)
  !***
  ! **Category:**  D2B1B
  !***
  ! **Type:**      SINGLE PRECISION (SCHDC-S, DCHDC-D, CCHDC-C)
  !***
  ! **Keywords:**  CHOLESKY DECOMPOSITION, LINEAR ALGEBRA, LINPACK, MATRIX,
  !             POSITIVE DEFINITE
  !***
  ! **Author:**  Dongarra, J., (ANL)
  !           Stewart, G. W., (U. of Maryland)
  !***
  ! **Description:**
  !
  !     SCHDC computes the Cholesky decomposition of a positive definite
  !     matrix.  A pivoting option allows the user to estimate the
  !     condition of a positive definite matrix or determine the rank
  !     of a positive semidefinite matrix.
  !
  !     On Entry
  !
  !         A      REAL(LDA,P).
  !                A contains the matrix whose decomposition is to
  !                be computed.  Only the upper half of A need be stored.
  !                The lower part of the array A is not referenced.
  !
  !         LDA    INTEGER.
  !                LDA is the leading dimension of the array A.
  !
  !         P      INTEGER.
  !                P is the order of the matrix.
  !
  !         WORK   REAL.
  !                WORK is a work array.
  !
  !         JPVT   INTEGER(P).
  !                JPVT contains integers that control the selection
  !                of the pivot elements, if pivoting has been requested.
  !                Each diagonal element A(K,K)
  !                is placed in one of three classes according to the
  !                value of JPVT(K).
  !
  !                   If JPVT(K) .GT. 0, then X(K) is an initial
  !                                      element.
  !
  !                   If JPVT(K) .EQ. 0, then X(K) is a free element.
  !
  !                   If JPVT(K) .LT. 0, then X(K) is a final element.
  !
  !                Before the decomposition is computed, initial elements
  !                are moved by symmetric row and column interchanges to
  !                the beginning of the array A and final
  !                elements to the end.  Both initial and final elements
  !                are frozen in place during the computation and only
  !                free elements are moved.  At the K-th stage of the
  !                reduction, if A(K,K) is occupied by a free element
  !                it is interchanged with the largest free element
  !                A(L,L) with L .GE. K.  JPVT is not referenced if
  !                JOB .EQ. 0.
  !
  !        JOB     INTEGER.
  !                JOB is an integer that initiates column pivoting.
  !                If JOB .EQ. 0, no pivoting is done.
  !                If JOB .NE. 0, pivoting is done.
  !
  !     On Return
  !
  !         A      A contains in its upper half the Cholesky factor
  !                of the matrix A as it has been permuted by pivoting.
  !
  !         JPVT   JPVT(J) contains the index of the diagonal element
  !                of a that was moved into the J-th position,
  !                provided pivoting was requested.
  !
  !         INFO   contains the index of the last positive diagonal
  !                element of the Cholesky factor.
  !
  !     For positive definite matrices INFO = P is the normal return.
  !     For pivoting with positive semidefinite matrices INFO will
  !     in general be less than P.  However, INFO may be greater than
  !     the rank of A, since rounding error can cause an otherwise zero
  !     element to be positive.  Indefinite systems will always cause
  !     INFO to be less than P.
  !
  !***
  ! **References:**  J. J. Dongarra, J. R. Bunch, C. B. Moler, and G. W.
  !                 Stewart, LINPACK Users' Guide, SIAM, 1979.
  !***
  ! **Routines called:**  SAXPY, SSWAP

  !* REVISION HISTORY  (YYMMDD)
  !   790319  DATE WRITTEN
  !   890313  REVISION DATE from Version 3.2
  !   891214  Prologue converted to Version 4.0 format.  (BAB)
  !   900326  Removed duplicate information from DESCRIPTION section.
  !           (WRB)
  !   920501  Reformatted the REFERENCES section.  (WRB)

  INTEGER Lda, P, Jpvt(*), Job, Info
  REAL A(Lda,*), Work(*)
  !
  INTEGER pu, pl, plp1, j, jp, jt, k, kb, km1, kp1, l, maxl
  REAL temp
  REAL maxdia
  LOGICAL swapk, negk
  !* FIRST EXECUTABLE STATEMENT  SCHDC
  pl = 1
  pu = 0
  Info = P
  IF ( Job/=0 ) THEN
    !
    !        PIVOTING HAS BEEN REQUESTED. REARRANGE THE
    !        THE ELEMENTS ACCORDING TO JPVT.
    !
    DO k = 1, P
      swapk = Jpvt(k)>0
      negk = Jpvt(k)<0
      Jpvt(k) = k
      IF ( negk ) Jpvt(k) = -Jpvt(k)
      IF ( swapk ) THEN
        IF ( k/=pl ) THEN
          CALL SSWAP(pl-1,A(1,k),1,A(1,pl),1)
          temp = A(k,k)
          A(k,k) = A(pl,pl)
          A(pl,pl) = temp
          plp1 = pl + 1
          IF ( P>=plp1 ) THEN
            DO j = plp1, P
              IF ( j<k ) THEN
                temp = A(pl,j)
                A(pl,j) = A(j,k)
                A(j,k) = temp
              ELSEIF ( j/=k ) THEN
                temp = A(k,j)
                A(k,j) = A(pl,j)
                A(pl,j) = temp
              END IF
            END DO
          END IF
          Jpvt(k) = Jpvt(pl)
          Jpvt(pl) = k
        END IF
        pl = pl + 1
      END IF
    END DO
    pu = P
    IF ( P>=pl ) THEN
      DO kb = pl, P
        k = P - kb + pl
        IF ( Jpvt(k)<0 ) THEN
          Jpvt(k) = -Jpvt(k)
          IF ( pu/=k ) THEN
            CALL SSWAP(k-1,A(1,k),1,A(1,pu),1)
            temp = A(k,k)
            A(k,k) = A(pu,pu)
            A(pu,pu) = temp
            kp1 = k + 1
            IF ( P>=kp1 ) THEN
              DO j = kp1, P
                IF ( j<pu ) THEN
                  temp = A(k,j)
                  A(k,j) = A(j,pu)
                  A(j,pu) = temp
                ELSEIF ( j/=pu ) THEN
                  temp = A(k,j)
                  A(k,j) = A(pu,j)
                  A(pu,j) = temp
                END IF
              END DO
            END IF
            jt = Jpvt(k)
            Jpvt(k) = Jpvt(pu)
            Jpvt(pu) = jt
          END IF
          pu = pu - 1
        END IF
      END DO
    END IF
  END IF
  DO k = 1, P
    !
    !        REDUCTION LOOP.
    !
    maxdia = A(k,k)
    kp1 = k + 1
    maxl = k
    !
    !        DETERMINE THE PIVOT ELEMENT.
    !
    IF ( k>=pl.AND.k<pu ) THEN
      DO l = kp1, pu
        IF ( A(l,l)>maxdia ) THEN
          maxdia = A(l,l)
          maxl = l
        END IF
      END DO
    END IF
    !
    !        QUIT IF THE PIVOT ELEMENT IS NOT POSITIVE.
    !
    IF ( maxdia>0.0E0 ) THEN
      IF ( k/=maxl ) THEN
        !
        !           START THE PIVOTING AND UPDATE JPVT.
        !
        km1 = k - 1
        CALL SSWAP(km1,A(1,k),1,A(1,maxl),1)
        A(maxl,maxl) = A(k,k)
        A(k,k) = maxdia
        jp = Jpvt(maxl)
        Jpvt(maxl) = Jpvt(k)
        Jpvt(k) = jp
      END IF
      !
      !        REDUCTION STEP. PIVOTING IS CONTAINED ACROSS THE ROWS.
      !
      Work(k) = SQRT(A(k,k))
      A(k,k) = Work(k)
      IF ( P>=kp1 ) THEN
        DO j = kp1, P
          IF ( k/=maxl ) THEN
            IF ( j<maxl ) THEN
              temp = A(k,j)
              A(k,j) = A(j,maxl)
              A(j,maxl) = temp
            ELSEIF ( j/=maxl ) THEN
              temp = A(k,j)
              A(k,j) = A(maxl,j)
              A(maxl,j) = temp
            END IF
          END IF
          A(k,j) = A(k,j)/Work(k)
          Work(j) = A(k,j)
          temp = -A(k,j)
          CALL SAXPY(j-k,temp,Work(kp1),1,A(kp1,j),1)
        END DO
      END IF
    ELSE
      Info = k - 1
      EXIT
    END IF
  END DO
END SUBROUTINE SCHDC
