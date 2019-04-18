!** DOGLEG
SUBROUTINE DOGLEG(N,R,Lr,Diag,Qtb,Delta,X,Wa1,Wa2)
  !>
  !  Subsidiary to SNSQ and SNSQE
  !***
  ! **Library:**   SLATEC
  !***
  ! **Type:**      SINGLE PRECISION (DOGLEG-S, DDOGLG-D)
  !***
  ! **Author:**  (UNKNOWN)
  !***
  ! **Description:**
  !
  !     Given an M by N matrix A, an N by N nonsingular DIAGONAL
  !     matrix D, an M-vector B, and a positive number DELTA, the
  !     problem is to determine the convex combination X of the
  !     Gauss-Newton and scaled gradient directions that minimizes
  !     (A*X - B) in the least squares sense, subject to the
  !     restriction that the Euclidean norm of D*X be at most DELTA.
  !
  !     This subroutine completes the solution of the problem
  !     if it is provided with the necessary information from the
  !     QR factorization of A. That is, if A = Q*R, where Q has
  !     orthogonal columns and R is an upper triangular matrix,
  !     then DOGLEG expects the full upper triangle of R and
  !     the first N components of (Q TRANSPOSE)*B.
  !
  !     The subroutine statement is
  !
  !       SUBROUTINE DOGLEG(N,R,LR,DIAG,QTB,DELTA,X,WA1,WA2)
  !
  !     where
  !
  !       N is a positive integer input variable set to the order of R.
  !
  !       R is an input array of length LR which must contain the upper
  !         triangular matrix R stored by rows.
  !
  !       LR is a positive integer input variable not less than
  !         (N*(N+1))/2.
  !
  !       DIAG is an input array of length N which must contain the
  !         diagonal elements of the matrix D.
  !
  !       QTB is an input array of length N which must contain the first
  !         N elements of the vector (Q TRANSPOSE)*B.
  !
  !       DELTA is a positive input variable which specifies an upper
  !         bound on the Euclidean norm of D*X.
  !
  !       X is an output array of length N which contains the desired
  !         convex combination of the Gauss-Newton direction and the
  !         scaled gradient direction.
  !
  !       WA1 and WA2 are work arrays of length N.
  !
  !***
  ! **See also:**  SNSQ, SNSQE
  !***
  ! **Routines called:**  ENORM, R1MACH

  !* REVISION HISTORY  (YYMMDD)
  !   800301  DATE WRITTEN
  !   890531  Changed all specific intrinsics to generic.  (WRB)
  !   890831  Modified array declarations.  (WRB)
  !   891214  Prologue converted to Version 4.0 format.  (BAB)
  !   900326  Removed duplicate information from DESCRIPTION section.
  !           (WRB)
  !   900328  Added TYPE section.  (WRB)
  USE service, ONLY : R1MACH
  INTEGER N, Lr
  REAL Delta
  REAL R(Lr), Diag(*), Qtb(*), X(*), Wa1(*), Wa2(*)
  INTEGER i, j, jj, jp1, k, l
  REAL alpha, bnorm, epsmch, gnorm, qnorm, sgnorm, summ, temp
  REAL, PARAMETER :: one = 1.0E0, zero = 0.0E0
  !* FIRST EXECUTABLE STATEMENT  DOGLEG
  epsmch = R1MACH(4)
  !
  !     FIRST, CALCULATE THE GAUSS-NEWTON DIRECTION.
  !
  jj = (N*(N+1))/2 + 1
  DO k = 1, N
    j = N - k + 1
    jp1 = j + 1
    jj = jj - k
    l = jj + 1
    summ = zero
    IF ( N>=jp1 ) THEN
      DO i = jp1, N
        summ = summ + R(l)*X(i)
        l = l + 1
      END DO
    END IF
    temp = R(jj)
    IF ( temp==zero ) THEN
      l = j
      DO i = 1, j
        temp = MAX(temp,ABS(R(l)))
        l = l + N - i
      END DO
      temp = epsmch*temp
      IF ( temp==zero ) temp = epsmch
    END IF
    X(j) = (Qtb(j)-summ)/temp
  END DO
  !
  !     TEST WHETHER THE GAUSS-NEWTON DIRECTION IS ACCEPTABLE.
  !
  DO j = 1, N
    Wa1(j) = zero
    Wa2(j) = Diag(j)*X(j)
  END DO
  qnorm = ENORM(N,Wa2)
  IF ( qnorm>Delta ) THEN
    !
    !     THE GAUSS-NEWTON DIRECTION IS NOT ACCEPTABLE.
    !     NEXT, CALCULATE THE SCALED GRADIENT DIRECTION.
    !
    l = 1
    DO j = 1, N
      temp = Qtb(j)
      DO i = j, N
        Wa1(i) = Wa1(i) + R(l)*temp
        l = l + 1
      END DO
      Wa1(j) = Wa1(j)/Diag(j)
    END DO
    !
    !     CALCULATE THE NORM OF THE SCALED GRADIENT DIRECTION,
    !     NORMALIZE, AND RESCALE THE GRADIENT.
    !
    gnorm = ENORM(N,Wa1)
    sgnorm = zero
    alpha = Delta/qnorm
    IF ( gnorm/=zero ) THEN
      DO j = 1, N
        Wa1(j) = (Wa1(j)/gnorm)/Diag(j)
      END DO
      !
      !     CALCULATE THE POINT ALONG THE SCALED GRADIENT
      !     AT WHICH THE QUADRATIC IS MINIMIZED.
      !
      l = 1
      DO j = 1, N
        summ = zero
        DO i = j, N
          summ = summ + R(l)*Wa1(i)
          l = l + 1
        END DO
        Wa2(j) = summ
      END DO
      temp = ENORM(N,Wa2)
      sgnorm = (gnorm/temp)/temp
      !
      !     TEST WHETHER THE SCALED GRADIENT DIRECTION IS ACCEPTABLE.
      !
      alpha = zero
      IF ( sgnorm<Delta ) THEN
        !
        !     THE SCALED GRADIENT DIRECTION IS NOT ACCEPTABLE.
        !     FINALLY, CALCULATE THE POINT ALONG THE DOGLEG
        !     AT WHICH THE QUADRATIC IS MINIMIZED.
        !
        bnorm = ENORM(N,Qtb)
        temp = (bnorm/gnorm)*(bnorm/qnorm)*(sgnorm/Delta)
        temp = temp - (Delta/qnorm)*(sgnorm/Delta)&
          **2 + SQRT((temp-(Delta/qnorm))**2+(one-(Delta/qnorm)**2)&
          *(one-(sgnorm/Delta)**2))
        alpha = ((Delta/qnorm)*(one-(sgnorm/Delta)**2))/temp
      END IF
    END IF
    !
    !     FORM APPROPRIATE CONVEX COMBINATION OF THE GAUSS-NEWTON
    !     DIRECTION AND THE SCALED GRADIENT DIRECTION.
    !
    temp = (one-alpha)*MIN(sgnorm,Delta)
    DO j = 1, N
      X(j) = temp*Wa1(j) + alpha*X(j)
    END DO
  END IF
  !
  !     LAST CARD OF SUBROUTINE DOGLEG.
  !
END SUBROUTINE DOGLEG
