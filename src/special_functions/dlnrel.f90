!** DLNREL
REAL(DP) ELEMENTAL FUNCTION DLNREL(X)
  !> Evaluate ln(1+X) accurate in the sense of relative error.
  !***
  ! **Library:**   SLATEC (FNLIB)
  !***
  ! **Category:**  C4B
  !***
  ! **Type:**      DOUBLE PRECISION (ALNREL-S, DLNREL-D, CLNREL-C)
  !***
  ! **Keywords:**  ELEMENTARY FUNCTIONS, FNLIB, LOGARITHM
  !***
  ! **Author:**  Fullerton, W., (LANL)
  !***
  ! **Description:**
  !
  ! DLNREL(X) calculates the double precision natural logarithm of
  ! (1.0+X) for double precision argument X.  This routine should
  ! be used when X is small and accurate to calculate the logarithm
  ! accurately (in the relative error sense) in the neighborhood
  ! of 1.0.
  !
  ! Series for ALNR       on the interval -3.75000E-01 to  3.75000E-01
  !                                        with weighted error   6.35E-32
  !                                         log weighted error  31.20
  !                               significant figures required  30.93
  !                                    decimal places required  32.01
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
  USE service, ONLY : eps_dp
  !
  REAL(DP), INTENT(IN) :: X
  !
  INTEGER, PARAMETER :: nlnrel = 23
  REAL(DP), PARAMETER :: xmin = -1._DP + SQRT(eps_dp)
  REAL(DP), PARAMETER :: alnrcs(43) = [ +.10378693562743769800686267719098E+1_DP, &
    -.13364301504908918098766041553133E+0_DP, +.19408249135520563357926199374750E-1_DP, &
    -.30107551127535777690376537776592E-2_DP, +.48694614797154850090456366509137E-3_DP, &
    -.81054881893175356066809943008622E-4_DP, +.13778847799559524782938251496059E-4_DP, &
    -.23802210894358970251369992914935E-5_DP, +.41640416213865183476391859901989E-6_DP, &
    -.73595828378075994984266837031998E-7_DP, +.13117611876241674949152294345011E-7_DP, &
    -.23546709317742425136696092330175E-8_DP, +.42522773276034997775638052962567E-9_DP, &
    -.77190894134840796826108107493300E-10_DP, +.14075746481359069909215356472191E-10_DP, &
    -.25769072058024680627537078627584E-11_DP, +.47342406666294421849154395005938E-12_DP, &
    -.87249012674742641745301263292675E-13_DP, +.16124614902740551465739833119115E-13_DP, &
    -.29875652015665773006710792416815E-14_DP, +.55480701209082887983041321697279E-15_DP, &
    -.10324619158271569595141333961932E-15_DP, +.19250239203049851177878503244868E-16_DP, &
    -.35955073465265150011189707844266E-17_DP, +.67264542537876857892194574226773E-18_DP, &
    -.12602624168735219252082425637546E-18_DP, +.23644884408606210044916158955519E-19_DP, &
    -.44419377050807936898878389179733E-20_DP, +.83546594464034259016241293994666E-21_DP, &
    -.15731559416479562574899253521066E-21_DP, +.29653128740247422686154369706666E-22_DP, &
    -.55949583481815947292156013226666E-23_DP, +.10566354268835681048187284138666E-23_DP, &
    -.19972483680670204548314999466666E-24_DP, +.37782977818839361421049855999999E-25_DP, &
    -.71531586889081740345038165333333E-26_DP, +.13552488463674213646502024533333E-26_DP, &
    -.25694673048487567430079829333333E-27_DP, +.48747756066216949076459519999999E-28_DP, &
    -.92542112530849715321132373333333E-29_DP, +.17578597841760239233269760000000E-29_DP, &
    -.33410026677731010351377066666666E-30_DP, +.63533936180236187354180266666666E-31_DP ]
  !* FIRST EXECUTABLE STATEMENT  DLNREL
  ! nlnrel = INITDS(alnrcs,0.1_SP*eps_2_dp)
  !
  IF( X<=(-1._DP) ) THEN
    ERROR STOP 'DLNREL : X IS <= -1'
  ELSEIF( ABS(X)<=0.375_DP ) THEN
    ! IF( X<xmin ) CALL XERMSG('DLNREL','ANSWER LT HALF PRECISION BECAUSE X TOO NEAR -1',1,1)
    DLNREL = X*(1._DP-X*DCSEVL(X/.375_DP,alnrcs(1:nlnrel)))
  ELSE
    DLNREL = LOG(1._DP+X)
  END IF

  RETURN
END FUNCTION DLNREL