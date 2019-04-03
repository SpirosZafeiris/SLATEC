!** DBESJ1
REAL(8) FUNCTION DBESJ1(X)
  IMPLICIT NONE
  !>
  !***
  !  Compute the Bessel function of the first kind of order one.
  !***
  ! **Library:**   SLATEC (FNLIB)
  !***
  ! **Category:**  C10A1
  !***
  ! **Type:**      DOUBLE PRECISION (BESJ1-S, DBESJ1-D)
  !***
  ! **Keywords:**  BESSEL FUNCTION, FIRST KIND, FNLIB, ORDER ONE,
  !             SPECIAL FUNCTIONS
  !***
  ! **Author:**  Fullerton, W., (LANL)
  !***
  ! **Description:**
  !
  ! DBESJ1(X) calculates the double precision Bessel function of the
  ! first kind of order one for double precision argument X.
  !
  ! Series for BJ1        on the interval  0.          to  1.60000E+01
  !                                        with weighted error   1.16E-33
  !                                         log weighted error  32.93
  !                               significant figures required  32.36
  !                                    decimal places required  33.57
  !
  !***
  ! **References:**  (NONE)
  !***
  ! **Routines called:**  D1MACH, D9B1MP, DCSEVL, INITDS, XERMSG

  !* REVISION HISTORY  (YYMMDD)
  !   780601  DATE WRITTEN
  !   890531  Changed all specific intrinsics to generic.  (WRB)
  !   890531  REVISION DATE from Version 3.2
  !   891214  Prologue converted to Version 4.0 format.  (BAB)
  !   900315  CALLs to XERROR changed to CALLs to XERMSG.  (THJ)
  !   910401  Corrected error in code which caused values to have the
  !           wrong sign for arguments less than 4.0.  (WRB)

  INTEGER INITDS
  REAL(8) :: X, ampl, theta, y, D1MACH, DCSEVL
  INTEGER, SAVE ::  ntj1
  REAL(8), SAVE ::xsml, xmin
  REAL(8), PARAMETER :: bj1cs(19) = [ -.117261415133327865606240574524003D+0, &
    -.253615218307906395623030884554698D+0, +.501270809844695685053656363203743D-1, &
    -.463151480962508191842619728789772D-2, +.247996229415914024539124064592364D-3, &
    -.867894868627882584521246435176416D-5, +.214293917143793691502766250991292D-6, &
    -.393609307918317979229322764073061D-8, +.559118231794688004018248059864032D-10, &
    -.632761640466139302477695274014880D-12, +.584099161085724700326945563268266D-14, &
    -.448253381870125819039135059199999D-16, +.290538449262502466306018688000000D-18, &
    -.161173219784144165412118186666666D-20, +.773947881939274637298346666666666D-23, &
    -.324869378211199841143466666666666D-25, +.120223767722741022720000000000000D-27, &
    -.395201221265134933333333333333333D-30, +.116167808226645333333333333333333D-32 ]
  LOGICAL :: first = .TRUE.
  !* FIRST EXECUTABLE STATEMENT  DBESJ1
  IF ( first ) THEN
    ntj1 = INITDS(bj1cs,19,0.1*REAL(D1MACH(3)))
    !
    xsml = SQRT(8.0D0*D1MACH(3))
    xmin = 2.0D0*D1MACH(1)
    first = .FALSE.
  ENDIF
  !
  y = ABS(X)
  IF ( y>4.0D0 ) THEN
    !
    CALL D9B1MP(y,ampl,theta)
    DBESJ1 = SIGN(ampl,X)*COS(theta)
    RETURN
  ENDIF
  !
  DBESJ1 = 0.0D0
  IF ( y==0.0D0 ) RETURN
  IF ( y<=xmin ) CALL XERMSG('SLATEC','DBESJ1',&
    'ABS(X) SO SMALL J1 UNDERFLOWS',1,1)
  IF ( y>xmin ) DBESJ1 = 0.5D0*X
  IF ( y>xsml ) DBESJ1 = X*(.25D0+DCSEVL(.125D0*y*y-1.D0,bj1cs,ntj1))
  RETURN
END FUNCTION DBESJ1
