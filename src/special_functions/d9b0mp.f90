!DECK D9B0MP
SUBROUTINE D9B0MP(X,Ampl,Theta)
  IMPLICIT NONE
  !***BEGIN PROLOGUE  D9B0MP
  !***SUBSIDIARY
  !***PURPOSE  Evaluate the modulus and phase for the J0 and Y0 Bessel
  !            functions.
  !***LIBRARY   SLATEC (FNLIB)
  !***CATEGORY  C10A1
  !***TYPE      DOUBLE PRECISION (D9B0MP-D)
  !***KEYWORDS  BESSEL FUNCTION, FNLIB, MODULUS, PHASE, SPECIAL FUNCTIONS
  !***AUTHOR  Fullerton, W., (LANL)
  !***DESCRIPTION
  !
  ! Evaluate the modulus and phase for the Bessel J0 and Y0 functions.
  !
  ! Series for BM0        on the interval  1.56250E-02 to  6.25000E-02
  !                                        with weighted error   4.40E-32
  !                                         log weighted error  31.36
  !                               significant figures required  30.02
  !                                    decimal places required  32.14
  !
  ! Series for BTH0       on the interval  0.          to  1.56250E-02
  !                                        with weighted error   2.66E-32
  !                                         log weighted error  31.57
  !                               significant figures required  30.67
  !                                    decimal places required  32.40
  !
  ! Series for BM02       on the interval  0.          to  1.56250E-02
  !                                        with weighted error   4.72E-32
  !                                         log weighted error  31.33
  !                               significant figures required  30.00
  !                                    decimal places required  32.13
  !
  ! Series for BT02       on the interval  1.56250E-02 to  6.25000E-02
  !                                        with weighted error   2.99E-32
  !                                         log weighted error  31.52
  !                               significant figures required  30.61
  !                                    decimal places required  32.32
  !
  !***REFERENCES  (NONE)
  !***ROUTINES CALLED  D1MACH, DCSEVL, INITDS, XERMSG
  !***REVISION HISTORY  (YYMMDD)
  !   770701  DATE WRITTEN
  !   890531  Changed all specific intrinsics to generic.  (WRB)
  !   890531  REVISION DATE from Version 3.2
  !   891214  Prologue converted to Version 4.0 format.  (BAB)
  !   900315  CALLs to XERROR changed to CALLs to XERMSG.  (THJ)
  !   900720  Routine changed from user-callable to subsidiary.  (WRB)
  !   920618  Removed space from variable names.  (RWC, WRB)
  !***END PROLOGUE  D9B0MP
  REAL eta
  INTEGER INITDS, nbm0, nbm02, nbt02, nbth0
  REAL(8) :: X, Ampl, Theta, bm0cs(37), bt02cs(39), bm02cs(40), &
    bth0cs(44), xmax, pi4, z, D1MACH, DCSEVL
  LOGICAL first
  SAVE bm0cs, bth0cs, bm02cs, bt02cs, pi4, nbm0, nbt02, nbm02, &
    nbth0, xmax, first
  DATA bm0cs(1)/ + .9211656246827742712573767730182D-1/
  DATA bm0cs(2)/ - .1050590997271905102480716371755D-2/
  DATA bm0cs(3)/ + .1470159840768759754056392850952D-4/
  DATA bm0cs(4)/ - .5058557606038554223347929327702D-6/
  DATA bm0cs(5)/ + .2787254538632444176630356137881D-7/
  DATA bm0cs(6)/ - .2062363611780914802618841018973D-8/
  DATA bm0cs(7)/ + .1870214313138879675138172596261D-9/
  DATA bm0cs(8)/ - .1969330971135636200241730777825D-10/
  DATA bm0cs(9)/ + .2325973793999275444012508818052D-11/
  DATA bm0cs(10)/ - .3009520344938250272851224734482D-12/
  DATA bm0cs(11)/ + .4194521333850669181471206768646D-13/
  DATA bm0cs(12)/ - .6219449312188445825973267429564D-14/
  DATA bm0cs(13)/ + .9718260411336068469601765885269D-15/
  DATA bm0cs(14)/ - .1588478585701075207366635966937D-15/
  DATA bm0cs(15)/ + .2700072193671308890086217324458D-16/
  DATA bm0cs(16)/ - .4750092365234008992477504786773D-17/
  DATA bm0cs(17)/ + .8615128162604370873191703746560D-18/
  DATA bm0cs(18)/ - .1605608686956144815745602703359D-18/
  DATA bm0cs(19)/ + .3066513987314482975188539801599D-19/
  DATA bm0cs(20)/ - .5987764223193956430696505617066D-20/
  DATA bm0cs(21)/ + .1192971253748248306489069841066D-20/
  DATA bm0cs(22)/ - .2420969142044805489484682581333D-21/
  DATA bm0cs(23)/ + .4996751760510616453371002879999D-22/
  DATA bm0cs(24)/ - .1047493639351158510095040511999D-22/
  DATA bm0cs(25)/ + .2227786843797468101048183466666D-23/
  DATA bm0cs(26)/ - .4801813239398162862370542933333D-24/
  DATA bm0cs(27)/ + .1047962723470959956476996266666D-24/
  DATA bm0cs(28)/ - .2313858165678615325101260800000D-25/
  DATA bm0cs(29)/ + .5164823088462674211635199999999D-26/
  DATA bm0cs(30)/ - .1164691191850065389525401599999D-26/
  DATA bm0cs(31)/ + .2651788486043319282958336000000D-27/
  DATA bm0cs(32)/ - .6092559503825728497691306666666D-28/
  DATA bm0cs(33)/ + .1411804686144259308038826666666D-28/
  DATA bm0cs(34)/ - .3298094961231737245750613333333D-29/
  DATA bm0cs(35)/ + .7763931143074065031714133333333D-30/
  DATA bm0cs(36)/ - .1841031343661458478421333333333D-30/
  DATA bm0cs(37)/ + .4395880138594310737100799999999D-31/
  DATA bth0cs(1)/ - .24901780862128936717709793789967D+0/
  DATA bth0cs(2)/ + .48550299609623749241048615535485D-3/
  DATA bth0cs(3)/ - .54511837345017204950656273563505D-5/
  DATA bth0cs(4)/ + .13558673059405964054377445929903D-6/
  DATA bth0cs(5)/ - .55691398902227626227583218414920D-8/
  DATA bth0cs(6)/ + .32609031824994335304004205719468D-9/
  DATA bth0cs(7)/ - .24918807862461341125237903877993D-10/
  DATA bth0cs(8)/ + .23449377420882520554352413564891D-11/
  DATA bth0cs(9)/ - .26096534444310387762177574766136D-12/
  DATA bth0cs(10)/ + .33353140420097395105869955014923D-13/
  DATA bth0cs(11)/ - .47890000440572684646750770557409D-14/
  DATA bth0cs(12)/ + .75956178436192215972642568545248D-15/
  DATA bth0cs(13)/ - .13131556016891440382773397487633D-15/
  DATA bth0cs(14)/ + .24483618345240857495426820738355D-16/
  DATA bth0cs(15)/ - .48805729810618777683256761918331D-17/
  DATA bth0cs(16)/ + .10327285029786316149223756361204D-17/
  DATA bth0cs(17)/ - .23057633815057217157004744527025D-18/
  DATA bth0cs(18)/ + .54044443001892693993017108483765D-19/
  DATA bth0cs(19)/ - .13240695194366572724155032882385D-19/
  DATA bth0cs(20)/ + .33780795621371970203424792124722D-20/
  DATA bth0cs(21)/ - .89457629157111779003026926292299D-21/
  DATA bth0cs(22)/ + .24519906889219317090899908651405D-21/
  DATA bth0cs(23)/ - .69388422876866318680139933157657D-22/
  DATA bth0cs(24)/ + .20228278714890138392946303337791D-22/
  DATA bth0cs(25)/ - .60628500002335483105794195371764D-23/
  DATA bth0cs(26)/ + .18649748964037635381823788396270D-23/
  DATA bth0cs(27)/ - .58783732384849894560245036530867D-24/
  DATA bth0cs(28)/ + .18958591447999563485531179503513D-24/
  DATA bth0cs(29)/ - .62481979372258858959291620728565D-25/
  DATA bth0cs(30)/ + .21017901684551024686638633529074D-25/
  DATA bth0cs(31)/ - .72084300935209253690813933992446D-26/
  DATA bth0cs(32)/ + .25181363892474240867156405976746D-26/
  DATA bth0cs(33)/ - .89518042258785778806143945953643D-27/
  DATA bth0cs(34)/ + .32357237479762298533256235868587D-27/
  DATA bth0cs(35)/ - .11883010519855353657047144113796D-27/
  DATA bth0cs(36)/ + .44306286907358104820579231941731D-28/
  DATA bth0cs(37)/ - .16761009648834829495792010135681D-28/
  DATA bth0cs(38)/ + .64292946921207466972532393966088D-29/
  DATA bth0cs(39)/ - .24992261166978652421207213682763D-29/
  DATA bth0cs(40)/ + .98399794299521955672828260355318D-30/
  DATA bth0cs(41)/ - .39220375242408016397989131626158D-30/
  DATA bth0cs(42)/ + .15818107030056522138590618845692D-30/
  DATA bth0cs(43)/ - .64525506144890715944344098365426D-31/
  DATA bth0cs(44)/ + .26611111369199356137177018346367D-31/
  DATA bm02cs(1)/ + .9500415145228381369330861335560D-1/
  DATA bm02cs(2)/ - .3801864682365670991748081566851D-3/
  DATA bm02cs(3)/ + .2258339301031481192951829927224D-5/
  DATA bm02cs(4)/ - .3895725802372228764730621412605D-7/
  DATA bm02cs(5)/ + .1246886416512081697930990529725D-8/
  DATA bm02cs(6)/ - .6065949022102503779803835058387D-10/
  DATA bm02cs(7)/ + .4008461651421746991015275971045D-11/
  DATA bm02cs(8)/ - .3350998183398094218467298794574D-12/
  DATA bm02cs(9)/ + .3377119716517417367063264341996D-13/
  DATA bm02cs(10)/ - .3964585901635012700569356295823D-14/
  DATA bm02cs(11)/ + .5286111503883857217387939744735D-15/
  DATA bm02cs(12)/ - .7852519083450852313654640243493D-16/
  DATA bm02cs(13)/ + .1280300573386682201011634073449D-16/
  DATA bm02cs(14)/ - .2263996296391429776287099244884D-17/
  DATA bm02cs(15)/ + .4300496929656790388646410290477D-18/
  DATA bm02cs(16)/ - .8705749805132587079747535451455D-19/
  DATA bm02cs(17)/ + .1865862713962095141181442772050D-19/
  DATA bm02cs(18)/ - .4210482486093065457345086972301D-20/
  DATA bm02cs(19)/ + .9956676964228400991581627417842D-21/
  DATA bm02cs(20)/ - .2457357442805313359605921478547D-21/
  DATA bm02cs(21)/ + .6307692160762031568087353707059D-22/
  DATA bm02cs(22)/ - .1678773691440740142693331172388D-22/
  DATA bm02cs(23)/ + .4620259064673904433770878136087D-23/
  DATA bm02cs(24)/ - .1311782266860308732237693402496D-23/
  DATA bm02cs(25)/ + .3834087564116302827747922440276D-24/
  DATA bm02cs(26)/ - .1151459324077741271072613293576D-24/
  DATA bm02cs(27)/ + .3547210007523338523076971345213D-25/
  DATA bm02cs(28)/ - .1119218385815004646264355942176D-25/
  DATA bm02cs(29)/ + .3611879427629837831698404994257D-26/
  DATA bm02cs(30)/ - .1190687765913333150092641762463D-26/
  DATA bm02cs(31)/ + .4005094059403968131802476449536D-27/
  DATA bm02cs(32)/ - .1373169422452212390595193916017D-27/
  DATA bm02cs(33)/ + .4794199088742531585996491526437D-28/
  DATA bm02cs(34)/ - .1702965627624109584006994476452D-28/
  DATA bm02cs(35)/ + .6149512428936330071503575161324D-29/
  DATA bm02cs(36)/ - .2255766896581828349944300237242D-29/
  DATA bm02cs(37)/ + .8399707509294299486061658353200D-30/
  DATA bm02cs(38)/ - .3172997595562602355567423936152D-30/
  DATA bm02cs(39)/ + .1215205298881298554583333026514D-30/
  DATA bm02cs(40)/ - .4715852749754438693013210568045D-31/
  DATA bt02cs(1)/ - .24548295213424597462050467249324D+0/
  DATA bt02cs(2)/ + .12544121039084615780785331778299D-2/
  DATA bt02cs(3)/ - .31253950414871522854973446709571D-4/
  DATA bt02cs(4)/ + .14709778249940831164453426969314D-5/
  DATA bt02cs(5)/ - .99543488937950033643468850351158D-7/
  DATA bt02cs(6)/ + .85493166733203041247578711397751D-8/
  DATA bt02cs(7)/ - .86989759526554334557985512179192D-9/
  DATA bt02cs(8)/ + .10052099533559791084540101082153D-9/
  DATA bt02cs(9)/ - .12828230601708892903483623685544D-10/
  DATA bt02cs(10)/ + .17731700781805131705655750451023D-11/
  DATA bt02cs(11)/ - .26174574569485577488636284180925D-12/
  DATA bt02cs(12)/ + .40828351389972059621966481221103D-13/
  DATA bt02cs(13)/ - .66751668239742720054606749554261D-14/
  DATA bt02cs(14)/ + .11365761393071629448392469549951D-14/
  DATA bt02cs(15)/ - .20051189620647160250559266412117D-15/
  DATA bt02cs(16)/ + .36497978794766269635720591464106D-16/
  DATA bt02cs(17)/ - .68309637564582303169355843788800D-17/
  DATA bt02cs(18)/ + .13107583145670756620057104267946D-17/
  DATA bt02cs(19)/ - .25723363101850607778757130649599D-18/
  DATA bt02cs(20)/ + .51521657441863959925267780949333D-19/
  DATA bt02cs(21)/ - .10513017563758802637940741461333D-19/
  DATA bt02cs(22)/ + .21820381991194813847301084501333D-20/
  DATA bt02cs(23)/ - .46004701210362160577225905493333D-21/
  DATA bt02cs(24)/ + .98407006925466818520953651199999D-22/
  DATA bt02cs(25)/ - .21334038035728375844735986346666D-22/
  DATA bt02cs(26)/ + .46831036423973365296066286933333D-23/
  DATA bt02cs(27)/ - .10400213691985747236513382399999D-23/
  DATA bt02cs(28)/ + .23349105677301510051777740800000D-24/
  DATA bt02cs(29)/ - .52956825323318615788049749333333D-25/
  DATA bt02cs(30)/ + .12126341952959756829196287999999D-25/
  DATA bt02cs(31)/ - .28018897082289428760275626666666D-26/
  DATA bt02cs(32)/ + .65292678987012873342593706666666D-27/
  DATA bt02cs(33)/ - .15337980061873346427835733333333D-27/
  DATA bt02cs(34)/ + .36305884306364536682359466666666D-28/
  DATA bt02cs(35)/ - .86560755713629122479172266666666D-29/
  DATA bt02cs(36)/ + .20779909972536284571238399999999D-29/
  DATA bt02cs(37)/ - .50211170221417221674325333333333D-30/
  DATA bt02cs(38)/ + .12208360279441714184191999999999D-30/
  DATA bt02cs(39)/ - .29860056267039913454250666666666D-31/
  DATA pi4/0.785398163397448309615660845819876D0/
  DATA first/.TRUE./
  !***FIRST EXECUTABLE STATEMENT  D9B0MP
  IF ( first ) THEN
    eta = 0.1*REAL(D1MACH(3))
    nbm0 = INITDS(bm0cs,37,eta)
    nbt02 = INITDS(bt02cs,39,eta)
    nbm02 = INITDS(bm02cs,40,eta)
    nbth0 = INITDS(bth0cs,44,eta)
    !
    xmax = 1.0D0/D1MACH(4)
  ENDIF
  first = .FALSE.
  !
  IF ( X<4.D0 ) CALL XERMSG('SLATEC','D9B0MP','X MUST BE GE 4',1,2)
  !
  IF ( X>8.D0 ) THEN
    !
    IF ( X>xmax ) CALL XERMSG('SLATEC','D9B0MP',&
      'NO PRECISION BECAUSE X IS BIG',2,2)
    !
    z = 128.D0/(X*X) - 1.D0
    Ampl = (.75D0+DCSEVL(z,bm02cs,nbm02))/SQRT(X)
    Theta = X - pi4 + DCSEVL(z,bth0cs,nbth0)/X
    RETURN
  ENDIF
  z = (128.D0/(X*X)-5.D0)/3.D0
  Ampl = (.75D0+DCSEVL(z,bm0cs,nbm0))/SQRT(X)
  Theta = X - pi4 + DCSEVL(z,bt02cs,nbt02)/X
  RETURN
END SUBROUTINE D9B0MP
