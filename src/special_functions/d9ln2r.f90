!** D9LN2R
REAL(DP) ELEMENTAL FUNCTION D9LN2R(X)
  !> Evaluate LOG(1+X) from second order relative accuracy so that
  !            LOG(1+X) = X - X**2/2 + X**3*D9LN2R(X)
  !***
  ! **Library:**   SLATEC (FNLIB)
  !***
  ! **Category:**  C4B
  !***
  ! **Type:**      DOUBLE PRECISION (R9LN2R-S, D9LN2R-D, C9LN2R-C)
  !***
  ! **Keywords:**  ELEMENTARY FUNCTIONS, FNLIB, LOGARITHM, SECOND ORDER
  !***
  ! **Author:**  Fullerton, W., (LANL)
  !***
  ! **Description:**
  !
  ! Evaluate  LOG(1+X)  from 2-nd order with relative error accuracy so
  ! that    LOG(1+X) = X - X**2/2 + X**3*D9LN2R(X)
  !
  ! Series for LN21       on the interval -6.25000E-01 to  0.
  !                                        with weighted error   1.82E-32
  !                                         log weighted error  31.74
  !                               significant figures required  31.00
  !                                    decimal places required  32.59
  !
  ! Series for LN22       on the interval  0.          to  8.12500E-01
  !                                        with weighted error   6.10E-32
  !                                         log weighted error  31.21
  !                               significant figures required  30.32
  !                                    decimal places required  32.00
  !
  !***
  ! **References:**  (NONE)
  !***
  ! **Routines called:**  D1MACH, DCSEVL, INITDS, XERMSG

  !* REVISION HISTORY  (YYMMDD)
  !   780401  DATE WRITTEN
  !   890531  Changed all specific intrinsics to generic.  (WRB)
  !   890911  Removed unnecessary intrinsics.  (WRB)
  !   890911  REVISION DATE from Version 3.2
  !   891214  Prologue converted to Version 4.0 format.  (BAB)
  !   900315  CALLs to XERROR changed to CALLs to XERMSG.  (THJ)
  !   900720  Routine changed from user-callable to subsidiary.  (WRB)
  USE service, ONLY : eps_2_dp, eps_dp
  !
  REAL(DP), INTENT(IN) :: X
  !
  INTEGER, PARAMETER :: ntln21 = 26, ntln22 = 20
  REAL(DP), PARAMETER :: eps = eps_2_dp, sqeps = SQRT(eps), txmax = 8._SP/sqeps, &
    txbig = 6._SP/SQRT(sqeps), xmin = -1._DP + SQRT(eps_dp), &
    xmax = txmax - (eps*txmax**2-2._DP*LOG(txmax))/(2._DP*eps*txmax), &
    xbig = txbig - (sqeps*txbig**2-2._DP*LOG(txbig))/(2._DP*sqeps*txbig)
  REAL(DP), PARAMETER :: ln21cs(50) = [ +.18111962513478809875894953043071E+0_DP, &
    -.15627123192872462669625155541078E+0_DP, +.28676305361557275209540627102051E-1_DP, &
    -.55586996559481398781157725126781E-2_DP, +.11178976652299837657335666279727E-2_DP, &
    -.23080508982327947182299279585705E-3_DP, +.48598853341100175874681558068750E-4_DP, &
    -.10390127388903210765514242633338E-4_DP, +.22484563707390128494621804946408E-5_DP, &
    -.49140592739266484875327802597091E-6_DP, +.10828256507077483336620152971597E-6_DP, &
    -.24025872763420701435976675416719E-7_DP, +.53624600472708133762984443250163E-8_DP, &
    -.12029951362138772264671646424377E-8_DP, +.27107889277591860785622551632266E-9_DP, &
    -.61323562618319010068796728430690E-10_DP, +.13920858369159469857436908543978E-10_DP, &
    -.31699300330223494015283057260883E-11_DP, +.72383754044307505335214326197011E-12_DP, &
    -.16570017184764411391498805506268E-12_DP, +.38018428663117424257364422631876E-13_DP, &
    -.87411189296972700259724429899137E-14_DP, +.20135619845055748302118751028154E-14_DP, &
    -.46464456409033907031102008154477E-15_DP, +.10739282147018339453453338554925E-15_DP, &
    -.24858534619937794755534021833960E-16_DP, +.57620197950800189813888142628181E-17_DP, &
    -.13373063769804394701402199958050E-17_DP, +.31074653227331824966533807166805E-18_DP, &
    -.72288104083040539906901957917627E-19_DP, +.16833783788037385103313258186888E-19_DP, &
    -.39239463312069958052519372739925E-20_DP, +.91551468387536789746385528640853E-21_DP, &
    -.21378895321320159520982095801002E-21_DP, +.49964507479047864699828564568746E-22_DP, &
    -.11686240636080170135360806147413E-22_DP, +.27353123470391863775628686786559E-23_DP, &
    -.64068025084792111965050345881599E-24_DP, +.15016293204334124162949071940266E-24_DP, &
    -.35217372410398479759497145002666E-25_DP, +.82643901014814767012482733397333E-26_DP, &
    -.19404930275943401918036617898666E-26_DP, +.45587880018841283562451588437333E-27_DP, &
    -.10715492087545202154378625023999E-27_DP, +.25199408007927592978096674133333E-28_DP, &
    -.59289088400120969341750476800000E-29_DP, +.13955864061057513058237153279999E-29_DP, &
    -.32864578813478583431436697599999E-30_DP, +.77424967950478166247254698666666E-31_DP, &
    -.18247735667260887638125226666666E-31_DP ]
  REAL(DP), PARAMETER :: ln22cs(37) = [ -.2224253253502046082986015223552E+0_DP, &
    -.6104710010807862398680104755764E-1_DP, +.7427235009750394590519629755729E-2_DP, &
    -.9335018261636970565612779606397E-3_DP, +.1200499076872601283350731287359E-3_DP, &
    -.1570472295282004112823352608243E-4_DP, +.2081874781051271096050783592759E-5_DP, &
    -.2789195577646713654057213051375E-6_DP, +.3769355823760132058422895135447E-7_DP, &
    -.5130902896527711258240589938003E-8_DP, +.7027141178150694738206218215392E-9_DP, &
    -.9674859550134342389243972005137E-10_DP, +.1338104645924887306588496449748E-10_DP, &
    -.1858102603534063981628453846591E-11_DP, +.2589294422527919749308600123070E-12_DP, &
    -.3619568316141588674466025382172E-13_DP, +.5074037398016623088006858917396E-14_DP, &
    -.7131012977031127302700938748927E-15_DP, +.1004490328554567481853386784126E-15_DP, &
    -.1417906532184025791904405075285E-16_DP, +.2005297034743326117891086396074E-17_DP, &
    -.2840996662339803305365396717567E-18_DP, +.4031469883969079899599878662826E-19_DP, &
    -.5729325241832207320455498956799E-20_DP, +.8153488253890010675848928733866E-21_DP, &
    -.1161825588549721787606027468799E-21_DP, +.1657516611662538343659339775999E-22_DP, &
    -.2367336704710805190114017280000E-23_DP, +.3384670367975521386076569599999E-24_DP, &
    -.4843940829215718204296396799999E-25_DP, +.6938759162514273718676138666666E-26_DP, &
    -.9948142607031436571923797333333E-27_DP, +.1427440611211698610634752000000E-27_DP, &
    -.2049794721898234911566506666666E-28_DP, +.2945648756401362222885546666666E-29_DP, &
    -.4235973185184957027669333333333E-30_DP, +.6095532614003832040106666666666E-31_DP ]
  !* FIRST EXECUTABLE STATEMENT  D9LN2R
  ! ntln21 = INITDS(ln21cs,0.1_SP*eps)
  ! ntln22 = INITDS(ln22cs,0.1_SP*eps)
  !
  IF( X>xmax ) THEN
    ERROR STOP 'D9LN2R : NO PRECISION IN ANSWER BECAUSE X IS TOO BIG'
  ELSEIF( X<(-.625_DP) .OR. X>0.8125_DP ) THEN
    ! IF( X<xmin ) 'D9LN2R','ANSWER LT HALF PRECISION BECAUSE X IS TOO NEAR -1'
    ! IF( X>xbig ) CALL XERMSG('D9LN2R','ANSWER LT HALF PRECISION BECAUSE X IS TOO BIG',2,1)
    D9LN2R = (LOG(1._DP+X)-X*(1._DP-0.5_DP*X))/X**3
  ELSEIF( X<0._DP ) THEN
    D9LN2R = 0.375_DP + DCSEVL(16._DP*X/5._DP+1._DP,ln21cs(1:ntln21))
  ELSE
    D9LN2R = 0.375_DP + DCSEVL(32._DP*X/13._DP-1._DP,ln22cs(1:ntln22))
  END IF

  RETURN
END FUNCTION D9LN2R