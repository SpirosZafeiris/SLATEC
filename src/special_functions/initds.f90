!** INITDS
INTEGER FUNCTION INITDS(Os,Nos,Eta)
  IMPLICIT NONE
  !>
  !***
  !  Determine the number of terms needed in an orthogonal
  !            polynomial series so that it meets a specified accuracy.
  !***
  ! **Library:**   SLATEC (FNLIB)
  !***
  ! **Category:**  C3A2
  !***
  ! **Type:**      DOUBLE PRECISION (INITS-S, INITDS-D)
  !***
  ! **Keywords:**  CHEBYSHEV, FNLIB, INITIALIZE, ORTHOGONAL POLYNOMIAL,
  !             ORTHOGONAL SERIES, SPECIAL FUNCTIONS
  !***
  ! **Author:**  Fullerton, W., (LANL)
  !***
  ! **Description:**
  !
  !  Initialize the orthogonal series, represented by the array OS, so
  !  that INITDS is the number of terms needed to insure the error is no
  !  larger than ETA.  Ordinarily, ETA will be chosen to be one-tenth
  !  machine precision.
  !
  !             Input Arguments --
  !   OS     double precision array of NOS coefficients in an orthogonal
  !          series.
  !   NOS    number of coefficients in OS.
  !   ETA    single precision scalar containing requested accuracy of
  !          series.
  !
  !***
  ! **References:**  (NONE)
  !***
  ! **Routines called:**  XERMSG

  !* REVISION HISTORY  (YYMMDD)
  !   770601  DATE WRITTEN
  !   890531  Changed all specific intrinsics to generic.  (WRB)
  !   890831  Modified array declarations.  (WRB)
  !   891115  Modified error message.  (WRB)
  !   891115  REVISION DATE from Version 3.2
  !   891214  Prologue converted to Version 4.0 format.  (BAB)
  !   900315  CALLs to XERROR changed to CALLs to XERMSG.  (THJ)
  
  REAL err, Eta
  INTEGER i, ii, Nos
  REAL(8) :: Os(*)
  !* FIRST EXECUTABLE STATEMENT  INITDS
  IF ( Nos<1 ) CALL XERMSG('SLATEC','INITDS',&
    'Number of coefficients is less than 1',2,1)
  !
  err = 0.
  DO ii = 1, Nos
    i = Nos + 1 - ii
    err = err + ABS(REAL(Os(i)))
    IF ( err>Eta ) EXIT
  END DO
  !
  IF ( i==Nos ) CALL XERMSG('SLATEC','INITDS',&
    'Chebyshev series too short for specified accuracy',1,1)
  INITDS = i
  !
END FUNCTION INITDS
