!** DBIE
REAL(8) FUNCTION DBIE(X)
  !>
  !***
  !  Calculate the Bairy function for a negative argument and an
  !            exponentially scaled Bairy function for a non-negative
  !            argument.
  !***
  ! **Library:**   SLATEC (FNLIB)
  !***
  ! **Category:**  C10D
  !***
  ! **Type:**      DOUBLE PRECISION (BIE-S, DBIE-D)
  !***
  ! **Keywords:**  BAIRY FUNCTION, EXPONENTIALLY SCALED, FNLIB,
  !             SPECIAL FUNCTIONS
  !***
  ! **Author:**  Fullerton, W., (LANL)
  !***
  ! **Description:**
  !
  ! DBIE(X) calculates the double precision Airy function of the
  ! second kind or the double precision exponentially scaled Airy
  ! function of the second kind, depending on the value of the
  ! double precision argument X.
  !
  ! Evaluate BI(X) for X .LE. 0.0  and  BI(X)*EXP(-ZETA)  where
  ! ZETA = 2/3 * X**(3/2)  for X .GE. 0.0
  !
  !
  ! Series for BIF        on the interval -1.00000E+00 to  1.00000E+00
  !                                        with weighted error   1.45E-32
  !                                         log weighted error  31.84
  !                               significant figures required  30.85
  !                                    decimal places required  32.40
  !
  !
  ! Series for BIG        on the interval -1.00000E+00 to  1.00000E+00
  !                                        with weighted error   1.29E-33
  !                                         log weighted error  32.89
  !                               significant figures required  31.48
  !                                    decimal places required  33.45
  !
  !
  ! Series for BIF2       on the interval  1.00000E+00 to  8.00000E+00
  !                                        with weighted error   6.08E-32
  !                                         log weighted error  31.22
  !                        approx significant figures required  30.8
  !                                    decimal places required  31.80
  !
  !
  ! Series for BIG2       on the interval  1.00000E+00 to  8.00000E+00
  !                                        with weighted error   4.91E-33
  !                                         log weighted error  32.31
  !                        approx significant figures required  31.6
  !                                    decimal places required  32.90
  !
  !
  ! Series for BIP1       on the interval  1.25000E-01 to  3.53553E-01
  !                                        with weighted error   1.06E-32
  !                                         log weighted error  31.98
  !                               significant figures required  30.61
  !                                    decimal places required  32.81
  !
  !
  ! Series for BIP2       on the interval  0.          to  1.25000E-01
  !                                        with weighted error   4.04E-33
  !                                         log weighted error  32.39
  !                               significant figures required  31.15
  !                                    decimal places required  33.37
  !
  !***
  ! **References:**  (NONE)
  !***
  ! **Routines called:**  D1MACH, D9AIMP, DCSEVL, INITDS

  !* REVISION HISTORY  (YYMMDD)
  !   770701  DATE WRITTEN
  !   890531  Changed all specific intrinsics to generic.  (WRB)
  !   890531  REVISION DATE from Version 3.2
  !   891214  Prologue converted to Version 4.0 format.  (BAB)
  USE service, ONLY : D1MACH
  REAL eta
  REAL(8) :: X, sqrtx, theta, xm, z
  INTEGER, SAVE :: nbif, nbig, nbif2, nbig2, nbip1, nbip2
  REAL(8), SAVE :: x3sml, x32sml, xbig
  REAL(8), PARAMETER :: bifcs(13) = [ -.16730216471986649483537423928176D-1, &
    +.10252335834249445611426362777757D+0, +.17083092507381516539429650242013D-2, &
    +.11862545467744681179216459210040D-4, +.44932907017792133694531887927242D-7, &
    +.10698207143387889067567767663628D-9, +.17480643399771824706010517628573D-12, &
    +.20810231071761711025881891834399D-15, +.18849814695665416509927971733333D-18, &
    +.13425779173097804625882666666666D-21, +.77159593429658887893333333333333D-25, &
    +.36533879617478566399999999999999D-28, +.14497565927953066666666666666666D-31 ]
  REAL(8), PARAMETER :: bigcs(13) = [ +.22466223248574522283468220139024D-1, &
    +.37364775453019545441727561666752D-1, +.44476218957212285696215294326639D-3, &
    +.24708075636329384245494591948882D-5, +.79191353395149635134862426285596D-8, &
    +.16498079851827779880887872402706D-10, +.24119906664835455909247501122841D-13, &
    +.26103736236091436985184781269333D-16, +.21753082977160323853123792000000D-19, &
    +.14386946400390433219483733333333D-22, +.77349125612083468629333333333333D-26, &
    +.34469292033849002666666666666666D-29, +.12938919273216000000000000000000D-32 ]
  REAL(8), PARAMETER :: bif2cs(15) = [ +.0998457269381604104468284257993D+0, &
    +.47862497786300553772211467318231D+0, +.25155211960433011771324415436675D-1, &
    +.58206938852326456396515697872216D-3, +.74997659644377865943861457378217D-5, &
    +.61346028703493836681403010356474D-7, +.34627538851480632900434268733359D-9, &
    +.14288910080270254287770846748931D-11, +.44962704298334641895056472179200D-14, &
    +.11142323065833011708428300106666D-16, +.22304791066175002081517866666666D-19, &
    +.36815778736393142842922666666666D-22, +.50960868449338261333333333333333D-25, &
    +.60003386926288554666666666666666D-28, +.60827497446570666666666666666666D-31 ]
  REAL(8), PARAMETER :: big2cs(15) = [ +.033305662145514340465176188111647D+0, &
    +.161309215123197067613287532084943D+0, +.631900730961342869121615634921173D-2, &
    +.118790456816251736389780192304567D-3, +.130453458862002656147116485012843D-5, &
    +.937412599553521729546809615508936D-8, +.474580188674725153788510169834595D-10, &
    +.178310726509481399800065667560946D-12, +.516759192784958180374276356640000D-15, &
    +.119004508386827125129496251733333D-17, +.222982880666403517277063466666666D-20, &
    +.346551923027689419722666666666666D-23, +.453926336320504514133333333333333D-26, &
    +.507884996513522346666666666666666D-29, +.491020674696533333333333333333333D-32 ]
  REAL(8), PARAMETER :: bip1cs(47) = [ -.83220474779434474687471864707973D-1, &
    +.11461189273711742889920226128031D-1, +.42896440718911509494134472566635D-3, &
    -.14906639379950514017847677732954D-3, -.13076597267876290663136340998881D-4, &
    +.63275983961030344754535716032494D-5, -.42226696982681924884778515889433D-6, &
    -.19147186298654689632835494181277D-6, +.64531062845583173611038157880934D-7, &
    -.78448546771397719289748310448628D-8, -.96077216623785085879198533565432D-9, &
    +.70004713316443966339006074402068D-9, -.17731789132814932022083128056698D-9, &
    +.22720894783465236347282126389311D-10, +.16540456313972049847032860681891D-11, &
    -.18517125559292316390755369896693D-11, +.59576312477117290165680715534277D-12, &
    -.12194348147346564781055769498986D-12, +.13347869253513048815386347813597D-13, &
    +.17278311524339746664384792889731D-14, -.14590732013016720735268871713166D-14, &
    +.49010319927115819978994989520104D-15, -.11556545519261548129262972762521D-15, &
    +.19098807367072411430671732441524D-16, -.11768966854492179886913995957862D-17, &
    -.63271925149530064474537459677047D-18, +.33861838880715361614130191322316D-18, &
    -.10725825321758625254992162219622D-18, +.25995709605617169284786933115562D-19, &
    -.48477583571081193660962309494101D-20, +.55298913982121625361505513198933D-21, &
    +.49421660826069471371748197444266D-22, -.55162121924145707458069720814933D-22, &
    +.21437560417632550086631884499626D-22, -.61910313387655605798785061137066D-23, &
    +.14629362707391245659830967336959D-23, -.27918484471059005576177866069333D-24, &
    +.36455703168570246150906795349333D-25, +.58511821906188711839382459733333D-27, &
    -.24946950487566510969745047551999D-26, +.10979323980338380977919579477333D-26, &
    -.34743388345961115015034088106666D-27, +.91373402635349697363171082240000D-28, &
    -.20510352728210629186247720959999D-28, +.37976985698546461748651622399999D-29, &
    -.48479458497755565887848448000000D-30, -.10558306941230714314205866666666D-31 ]
  REAL(8), PARAMETER :: bip2cs(88) = [ -.11359673758598867913797310895527D+0, &
    +.41381473947881595760052081171444D-2, +.13534706221193329857696921727508D-3, &
    +.10427316653015353405887183456780D-4, +.13474954767849907889589911958925D-5, &
    +.16965374054383983356062511163756D-6, -.10096500865641624301366228396373D-7, &
    -.16729119493778475127836973095943D-7, -.45815364485068383217152795613391D-8, &
    +.37366813665655477274064749384284D-9, +.57669303201452448119584643502111D-9, &
    +.62181265087850324095393408792371D-10, -.63294120282743068241589177281354D-10, &
    -.14915047908598767633999091989487D-10, +.78896213942486771938172394294891D-11, &
    +.24960513721857797984888064000127D-11, -.12130075287291659477746664734814D-11, &
    -.37404939108727277887343460402716D-12, +.22377278140321476798783446931091D-12, &
    +.47490296312192466341986077472514D-13, -.45261607991821224810605655831294D-13, &
    -.30172271841986072645112245876020D-14, +.91058603558754058327592683478908D-14, &
    -.98149238033807062926643864207709D-15, -.16429400647889465253601245251589D-14, &
    +.55334834214274215451182114635164D-15, +.21750479864482655984374381998156D-15, &
    -.17379236200220656971287029558087D-15, -.10470023471443714959283909313604D-17, &
    +.39219145986056386925441403311462D-16, -.11621293686345196925824005665910D-16, &
    -.54027474491754245533735411307773D-17, +.45441582123884610882675428553304D-17, &
    -.28775599625221075729427585480086D-18, -.10017340927225341243596162960440D-17, &
    +.44823931215068369856332561906313D-18, +.76135968654908942328948982366775D-19, &
    -.14448324094881347238956060145422D-18, +.40460859449205362251624847392112D-19, &
    +.20321085700338446891325190707277D-19, -.19602795471446798718272758041962D-19, &
    +.34273038443944824263518958211738D-20, +.37023705853905135480024651593154D-20, &
    -.26879595172041591131400332966712D-20, +.28121678463531712209714454683364D-21, &
    +.60933963636177797173271119680329D-21, -.38666621897150844994172977893413D-21, &
    +.25989331253566943450895651927228D-22, +.97194393622938503767281175216084D-22, &
    -.59392817834375098415630478204591D-22, +.38864949977113015409591960439444D-23, &
    +.15334307393617272869721512868769D-22, -.97513555209762624036336521409724D-23, &
    +.96340644440489471424741339383726D-24, +.23841999400208880109946748792454D-23, &
    -.16896986315019706184848044205207D-23, +.27352715888928361222578444801478D-24, &
    +.35660016185409578960111685025730D-24, -.30234026608258827249534280666954D-24, &
    +.75002041605973930653144204823232D-25, +.48403287575851388827455319838748D-25, &
    -.54364137654447888432698010297766D-25, +.19281214470820962653345978809756D-25, &
    +.50116355020532656659611814172172D-26, -.95040744582693253786034620869972D-26, &
    +.46372646157101975948696332245611D-26, +.21177170704466954163768170577046D-28, &
    -.15404850268168594303692204548726D-26, +.10387944293201213662047889194441D-26, &
    -.19890078156915416751316728235153D-27, -.21022173878658495471177044522532D-27, &
    +.21353099724525793150633356670491D-27, -.79040810747961342319023537632627D-28, &
    -.16575359960435585049973741763592D-28, +.38868342850124112587625586496537D-28, &
    -.22309237330896866182621562424717D-28, +.27777244420176260265625977404382D-29, &
    +.57078543472657725368712433782772D-29, -.51743084445303852800173371555280D-29, &
    +.18413280751095837198450927071569D-29, +.44422562390957094598544071068647D-30, &
    -.98504142639629801547464958226943D-30, +.58857201353585104884754198881995D-30, &
    -.97636075440429787961402312628595D-31, -.13581011996074695047063597884122D-30, &
    +.13999743518492413270568048380345D-30, -.59754904545248477620884562981118D-31, &
    -.40391653875428313641045327529856D-32 ]
  REAL(8), PARAMETER :: atr = 8.75069057084843450880771988210148D0
  REAL(8), PARAMETER :: btr = -2.09383632135605431360096498526268D0
  LOGICAL :: first = .TRUE.
  !* FIRST EXECUTABLE STATEMENT  DBIE
  IF ( first ) THEN
    eta = 0.1*REAL(D1MACH(3))
    nbif = INITDS(bifcs,13,eta)
    nbig = INITDS(bigcs,13,eta)
    nbif2 = INITDS(bif2cs,15,eta)
    nbig2 = INITDS(big2cs,15,eta)
    nbip1 = INITDS(bip1cs,47,eta)
    nbip2 = INITDS(bip2cs,88,eta)
    !
    x3sml = eta**0.3333
    x32sml = 1.3104D0*x3sml**2
    xbig = D1MACH(2)**0.6666D0
    first = .FALSE.
  END IF
  !
  IF ( X<(-1.0D0) ) THEN
    CALL D9AIMP(X,xm,theta)
    DBIE = xm*SIN(theta)
    RETURN
    !
  ELSEIF ( X<=1.0D0 ) THEN
    z = 0.D0
    IF ( ABS(X)>x3sml ) z = X**3
    DBIE = 0.625D0 + DCSEVL(z,bifcs,nbif)&
      + X*(0.4375D0+DCSEVL(z,bigcs,nbig))
    IF ( X>x32sml ) DBIE = DBIE*EXP(-2.0D0*X*SQRT(X)/3.0D0)
    RETURN
    !
  ELSEIF ( X<=2.0D0 ) THEN
    z = (2.0D0*X**3-9.0D0)/7.0D0
    DBIE = EXP(-2.0D0*X*SQRT(X)/3.0D0)&
      *(1.125D0+DCSEVL(z,bif2cs,nbif2)+X*(0.625D0+DCSEVL(z,big2cs,nbig2)))
    RETURN
    !
  ELSEIF ( X>4.0D0 ) THEN
    !
    sqrtx = SQRT(X)
    z = -1.0D0
    IF ( X<xbig ) z = 16.D0/(X*sqrtx) - 1.0D0
    DBIE = (0.625D0+DCSEVL(z,bip2cs,nbip2))/SQRT(sqrtx)
    RETURN
  END IF
  sqrtx = SQRT(X)
  z = atr/(X*sqrtx) + btr
  DBIE = (0.625D0+DCSEVL(z,bip1cs,nbip1))/SQRT(sqrtx)
  RETURN
END FUNCTION DBIE
