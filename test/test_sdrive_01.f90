MODULE TEST45_MOD
  IMPLICIT NONE

CONTAINS
  !DECK SDQCK
  SUBROUTINE SDQCK(Lun,Kprint,Ipass)
    IMPLICIT NONE
    !***BEGIN PROLOGUE  SDQCK
    !***PURPOSE  Quick check for SLATEC routines SDRIV1, SDRIV2 and SDRIV3.
    !***LIBRARY   SLATEC (SDRIVE)
    !***CATEGORY  I1A2, I1A1B
    !***TYPE      SINGLE PRECISION (SDQCK-S, DDQCK-D, CDQCK-C)
    !***KEYWORDS  QUICK CHECK, SDRIV1, SDRIV2, SDRIV3
    !***AUTHOR  Kahaner, D. K., (NIST)
    !             National Institute of Standards and Technology
    !             Gaithersburg, MD  20899
    !           Sutherland, C. D., (LANL)
    !             Mail Stop D466
    !             Los Alamos National Laboratory
    !             Los Alamos, NM  87545
    !***DESCRIPTION
    !
    !  For assistance in determining the cause of a failure of these
    !  routines contact C. D. Sutherland at commercial telephone number
    !  (505)667-6949, FTS telephone number 8-843-6949, or electronic mail
    !  address CDS@LANL.GOV .
    !
    !***ROUTINES CALLED  R1MACH, SDF, SDRIV1, SDRIV2, SDRIV3, XERCLR
    !***REVISION HISTORY  (YYMMDD)
    !   890405  DATE WRITTEN
    !   890405  Revised to meet SLATEC standards.
    !***END PROLOGUE  SDQCK
    REAL ALFA, eps, ewt(1), HMAX, R1MACH, t, tout
    INTEGER ierflg, IERROR, IMPL, Ipass, Kprint, leniw, leniwx, lenw, &
      LENWMX, lenwx, LIWMX, Lun, mint, MITER, ML, mstate, MU, &
      MXORD, MXSTEP, N, nde, nfe, nje, NROOT, nstate, nstep, &
      NTASK, nx
    PARAMETER (ALFA=1.E0,HMAX=15.E0,IERROR=3,IMPL=0,LENWMX=342,LIWMX=53,&
      MITER=5,ML=2,MU=2,MXORD=5,MXSTEP=1000,N=3,NROOT=0,NTASK=1)
    REAL work(LENWMX), y(N+1)
    INTEGER iwork(LIWMX)
    DATA ewt(1)/.00001E0/
    !***FIRST EXECUTABLE STATEMENT  SDQCK
    eps = R1MACH(4)**(1.E0/3.E0)
    Ipass = 1
    !                                            Exercise SDRIV1 for problem
    !                                            with known solution.
    y(4) = ALFA
    t = 0.E0
    y(1) = 10.E0
    y(2) = 0.E0
    y(3) = 10.E0
    tout = 10.E0
    mstate = 1
    lenw = 342
    CALL SDRIV1(N,t,y,SDF,tout,mstate,eps,work,lenw,ierflg)
    nstep = INT( work(lenw-(N+50)+3) )
    nfe = INT( work(lenw-(N+50)+4) )
    nje = INT( work(lenw-(N+50)+5) )
    IF ( mstate/=2 ) THEN
      IF ( Kprint==1 ) THEN
        WRITE (Lun,&
          '('' While using SDRIV1, a solution was not obtained.'' //)' )
      ELSEIF ( Kprint>=2 ) THEN
        WRITE (Lun,&
          '('' While using SDRIV1, a solution was not obtained.'')' )
        WRITE (Lun,&
          '('' The values of parameters, results, and statistical quantities are:'')')
        WRITE (Lun,*) ' MSTATE = ', mstate, ', Error number = ', ierflg
        WRITE (Lun,*) ' N ', N, ', EPS ', eps, ', LENW ', lenw
        WRITE (Lun,*) ' T ', t
        WRITE (Lun,*) ' Y(1) ', y(1)
        WRITE (Lun,*) ' Y(2) ', y(2)
        WRITE (Lun,*) ' Y(3) ', y(3)
        WRITE (Lun,*) ' Number of steps taken is  ', nstep
        WRITE (Lun,*) ' Number of evaluations of the right hand side is  ', &
          nfe
        WRITE (Lun,*) ' Number of evaluations of the Jacobian matrix is  ', &
          nje
        WRITE (Lun,'(//)')
      ENDIF
      Ipass = 0
    ELSEIF ( ABS(1.E0-y(1)*1.5E0)>eps**(2.E0/3.E0).OR.ABS(1.E0-y(2)*3.E0)&
        >eps**(2.E0/3.E0).OR.ABS(1.E0-y(3))>eps**(2.E0/3.E0) ) THEN
      IF ( Kprint==1 ) THEN
        WRITE (Lun,&
          '('' SDRIV1:The solution determined is not accurate enough.'' //)')
      ELSEIF ( Kprint==2 ) THEN
        WRITE (Lun,&
          '('' SDRIV1:The solution determined is not accurate enough.'')')
        WRITE (Lun,&
          '('' The values of parameters, results, and statistical quantities are:'')')
        WRITE (Lun,*) ' EPS = ', eps
        WRITE (Lun,*) ' T ', t
        WRITE (Lun,*) ' Y(1) ', y(1)
        WRITE (Lun,*) ' Y(2) ', y(2)
        WRITE (Lun,*) ' Y(3) ', y(3)
        WRITE (Lun,*) ' Number of steps taken is  ', nstep
        WRITE (Lun,*) ' Number of evaluations of the right hand side is  ', &
          nfe
        WRITE (Lun,*) ' Number of evaluations of the Jacobian matrix is  ', &
          nje
        WRITE (Lun,'(//)')
      ENDIF
      Ipass = 0
    ELSEIF ( Kprint==2 ) THEN
      WRITE (Lun,&
        '('' SDRIV1:The solution determined met the expected values.'' //)')
    ELSEIF ( Kprint==3 ) THEN
      WRITE (Lun,&
        '('' SDRIV1:The solution determined met the expected values.'')')
      WRITE (Lun,'('' The values of results are '')')
      WRITE (Lun,*) ' T ', t
      WRITE (Lun,*) ' Y(1) ', y(1)
      WRITE (Lun,*) ' Y(2) ', y(2)
      WRITE (Lun,*) ' Y(3) ', y(3)
      WRITE (Lun,'(/)')
    ENDIF
    CALL XERCLR
    !                                         Run SDRIV1 with invalid input.
    nx = 201
    t = 0.E0
    y(1) = 10.E0
    y(2) = 0.E0
    y(3) = 10.E0
    y(4) = ALFA
    tout = 10.E0
    mstate = 1
    lenw = 342
    CALL SDRIV1(nx,t,y,SDF,tout,mstate,eps,work,lenw,ierflg)
    IF ( ierflg/=21 ) THEN
      IF ( Kprint==1 ) THEN
        WRITE (Lun,&
          '('' SDRIV1:An invalid parameter has not been correctly detected.'' //)')
      ELSEIF ( Kprint>=2 ) THEN
        WRITE (Lun,&
          '('' SDRIV1:An invalid parameter has not been correctly detected.'')')
        WRITE (Lun,*) ' The value of N was set to ', nx
        WRITE (Lun,*) ' MSTATE = ', mstate, ', Error number = ', ierflg
        WRITE (Lun,&
          '('' The values of parameters, results, and statistical quantities are:'')')
        WRITE (Lun,*) ' EPS ', eps, ', LENW ', lenw
        WRITE (Lun,*) ' T ', t
        WRITE (Lun,*) ' Y(1) ', y(1)
        WRITE (Lun,*) ' Y(2) ', y(2)
        WRITE (Lun,*) ' Y(3) ', y(3)
        WRITE (Lun,*) ' Number of steps taken is  ', nstep
        WRITE (Lun,*) ' Number of evaluations of the right hand side is  ', &
          nfe
        WRITE (Lun,*) ' Number of evaluations of the Jacobian matrix is  ', &
          nje
        WRITE (Lun,'(//)')
      ENDIF
      Ipass = 0
    ELSEIF ( Kprint==2 ) THEN
      WRITE (Lun,&
        '('' SDRIV1:An invalid parameter has been correctly detected.'' //)')
    ELSEIF ( Kprint==3 ) THEN
      WRITE (Lun,&
        '('' SDRIV1:An invalid parameter has been correctly detected.'')')
      WRITE (Lun,*) ' The value of N was set to ', nx
      WRITE (Lun,*) ' MSTATE = ', mstate, ', Error number = ', ierflg
      WRITE (Lun,'(/)')
    ENDIF
    CALL XERCLR
    !                                            Exercise SDRIV2 for problem
    !                                            with known solution.
    t = 0.E0
    y(1) = 10.E0
    y(2) = 0.E0
    y(3) = 10.E0
    y(4) = ALFA
    mstate = 1
    tout = 10.E0
    mint = 1
    lenw = 298
    leniw = 50
    CALL SDRIV2(N,t,y,SDF,tout,mstate,NROOT,eps,ewt,mint,work,lenw,iwork,&
      leniw,SDF,ierflg)
    nstep = iwork(3)
    nfe = iwork(4)
    nje = iwork(5)
    IF ( mstate/=2 ) THEN
      IF ( Kprint==1 ) THEN
        WRITE (Lun,&
          '('' While using SDRIV2, a solution was not obtained.'' //)'&
          )
      ELSEIF ( Kprint>=2 ) THEN
        WRITE (Lun,&
          '('' While using SDRIV2, a solution was not obtained.'')'&
          )
        WRITE (Lun,*) ' MSTATE = ', mstate, ', Error number = ', ierflg
        WRITE (Lun,&
          '('' The values of parameters, results, and statistical quantities are:'')')
        WRITE (Lun,*) ' EPS = ', eps, ', EWT ', ewt
        WRITE (Lun,*) ' MINT = ', mint, ', LENW ', lenw, ', LENIW ', &
          leniw
        WRITE (Lun,*) ' T ', t
        WRITE (Lun,*) ' Y(1) ', y(1)
        WRITE (Lun,*) ' Y(2) ', y(2)
        WRITE (Lun,*) ' Y(3) ', y(3)
        WRITE (Lun,*) ' Number of steps taken is  ', nstep
        WRITE (Lun,*) ' Number of evaluations of the right hand side is  ', &
          nfe
        WRITE (Lun,*) ' Number of evaluations of the Jacobian matrix is  ', &
          nje
        WRITE (Lun,'(//)')
      ENDIF
      Ipass = 0
    ELSEIF ( ABS(1.E0-y(1)*1.5E0)>eps**(2.E0/3.E0).OR.ABS(1.E0-y(2)*3.E0)&
        >eps**(2.E0/3.E0).OR.ABS(1.E0-y(3))>eps**(2.E0/3.E0) ) THEN
      IF ( Kprint==1 ) THEN
        WRITE (Lun,&
          '('' SDRIV2:The solution determined is not accurate enough.'' //)')
      ELSEIF ( Kprint==2 ) THEN
        WRITE (Lun,&
          '('' SDRIV2:The solution determined is not accurate enough.'')')
        WRITE (Lun,&
          '('' The values of parameters, results, and statistical quantities are:'')')
        WRITE (Lun,*) ' EPS = ', eps, ', EWT = ', ewt
        WRITE (Lun,*) ' T ', t
        WRITE (Lun,*) ' Y(1) ', y(1)
        WRITE (Lun,*) ' Y(2) ', y(2)
        WRITE (Lun,*) ' Y(3) ', y(3)
        WRITE (Lun,*) ' Number of steps taken is  ', nstep
        WRITE (Lun,*) ' Number of evaluations of the right hand side is  ', &
          nfe
        WRITE (Lun,*) ' Number of evaluations of the Jacobian matrix is  ', &
          nje
        WRITE (Lun,'(//)')
      ENDIF
      Ipass = 0
    ELSEIF ( Kprint==2 ) THEN
      WRITE (Lun,&
        '('' SDRIV2:The solution determined met the expected values.'' //)')
    ELSEIF ( Kprint==3 ) THEN
      WRITE (Lun,&
        '('' SDRIV2:The solution determined met the expected values.'')')
      WRITE (Lun,'('' The values of results are '')')
      WRITE (Lun,*) ' T ', t
      WRITE (Lun,*) ' Y(1) ', y(1)
      WRITE (Lun,*) ' Y(2) ', y(2)
      WRITE (Lun,*) ' Y(3) ', y(3)
      WRITE (Lun,'(/)')
    ENDIF
    CALL XERCLR
    !                                         Run SDRIV2 with invalid input.
    t = 0.E0
    y(1) = 10.E0
    y(2) = 0.E0
    y(3) = 10.E0
    y(4) = ALFA
    tout = 10.E0
    mstate = 1
    mint = 1
    lenwx = 1
    leniw = 50
    CALL SDRIV2(N,t,y,SDF,tout,mstate,NROOT,eps,ewt,mint,work,lenwx,iwork,&
      leniw,SDF,ierflg)
    IF ( ierflg/=32 ) THEN
      IF ( Kprint==1 ) THEN
        WRITE (Lun,&
          '('' SDRIV2:An invalid parameter has not been correctly detected.'' //)')
      ELSEIF ( Kprint>=2 ) THEN
        WRITE (Lun,&
          '('' SDRIV2:An invalid parameter has not been correctly detected.'')')
        WRITE (Lun,*) ' The value of LENW was set to ', lenwx
        WRITE (Lun,*) ' MSTATE = ', mstate, ', Error number = ', ierflg
        WRITE (Lun,&
          '('' The values of parameters, results, and statistical quantities are:'')')
        WRITE (Lun,*) ' EPS ', eps, ', MINT ', mint, ', LENW ', lenw, &
          ', LENIW ', leniw
        WRITE (Lun,*) ' T ', t
        WRITE (Lun,*) ' Y(1) ', y(1)
        WRITE (Lun,*) ' Y(2) ', y(2)
        WRITE (Lun,*) ' Y(3) ', y(3)
        WRITE (Lun,*) ' Number of steps taken is  ', nstep
        WRITE (Lun,*) ' Number of evaluations of the right hand side is  ', &
          nfe
        WRITE (Lun,*) ' Number of evaluations of the Jacobian matrix is  ', &
          nje
        WRITE (Lun,'(//)')
      ENDIF
      Ipass = 0
    ELSEIF ( Kprint==2 ) THEN
      WRITE (Lun,&
        '('' SDRIV2:An invalid parameter has been correctly detected.'' //)')
    ELSEIF ( Kprint==3 ) THEN
      WRITE (Lun,&
        '('' SDRIV2:An invalid parameter has been correctly detected.'')')
      WRITE (Lun,*) ' The value of LENW was set to ', lenwx
      WRITE (Lun,*) ' MSTATE = ', mstate, ', Error number = ', ierflg
      WRITE (Lun,'(/)')
    ENDIF
    CALL XERCLR
    !                                            Exercise SDRIV3 for problem
    !                                            with known solution.
    t = 0.E0
    y(1) = 10.E0
    y(2) = 0.E0
    y(3) = 10.E0
    y(4) = ALFA
    nstate = 1
    tout = 10.E0
    mint = 2
    lenw = 301
    leniw = 53
    CALL SDRIV3(N,t,y,SDF,nstate,tout,NTASK,NROOT,eps,ewt,IERROR,mint,MITER,&
      IMPL,ML,MU,MXORD,HMAX,work,lenw,iwork,leniw,SDF,SDF,nde,&
      MXSTEP,SDF,SDF,ierflg)
    nstep = iwork(3)
    nfe = iwork(4)
    nje = iwork(5)
    IF ( nstate/=2 ) THEN
      IF ( Kprint==1 ) THEN
        WRITE (Lun,&
          '('' While using SDRIV3, a solution was not obtained.'' //)'&
          )
      ELSEIF ( Kprint>=2 ) THEN
        WRITE (Lun,&
          '('' While using SDRIV3, a solution was not obtained.'')'&
          )
        WRITE (Lun,*) ' MSTATE = ', mstate, ', Error number = ', ierflg
        WRITE (Lun,&
          '('' The values of parameters, results, and statistical quantities are:'')')
        WRITE (Lun,*) ' EPS = ', eps, ', EWT = ', ewt, ', IERROR = ', &
          IERROR
        WRITE (Lun,*) ' MINT = ', mint, ', MITER = ', MITER, ', IMPL = ', &
          IMPL
        WRITE (Lun,*) ' T ', t
        WRITE (Lun,*) ' Y(1) ', y(1)
        WRITE (Lun,*) ' Y(2) ', y(2)
        WRITE (Lun,*) ' Y(3) ', y(3)
        WRITE (Lun,*) ' Number of steps taken is  ', nstep
        WRITE (Lun,*) ' Number of evaluations of the right hand side is  ', &
          nfe
        WRITE (Lun,*) ' Number of evaluations of the Jacobian matrix is  ', &
          nje
        WRITE (Lun,'(//)')
      ENDIF
      Ipass = 0
    ELSEIF ( ABS(1.E0-y(1)*1.5E0)>eps**(2.E0/3.E0).OR.ABS(1.E0-y(2)*3.E0)&
        >eps**(2.E0/3.E0).OR.ABS(1.E0-y(3))>eps**(2.E0/3.E0) ) THEN
      IF ( Kprint==1 ) THEN
        WRITE (Lun,&
          '('' SDRIV3:The solution determined is not accurate enough.''//)')
      ELSEIF ( Kprint>=2 ) THEN
        WRITE (Lun,&
          '('' SDRIV3:The solution determined is not accurate enough.'')')
        WRITE (Lun,&
          '('' The values of parameters, results, and statistical quantities are:'')')
        WRITE (Lun,*) ' EPS = ', eps, ', EWT = ', ewt, ', IERROR = ', &
          IERROR
        WRITE (Lun,*) ' MINT = ', mint, ', MITER = ', MITER, ', IMPL = ', &
          IMPL
        WRITE (Lun,*) ' T ', t
        WRITE (Lun,*) ' Y(1) ', y(1)
        WRITE (Lun,*) ' Y(2) ', y(2)
        WRITE (Lun,*) ' Y(3) ', y(3)
        WRITE (Lun,*) ' Number of steps taken is  ', nstep
        WRITE (Lun,*) ' Number of evaluations of the right hand side is  ', &
          nfe
        WRITE (Lun,*) ' Number of evaluations of the Jacobian matrix is  ', &
          nje
        WRITE (Lun,'(//)')
      ENDIF
      Ipass = 0
    ELSEIF ( Kprint==2 ) THEN
      WRITE (Lun,&
        '('' SDRIV3:The solution determined met the expected values.'' //)')
    ELSEIF ( Kprint==3 ) THEN
      WRITE (Lun,&
        '('' SDRIV3:The solution determined met the expected values.'')')
      WRITE (Lun,'('' The values of results are '')')
      WRITE (Lun,*) ' T ', t
      WRITE (Lun,*) ' Y(1) ', y(1)
      WRITE (Lun,*) ' Y(2) ', y(2)
      WRITE (Lun,*) ' Y(3) ', y(3)
      WRITE (Lun,'(/)')
    ENDIF
    CALL XERCLR
    !                                         Run SDRIV3 with invalid input.
    t = 0.E0
    y(1) = 10.E0
    y(2) = 0.E0
    y(3) = 10.E0
    y(4) = ALFA
    nstate = 1
    tout = 10.E0
    mint = 2
    lenw = 301
    leniwx = 1
    CALL SDRIV3(N,t,y,SDF,nstate,tout,NTASK,NROOT,eps,ewt,IERROR,mint,MITER,&
      IMPL,ML,MU,MXORD,HMAX,work,lenw,iwork,leniwx,SDF,SDF,nde,&
      MXSTEP,SDF,SDF,ierflg)
    IF ( ierflg/=33 ) THEN
      IF ( Kprint==1 ) THEN
        WRITE (Lun,&
          '('' SDRIV3:An invalid parameter has not been correctly detected.'' //)')
      ELSEIF ( Kprint>=2 ) THEN
        WRITE (Lun,&
          '('' SDRIV3:An invalid parameter has not been correctly detected.'')')
        WRITE (Lun,*) ' The value of LENIW was set to ', leniwx
        WRITE (Lun,*) ' NSTATE = ', nstate, ', Error number = ', ierflg
        WRITE (Lun,&
          '('' The values of parameters, results, and statistical quantities are:'')')
        WRITE (Lun,*) ' EPS = ', eps, ', EWT = ', ewt, ', IERROR = ', &
          IERROR
        WRITE (Lun,*) ' MINT = ', mint, ', MITER = ', MITER, ', IMPL = ', &
          IMPL
        WRITE (Lun,*) ' T ', t
        WRITE (Lun,*) ' Y(1) ', y(1)
        WRITE (Lun,*) ' Y(2) ', y(2)
        WRITE (Lun,*) ' Y(3) ', y(3)
        WRITE (Lun,*) ' Number of steps taken is  ', nstep
        WRITE (Lun,*) ' Number of evaluations of the right hand side is  ', &
          nfe
        WRITE (Lun,*) ' Number of evaluations of the Jacobian matrix is  ', &
          nje
        WRITE (Lun,'(//)')
      ENDIF
      Ipass = 0
    ELSEIF ( Kprint==2 ) THEN
      WRITE (Lun,&
        '('' SDRIV3:An invalid parameter has been correctly detected.'' //)')
    ELSEIF ( Kprint==3 ) THEN
      WRITE (Lun,&
        '('' SDRIV3:An invalid parameter has been correctly detected.'')')
      WRITE (Lun,*) ' The value of LENIW was set to ', leniwx
      WRITE (Lun,*) ' NSTATE = ', nstate, ', Error number = ', ierflg
      WRITE (Lun,'(/)')
    ENDIF
    CALL XERCLR
  END SUBROUTINE SDQCK
  !DECK SDF
  SUBROUTINE SDF(N,T,Y,Yp)
    IMPLICIT NONE
    !***BEGIN PROLOGUE  SDF
    !***SUBSIDIARY
    !***PURPOSE  Quick check for SLATEC routines SDRIV1, SDRIV2 and SDRIV3.
    !***LIBRARY   SLATEC (SDRIVE)
    !***CATEGORY  I1A2, I1A1B
    !***TYPE      SINGLE PRECISION (SDF-S, DDF-D, CDF-C)
    !***KEYWORDS  QUICK CHECK, SDRIV1, SDRIV2, SDRIV3
    !***AUTHOR  Kahaner, D. K., (NIST)
    !             National Institute of Standards and Technology
    !             Gaithersburg, MD  20899
    !           Sutherland, C. D., (LANL)
    !             Mail Stop D466
    !             Los Alamos National Laboratory
    !             Los Alamos, NM  87545
    !***SEE ALSO  SDQCK
    !***ROUTINES CALLED  (NONE)
    !***REVISION HISTORY  (YYMMDD)
    !   890405  DATE WRITTEN
    !   890405  Revised to meet SLATEC standards.
    !***END PROLOGUE  SDF
    REAL alfa, T, Y(*), Yp(*)
    INTEGER N
    !***FIRST EXECUTABLE STATEMENT  SDF
    alfa = Y(N+1)
    Yp(1) = 1.E0 + alfa*(Y(2)-Y(1)) - Y(1)*Y(3)
    Yp(2) = alfa*(Y(1)-Y(2)) - Y(2)*Y(3)
    Yp(3) = 1.E0 - Y(3)*(Y(1)+Y(2))
  END SUBROUTINE SDF
END MODULE TEST45_MOD
!DECK TEST45
PROGRAM TEST45
  USE TEST45_MOD
  IMPLICIT NONE
  !***BEGIN PROLOGUE  TEST45
  !***PURPOSE  Driver for testing SLATEC subprograms
  !            SDRIV1  SDRIV2  SDRIV3
  !***LIBRARY   SLATEC
  !***CATEGORY  I1A2, I1A1B
  !***TYPE      SINGLE PRECISION (TEST45-S, TEST46-D, TEST47-C)
  !***KEYWORDS  SDRIVE, QUICK CHECK DRIVER
  !***AUTHOR  SLATEC Common Mathematical Library Committee
  !***DESCRIPTION
  !
  ! *Usage:
  !     One input data record is required
  !         READ (LIN, '(I1)') KPRINT
  !
  ! *Arguments:
  !     KPRINT = 0  Quick checks - No printing.
  !                 Driver       - Short pass or fail message printed.
  !              1  Quick checks - No message printed for passed tests,
  !                                short message printed for failed tests.
  !                 Driver       - Short pass or fail message printed.
  !              2  Quick checks - Print short message for passed tests,
  !                                fuller information for failed tests.
  !                 Driver       - Pass or fail message printed.
  !              3  Quick checks - Print complete quick check results.
  !                 Driver       - Pass or fail message printed.
  !
  ! *Description:
  !     Driver for testing SLATEC subprograms
  !        SDRIV1  SDRIV2  SDRIV3
  !
  !***REFERENCES  Kirby W. Fong, Thomas H. Jefferson, Tokihiko Suyehiro
  !                 and Lee Walton, Guide to the SLATEC Common Mathema-
  !                 tical Library, April 10, 1990.
  !***ROUTINES CALLED  I1MACH, SDQCK, XERMAX, XSETF, XSETUN
  !***REVISION HISTORY  (YYMMDD)
  !   920801  DATE WRITTEN
  !***END PROLOGUE  TEST45
  INTEGER I1MACH
  INTEGER ipass, kprint, lin, lun, nfail
  !***FIRST EXECUTABLE STATEMENT  TEST45
  lun = I1MACH(2)
  lin = I1MACH(1)
  nfail = 0
  !
  !     Read KPRINT parameter
  !
  CALL GET_ARGUMENT(kprint)
  CALL XERMAX(1000)
  CALL XSETUN(lun)
  IF ( kprint<=1 ) THEN
    CALL XSETF(0)
  ELSE
    CALL XSETF(1)
  ENDIF
  !
  !     Test single precision SDRIVE
  !
  CALL SDQCK(lun,kprint,ipass)
  IF ( ipass==0 ) nfail = nfail + 1
  !
  !     Write PASS or FAIL message
  !
  IF ( nfail==0 ) THEN
    WRITE (lun,99001)
    99001 FORMAT (/' --------------TEST45 PASSED ALL TESTS----------------')
  ELSE
    WRITE (lun,99002) nfail
    99002 FORMAT (/' ************* WARNING -- ',I5,&
      ' TEST(S) FAILED IN PROGRAM TEST45 *************')
  ENDIF
  STOP
END PROGRAM TEST45
