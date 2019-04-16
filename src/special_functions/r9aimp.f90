!** R9AIMP
SUBROUTINE R9AIMP(X,Ampl,Theta)
  !>
  !***
  !  Evaluate the Airy modulus and phase.
  !***
  ! **Library:**   SLATEC (FNLIB)
  !***
  ! **Category:**  C10D
  !***
  ! **Type:**      SINGLE PRECISION (R9AIMP-S, D9AIMP-D)
  !***
  ! **Keywords:**  AIRY FUNCTION, FNLIB, MODULUS, PHASE, SPECIAL FUNCTIONS
  !***
  ! **Author:**  Fullerton, W., (LANL)
  !***
  ! **Description:**
  !
  ! Evaluate the Airy modulus and phase for X .LE. -1.0
  !
  ! Series for AM21       on the interval -1.25000D-01 to  0.
  !                                        with weighted error   2.89E-17
  !                                         log weighted error  16.54
  !                               significant figures required  14.15
  !                                    decimal places required  17.34
  !
  ! Series for ATH1       on the interval -1.25000D-01 to  0.
  !                                        with weighted error   2.53E-17
  !                                         log weighted error  16.60
  !                               significant figures required  15.15
  !                                    decimal places required  17.38
  !
  ! Series for AM22       on the interval -1.00000D+00 to -1.25000D-01
  !                                        with weighted error   2.99E-17
  !                                         log weighted error  16.52
  !                               significant figures required  14.57
  !                                    decimal places required  17.28
  !
  ! Series for ATH2       on the interval -1.00000D+00 to -1.25000D-01
  !                                        with weighted error   2.57E-17
  !                                         log weighted error  16.59
  !                               significant figures required  15.07
  !                                    decimal places required  17.34
  !
  !***
  ! **References:**  (NONE)
  !***
  ! **Routines called:**  CSEVL, INITS, R1MACH, XERMSG

  !* REVISION HISTORY  (YYMMDD)
  !   770701  DATE WRITTEN
  !   890206  REVISION DATE from Version 3.2
  !   891214  Prologue converted to Version 4.0 format.  (BAB)
  !   900315  CALLs to XERROR changed to CALLs to XERMSG.  (THJ)
  !   900720  Routine changed from user-callable to subsidiary.  (WRB)

  REAL Ampl, eta, sqrtx, Theta, X, z
  INTEGER, SAVE :: nam21, nath1, nam22, nath2
  REAL, SAVE :: xsml
  REAL, PARAMETER :: am21cs(40) = [ .0065809191761485E0, .0023675984685722E0, &
    .0001324741670371E0, .0000157600904043E0, .0000027529702663E0, &
    .0000006102679017E0, .0000001595088468E0, .0000000471033947E0, &
    .0000000152933871E0, .0000000053590722E0, .0000000020000910E0, &
    .0000000007872292E0, .0000000003243103E0, .0000000001390106E0, &
    .0000000000617011E0, .0000000000282491E0, .0000000000132979E0, &
    .0000000000064188E0, .0000000000031697E0, .0000000000015981E0, &
    .0000000000008213E0, .0000000000004296E0, .0000000000002284E0, &
    .0000000000001232E0, .0000000000000675E0, .0000000000000374E0, &
    .0000000000000210E0, .0000000000000119E0, .0000000000000068E0, &
    .0000000000000039E0, .0000000000000023E0, .0000000000000013E0, &
    .0000000000000008E0, .0000000000000005E0, .0000000000000003E0, &
    .0000000000000001E0, .0000000000000001E0, .0000000000000000E0, &
    .0000000000000000E0, .0000000000000000E0 ]
  REAL, PARAMETER :: ath1cs(36) = [ -.07125837815669365E0, -.00590471979831451E0, &
    -.00012114544069499E0, -.00000988608542270E0, -.00000138084097352E0, &
    -.00000026142640172E0, -.00000006050432589E0, -.00000001618436223E0, &
    -.00000000483464911E0, -.00000000157655272E0, -.00000000055231518E0, &
    -.00000000020545441E0, -.00000000008043412E0, -.00000000003291252E0, &
    -.00000000001399875E0, -.00000000000616151E0, -.00000000000279614E0, &
    -.00000000000130428E0, -.00000000000062373E0, -.00000000000030512E0, &
    -.00000000000015239E0, -.00000000000007758E0, -.00000000000004020E0, &
    -.00000000000002117E0, -.00000000000001132E0, -.00000000000000614E0, &
    -.00000000000000337E0, -.00000000000000188E0, -.00000000000000105E0, &
    -.00000000000000060E0, -.00000000000000034E0, -.00000000000000020E0, &
    -.00000000000000011E0, -.00000000000000007E0, -.00000000000000004E0, &
    -.00000000000000002E0 ]
  REAL, PARAMETER :: am22cs(33) = [ -.01562844480625341E0, .00778336445239681E0, &
    .00086705777047718E0, .00015696627315611E0, .00003563962571432E0, &
    .00000924598335425E0, .00000262110161850E0, .00000079188221651E0, &
    .00000025104152792E0, .00000008265223206E0, .00000002805711662E0, &
    .00000000976821090E0, .00000000347407923E0, .00000000125828132E0, &
    .00000000046298826E0, .00000000017272825E0, .00000000006523192E0, &
    .00000000002490471E0, .00000000000960156E0, .00000000000373448E0, &
    .00000000000146417E0, .00000000000057826E0, .00000000000022991E0, &
    .00000000000009197E0, .00000000000003700E0, .00000000000001496E0, &
    .00000000000000608E0, .00000000000000248E0, .00000000000000101E0, &
    .00000000000000041E0, .00000000000000017E0, .00000000000000007E0, &
    .00000000000000002E0 ]
  REAL, PARAMETER :: ath2cs(32) = [ .00440527345871877E0,-.03042919452318455E0, &
    -.00138565328377179E0,-.00018044439089549E0,-.00003380847108327E0, &
    -.00000767818353522E0,-.00000196783944371E0,-.00000054837271158E0, &
    -.00000016254615505E0,-.00000005053049981E0,-.00000001631580701E0, &
    -.00000000543420411E0,-.00000000185739855E0,-.00000000064895120E0, &
    -.00000000023105948E0,-.00000000008363282E0,-.00000000003071196E0, &
    -.00000000001142367E0,-.00000000000429811E0,-.00000000000163389E0, &
    -.00000000000062693E0,-.00000000000024260E0,-.00000000000009461E0, &
    -.00000000000003716E0,-.00000000000001469E0,-.00000000000000584E0, &
    -.00000000000000233E0,-.00000000000000093E0,-.00000000000000037E0, &
    -.00000000000000015E0,-.00000000000000006E0,-.00000000000000002E0 ]
  REAL, PARAMETER ::  pi4 = 0.78539816339744831E0
  LOGICAL :: first = .TRUE.
  !* FIRST EXECUTABLE STATEMENT  R9AIMP
  IF ( first ) THEN
    eta = 0.1*R1MACH(3)
    nam21 = INITS(am21cs,40,eta)
    nath1 = INITS(ath1cs,36,eta)
    nam22 = INITS(am22cs,33,eta)
    nath2 = INITS(ath2cs,32,eta)
    !
    xsml = -1.0/R1MACH(3)**0.3333
    first = .FALSE.
  END IF
  !
  IF ( X>=(-2.0) ) THEN
    !
    IF ( X>(-1.0) ) CALL XERMSG('SLATEC','R9AIMP','X MUST BE LE -1.0',1,2)
    !
    z = (16.0/X**3+9.0)/7.0
    Ampl = 0.3125 + CSEVL(z,am22cs,nam22)
    Theta = -0.625 + CSEVL(z,ath2cs,nath2)
  ELSE
    z = 1.0
    IF ( X>xsml ) z = 16.0/X**3 + 1.0
    Ampl = 0.3125 + CSEVL(z,am21cs,nam21)
    Theta = -0.625 + CSEVL(z,ath1cs,nath1)
  END IF
  !
  sqrtx = SQRT(-X)
  Ampl = SQRT(Ampl/sqrtx)
  Theta = pi4 - X*sqrtx*Theta
  !
END SUBROUTINE R9AIMP
