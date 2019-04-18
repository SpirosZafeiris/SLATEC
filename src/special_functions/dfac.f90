!** DFAC
REAL(8) FUNCTION DFAC(N)
  !>
  !***
  !  Compute the factorial function.
  !***
  ! **Library:**   SLATEC (FNLIB)
  !***
  ! **Category:**  C1
  !***
  ! **Type:**      DOUBLE PRECISION (FAC-S, DFAC-D)
  !***
  ! **Keywords:**  FACTORIAL, FNLIB, SPECIAL FUNCTIONS
  !***
  ! **Author:**  Fullerton, W., (LANL)
  !***
  ! **Description:**
  !
  ! DFAC(N) calculates the double precision factorial for integer
  ! argument N.
  !
  !***
  ! **References:**  (NONE)
  !***
  ! **Routines called:**  D9LGMC, DGAMLM, XERMSG

  !* REVISION HISTORY  (YYMMDD)
  !   770601  DATE WRITTEN
  !   890531  Changed all specific intrinsics to generic.  (WRB)
  !   890531  REVISION DATE from Version 3.2
  !   891214  Prologue converted to Version 4.0 format.  (BAB)
  !   900315  CALLs to XERROR changed to CALLs to XERMSG.  (THJ)
  USE service, ONLY : XERMSG
  INTEGER N
  REAL(8) :: x, xmax, xmin
  REAL(8), PARAMETER :: facn(31) = [ +.100000000000000000000000000000000D+1, &
    +.100000000000000000000000000000000D+1, +.200000000000000000000000000000000D+1, &
    +.600000000000000000000000000000000D+1, +.240000000000000000000000000000000D+2, &
    +.120000000000000000000000000000000D+3, +.720000000000000000000000000000000D+3, &
    +.504000000000000000000000000000000D+4, +.403200000000000000000000000000000D+5, &
    +.362880000000000000000000000000000D+6, +.362880000000000000000000000000000D+7, &
    +.399168000000000000000000000000000D+8, +.479001600000000000000000000000000D+9, &
    +.622702080000000000000000000000000D+10, +.871782912000000000000000000000000D+11, &
    +.130767436800000000000000000000000D+13, +.209227898880000000000000000000000D+14, &
    +.355687428096000000000000000000000D+15, +.640237370572800000000000000000000D+16, &
    +.121645100408832000000000000000000D+18, +.243290200817664000000000000000000D+19, &
    +.510909421717094400000000000000000D+20, +.112400072777760768000000000000000D+22, &
    +.258520167388849766400000000000000D+23, +.620448401733239439360000000000000D+24, &
    +.155112100433309859840000000000000D+26, +.403291461126605635584000000000000D+27, &
    +.108888694504183521607680000000000D+29, +.304888344611713860501504000000000D+30, &
    +.884176199373970195454361600000000D+31, +.265252859812191058636308480000000D+33 ]
  REAL(8), PARAMETER :: sq2pil = 0.91893853320467274178032973640562D0
  INTEGER :: nmax = 0
  !* FIRST EXECUTABLE STATEMENT  DFAC
  IF ( nmax==0 ) THEN
    CALL DGAMLM(xmin,xmax)
    nmax = INT( xmax ) - 1
  END IF
  !
  IF ( N<0 ) CALL XERMSG('SLATEC','DFAC',&
    'FACTORIAL OF NEGATIVE INTEGER UNDEFINED',1,2)
  !
  IF ( N<=30 ) DFAC = facn(N+1)
  IF ( N<=30 ) RETURN
  !
  IF ( N>nmax ) CALL XERMSG('SLATEC','DFAC',&
    'N SO BIG FACTORIAL(N) OVERFLOWS',2,2)
  !
  x = N + 1
  DFAC = EXP((x-0.5D0)*LOG(x)-x+sq2pil+D9LGMC(x))
  !
END FUNCTION DFAC
