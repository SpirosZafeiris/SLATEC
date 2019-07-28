!** GVEC
PURE SUBROUTINE GVEC(X,G)
  !> Subsidiary to
  !***
  ! **Library:**   SLATEC
  !***
  ! **Author:**  (UNKNOWN)
  !***
  ! **Routines called:**  (NONE)

  !* REVISION HISTORY  (YYMMDD)
  !   ??????  DATE WRITTEN
  !   891214  Prologue converted to Version 4.0 format.  (BAB)

  REAL(SP), INTENT(IN) :: X
  REAL(SP), INTENT(OUT) :: G(2)
  !* FIRST EXECUTABLE STATEMENT  GVEC
  G(1) = 0._SP
  G(2) = 1._SP + COS(X)
  !
END SUBROUTINE GVEC