!DECK CCBRT
COMPLEX FUNCTION CCBRT(Z)
  IMPLICIT NONE
  !***BEGIN PROLOGUE  CCBRT
  !***PURPOSE  Compute the cube root.
  !***LIBRARY   SLATEC (FNLIB)
  !***CATEGORY  C2
  !***TYPE      COMPLEX (CBRT-S, DCBRT-D, CCBRT-C)
  !***KEYWORDS  CUBE ROOT, ELEMENTARY FUNCTIONS, FNLIB, ROOTS
  !***AUTHOR  Fullerton, W., (LANL)
  !***DESCRIPTION
  !
  ! CCBRT(Z) calculates the complex cube root of Z.  The principal root
  ! for which -PI .LT. arg(Z) .LE. +PI is returned.
  !
  !***REFERENCES  (NONE)
  !***ROUTINES CALLED  CARG, CBRT
  !***REVISION HISTORY  (YYMMDD)
  !   770401  DATE WRITTEN
  !   890531  Changed all specific intrinsics to generic.  (WRB)
  !   890531  REVISION DATE from Version 3.2
  !   891214  Prologue converted to Version 4.0 format.  (BAB)
  !***END PROLOGUE  CCBRT
  REAL CARG, CBRT, r, theta
  COMPLEX Z
  !***FIRST EXECUTABLE STATEMENT  CCBRT
  theta = CARG(Z)/3.0
  r = CBRT(ABS(Z))
  !
  CCBRT = CMPLX(r*COS(theta),r*SIN(theta))
  !
END FUNCTION CCBRT
