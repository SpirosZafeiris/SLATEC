!** DBESI0
REAL(8) FUNCTION DBESI0(X)
  !>
  !  Compute the hyperbolic Bessel function of the first kind
  !            of order zero.
  !***
  ! **Library:**   SLATEC (FNLIB)
  !***
  ! **Category:**  C10B1
  !***
  ! **Type:**      DOUBLE PRECISION (BESI0-S, DBESI0-D)
  !***
  ! **Keywords:**  FIRST KIND, FNLIB, HYPERBOLIC BESSEL FUNCTION,
  !             MODIFIED BESSEL FUNCTION, ORDER ZERO, SPECIAL FUNCTIONS
  !***
  ! **Author:**  Fullerton, W., (LANL)
  !***
  ! **Description:**
  !
  ! DBESI0(X) calculates the double precision modified (hyperbolic)
  ! Bessel function of the first kind of order zero and double
  ! precision argument X.
  !
  ! Series for BI0        on the interval  0.          to  9.00000E+00
  !                                        with weighted error   9.51E-34
  !                                         log weighted error  33.02
  !                               significant figures required  33.31
  !                                    decimal places required  33.65
  !
  !***
  ! **References:**  (NONE)
  !***
  ! **Routines called:**  D1MACH, DBSI0E, DCSEVL, INITDS, XERMSG

  !* REVISION HISTORY  (YYMMDD)
  !   770701  DATE WRITTEN
  !   890531  Changed all specific intrinsics to generic.  (WRB)
  !   890531  REVISION DATE from Version 3.2
  !   891214  Prologue converted to Version 4.0 format.  (BAB)
  !   900315  CALLs to XERROR changed to CALLs to XERMSG.  (THJ)
  USE service, ONLY : XERMSG, D1MACH
  REAL(8) :: X, y
  INTEGER, SAVE :: nti0
  REAL(8), SAVE :: xsml, xmax
  REAL(8), PARAMETER :: bi0cs(18) = [ -.7660547252839144951081894976243285D-1, &
    +.1927337953993808269952408750881196D+1, +.2282644586920301338937029292330415D+0, &
    +.1304891466707290428079334210691888D-1, +.4344270900816487451378682681026107D-3, &
    +.9422657686001934663923171744118766D-5, +.1434006289510691079962091878179957D-6, &
    +.1613849069661749069915419719994611D-8, +.1396650044535669699495092708142522D-10, &
    +.9579451725505445344627523171893333D-13, +.5333981859862502131015107744000000D-15, &
    +.2458716088437470774696785919999999D-17, +.9535680890248770026944341333333333D-20, &
    +.3154382039721427336789333333333333D-22, +.9004564101094637431466666666666666D-25, &
    +.2240647369123670016000000000000000D-27, +.4903034603242837333333333333333333D-30, &
    +.9508172606122666666666666666666666D-33 ]
  LOGICAL :: first = .TRUE.
  !* FIRST EXECUTABLE STATEMENT  DBESI0
  IF ( first ) THEN
    nti0 = INITDS(bi0cs,18,0.1*REAL(D1MACH(3)))
    xsml = SQRT(4.5D0*D1MACH(3))
    xmax = LOG(D1MACH(2))
    first = .FALSE.
  END IF
  !
  y = ABS(X)
  IF ( y>3.0D0 ) THEN
    !
    IF ( y>xmax ) CALL XERMSG('SLATEC','DBESI0','ABS(X) SO BIG I0 OVERFLOWS',2,2)
    !
    DBESI0 = EXP(y)*DBSI0E(X)
    RETURN
  END IF
  !
  DBESI0 = 1.0D0
  IF ( y>xsml ) DBESI0 = 2.75D0 + DCSEVL(y*y/4.5D0-1.D0,bi0cs,nti0)
  RETURN
END FUNCTION DBESI0
