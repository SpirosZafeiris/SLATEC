!** DBSK0E
REAL(DP) FUNCTION DBSK0E(X)
  !>
  !  Compute the exponentially scaled modified (hyperbolic)
  !            Bessel function of the third kind of order zero.
  !***
  ! **Library:**   SLATEC (FNLIB)
  !***
  ! **Category:**  C10B1
  !***
  ! **Type:**      DOUBLE PRECISION (BESK0E-S, DBSK0E-D)
  !***
  ! **Keywords:**  EXPONENTIALLY SCALED, FNLIB, HYPERBOLIC BESSEL FUNCTION,
  !             MODIFIED BESSEL FUNCTION, ORDER ZERO, SPECIAL FUNCTIONS,
  !             THIRD KIND
  !***
  ! **Author:**  Fullerton, W., (LANL)
  !***
  ! **Description:**
  !
  ! DBSK0E(X) computes the double precision exponentially scaled
  ! modified (hyperbolic) Bessel function of the third kind of
  ! order zero for positive double precision argument X.
  !
  ! Series for BK0        on the interval  0.          to  4.00000E+00
  !                                        with weighted error   3.08E-33
  !                                         log weighted error  32.51
  !                               significant figures required  32.05
  !                                    decimal places required  33.11
  !
  ! Series for AK0        on the interval  1.25000E-01 to  5.00000E-01
  !                                        with weighted error   2.85E-32
  !                                         log weighted error  31.54
  !                               significant figures required  30.19
  !                                    decimal places required  32.33
  !
  ! Series for AK02       on the interval  0.          to  1.25000E-01
  !                                        with weighted error   2.30E-32
  !                                         log weighted error  31.64
  !                               significant figures required  29.68
  !                                    decimal places required  32.40
  !
  !***
  ! **References:**  (NONE)
  !***
  ! **Routines called:**  D1MACH, DBESI0, DCSEVL, INITDS, XERMSG

  !* REVISION HISTORY  (YYMMDD)
  !   770701  DATE WRITTEN
  !   890531  Changed all specific intrinsics to generic.  (WRB)
  !   890531  REVISION DATE from Version 3.2
  !   891214  Prologue converted to Version 4.0 format.  (BAB)
  !   900315  CALLs to XERROR changed to CALLs to XERMSG.  (THJ)
  USE service, ONLY : XERMSG, D1MACH
  REAL(DP) :: X
  REAL(DP) :: y
  INTEGER, SAVE :: ntk0, ntak0, ntak02
  REAL(DP), PARAMETER :: eta = 0.1D0*D1MACH(3), xsml = SQRT(4.0D0*D1MACH(3))
  REAL(DP), PARAMETER :: bk0cs(16) = [ -.353273932339027687201140060063153D-1, &
    +.344289899924628486886344927529213D+0, +.359799365153615016265721303687231D-1, &
    +.126461541144692592338479508673447D-2, +.228621210311945178608269830297585D-4, &
    +.253479107902614945730790013428354D-6, +.190451637722020885897214059381366D-8, &
    +.103496952576336245851008317853089D-10, +.425981614279108257652445327170133D-13, &
    +.137446543588075089694238325440000D-15, +.357089652850837359099688597333333D-18, &
    +.763164366011643737667498666666666D-21, +.136542498844078185908053333333333D-23, &
    +.207527526690666808319999999999999D-26, +.271281421807298560000000000000000D-29, &
    +.308259388791466666666666666666666D-32 ]
  REAL(DP), PARAMETER :: ak0cs(38) = [ -.7643947903327941424082978270088D-1, &
    -.2235652605699819052023095550791D-1, +.7734181154693858235300618174047D-3, &
    -.4281006688886099464452146435416D-4, +.3081700173862974743650014826660D-5, &
    -.2639367222009664974067448892723D-6, +.2563713036403469206294088265742D-7, &
    -.2742705549900201263857211915244D-8, +.3169429658097499592080832873403D-9, &
    -.3902353286962184141601065717962D-10, +.5068040698188575402050092127286D-11, &
    -.6889574741007870679541713557984D-12, +.9744978497825917691388201336831D-13, &
    -.1427332841884548505389855340122D-13, +.2156412571021463039558062976527D-14, &
    -.3349654255149562772188782058530D-15, +.5335260216952911692145280392601D-16, &
    -.8693669980890753807639622378837D-17, +.1446404347862212227887763442346D-17, &
    -.2452889825500129682404678751573D-18, +.4233754526232171572821706342400D-19, &
    -.7427946526454464195695341294933D-20, +.1323150529392666866277967462400D-20, &
    -.2390587164739649451335981465599D-21, +.4376827585923226140165712554666D-22, &
    -.8113700607345118059339011413333D-23, +.1521819913832172958310378154666D-23, &
    -.2886041941483397770235958613333D-24, +.5530620667054717979992610133333D-25, &
    -.1070377329249898728591633066666D-25, +.2091086893142384300296328533333D-26, &
    -.4121713723646203827410261333333D-27, +.8193483971121307640135680000000D-28, &
    -.1642000275459297726780757333333D-28, +.3316143281480227195890346666666D-29, &
    -.6746863644145295941085866666666D-30, +.1382429146318424677635413333333D-30, &
    -.2851874167359832570811733333333D-31 ]
  REAL(DP), PARAMETER :: ak02cs(33) = [ -.1201869826307592239839346212452D-1, &
    -.9174852691025695310652561075713D-2, +.1444550931775005821048843878057D-3, &
    -.4013614175435709728671021077879D-5, +.1567831810852310672590348990333D-6, &
    -.7770110438521737710315799754460D-8, +.4611182576179717882533130529586D-9, &
    -.3158592997860565770526665803309D-10, +.2435018039365041127835887814329D-11, &
    -.2074331387398347897709853373506D-12, +.1925787280589917084742736504693D-13, &
    -.1927554805838956103600347182218D-14, +.2062198029197818278285237869644D-15, &
    -.2341685117579242402603640195071D-16, +.2805902810643042246815178828458D-17, &
    -.3530507631161807945815482463573D-18, +.4645295422935108267424216337066D-19, &
    -.6368625941344266473922053461333D-20, +.9069521310986515567622348800000D-21, &
    -.1337974785423690739845005311999D-21, +.2039836021859952315522088960000D-22, &
    -.3207027481367840500060869973333D-23, +.5189744413662309963626359466666D-24, &
    -.8629501497540572192964607999999D-25, +.1472161183102559855208038400000D-25, &
    -.2573069023867011283812351999999D-26, +.4601774086643516587376640000000D-27, &
    -.8411555324201093737130666666666D-28, +.1569806306635368939301546666666D-28, &
    -.2988226453005757788979199999999D-29, +.5796831375216836520618666666666D-30, &
    -.1145035994347681332155733333333D-30, +.2301266594249682802005333333333D-31 ]
  LOGICAL, SAVE :: first = .TRUE.
  !* FIRST EXECUTABLE STATEMENT  DBSK0E
  IF ( first ) THEN
    ntk0 = INITDS(bk0cs,16,eta)
    ntak0 = INITDS(ak0cs,38,eta)
    ntak02 = INITDS(ak02cs,33,eta)
    first = .FALSE.
  END IF
  !
  IF ( X<=0.D0 ) CALL XERMSG('DBSK0E','X IS ZERO OR NEGATIVE',2,2)
  IF ( X>2.0D0 ) THEN
    !
    IF ( X<=8.D0 ) THEN
      DBSK0E = (1.25D0+DCSEVL((16.D0/X-5.D0)/3.D0,ak0cs,ntak0))/SQRT(X)
    ELSE
      DBSK0E = (1.25D0+DCSEVL(16.D0/X-1.D0,ak02cs,ntak02))/SQRT(X)
    END IF
    RETURN
  END IF
  !
  y = 0.D0
  IF ( X>xsml ) y = X*X
  DBSK0E = EXP(X)&
    *(-LOG(0.5D0*X)*DBESI0(X)-0.25D0+DCSEVL(.5D0*y-1.D0,bk0cs,ntk0))
  RETURN
END FUNCTION DBSK0E
