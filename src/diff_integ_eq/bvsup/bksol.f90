!** BKSOL
SUBROUTINE BKSOL(N,A,X)
  !>
  !  Subsidiary to BVSUP
  !***
  ! **Library:**   SLATEC
  !***
  ! **Type:**      SINGLE PRECISION (BKSOL-S, DBKSOL-D)
  !***
  ! **Author:**  Watts, H. A., (SNLA)
  !***
  ! **Description:**
  !
  !- *********************************************************************
  !     Solution of an upper triangular linear system by
  !     back-substitution
  !
  !     The matrix A is assumed to be stored in a linear
  !     array proceeding in a row-wise manner. The
  !     vector X contains the given constant vector on input
  !     and contains the solution on return.
  !     The actual diagonal of A is unity while a diagonal
  !     scaling matrix is stored there.
  !- *********************************************************************
  !
  !***
  ! **See also:**  BVSUP
  !***
  ! **Routines called:**  SDOT

  !* REVISION HISTORY  (YYMMDD)
  !   750601  DATE WRITTEN
  !   891214  Prologue converted to Version 4.0 format.  (BAB)
  !   900328  Added TYPE section.  (WRB)
  !   910722  Updated AUTHOR section.  (ALS)
  USE linear, ONLY : SDOT
  REAL A(*), X(*)
  INTEGER j, k, m, N, nm1
  !* FIRST EXECUTABLE STATEMENT  BKSOL
  m = (N*(N+1))/2
  X(N) = X(N)*A(m)
  IF ( N/=1 ) THEN
    nm1 = N - 1
    DO k = 1, nm1
      j = N - k
      m = m - k - 1
      X(j) = X(j)*A(m) - SDOT(k,A(m+1),1,X(j+1),1)
    END DO
  END IF
  !
END SUBROUTINE BKSOL
