!** DYAIRY
SUBROUTINE DYAIRY(X,Rx,C,Bi,Dbi)
  !>
  !  Subsidiary to DBESJ and DBESY
  !***
  ! **Library:**   SLATEC
  !***
  ! **Type:**      DOUBLE PRECISION (YAIRY-S, DYAIRY-D)
  !***
  ! **Author:**  Amos, D. E., (SNLA)
  !           Daniel, S. L., (SNLA)
  !***
  ! **Description:**
  !
  !                  DYAIRY computes the Airy function BI(X)
  !                   and its derivative DBI(X) for DASYJY
  !
  !                                     INPUT
  !
  !         X  - Argument, computed by DASYJY, X unrestricted
  !        RX  - RX=SQRT(ABS(X)), computed by DASYJY
  !         C  - C=2.*(ABS(X)**1.5)/3., computed by DASYJY
  !
  !                                    OUTPUT
  !        BI  - Value of function BI(X)
  !       DBI  - Value of the derivative DBI(X)
  !
  !***
  ! **See also:**  DBESJ, DBESY
  !***
  ! **Routines called:**  (NONE)

  !* REVISION HISTORY  (YYMMDD)
  !   750101  DATE WRITTEN
  !   890531  Changed all specific intrinsics to generic.  (WRB)
  !   891214  Prologue converted to Version 4.0 format.  (BAB)
  !   900328  Added TYPE section.  (WRB)
  !   910408  Updated the AUTHOR section.  (WRB)

  !
  INTEGER i, j
  REAL(8) :: ax, Bi, C, cv, Dbi, d1, d2, ex, e1, e2, f1, f2, rtrx, Rx, s1, s2, &
    t, tc, temp1, temp2, tt, X
  INTEGER, PARAMETER :: n1 = 20, n2 = 19, n3 = 14
  INTEGER, PARAMETER :: m1 = 18, m2 = 17, m3 = 12
  INTEGER, PARAMETER :: n1d = 21, n2d = 20, n3d = 19, n4d = 14
  INTEGER, PARAMETER :: m1d = 19, m2d = 18, m3d = 17, m4d = 12
  REAL(8), PARAMETER :: fpi12 = 1.30899693899575D+00, spi12 = 1.83259571459405D+00, &
    con1 = 6.66666666666667D-01, con2 = 7.74148278841779D+00, &
    con3 = 3.64766105490356D-01
  REAL(8), PARAMETER :: bk1(20) = [ 2.43202846447449D+00, 2.57132009754685D+00, &
    1.02802341258616D+00, 3.41958178205872D-01, 8.41978629889284D-02, &
    1.93877282587962D-02, 3.92687837130335D-03, 6.83302689948043D-04, &
    1.14611403991141D-04, 1.74195138337086D-05, 2.41223620956355D-06, &
    3.24525591983273D-07, 4.03509798540183D-08, 4.70875059642296D-09, &
    5.35367432585889D-10, 5.70606721846334D-11, 5.80526363709933D-12, &
    5.76338988616388D-13, 5.42103834518071D-14, 4.91857330301677D-15 ]
  REAL(8), PARAMETER :: bk2(20) = [ 5.74830555784088D-01, -6.91648648376891D-03, &
    1.97460263052093D-03, -5.24043043868823D-04, 1.22965147239661D-04, &
    -2.27059514462173D-05, 2.23575555008526D-06, 4.15174955023899D-07, &
    -2.84985752198231D-07, 8.50187174775435D-08, -1.70400826891326D-08, &
    2.25479746746889D-09, -1.09524166577443D-10, -3.41063845099711D-11, &
    1.11262893886662D-11, -1.75542944241734D-12, 1.36298600401767D-13, &
    8.76342105755664D-15, -4.64063099157041D-15, 7.78772758732960D-16 ]
  REAL(8), PARAMETER :: bk3(20) = [ 5.66777053506912D-01, 2.63672828349579D-03, &
    5.12303351473130D-05, 2.10229231564492D-06, 1.42217095113890D-07, &
    1.28534295891264D-08, 7.28556219407507D-10, -3.45236157301011D-10, &
    -2.11919115912724D-10, -6.56803892922376D-11, -8.14873160315074D-12, &
    3.03177845632183D-12, 1.73447220554115D-12, 1.67935548701554D-13, &
    -1.49622868806719D-13, -5.15470458953407D-14, 8.75741841857830D-15, &
    7.96735553525720D-15, -1.29566137861742D-16, -1.11878794417520D-15 ]
  REAL(8), PARAMETER :: bk4(14) = [ 4.85444386705114D-01, -3.08525088408463D-03, &
    6.98748404837928D-05, -2.82757234179768D-06, 1.59553313064138D-07, &
    -1.12980692144601D-08, 9.47671515498754D-10, -9.08301736026423D-11, &
    9.70776206450724D-12, -1.13687527254574D-12, 1.43982917533415D-13, &
    -1.95211019558815D-14, 2.81056379909357D-15, -4.26916444775176D-16 ]
  REAL(8), PARAMETER :: bjp(19) = [ 1.34918611457638D-01, -3.19314588205813D-01, &
    5.22061946276114D-02, 5.28869112170312D-02, -8.58100756077350D-03, &
    -2.99211002025555D-03, 4.21126741969759D-04, 8.73931830369273D-05, &
    -1.06749163477533D-05, -1.56575097259349D-06, 1.68051151983999D-07, &
    1.89901103638691D-08, -1.81374004961922D-09, -1.66339134593739D-10, &
    1.42956335780810D-11, 1.10179811626595D-12, -8.60187724192263D-14, &
    -5.71248177285064D-15, 4.08414552853803D-16 ]
  REAL(8), PARAMETER :: bjn(19) = [ 6.59041673525697D-02, -4.24905910566004D-01, &
    2.87209745195830D-01, 1.29787771099606D-01, -4.56354317590358D-02, &
    -1.02630175982540D-02, 2.50704671521101D-03, 3.78127183743483D-04, &
    -7.11287583284084D-05, -8.08651210688923D-06, 1.23879531273285D-06, &
    1.13096815867279D-07, -1.46234283176310D-08, -1.11576315688077D-09, &
    1.24846618243897D-10, 8.18334132555274D-12, -8.07174877048484D-13, &
    -4.63778618766425D-14, 4.09043399081631D-15 ]
  REAL(8), PARAMETER :: aa(14) = [ -2.78593552803079D-01, 3.52915691882584D-03, &
    2.31149677384994D-05, -4.71317842263560D-06, 1.12415907931333D-07, &
    2.00100301184339D-08, -2.60948075302193D-09, 3.55098136101216D-11, &
    3.50849978423875D-11, -5.83007187954202D-12, 2.04644828753326D-13, &
    1.10529179476742D-13, -2.87724778038775D-14, 2.88205111009939D-15 ]
  REAL(8), PARAMETER :: bb(14) = [ -4.90275424742791D-01, -1.57647277946204D-03, &
    9.66195963140306D-05, -1.35916080268815D-07, -2.98157342654859D-07, &
    1.86824767559979D-08, 1.03685737667141D-09, -3.28660818434328D-10, &
    2.57091410632780D-11, 2.32357655300677D-12, -9.57523279048255D-13, &
    1.20340828049719D-13, 2.90907716770715D-15, -4.55656454580149D-15 ]
  REAL(8), PARAMETER :: dbk1(21) = [ 2.95926143981893D+00, 3.86774568440103D+00, &
    1.80441072356289D+00, 5.78070764125328D-01, 1.63011468174708D-01, &
    3.92044409961855D-02, 7.90964210433812D-03, 1.50640863167338D-03, &
    2.56651976920042D-04, 3.93826605867715D-05, 5.81097771463818D-06, &
    7.86881233754659D-07, 9.93272957325739D-08, 1.21424205575107D-08, &
    1.38528332697707D-09, 1.50190067586758D-10, 1.58271945457594D-11, &
    1.57531847699042D-12, 1.50774055398181D-13, 1.40594335806564D-14, &
    1.24942698777218D-15 ]
  REAL(8), PARAMETER :: dbk2(20) = [ 5.49756809432471D-01, 9.13556983276901D-03, &
    -2.53635048605507D-03, 6.60423795342054D-04, -1.55217243135416D-04, &
    3.00090325448633D-05, -3.76454339467348D-06, -1.33291331611616D-07, &
    2.42587371049013D-07, -8.07861075240228D-08, 1.71092818861193D-08, &
    -2.41087357570599D-09, 1.53910848162371D-10, 2.56465373190630D-11, &
    -9.88581911653212D-12, 1.60877986412631D-12, -1.20952524741739D-13, &
    -1.06978278410820D-14, 5.02478557067561D-15, -8.68986130935886D-16 ]
  REAL(8), PARAMETER :: dbk3(20) = [ 5.60598509354302D-01, -3.64870013248135D-03, &
    -5.98147152307417D-05, -2.33611595253625D-06, -1.64571516521436D-07, &
    -2.06333012920569D-08, -4.27745431573110D-09, -1.08494137799276D-09, &
    -2.37207188872763D-10, -2.22132920864966D-11, 1.07238008032138D-11, &
    5.71954845245808D-12,   7.51102737777835D-13, -3.81912369483793D-13, &
    -1.75870057119257D-13,  6.69641694419084D-15, 2.26866724792055D-14, &
    2.69898141356743D-15,  -2.67133612397359D-15, -6.54121403165269D-16 ]
  REAL(8), PARAMETER :: dbk4(14) = [ 4.93072999188036D-01, 4.38335419803815D-03, &
    -8.37413882246205D-05, 3.20268810484632D-06, -1.75661979548270D-07, &
    1.22269906524508D-08, -1.01381314366052D-09, 9.63639784237475D-11, &
    -1.02344993379648D-11, 1.19264576554355D-12, -1.50443899103287D-13, &
    2.03299052379349D-14, -2.91890652008292D-15, 4.42322081975475D-16 ]
  REAL(8), PARAMETER :: dbjp(19) = [ 1.13140872390745D-01, -2.08301511416328D-01, &
    1.69396341953138D-02, 2.90895212478621D-02, -3.41467131311549D-03, &
    -1.46455339197417D-03, 1.63313272898517D-04, 3.91145328922162D-05, &
    -3.96757190808119D-06, -6.51846913772395D-07, 5.98707495269280D-08, &
    7.44108654536549D-09, -6.21241056522632D-10, -6.18768017313526D-11, &
    4.72323484752324D-12, 3.91652459802532D-13, -2.74985937845226D-14, &
    -1.95036497762750D-15, 1.26669643809444D-16 ]
  REAL(8), PARAMETER :: dbjn(19) = [ -1.88091260068850D-02, -1.47798180826140D-01, &
    5.46075900433171D-01, 1.52146932663116D-01, -9.58260412266886D-02, &
    -1.63102731696130D-02, 5.75364806680105D-03, 7.12145408252655D-04, &
    -1.75452116846724D-04, -1.71063171685128D-05, 3.24435580631680D-06, &
    2.61190663932884D-07, -4.03026865912779D-08, -2.76435165853895D-09, &
    3.59687929062312D-10, 2.14953308456051D-11, -2.41849311903901D-12, &
    -1.28068004920751D-13, 1.26939834401773D-14 ]
  REAL(8), PARAMETER :: daa(14) = [ 2.77571356944231D-01, -4.44212833419920D-03, &
    8.42328522190089D-05, 2.58040318418710D-06, -3.42389720217621D-07, &
    6.24286894709776D-09, 2.36377836844577D-09, -3.16991042656673D-10, &
    4.40995691658191D-12, 5.18674221093575D-12, -9.64874015137022D-13, &
    4.90190576608710D-14, 1.77253430678112D-14, -5.55950610442662D-15 ]
  REAL(8), PARAMETER :: dbb(14) = [ 4.91627321104601D-01, 3.11164930427489D-03, &
    8.23140762854081D-05, -4.61769776172142D-06, -6.13158880534626D-08, &
    2.87295804656520D-08, -1.81959715372117D-09, -1.44752826642035D-10, &
    4.53724043420422D-11, -3.99655065847223D-12, -3.24089119830323D-13, &
    1.62098952568741D-13, -2.40765247974057D-14, 1.69384811284491D-16 ]
  !* FIRST EXECUTABLE STATEMENT  DYAIRY
  ax = ABS(X)
  Rx = SQRT(ax)
  C = con1*ax*Rx
  IF ( X<0.0D0 ) THEN
    !
    IF ( C>5.0D0 ) THEN
      !
      rtrx = SQRT(Rx)
      t = 10.0D0/C - 1.0D0
      tt = t + t
      j = n3
      f1 = aa(j)
      e1 = bb(j)
      f2 = 0.0D0
      e2 = 0.0D0
      DO i = 1, m3
        j = j - 1
        temp1 = f1
        temp2 = e1
        f1 = tt*f1 - f2 + aa(j)
        e1 = tt*e1 - e2 + bb(j)
        f2 = temp1
        e2 = temp2
      END DO
      temp1 = t*f1 - f2 + aa(1)
      temp2 = t*e1 - e2 + bb(1)
      cv = C - fpi12
      Bi = (temp1*COS(cv)+temp2*SIN(cv))/rtrx
      j = n4d
      f1 = daa(j)
      e1 = dbb(j)
      f2 = 0.0D0
      e2 = 0.0D0
      DO i = 1, m4d
        j = j - 1
        temp1 = f1
        temp2 = e1
        f1 = tt*f1 - f2 + daa(j)
        e1 = tt*e1 - e2 + dbb(j)
        f2 = temp1
        e2 = temp2
      END DO
      temp1 = t*f1 - f2 + daa(1)
      temp2 = t*e1 - e2 + dbb(1)
      cv = C - spi12
      Dbi = (temp1*COS(cv)-temp2*SIN(cv))*rtrx
      RETURN
    END IF
  ELSEIF ( C>8.0D0 ) THEN
    !
    rtrx = SQRT(Rx)
    t = 16.0D0/C - 1.0D0
    tt = t + t
    j = n1
    f1 = bk3(j)
    f2 = 0.0D0
    DO i = 1, m1
      j = j - 1
      temp1 = f1
      f1 = tt*f1 - f2 + bk3(j)
      f2 = temp1
    END DO
    s1 = t*f1 - f2 + bk3(1)
    j = n2d
    f1 = dbk3(j)
    f2 = 0.0D0
    DO i = 1, m2d
      j = j - 1
      temp1 = f1
      f1 = tt*f1 - f2 + dbk3(j)
      f2 = temp1
    END DO
    d1 = t*f1 - f2 + dbk3(1)
    tc = C + C
    ex = EXP(C)
    IF ( tc>35.0D0 ) THEN
      Bi = ex*s1/rtrx
      Dbi = ex*rtrx*d1
      RETURN
    ELSE
      t = 10.0D0/C - 1.0D0
      tt = t + t
      j = n3
      f1 = bk4(j)
      f2 = 0.0D0
      DO i = 1, m3
        j = j - 1
        temp1 = f1
        f1 = tt*f1 - f2 + bk4(j)
        f2 = temp1
      END DO
      s2 = t*f1 - f2 + bk4(1)
      Bi = (s1+EXP(-tc)*s2)/rtrx
      Bi = Bi*ex
      j = n4d
      f1 = dbk4(j)
      f2 = 0.0D0
      DO i = 1, m4d
        j = j - 1
        temp1 = f1
        f1 = tt*f1 - f2 + dbk4(j)
        f2 = temp1
      END DO
      d2 = t*f1 - f2 + dbk4(1)
      Dbi = rtrx*(d1+EXP(-tc)*d2)
      Dbi = Dbi*ex
      RETURN
    END IF
  ELSEIF ( X>2.5D0 ) THEN
    rtrx = SQRT(Rx)
    t = (X+X-con2)*con3
    tt = t + t
    j = n1
    f1 = bk2(j)
    f2 = 0.0D0
    DO i = 1, m1
      j = j - 1
      temp1 = f1
      f1 = tt*f1 - f2 + bk2(j)
      f2 = temp1
    END DO
    Bi = (t*f1-f2+bk2(1))/rtrx
    ex = EXP(C)
    Bi = Bi*ex
    j = n2d
    f1 = dbk2(j)
    f2 = 0.0D0
    DO i = 1, m2d
      j = j - 1
      temp1 = f1
      f1 = tt*f1 - f2 + dbk2(j)
      f2 = temp1
    END DO
    Dbi = (t*f1-f2+dbk2(1))*rtrx
    Dbi = Dbi*ex
    RETURN
  ELSE
    t = (X+X-2.5D0)*0.4D0
    tt = t + t
    j = n1
    f1 = bk1(j)
    f2 = 0.0D0
    DO i = 1, m1
      j = j - 1
      temp1 = f1
      f1 = tt*f1 - f2 + bk1(j)
      f2 = temp1
    END DO
    Bi = t*f1 - f2 + bk1(1)
    j = n1d
    f1 = dbk1(j)
    f2 = 0.0D0
    DO i = 1, m1d
      j = j - 1
      temp1 = f1
      f1 = tt*f1 - f2 + dbk1(j)
      f2 = temp1
    END DO
    Dbi = t*f1 - f2 + dbk1(1)
    RETURN
  END IF
  t = 0.4D0*C - 1.0D0
  tt = t + t
  j = n2
  f1 = bjp(j)
  e1 = bjn(j)
  f2 = 0.0D0
  e2 = 0.0D0
  DO i = 1, m2
    j = j - 1
    temp1 = f1
    temp2 = e1
    f1 = tt*f1 - f2 + bjp(j)
    e1 = tt*e1 - e2 + bjn(j)
    f2 = temp1
    e2 = temp2
  END DO
  Bi = (t*e1-e2+bjn(1)) - ax*(t*f1-f2+bjp(1))
  j = n3d
  f1 = dbjp(j)
  e1 = dbjn(j)
  f2 = 0.0D0
  e2 = 0.0D0
  DO i = 1, m3d
    j = j - 1
    temp1 = f1
    temp2 = e1
    f1 = tt*f1 - f2 + dbjp(j)
    e1 = tt*e1 - e2 + dbjn(j)
    f2 = temp1
    e2 = temp2
  END DO
  Dbi = X*X*(t*f1-f2+dbjp(1)) + (t*e1-e2+dbjn(1))
  RETURN
END SUBROUTINE DYAIRY
