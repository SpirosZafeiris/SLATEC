!** D9ATN1
REAL(8) FUNCTION D9ATN1(X)
  !>
  !***
  !  Evaluate DATAN(X) from first order relative accuracy so
  !            that DATAN(X) = X + X**3*D9ATN1(X).
  !***
  ! **Library:**   SLATEC (FNLIB)
  !***
  ! **Category:**  C4A
  !***
  ! **Type:**      DOUBLE PRECISION (R9ATN1-S, D9ATN1-D)
  !***
  ! **Keywords:**  ARC TANGENT, ELEMENTARY FUNCTIONS, FIRST ORDER, FNLIB,
  !             TRIGONOMETRIC
  !***
  ! **Author:**  Fullerton, W., (LANL)
  !***
  ! **Description:**
  !
  ! Evaluate  DATAN(X)  from first order, that is, evaluate
  ! (DATAN(X)-X)/X**3  with relative error accuracy so that
  !        DATAN(X) = X + X**3*D9ATN1(X).
  !
  ! Series for ATN1       on the interval  0.          to  1.00000E+00
  !                                        with weighted error   3.39E-32
  !                                         log weighted error  31.47
  !                               significant figures required  30.26
  !                                    decimal places required  32.27
  !
  !***
  ! **References:**  (NONE)
  !***
  ! **Routines called:**  D1MACH, DCSEVL, INITDS, XERMSG

  !* REVISION HISTORY  (YYMMDD)
  !   780401  DATE WRITTEN
  !   890531  Changed all specific intrinsics to generic.  (WRB)
  !   891115  Corrected third argument in reference to INITDS.  (WRB)
  !   891115  REVISION DATE from Version 3.2
  !   891214  Prologue converted to Version 4.0 format.  (BAB)
  !   900315  CALLs to XERROR changed to CALLs to XERMSG.  (THJ)
  !   900720  Routine changed from user-callable to subsidiary.  (WRB)
  USE service, ONLY : XERMSG, D1MACH
  REAL(8) :: X, y, eps
  INTEGER, SAVE :: ntatn1
  REAL(8), SAVE :: xsml, xbig, xmax
  REAL(8), PARAMETER :: atn1cs(40) = [ -.3283997535355202356907939922990D-1, &
    +.5833432343172412449951669914907D-1, -.7400369696719646463809011551413D-2, &
    +.1009784199337288083590357511639D-2, -.1439787163565205621471303697700D-3, &
    +.2114512648992107572072112243439D-4, -.3172321074254667167402564996757D-5, &
    +.4836620365460710825377859384800D-6, -.7467746546814112670437614322776D-7, &
    +.1164800896824429830620998641342D-7, -.1832088370847201392699956242452D-8, &
    +.2901908277966063313175351230455D-9, -.4623885312106326738351805721512D-10, &
    +.7405528668775736917992197048286D-11, -.1191354457845136682370820373417D-11, &
    +.1924090144391772599867855692518D-12, -.3118271051076194272254476155327D-13, &
    +.5069240036567731789694520593032D-14, -.8263694719802866053818284405964D-15, &
    +.1350486709817079420526506123029D-15, -.2212023650481746045840137823191D-16, &
    +.3630654747381356783829047647709D-17, -.5970345328847154052451215859165D-18, &
    +.9834816050077133119448329005738D-19, -.1622655075855062336144387604480D-19, &
    +.2681186176945436796301320301226D-20, -.4436309706785255479636243688106D-21, &
    +.7349691897652496945072465510400D-22, -.1219077508350052588289401378133D-22, &
    +.2024298836805215403184540876799D-23, -.3364871555797354579925576362666D-24, &
    +.5598673968346988749492933973333D-25, -.9323939267272320229628532053333D-26, &
    +.1554133116995970222934807893333D-26, -.2592569534179745922757427199999D-27, &
    +.4328193466245734685037909333333D-28, -.7231013125595437471192405333333D-29, &
    +.1208902859830494772942165333333D-29, -.2022404543449897579315199999999D-30, &
    +.3385428713046493843073706666666D-31 ]
  LOGICAL :: first = .TRUE.
  !* FIRST EXECUTABLE STATEMENT  D9ATN1
  IF ( first ) THEN
    eps = D1MACH(3)
    ntatn1 = INITDS(atn1cs,40,0.1*REAL(eps))
    !
    xsml = SQRT(0.1D0*eps)
    xbig = 1.571D0/SQRT(eps)
    xmax = 1.571D0/eps
    first = .FALSE.
  END IF
  !
  y = ABS(X)
  IF ( y>1.0D0 ) THEN
    !
    IF ( y>xmax ) CALL XERMSG('SLATEC','D9ATN1',&
      'NO PRECISION IN ANSWER BECAUSE X IS TOO BIG',2,2)
    IF ( y>xbig ) CALL XERMSG('SLATEC','D9ATN1',&
      'ANSWER LT HALF PRECISION BECAUSE X IS TOO BIG',1,1)
    !
    D9ATN1 = (ATAN(X)-X)/X**3
    RETURN
  END IF
  !
  IF ( y<=xsml ) D9ATN1 = -1.0D0/3.0D0
  IF ( y<=xsml ) RETURN
  !
  D9ATN1 = -0.25D0 + DCSEVL(2.D0*y*y-1.D0,atn1cs,ntatn1)
  RETURN
END FUNCTION D9ATN1
