!** DEXPRL
REAL(8) FUNCTION DEXPRL(X)
  IMPLICIT NONE
  !>
  !***
  !  Calculate the relative error exponential (EXP(X)-1)/X.
  !***
  ! **Library:**   SLATEC (FNLIB)
  !***
  ! **Category:**  C4B
  !***
  ! **Type:**      DOUBLE PRECISION (EXPREL-S, DEXPRL-D, CEXPRL-C)
  !***
  ! **Keywords:**  ELEMENTARY FUNCTIONS, EXPONENTIAL, FIRST ORDER, FNLIB
  !***
  ! **Author:**  Fullerton, W., (LANL)
  !***
  ! **Description:**
  !
  ! Evaluate  EXPREL(X) = (EXP(X) - 1.0) / X.   For small ABS(X) the
  ! Taylor series is used.  If X is negative the reflection formula
  !         EXPREL(X) = EXP(X) * EXPREL(ABS(X))
  ! may be used.  This reflection formula will be of use when the
  ! evaluation for small ABS(X) is done by Chebyshev series rather than
  ! Taylor series.
  !
  !***
  ! **References:**  (NONE)
  !***
  ! **Routines called:**  D1MACH

  !* REVISION HISTORY  (YYMMDD)
  !   770801  DATE WRITTEN
  !   890531  Changed all specific intrinsics to generic.  (WRB)
  !   890911  Removed unnecessary intrinsics.  (WRB)
  !   890911  REVISION DATE from Version 3.2
  !   891214  Prologue converted to Version 4.0 format.  (BAB)

  INTEGER i
  REAL(8) :: X, absx, alneps, xln, xn, D1MACH
  INTEGER, SAVE :: nterms
  REAL(8), SAVE :: xbnd
  LOGICAL :: first = .TRUE.
  !* FIRST EXECUTABLE STATEMENT  DEXPRL
  IF ( first ) THEN
    alneps = LOG(D1MACH(3))
    xn = 3.72D0 - 0.3D0*alneps
    xln = LOG((xn+1.0D0)/1.36D0)
    nterms = INT( xn - (xn*xln+alneps)/(xln+1.36D0) + 1.5D0 )
    xbnd = D1MACH(3)
    first = .FALSE.
  ENDIF
  !
  absx = ABS(X)
  IF ( absx>0.5D0 ) DEXPRL = (EXP(X)-1.0D0)/X
  IF ( absx>0.5D0 ) RETURN
  !
  DEXPRL = 1.0D0
  IF ( absx<xbnd ) RETURN
  !
  DEXPRL = 0.0D0
  DO i = 1, nterms
    DEXPRL = 1.0D0 + DEXPRL*X/(nterms+2-i)
  ENDDO
  !
END FUNCTION DEXPRL
