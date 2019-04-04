!** DASINH
REAL(8) FUNCTION DASINH(X)
  IMPLICIT NONE
  !>
  !***
  !  Compute the arc hyperbolic sine.
  !***
  ! **Library:**   SLATEC (FNLIB)
  !***
  ! **Category:**  C4C
  !***
  ! **Type:**      DOUBLE PRECISION (ASINH-S, DASINH-D, CASINH-C)
  !***
  ! **Keywords:**  ARC HYPERBOLIC SINE, ASINH, ELEMENTARY FUNCTIONS, FNLIB,
  !             INVERSE HYPERBOLIC SINE
  !***
  ! **Author:**  Fullerton, W., (LANL)
  !***
  ! **Description:**
  !
  ! DASINH(X) calculates the double precision arc hyperbolic
  ! sine for double precision argument X.
  !
  !***
  ! **References:**  (NONE)
  !***
  ! **Routines called:**  D1MACH, DCSEVL, INITDS

  !* REVISION HISTORY  (YYMMDD)
  !   770601  DATE WRITTEN
  !   890531  Changed all specific intrinsics to generic.  (WRB)
  !   890531  REVISION DATE from Version 3.2
  !   891214  Prologue converted to Version 4.0 format.  (BAB)

  INTEGER INITDS
  REAL(8) :: X, y, DCSEVL, D1MACH
  INTEGER, SAVE :: nterms
  REAL(8), SAVE :: xmax, sqeps
  REAL(8), PARAMETER :: asnhcs(39) = [ -.12820039911738186343372127359268D+0, &
    -.58811761189951767565211757138362D-1, +.47274654322124815640725249756029D-2, &
    -.49383631626536172101360174790273D-3, +.58506207058557412287494835259321D-4, &
    -.74669983289313681354755069217188D-5, +.10011693583558199265966192015812D-5, &
    -.13903543858708333608616472258886D-6, +.19823169483172793547317360237148D-7, &
    -.28847468417848843612747272800317D-8, +.42672965467159937953457514995907D-9, &
    -.63976084654366357868752632309681D-10, +.96991686089064704147878293131179D-11, &
    -.14844276972043770830246658365696D-11, +.22903737939027447988040184378983D-12, &
    -.35588395132732645159978942651310D-13, +.55639694080056789953374539088554D-14, &
    -.87462509599624678045666593520162D-15, +.13815248844526692155868802298129D-15, &
    -.21916688282900363984955142264149D-16, +.34904658524827565638313923706880D-17, &
    -.55785788400895742439630157032106D-18, +.89445146617134012551050882798933D-19, &
    -.14383426346571317305551845239466D-19, +.23191811872169963036326144682666D-20, &
    -.37487007953314343674570604543999D-21, +.60732109822064279404549242880000D-22, &
    -.98599402764633583177370173440000D-23, +.16039217452788496315232638293333D-23, &
    -.26138847350287686596716134399999D-24, +.42670849606857390833358165333333D-25, &
    -.69770217039185243299730773333333D-26, +.11425088336806858659812693333333D-26, &
    -.18735292078860968933021013333333D-27, +.30763584414464922794065920000000D-28, &
    -.50577364031639824787046399999999D-29, +.83250754712689142224213333333333D-30, &
    -.13718457282501044163925333333333D-30, +.22629868426552784104106666666666D-31 ]
  REAL(8), PARAMETER :: aln2 = 0.69314718055994530941723212145818D0
  LOGICAL :: first = .TRUE.
  !* FIRST EXECUTABLE STATEMENT  DASINH
  IF ( first ) THEN
    nterms = INITDS(asnhcs,39,0.1*REAL(D1MACH(3)))
    sqeps = SQRT(D1MACH(3))
    xmax = 1.0D0/sqeps
    first = .FALSE.
  END IF
  !
  y = ABS(X)
  IF ( y>1.0D0 ) THEN
    IF ( y<xmax ) DASINH = LOG(y+SQRT(y*y+1.D0))
    IF ( y>=xmax ) DASINH = aln2 + LOG(y)
    DASINH = SIGN(DASINH,X)
    RETURN
  END IF
  !
  DASINH = X
  IF ( y>sqeps ) DASINH = X*(1.0D0+DCSEVL(2.D0*X*X-1.D0,asnhcs,nterms))
  RETURN
END FUNCTION DASINH
