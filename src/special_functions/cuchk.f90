!** CUCHK
SUBROUTINE CUCHK(Y,Nz,Ascle,Tol)
  !>
  !  Subsidiary to SERI, CUOIK, CUNK1, CUNK2, CUNI1, CUNI2 and
  !            CKSCL
  !***
  ! **Library:**   SLATEC
  !***
  ! **Type:**      ALL (CUCHK-A, ZUCHK-A)
  !***
  ! **Author:**  Amos, D. E., (SNL)
  !***
  ! **Description:**
  !
  !      Y ENTERS AS A SCALED QUANTITY WHOSE MAGNITUDE IS GREATER THAN
  !      EXP(-ALIM)=ASCLE=1.0E+3*R1MACH(1)/TOL. THE TEST IS MADE TO SEE
  !      IF THE MAGNITUDE OF THE REAL OR IMAGINARY PART WOULD UNDER FLOW
  !      WHEN Y IS SCALED (BY TOL) TO ITS PROPER VALUE. Y IS ACCEPTED
  !      IF THE UNDERFLOW IS AT LEAST ONE PRECISION BELOW THE MAGNITUDE
  !      OF THE LARGEST COMPONENT; OTHERWISE THE PHASE ANGLE DOES NOT HAVE
  !      ABSOLUTE ACCURACY AND AN UNDERFLOW IS ASSUMED.
  !
  !***
  ! **See also:**  CKSCL, CUNI1, CUNI2, CUNK1, CUNK2, CUOIK, SERI
  !***
  ! **Routines called:**  (NONE)

  !* REVISION HISTORY  (YYMMDD)
  !   ??????  DATE WRITTEN
  !   910415  Prologue converted to Version 4.0 format.  (BAB)
  
  !
  COMPLEX Y
  REAL Ascle, ss, st, Tol, yr, yi
  INTEGER Nz
  !* FIRST EXECUTABLE STATEMENT  CUCHK
  Nz = 0
  yr = REAL(Y)
  yi = AIMAG(Y)
  yr = ABS(yr)
  yi = ABS(yi)
  st = MIN(yr,yi)
  IF ( st>Ascle ) RETURN
  ss = MAX(yr,yi)
  st = st/Tol
  IF ( ss<st ) Nz = 1
END SUBROUTINE CUCHK
