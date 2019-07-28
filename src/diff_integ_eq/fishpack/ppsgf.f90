!** PPSGF
REAL(SP) PURE FUNCTION PPSGF(X,Iz,C,A,Bh)
  !> Subsidiary to BLKTRI
  !***
  ! **Library:**   SLATEC
  !***
  ! **Type:**      SINGLE PRECISION (PPSGF-S)
  !***
  ! **Author:**  (UNKNOWN)
  !***
  ! **See also:**  BLKTRI
  !***
  ! **Routines called:**  (NONE)

  !* REVISION HISTORY  (YYMMDD)
  !   801001  DATE WRITTEN
  !   891214  Prologue converted to Version 4.0 format.  (BAB)
  !   900402  Added TYPE section.  (WRB)

  INTEGER, INTENT(IN) :: Iz
  REAL(SP), INTENT(IN) :: X, A(Iz), Bh(Iz), C(Iz)
  !
  INTEGER :: j
  REAL(SP) :: summ
  !* FIRST EXECUTABLE STATEMENT  PPSGF
  summ = 0._SP
  DO j = 1, Iz
    summ = summ - 1._SP/(X-Bh(j))**2
  END DO
  PPSGF = summ
  !
END FUNCTION PPSGF