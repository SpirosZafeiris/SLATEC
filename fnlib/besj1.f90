!DECK BESJ1
FUNCTION BESJ1(X)
  IMPLICIT NONE
  REAL ampl, BESJ1, bj1cs, bm1cs, bth1cs, CSEVL, pi4, R1MACH, &
    theta, X, xmax, xmin, xsml, y, z
  INTEGER INITS, ntj1, ntm1, ntth1
  !***BEGIN PROLOGUE  BESJ1
  !***PURPOSE  Compute the Bessel function of the first kind of order one.
  !***LIBRARY   SLATEC (FNLIB)
  !***CATEGORY  C10A1
  !***TYPE      SINGLE PRECISION (BESJ1-S, DBESJ1-D)
  !***KEYWORDS  BESSEL FUNCTION, FIRST KIND, FNLIB, ORDER ONE,
  !             SPECIAL FUNCTIONS
  !***AUTHOR  Fullerton, W., (LANL)
  !***DESCRIPTION
  !
  ! BESJ1(X) calculates the Bessel function of the first kind of
  ! order one for real argument X.
  !
  ! Series for BJ1        on the interval  0.          to  1.60000D+01
  !                                        with weighted error   4.48E-17
  !                                         log weighted error  16.35
  !                               significant figures required  15.77
  !                                    decimal places required  16.89
  !
  ! Series for BM1        on the interval  0.          to  6.25000D-02
  !                                        with weighted error   5.61E-17
  !                                         log weighted error  16.25
  !                               significant figures required  14.97
  !                                    decimal places required  16.91
  !
  ! Series for BTH1       on the interval  0.          to  6.25000D-02
  !                                        with weighted error   4.10E-17
  !                                         log weighted error  16.39
  !                               significant figures required  15.96
  !                                    decimal places required  17.08
  !
  !***REFERENCES  (NONE)
  !***ROUTINES CALLED  CSEVL, INITS, R1MACH, XERMSG
  !***REVISION HISTORY  (YYMMDD)
  !   780601  DATE WRITTEN
  !   890210  REVISION DATE from Version 3.2
  !   891214  Prologue converted to Version 4.0 format.  (BAB)
  !   900315  CALLs to XERROR changed to CALLs to XERMSG.  (THJ)
  !   900326  Removed duplicate information from DESCRIPTION section.
  !           (WRB)
  !***END PROLOGUE  BESJ1
  DIMENSION bj1cs(12), bm1cs(21), bth1cs(24)
  LOGICAL first
  SAVE bj1cs, bm1cs, bth1cs, pi4, ntj1, ntm1, ntth1, xsml, xmin, &
    xmax, first
  DATA bj1cs(1)/ - .11726141513332787E0/
  DATA bj1cs(2)/ - .25361521830790640E0/
  DATA bj1cs(3)/.050127080984469569E0/
  DATA bj1cs(4)/ - .004631514809625081E0/
  DATA bj1cs(5)/.000247996229415914E0/
  DATA bj1cs(6)/ - .000008678948686278E0/
  DATA bj1cs(7)/.000000214293917143E0/
  DATA bj1cs(8)/ - .000000003936093079E0/
  DATA bj1cs(9)/.000000000055911823E0/
  DATA bj1cs(10)/ - .000000000000632761E0/
  DATA bj1cs(11)/.000000000000005840E0/
  DATA bj1cs(12)/ - .000000000000000044E0/
  DATA bm1cs(1)/.1047362510931285E0/
  DATA bm1cs(2)/.00442443893702345E0/
  DATA bm1cs(3)/ - .00005661639504035E0/
  DATA bm1cs(4)/.00000231349417339E0/
  DATA bm1cs(5)/ - .00000017377182007E0/
  DATA bm1cs(6)/.00000001893209930E0/
  DATA bm1cs(7)/ - .00000000265416023E0/
  DATA bm1cs(8)/.00000000044740209E0/
  DATA bm1cs(9)/ - .00000000008691795E0/
  DATA bm1cs(10)/.00000000001891492E0/
  DATA bm1cs(11)/ - .00000000000451884E0/
  DATA bm1cs(12)/.00000000000116765E0/
  DATA bm1cs(13)/ - .00000000000032265E0/
  DATA bm1cs(14)/.00000000000009450E0/
  DATA bm1cs(15)/ - .00000000000002913E0/
  DATA bm1cs(16)/.00000000000000939E0/
  DATA bm1cs(17)/ - .00000000000000315E0/
  DATA bm1cs(18)/.00000000000000109E0/
  DATA bm1cs(19)/ - .00000000000000039E0/
  DATA bm1cs(20)/.00000000000000014E0/
  DATA bm1cs(21)/ - .00000000000000005E0/
  DATA bth1cs(1)/.74060141026313850E0/
  DATA bth1cs(2)/ - .004571755659637690E0/
  DATA bth1cs(3)/.000119818510964326E0/
  DATA bth1cs(4)/ - .000006964561891648E0/
  DATA bth1cs(5)/.000000655495621447E0/
  DATA bth1cs(6)/ - .000000084066228945E0/
  DATA bth1cs(7)/.000000013376886564E0/
  DATA bth1cs(8)/ - .000000002499565654E0/
  DATA bth1cs(9)/.000000000529495100E0/
  DATA bth1cs(10)/ - .000000000124135944E0/
  DATA bth1cs(11)/.000000000031656485E0/
  DATA bth1cs(12)/ - .000000000008668640E0/
  DATA bth1cs(13)/.000000000002523758E0/
  DATA bth1cs(14)/ - .000000000000775085E0/
  DATA bth1cs(15)/.000000000000249527E0/
  DATA bth1cs(16)/ - .000000000000083773E0/
  DATA bth1cs(17)/.000000000000029205E0/
  DATA bth1cs(18)/ - .000000000000010534E0/
  DATA bth1cs(19)/.000000000000003919E0/
  DATA bth1cs(20)/ - .000000000000001500E0/
  DATA bth1cs(21)/.000000000000000589E0/
  DATA bth1cs(22)/ - .000000000000000237E0/
  DATA bth1cs(23)/.000000000000000097E0/
  DATA bth1cs(24)/ - .000000000000000040E0/
  DATA pi4/0.78539816339744831E0/
  DATA first/.TRUE./
  !***FIRST EXECUTABLE STATEMENT  BESJ1
  IF ( first ) THEN
    ntj1 = INITS(bj1cs,12,0.1*R1MACH(3))
    ntm1 = INITS(bm1cs,21,0.1*R1MACH(3))
    ntth1 = INITS(bth1cs,24,0.1*R1MACH(3))
    !
    xsml = SQRT(8.0*R1MACH(3))
    xmin = 2.0*R1MACH(1)
    xmax = 1.0/R1MACH(4)
  ENDIF
  first = .FALSE.
  !
  y = ABS(X)
  IF ( y>4.0 ) THEN
    !
    IF ( y>xmax ) CALL XERMSG('SLATEC','BESJ1',&
      'NO PRECISION BECAUSE ABS(X) IS TOO BIG',2,2)
    z = 32.0/y**2 - 1.0
    ampl = (0.75+CSEVL(z,bm1cs,ntm1))/SQRT(y)
    theta = y - 3.0*pi4 + CSEVL(z,bth1cs,ntth1)/y
    BESJ1 = SIGN(ampl,X)*COS(theta)
    RETURN
  ENDIF
  !
  BESJ1 = 0.
  IF ( y==0.0 ) RETURN
  IF ( y<=xmin ) CALL XERMSG('SLATEC','BESJ1',&
    'ABS(X) SO SMALL J1 UNDERFLOWS',1,1)
  IF ( y>xmin ) BESJ1 = 0.5*X
  IF ( y>xsml ) BESJ1 = X*(.25+CSEVL(.125*y*y-1.,bj1cs,ntj1))
  RETURN
END FUNCTION BESJ1
