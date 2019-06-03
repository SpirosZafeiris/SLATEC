!** DE1
REAL(DP) FUNCTION DE1(X)
  !>
  !  Compute the exponential integral E1(X).
  !***
  ! **Library:**   SLATEC (FNLIB)
  !***
  ! **Category:**  C5
  !***
  ! **Type:**      DOUBLE PRECISION (E1-S, DE1-D)
  !***
  ! **Keywords:**  E1 FUNCTION, EXPONENTIAL INTEGRAL, FNLIB,
  !             SPECIAL FUNCTIONS
  !***
  ! **Author:**  Fullerton, W., (LANL)
  !***
  ! **Description:**
  !
  ! DE1 calculates the double precision exponential integral, E1(X), for
  ! positive double precision argument X and the Cauchy principal value
  ! for negative X.  If principal values are used everywhere, then, for
  ! all X,
  !
  !    E1(X) = -Ei(-X)
  ! or
  !    Ei(X) = -E1(-X).
  !
  !
  ! Series for AE10       on the interval -3.12500E-02 to  0.
  !                                        with weighted error   4.62E-32
  !                                         log weighted error  31.34
  !                               significant figures required  29.70
  !                                    decimal places required  32.18
  !
  !
  ! Series for AE11       on the interval -1.25000E-01 to -3.12500E-02
  !                                        with weighted error   2.22E-32
  !                                         log weighted error  31.65
  !                               significant figures required  30.75
  !                                    decimal places required  32.54
  !
  !
  ! Series for AE12       on the interval -2.50000E-01 to -1.25000E-01
  !                                        with weighted error   5.19E-32
  !                                         log weighted error  31.28
  !                               significant figures required  30.82
  !                                    decimal places required  32.09
  !
  !
  ! Series for E11        on the interval -4.00000E+00 to -1.00000E+00
  !                                        with weighted error   8.49E-34
  !                                         log weighted error  33.07
  !                               significant figures required  34.13
  !                                    decimal places required  33.80
  !
  !
  ! Series for E12        on the interval -1.00000E+00 to  1.00000E+00
  !                                        with weighted error   8.08E-33
  !                                         log weighted error  32.09
  !                        approx significant figures required  30.4
  !                                    decimal places required  32.79
  !
  !
  ! Series for AE13       on the interval  2.50000E-01 to  1.00000E+00
  !                                        with weighted error   6.65E-32
  !                                         log weighted error  31.18
  !                               significant figures required  30.69
  !                                    decimal places required  32.03
  !
  !
  ! Series for AE14       on the interval  0.          to  2.50000E-01
  !                                        with weighted error   5.07E-32
  !                                         log weighted error  31.30
  !                               significant figures required  30.40
  !                                    decimal places required  32.20
  !
  !***
  ! **References:**  (NONE)
  !***
  ! **Routines called:**  D1MACH, DCSEVL, INITDS, XERMSG

  !* REVISION HISTORY  (YYMMDD)
  !   770701  DATE WRITTEN
  !   890531  Changed all specific intrinsics to generic.  (WRB)
  !   891115  Modified prologue description.  (WRB)
  !   891115  REVISION DATE from Version 3.2
  !   891214  Prologue converted to Version 4.0 format.  (BAB)
  !   900315  CALLs to XERROR changed to CALLs to XERMSG.  (THJ)
  !   920618  Removed space from variable names.  (RWC, WRB)
  USE service, ONLY : XERMSG, D1MACH
  REAL(DP) :: X
  INTEGER, SAVE :: ntae10, ntae11, ntae12, nte11, nte12, ntae13, ntae14
  REAL(DP), PARAMETER :: eta = 0.1D0*D1MACH(3), xmaxt = -LOG(D1MACH(1)), &
    xmax = xmaxt - LOG(xmaxt)
  REAL(DP), PARAMETER :: ae10cs(50)  = [ +.3284394579616699087873844201881D-1, &
    -.1669920452031362851476184343387D-1, +.2845284724361346807424899853252D-3, &
    -.7563944358516206489487866938533D-5, +.2798971289450859157504843180879D-6, &
    -.1357901828534531069525563926255D-7, +.8343596202040469255856102904906D-9, &
    -.6370971727640248438275242988532D-10, +.6007247608811861235760831561584D-11, &
    -.7022876174679773590750626150088D-12, +.1018302673703687693096652346883D-12, &
    -.1761812903430880040406309966422D-13, +.3250828614235360694244030353877D-14, &
    -.5071770025505818678824872259044D-15, +.1665177387043294298172486084156D-16, &
    +.3166753890797514400677003536555D-16, -.1588403763664141515133118343538D-16, &
    +.4175513256138018833003034618484D-17, -.2892347749707141906710714478852D-18, &
    -.2800625903396608103506340589669D-18, +.1322938639539270903707580023781D-18, &
    -.1804447444177301627283887833557D-19, -.7905384086522616076291644817604D-20, &
    +.4435711366369570103946235838027D-20, -.4264103994978120868865309206555D-21, &
    -.3920101766937117541553713162048D-21, +.1527378051343994266343752326971D-21, &
    +.1024849527049372339310308783117D-22, -.2134907874771433576262711405882D-22, &
    +.3239139475160028267061694700366D-23, +.2142183762299889954762643168296D-23, &
    -.8234609419601018414700348082312D-24, -.1524652829645809479613694401140D-24, &
    +.1378208282460639134668480364325D-24, +.2131311202833947879523224999253D-26, &
    -.2012649651526484121817466763127D-25, +.1995535662263358016106311782673D-26, &
    +.2798995808984003464948686520319D-26, -.5534511845389626637640819277823D-27, &
    -.3884995396159968861682544026146D-27, +.1121304434507359382850680354679D-27, &
    +.5566568152423740948256563833514D-28, -.2045482929810499700448533938176D-28, &
    -.8453813992712336233411457493674D-29, +.3565758433431291562816111116287D-29, &
    +.1383653872125634705539949098871D-29, -.6062167864451372436584533764778D-30, &
    -.2447198043989313267437655119189D-30, +.1006850640933998348011548180480D-30, &
    +.4623685555014869015664341461674D-31 ]
  REAL(DP), PARAMETER :: ae11cs(60) = [ +.20263150647078889499401236517381D+0, &
    -.73655140991203130439536898728034D-1, +.63909349118361915862753283840020D-2, &
    -.60797252705247911780653153363999D-3, -.73706498620176629330681411493484D-4, &
    +.48732857449450183453464992488076D-4, -.23837064840448290766588489460235D-5, &
    -.30518612628561521027027332246121D-5, +.17050331572564559009688032992907D-6, &
    +.23834204527487747258601598136403D-6, +.10781772556163166562596872364020D-7, &
    -.17955692847399102653642691446599D-7, -.41284072341950457727912394640436D-8, &
    +.68622148588631968618346844526664D-9, +.53130183120506356147602009675961D-9, &
    +.78796880261490694831305022893515D-10, -.26261762329356522290341675271232D-10, &
    -.15483687636308261963125756294100D-10, -.25818962377261390492802405122591D-11, &
    +.59542879191591072658903529959352D-12, +.46451400387681525833784919321405D-12, &
    +.11557855023255861496288006203731D-12, -.10475236870835799012317547189670D-14, &
    -.11896653502709004368104489260929D-13, -.47749077490261778752643019349950D-14, &
    -.81077649615772777976249734754135D-15, +.13435569250031554199376987998178D-15, &
    +.14134530022913106260248873881287D-15, +.49451592573953173115520663232883D-16, &
    +.79884048480080665648858587399367D-17, -.14008632188089809829248711935393D-17, &
    -.14814246958417372107722804001680D-17, -.55826173646025601904010693937113D-18, &
    -.11442074542191647264783072544598D-18, +.25371823879566853500524018479923D-20, &
    +.13205328154805359813278863389097D-19, +.62930261081586809166287426789485D-20, &
    +.17688270424882713734999261332548D-20, +.23266187985146045209674296887432D-21, &
    -.67803060811125233043773831844113D-22, -.59440876959676373802874150531891D-22, &
    -.23618214531184415968532592503466D-22, -.60214499724601478214168478744576D-23, &
    -.65517906474348299071370444144639D-24, +.29388755297497724587042038699349D-24, &
    +.22601606200642115173215728758510D-24, +.89534369245958628745091206873087D-25, &
    +.24015923471098457555772067457706D-25, +.34118376888907172955666423043413D-26, &
    -.71617071694630342052355013345279D-27, -.75620390659281725157928651980799D-27, &
    -.33774612157467324637952920780800D-27, -.10479325703300941711526430332245D-27, &
    -.21654550252170342240854880201386D-28, -.75297125745288269994689298432000D-30, &
    +.19103179392798935768638084000426D-29, +.11492104966530338547790728833706D-29, &
    +.43896970582661751514410359193600D-30, +.12320883239205686471647157725866D-30, &
    +.22220174457553175317538581162666D-31 ]
  REAL(DP), PARAMETER :: ae12cs(41) = [ +.63629589796747038767129887806803D+0, &
    -.13081168675067634385812671121135D+0, -.84367410213053930014487662129752D-2, &
    +.26568491531006685413029428068906D-2, +.32822721781658133778792170142517D-3, &
    -.23783447771430248269579807851050D-4, -.11439804308100055514447076797047D-4, &
    -.14405943433238338455239717699323D-5, +.52415956651148829963772818061664D-8, &
    +.38407306407844323480979203059716D-7, +.85880244860267195879660515759344D-8, &
    +.10219226625855003286339969553911D-8, +.21749132323289724542821339805992D-10, &
    -.22090238142623144809523503811741D-10, -.63457533544928753294383622208801D-11, &
    -.10837746566857661115340539732919D-11, -.11909822872222586730262200440277D-12, &
    -.28438682389265590299508766008661D-14, +.25080327026686769668587195487546D-14, &
    +.78729641528559842431597726421265D-15, +.15475066347785217148484334637329D-15, &
    +.22575322831665075055272608197290D-16, +.22233352867266608760281380836693D-17, &
    +.16967819563544153513464194662399D-19, -.57608316255947682105310087304533D-19, &
    -.17591235774646878055625369408853D-19, -.36286056375103174394755328682666D-20, &
    -.59235569797328991652558143488000D-21, -.76030380926310191114429136895999D-22, &
    -.62547843521711763842641428479999D-23, +.25483360759307648606037606400000D-24, &
    +.25598615731739857020168874666666D-24, +.71376239357899318800207052800000D-25, &
    +.14703759939567568181578956800000D-25, +.25105524765386733555198634666666D-26, &
    +.35886666387790890886583637333333D-27, +.39886035156771301763317759999999D-28, &
    +.21763676947356220478805333333333D-29, -.46146998487618942367607466666666D-30, &
    -.20713517877481987707153066666666D-30, -.51890378563534371596970666666666D-31 ]
  REAL(DP), PARAMETER :: e11cs(29) = [ -.16113461655571494025720663927566180D+2, &
    +.77940727787426802769272245891741497D+1, -.19554058188631419507127283812814491D+1, &
    +.37337293866277945611517190865690209D+0, -.56925031910929019385263892220051166D-1, &
    +.72110777696600918537847724812635813D-2, -.78104901449841593997715184089064148D-3, &
    +.73880933562621681878974881366177858D-4, -.62028618758082045134358133607909712D-5, &
    +.46816002303176735524405823868362657D-6, -.32092888533298649524072553027228719D-7, &
    +.20151997487404533394826262213019548D-8, -.11673686816697793105356271695015419D-9, &
    +.62762706672039943397788748379615573D-11, -.31481541672275441045246781802393600D-12, &
    +.14799041744493474210894472251733333D-13, -.65457091583979673774263401588053333D-15, &
    +.27336872223137291142508012748799999D-16, -.10813524349754406876721727624533333D-17, &
    +.40628328040434303295300348586666666D-19, -.14535539358960455858914372266666666D-20, &
    +.49632746181648636830198442666666666D-22, -.16208612696636044604866560000000000D-23, &
    +.50721448038607422226431999999999999D-25, -.15235811133372207813973333333333333D-26, &
    +.44001511256103618696533333333333333D-28, -.12236141945416231594666666666666666D-29, &
    +.32809216661066001066666666666666666D-31, -.84933452268306432000000000000000000D-33 ]
  REAL(DP), PARAMETER :: e12cs(25) = [ -.3739021479220279511668698204827D-1, &
    +.4272398606220957726049179176528D-1, -.130318207984970054415392055219726D+0, &
    +.144191240246988907341095893982137D-1, -.134617078051068022116121527983553D-2, &
    +.107310292530637799976115850970073D-3, -.742999951611943649610283062223163D-5, &
    +.453773256907537139386383211511827D-6, -.247641721139060131846547423802912D-7, &
    +.122076581374590953700228167846102D-8, -.548514148064092393821357398028261D-10, &
    +.226362142130078799293688162377002D-11, -.863589727169800979404172916282240D-13, &
    +.306291553669332997581032894881279D-14, -.101485718855944147557128906734933D-15, &
    +.315482174034069877546855328426666D-17, -.923604240769240954484015923200000D-19, &
    +.255504267970814002440435029333333D-20, -.669912805684566847217882453333333D-22, &
    +.166925405435387319431987199999999D-23, -.396254925184379641856000000000000D-25, &
    +.898135896598511332010666666666666D-27, -.194763366993016433322666666666666D-28, &
    +.404836019024630033066666666666666D-30, -.807981567699845120000000000000000D-32 ]
  REAL(DP), PARAMETER :: ae13cs(50) = [ -.60577324664060345999319382737747D+0, &
    -.11253524348366090030649768852718D+0, +.13432266247902779492487859329414D-1, &
    -.19268451873811457249246838991303D-2, +.30911833772060318335586737475368D-3, &
    -.53564132129618418776393559795147D-4, +.98278128802474923952491882717237D-5, &
    -.18853689849165182826902891938910D-5, +.37494319356894735406964042190531D-6, &
    -.76823455870552639273733465680556D-7, +.16143270567198777552956300060868D-7, &
    -.34668022114907354566309060226027D-8, +.75875420919036277572889747054114D-9, &
    -.16886433329881412573514526636703D-9, +.38145706749552265682804250927272D-10, &
    -.87330266324446292706851718272334D-11, +.20236728645867960961794311064330D-11, &
    -.47413283039555834655210340820160D-12, +.11221172048389864324731799928920D-12, &
    -.26804225434840309912826809093395D-13, +.64578514417716530343580369067212D-14, &
    -.15682760501666478830305702849194D-14, +.38367865399315404861821516441408D-15, &
    -.94517173027579130478871048932556D-16, +.23434812288949573293896666439133D-16, &
    -.58458661580214714576123194419882D-17, +.14666229867947778605873617419195D-17, &
    -.36993923476444472706592538274474D-18, +.93790159936721242136014291817813D-19, &
    -.23893673221937873136308224087381D-19, +.61150624629497608051934223837866D-20, &
    -.15718585327554025507719853288106D-20, +.40572387285585397769519294491306D-21, &
    -.10514026554738034990566367122773D-21, +.27349664930638667785806003131733D-22, &
    -.71401604080205796099355574271999D-23, +.18705552432235079986756924211199D-23, &
    -.49167468166870480520478020949333D-24, +.12964988119684031730916087125333D-24, &
    -.34292515688362864461623940437333D-25, +.90972241643887034329104820906666D-26, &
    -.24202112314316856489934847999999D-26, +.64563612934639510757670475093333D-27, &
    -.17269132735340541122315987626666D-27, +.46308611659151500715194231466666D-28, &
    -.12448703637214131241755170133333D-28, +.33544574090520678532907007999999D-29, &
    -.90598868521070774437543935999999D-30, +.24524147051474238587273216000000D-30, &
    -.66528178733552062817107967999999D-31 ]
  REAL(DP), PARAMETER :: ae14cs(64) = [ -.1892918000753016825495679942820D+0, &
    -.8648117855259871489968817056824D-1, +.7224101543746594747021514839184D-2, &
    -.8097559457557386197159655610181D-3, +.1099913443266138867179251157002D-3, &
    -.1717332998937767371495358814487D-4, +.2985627514479283322825342495003D-5, &
    -.5659649145771930056560167267155D-6, +.1152680839714140019226583501663D-6, &
    -.2495030440269338228842128765065D-7, +.5692324201833754367039370368140D-8, &
    -.1359957664805600338490030939176D-8, +.3384662888760884590184512925859D-9, &
    -.8737853904474681952350849316580D-10, +.2331588663222659718612613400470D-10, &
    -.6411481049213785969753165196326D-11, +.1812246980204816433384359484682D-11, &
    -.5253831761558460688819403840466D-12, +.1559218272591925698855028609825D-12, &
    -.4729168297080398718476429369466D-13, +.1463761864393243502076199493808D-13, &
    -.4617388988712924102232173623604D-14, +.1482710348289369323789239660371D-14, &
    -.4841672496239229146973165734417D-15, +.1606215575700290408116571966188D-15, &
    -.5408917538957170947895023784252D-16, +.1847470159346897881370231402310D-16, &
    -.6395830792759094470500610425050D-17, +.2242780721699759457250233276170D-17, &
    -.7961369173983947552744555308646D-18, +.2859308111540197459808619929272D-18, &
    -.1038450244701137145900697137446D-18, +.3812040607097975780866841008319D-19, &
    -.1413795417717200768717562723696D-19, +.5295367865182740958305442594815D-20, &
    -.2002264245026825902137211131439D-20, +.7640262751275196014736848610918D-21, &
    -.2941119006868787883311263523362D-21, +.1141823539078927193037691483586D-21, &
    -.4469308475955298425247020718489D-22, +.1763262410571750770630491408520D-22, &
    -.7009968187925902356351518262340D-23, +.2807573556558378922287757507515D-23, &
    -.1132560944981086432141888891562D-23, +.4600574684375017946156764233727D-24, &
    -.1881448598976133459864609148108D-24, +.7744916111507730845444328478037D-25, &
    -.3208512760585368926702703826261D-25, +.1337445542910839760619930421384D-25, &
    -.5608671881802217048894771735210D-26, +.2365839716528537483710069473279D-26, &
    -.1003656195025305334065834526856D-26, +.4281490878094161131286642556927D-27, &
    -.1836345261815318199691326958250D-27, +.7917798231349540000097468678144D-28, &
    -.3431542358742220361025015775231D-28, +.1494705493897103237475066008917D-28, &
    -.6542620279865705439739042420053D-29, +.2877581395199171114340487353685D-29, &
    -.1271557211796024711027981200042D-29, +.5644615555648722522388044622506D-30, &
    -.2516994994284095106080616830293D-30, +.1127259818927510206370368804181D-30, &
    -.5069814875800460855562584719360D-31 ]
  LOGICAL, SAVE :: first = .TRUE.
  !* FIRST EXECUTABLE STATEMENT  DE1
  IF ( first ) THEN
    ntae10 = INITDS(ae10cs,50,eta)
    ntae11 = INITDS(ae11cs,60,eta)
    ntae12 = INITDS(ae12cs,41,eta)
    nte11 = INITDS(e11cs,29,eta)
    nte12 = INITDS(e12cs,25,eta)
    ntae13 = INITDS(ae13cs,50,eta)
    ntae14 = INITDS(ae14cs,64,eta)
    first = .FALSE.
  END IF
  !
  IF ( X>(-1.D0) ) THEN
    !
    IF ( X<=1.0D0 ) THEN
      IF ( X==0.D0 ) CALL XERMSG('DE1','X IS 0',2,2)
      DE1 = (-LOG(ABS(X))-0.6875D0+X) + DCSEVL(X,e12cs,nte12)
      RETURN
      !
    ELSEIF ( X<=4.0D0 ) THEN
      DE1 = EXP(-X)/X*(1.D0+DCSEVL((8.D0/X-5.D0)/3.D0,ae13cs,ntae13))
      RETURN
      !
    ELSEIF ( X>xmax ) THEN
      !
      CALL XERMSG('DE1','X SO BIG E1 UNDERFLOWS',1,1)
      DE1 = 0.D0
      RETURN
    END IF
  ELSEIF ( X>(-32.D0) ) THEN
    !
    IF ( X<=(-8.D0) ) THEN
      DE1 = EXP(-X)/X*(1.D0+DCSEVL((64.D0/X+5.D0)/3.D0,ae11cs,ntae11))
      RETURN
      !
    ELSEIF ( X>(-4.D0) ) THEN
      !
      DE1 = -LOG(-X) + DCSEVL((2.D0*X+5.D0)/3.D0,e11cs,nte11)
      RETURN
    ELSE
      DE1 = EXP(-X)/X*(1.D0+DCSEVL(16.D0/X+3.D0,ae12cs,ntae12))
      RETURN
    END IF
  ELSE
    DE1 = EXP(-X)/X*(1.D0+DCSEVL(64.D0/X+1.D0,ae10cs,ntae10))
    RETURN
  END IF
  DE1 = EXP(-X)/X*(1.D0+DCSEVL(8.D0/X-1.D0,ae14cs,ntae14))
  RETURN
END FUNCTION DE1
