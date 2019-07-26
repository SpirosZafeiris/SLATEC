!** PSIXN
REAL(SP) ELEMENTAL FUNCTION PSIXN(N)
  !> Subsidiary to EXINT
  !***
  ! **Library:**   SLATEC
  !***
  ! **Type:**      SINGLE PRECISION (PSIXN-S, DPSIXN-D)
  !***
  ! **Author:**  Amos, D. E., (SNLA)
  !***
  ! **Description:**
  !
  !     This subroutine returns values of PSI(X)=derivative of log
  !     GAMMA(X), X > 0.0 at integer arguments. A table look-up is
  !     performed for N <= 100, and the asymptotic expansion is
  !     evaluated for N > 100.
  !
  !***
  ! **See also:**  EXINT
  !***
  ! **Routines called:**  R1MACH

  !* REVISION HISTORY  (YYMMDD)
  !   800501  DATE WRITTEN
  !   890531  Changed all specific intrinsics to generic.  (WRB)
  !   891214  Prologue converted to Version 4.0 format.  (BAB)
  !   900328  Added TYPE section.  (WRB)
  !   910722  Updated AUTHOR section.  (ALS)
  USE service, ONLY : eps_sp
  !
  INTEGER, INTENT(IN) :: N
  !
  INTEGER :: k
  REAL(SP) :: ax, fn, rfn2, trm, s, wdtol
  !-----------------------------------------------------------------------
  !             PSIXN(N), N = 1,100
  !-----------------------------------------------------------------------
  REAL(SP), PARAMETER :: c(100) = [ -5.77215664901532861E-01_SP, 4.22784335098467139E-01_SP, &
    9.22784335098467139E-01_SP, 1.25611766843180047E+00_SP, 1.50611766843180047E+00_SP, &
    1.70611766843180047E+00_SP, 1.87278433509846714E+00_SP, 2.01564147795561000E+00_SP, &
    2.14064147795561000E+00_SP, 2.25175258906672111E+00_SP, 2.35175258906672111E+00_SP, &
    2.44266167997581202E+00_SP, 2.52599501330914535E+00_SP, 2.60291809023222227E+00_SP, &
    2.67434666166079370E+00_SP, 2.74101332832746037E+00_SP, 2.80351332832746037E+00_SP, &
    2.86233685773922507E+00_SP, 2.91789241329478063E+00_SP, 2.97052399224214905E+00_SP, &
    3.02052399224214905E+00_SP, 3.06814303986119667E+00_SP, 3.11359758531574212E+00_SP, &
    3.15707584618530734E+00_SP, 3.19874251285197401E+00_SP, 3.23874251285197401E+00_SP, &
    3.27720405131351247E+00_SP, 3.31424108835054951E+00_SP, 3.34995537406483522E+00_SP, &
    3.38443813268552488E+00_SP, 3.41777146601885821E+00_SP, 3.45002953053498724E+00_SP, &
    3.48127953053498724E+00_SP, 3.51158256083801755E+00_SP, 3.54099432554389990E+00_SP, &
    3.56956575411532847E+00_SP, 3.59734353189310625E+00_SP, 3.62437055892013327E+00_SP, &
    3.65068634839381748E+00_SP, 3.67632737403484313E+00_SP, 3.70132737403484313E+00_SP, &
    3.72571761793728215E+00_SP, 3.74952714174680596E+00_SP, 3.77278295570029433E+00_SP, &
    3.79551022842756706E+00_SP, 3.81773245064978928E+00_SP, 3.83947158108457189E+00_SP, &
    3.86074817682925274E+00_SP, 3.88158151016258607E+00_SP, 3.90198967342789220E+00_SP, &
    3.92198967342789220E+00_SP, 3.94159751656514710E+00_SP, 3.96082828579591633E+00_SP, &
    3.97969621032421822E+00_SP, 3.99821472884273674E+00_SP, 4.01639654702455492E+00_SP, &
    4.03425368988169777E+00_SP, 4.05179754953082058E+00_SP, 4.06903892884116541E+00_SP, &
    4.08598808138353829E+00_SP, 4.10265474805020496E+00_SP, 4.11904819067315578E+00_SP, &
    4.13517722293122029E+00_SP, 4.15105023880423617E+00_SP, 4.16667523880423617E+00_SP, &
    4.18205985418885155E+00_SP, 4.19721136934036670E+00_SP, 4.21213674247469506E+00_SP, &
    4.22684262482763624E+00_SP, 4.24133537845082464E+00_SP, 4.25562109273653893E+00_SP, &
    4.26970559977879245E+00_SP, 4.28359448866768134E+00_SP, 4.29729311880466764E+00_SP, &
    4.31080663231818115E+00_SP, 4.32413996565151449E+00_SP, 4.33729786038835659E+00_SP, &
    4.35028487337536958E+00_SP, 4.36310538619588240E+00_SP, 4.37576361404398366E+00_SP, &
    4.38826361404398366E+00_SP, 4.40060929305632934E+00_SP, 4.41280441500754886E+00_SP, &
    4.42485260777863319E+00_SP, 4.43675736968339510E+00_SP, 4.44852207556574804E+00_SP, &
    4.46014998254249223E+00_SP, 4.47164423541605544E+00_SP, 4.48300787177969181E+00_SP, &
    4.49424382683587158E+00_SP, 4.50535493794698269E+00_SP, 4.51634394893599368E+00_SP, &
    4.52721351415338499E+00_SP, 4.53796620232542800E+00_SP, 4.54860450019776842E+00_SP, &
    4.55913081598724211E+00_SP, 4.56954748265390877E+00_SP, 4.57985676100442424E+00_SP, &
    4.59006084263707730E+00_SP, 4.60016185273808740E+00_SP ]
  !-----------------------------------------------------------------------
  !             COEFFICIENTS OF ASYMPTOTIC EXPANSION
  !-----------------------------------------------------------------------
  REAL(SP), PARAMETER :: b(6) = [ 8.33333333333333333E-02_SP, -8.33333333333333333E-03_SP, &
    3.96825396825396825E-03_SP, -4.16666666666666666E-03_SP, 7.57575757575757576E-03_SP, &
    -2.10927960927960928E-02_SP ]
  !
  !* FIRST EXECUTABLE STATEMENT  PSIXN
  IF( N>100 ) THEN
    wdtol = MAX(eps_sp,1.0E-18_SP)
    fn = N
    ax = 1._SP
    s = -0.5_SP/fn
    IF( ABS(s)>wdtol ) THEN
      rfn2 = 1._SP/(fn*fn)
      DO k = 1, 6
        ax = ax*rfn2
        trm = -b(k)*ax
        IF( ABS(trm)<wdtol ) EXIT
        s = s + trm
      END DO
    END IF
    PSIXN = s + LOG(fn)
  ELSE
    PSIXN = c(N)
  END IF

END FUNCTION PSIXN