!DECK DFAC
REAL(8) FUNCTION DFAC(N)
  IMPLICIT NONE
  !***BEGIN PROLOGUE  DFAC
  !***PURPOSE  Compute the factorial function.
  !***LIBRARY   SLATEC (FNLIB)
  !***CATEGORY  C1
  !***TYPE      DOUBLE PRECISION (FAC-S, DFAC-D)
  !***KEYWORDS  FACTORIAL, FNLIB, SPECIAL FUNCTIONS
  !***AUTHOR  Fullerton, W., (LANL)
  !***DESCRIPTION
  !
  ! DFAC(N) calculates the double precision factorial for integer
  ! argument N.
  !
  !***REFERENCES  (NONE)
  !***ROUTINES CALLED  D9LGMC, DGAMLM, XERMSG
  !***REVISION HISTORY  (YYMMDD)
  !   770601  DATE WRITTEN
  !   890531  Changed all specific intrinsics to generic.  (WRB)
  !   890531  REVISION DATE from Version 3.2
  !   891214  Prologue converted to Version 4.0 format.  (BAB)
  !   900315  CALLs to XERROR changed to CALLs to XERMSG.  (THJ)
  !***END PROLOGUE  DFAC
  INTEGER N, nmax
  REAL(8) :: facn(31), sq2pil, x, xmax, xmin, D9LGMC
  SAVE facn, sq2pil, nmax
  DATA facn(1)/ + .100000000000000000000000000000000D+1/
  DATA facn(2)/ + .100000000000000000000000000000000D+1/
  DATA facn(3)/ + .200000000000000000000000000000000D+1/
  DATA facn(4)/ + .600000000000000000000000000000000D+1/
  DATA facn(5)/ + .240000000000000000000000000000000D+2/
  DATA facn(6)/ + .120000000000000000000000000000000D+3/
  DATA facn(7)/ + .720000000000000000000000000000000D+3/
  DATA facn(8)/ + .504000000000000000000000000000000D+4/
  DATA facn(9)/ + .403200000000000000000000000000000D+5/
  DATA facn(10)/ + .362880000000000000000000000000000D+6/
  DATA facn(11)/ + .362880000000000000000000000000000D+7/
  DATA facn(12)/ + .399168000000000000000000000000000D+8/
  DATA facn(13)/ + .479001600000000000000000000000000D+9/
  DATA facn(14)/ + .622702080000000000000000000000000D+10/
  DATA facn(15)/ + .871782912000000000000000000000000D+11/
  DATA facn(16)/ + .130767436800000000000000000000000D+13/
  DATA facn(17)/ + .209227898880000000000000000000000D+14/
  DATA facn(18)/ + .355687428096000000000000000000000D+15/
  DATA facn(19)/ + .640237370572800000000000000000000D+16/
  DATA facn(20)/ + .121645100408832000000000000000000D+18/
  DATA facn(21)/ + .243290200817664000000000000000000D+19/
  DATA facn(22)/ + .510909421717094400000000000000000D+20/
  DATA facn(23)/ + .112400072777760768000000000000000D+22/
  DATA facn(24)/ + .258520167388849766400000000000000D+23/
  DATA facn(25)/ + .620448401733239439360000000000000D+24/
  DATA facn(26)/ + .155112100433309859840000000000000D+26/
  DATA facn(27)/ + .403291461126605635584000000000000D+27/
  DATA facn(28)/ + .108888694504183521607680000000000D+29/
  DATA facn(29)/ + .304888344611713860501504000000000D+30/
  DATA facn(30)/ + .884176199373970195454361600000000D+31/
  DATA facn(31)/ + .265252859812191058636308480000000D+33/
  DATA sq2pil/0.91893853320467274178032973640562D0/
  DATA nmax/0/
  !***FIRST EXECUTABLE STATEMENT  DFAC
  IF ( nmax==0 ) THEN
    CALL DGAMLM(xmin,xmax)
    nmax = INT( xmax ) - 1
  ENDIF
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
