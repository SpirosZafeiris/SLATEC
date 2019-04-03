!** ASINH
REAL FUNCTION ASINH(X)
  IMPLICIT NONE
  !>
  !***
  !  Compute the arc hyperbolic sine.
  !***
  ! **Library:**   SLATEC (FNLIB)
  !***
  ! **Category:**  C4C
  !***
  ! **Type:**      SINGLE PRECISION (ASINH-S, DASINH-D, CASINH-C)
  !***
  ! **Keywords:**  ARC HYPERBOLIC SINE, ASINH, ELEMENTARY FUNCTIONS, FNLIB,
  !             INVERSE HYPERBOLIC SINE
  !***
  ! **Author:**  Fullerton, W., (LANL)
  !***
  ! **Description:**
  !
  ! ASINH(X) computes the arc hyperbolic sine of X.
  !
  ! Series for ASNH       on the interval  0.          to  1.00000D+00
  !                                        with weighted error   2.19E-17
  !                                         log weighted error  16.66
  !                               significant figures required  15.60
  !                                    decimal places required  17.31
  !
  !***
  ! **References:**  (NONE)
  !***
  ! **Routines called:**  CSEVL, INITS, R1MACH

  !* REVISION HISTORY  (YYMMDD)
  !   770401  DATE WRITTEN
  !   890531  Changed all specific intrinsics to generic.  (WRB)
  !   890531  REVISION DATE from Version 3.2
  !   891214  Prologue converted to Version 4.0 format.  (BAB)

  REAL CSEVL, R1MACH, X, y
  INTEGER INITS
  INTEGER, SAVE :: nterms
  REAL, SAVE :: xmax, sqeps
  REAL, PARAMETER :: aln2 = 0.69314718055994530942E0
  REAL, PARAMETER :: asnhcs(20) = [ -.12820039911738186E0,-.058811761189951768E0, &
    .004727465432212481E0, -.000493836316265361E0, .000058506207058557E0, &
    -.000007466998328931E0, .000001001169358355E0,-.000000139035438587E0, &
    .000000019823169483E0, -.000000002884746841E0, .000000000426729654E0, &
    -.000000000063976084E0, .000000000009699168E0,-.000000000001484427E0, &
    .000000000000229037E0, -.000000000000035588E0, .000000000000005563E0, &
    -.000000000000000874E0, .000000000000000138E0,-.000000000000000021E0 ]
  LOGICAL :: first = .TRUE.
  !* FIRST EXECUTABLE STATEMENT  ASINH
  IF ( first ) THEN
    nterms = INITS(asnhcs,20,0.1*R1MACH(3))
    sqeps = SQRT(R1MACH(3))
    xmax = 1.0/sqeps
    first = .FALSE.
  ENDIF
  !
  y = ABS(X)
  IF ( y>1.0 ) THEN
    !
    IF ( y<xmax ) ASINH = LOG(y+SQRT(y**2+1.))
    IF ( y>=xmax ) ASINH = aln2 + LOG(y)
    ASINH = SIGN(ASINH,X)
    RETURN
  ENDIF
  !
  ASINH = X
  IF ( y>sqeps ) ASINH = X*(1.0+CSEVL(2.*X*X-1.,asnhcs,nterms))
  RETURN
END FUNCTION ASINH
