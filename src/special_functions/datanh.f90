!** DATANH
REAL(8) FUNCTION DATANH(X)
  IMPLICIT NONE
  !>
  !***
  !  Compute the arc hyperbolic tangent.
  !***
  ! **Library:**   SLATEC (FNLIB)
  !***
  ! **Category:**  C4C
  !***
  ! **Type:**      DOUBLE PRECISION (ATANH-S, DATANH-D, CATANH-C)
  !***
  ! **Keywords:**  ARC HYPERBOLIC TANGENT, ATANH, ELEMENTARY FUNCTIONS,
  !             FNLIB, INVERSE HYPERBOLIC TANGENT
  !***
  ! **Author:**  Fullerton, W., (LANL)
  !***
  ! **Description:**
  !
  ! DATANH(X) calculates the double precision arc hyperbolic
  ! tangent for double precision argument X.
  !
  ! Series for ATNH       on the interval  0.          to  2.50000E-01
  !                                        with weighted error   6.86E-32
  !                                         log weighted error  31.16
  !                               significant figures required  30.00
  !                                    decimal places required  31.88
  !
  !***
  ! **References:**  (NONE)
  !***
  ! **Routines called:**  D1MACH, DCSEVL, INITDS, XERMSG

  !* REVISION HISTORY  (YYMMDD)
  !   770601  DATE WRITTEN
  !   890531  Changed all specific intrinsics to generic.  (WRB)
  !   890531  REVISION DATE from Version 3.2
  !   891214  Prologue converted to Version 4.0 format.  (BAB)
  !   900315  CALLs to XERROR changed to CALLs to XERMSG.  (THJ)

  INTEGER INITDS
  REAL(8) :: X, y, DCSEVL, D1MACH
  INTEGER, SAVE :: nterms
  REAL(8), SAVE :: dxrel, sqeps
  REAL(8), PARAMETER :: atnhcs(27) = [ +.9439510239319549230842892218633D-1, &
    +.4919843705578615947200034576668D-1, +.2102593522455432763479327331752D-2, &
    +.1073554449776116584640731045276D-3, +.5978267249293031478642787517872D-5, &
    +.3505062030889134845966834886200D-6, +.2126374343765340350896219314431D-7, &
    +.1321694535715527192129801723055D-8, +.8365875501178070364623604052959D-10, &
    +.5370503749311002163881434587772D-11, +.3486659470157107922971245784290D-12, &
    +.2284549509603433015524024119722D-13, +.1508407105944793044874229067558D-14, &
    +.1002418816804109126136995722837D-15, +.6698674738165069539715526882986D-17, &
    +.4497954546494931083083327624533D-18, +.3032954474279453541682367146666D-19, &
    +.2052702064190936826463861418666D-20, +.1393848977053837713193014613333D-21, &
    +.9492580637224576971958954666666D-23, +.6481915448242307604982442666666D-24, &
    +.4436730205723615272632320000000D-25, +.3043465618543161638912000000000D-26, &
    +.2091881298792393474047999999999D-27, +.1440445411234050561365333333333D-28, &
    +.9935374683141640465066666666666D-30, +.6863462444358260053333333333333D-31 ]
  LOGICAL :: first = .TRUE.
  !* FIRST EXECUTABLE STATEMENT  DATANH
  IF ( first ) THEN
    nterms = INITDS(atnhcs,27,0.1*REAL(D1MACH(3)))
    dxrel = SQRT(D1MACH(4))
    sqeps = SQRT(3.0D0*D1MACH(3))
    first = .FALSE.
  END IF
  !
  y = ABS(X)
  IF ( y>=1.D0 ) CALL XERMSG('SLATEC','DATANH','ABS(X) GE 1',2,2)
  !
  IF ( 1.D0-y<dxrel ) CALL XERMSG('SLATEC','DATANH',&
    'ANSWER LT HALF PRECISION BECAUSE ABS(X) TOO NEAR 1',1,1)
  !
  DATANH = X
  IF ( y>sqeps.AND.y<=0.5D0 )&
    DATANH = X*(1.0D0+DCSEVL(8.D0*X*X-1.D0,atnhcs,nterms))
  IF ( y>0.5D0 ) DATANH = 0.5D0*LOG((1.0D0+X)/(1.0D0-X))
  !
END FUNCTION DATANH
