!** CBUNK
SUBROUTINE CBUNK(Z,Fnu,Kode,Mr,N,Y,Nz,Tol,Elim,Alim)
  IMPLICIT NONE
  !>
  !***
  !  Subsidiary to CBESH and CBESK
  !***
  ! **Library:**   SLATEC
  !***
  ! **Type:**      ALL (CBUNK-A, ZBUNK-A)
  !***
  ! **Author:**  Amos, D. E., (SNL)
  !***
  ! **Description:**
  !
  !     CBUNK COMPUTES THE K BESSEL FUNCTION FOR FNU.GT.FNUL.
  !     ACCORDING TO THE UNIFORM ASYMPTOTIC EXPANSION FOR K(FNU,Z)
  !     IN CUNK1 AND THE EXPANSION FOR H(2,FNU,Z) IN CUNK2
  !
  !***
  ! **See also:**  CBESH, CBESK
  !***
  ! **Routines called:**  CUNK1, CUNK2

  !* REVISION HISTORY  (YYMMDD)
  !   830501  DATE WRITTEN
  !   910415  Prologue converted to Version 4.0 format.  (BAB)
  
  INTEGER Kode, Mr, N, Nz
  COMPLEX Y(N), Z
  REAL Alim, ax, ay, Elim, Fnu, Tol, xx, yy
  !* FIRST EXECUTABLE STATEMENT  CBUNK
  Nz = 0
  xx = REAL(Z)
  yy = AIMAG(Z)
  ax = ABS(xx)*1.7321E0
  ay = ABS(yy)
  IF ( ay>ax ) THEN
    !-----------------------------------------------------------------------
    !     ASYMPTOTIC EXPANSION FOR H(2,FNU,Z*EXP(M*HPI)) FOR LARGE FNU
    !     APPLIED IN PI/3.LT.ABS(ARG(Z)).LE.PI/2 WHERE M=+I OR -I
    !     AND HPI=PI/2
    !-----------------------------------------------------------------------
    CALL CUNK2(Z,Fnu,Kode,Mr,N,Y,Nz,Tol,Elim,Alim)
  ELSE
    !-----------------------------------------------------------------------
    !     ASYMPTOTIC EXPANSION FOR K(FNU,Z) FOR LARGE FNU APPLIED IN
    !     -PI/3.LE.ARG(Z).LE.PI/3
    !-----------------------------------------------------------------------
    CALL CUNK1(Z,Fnu,Kode,Mr,N,Y,Nz,Tol,Elim,Alim)
  ENDIF
END SUBROUTINE CBUNK
