!** DDES
SUBROUTINE DDES(DF,Neq,T,Y,Tout,Info,Rtol,Atol,Idid,Ypout,Yp,Yy,Wt,P,Phi,&
    Alpha,Beta,Psi,V,W,Sig,G,Gi,H,Eps,X,Xold,Hold,Told,Delsgn,&
    Tstop,Twou,Fouru,Start,Phase1,Nornd,Stiff,Intout,Ns,Kord,&
    Kold,Init,Ksteps,Kle4,Iquit,Kprev,Ivc,Iv,Kgi,Rpar,Ipar)
  !>
  !***
  !  Subsidiary to DDEABM
  !***
  ! **Library:**   SLATEC
  !***
  ! **Type:**      DOUBLE PRECISION (DES-S, DDES-D)
  !***
  ! **Author:**  Watts, H. A., (SNLA)
  !***
  ! **Description:**
  !
  !   DDEABM merely allocates storage for DDES to relieve the user of the
  !   inconvenience of a long call list.  Consequently  DDES  is used as
  !   described in the comments for  DDEABM .
  !
  !***
  ! **See also:**  DDEABM
  !***
  ! **Routines called:**  D1MACH, DINTP, DSTEPS, XERMSG

  !* REVISION HISTORY  (YYMMDD)
  !   820301  DATE WRITTEN
  !   890531  Changed all specific intrinsics to generic.  (WRB)
  !   890831  Modified array declarations.  (WRB)
  !   891214  Prologue converted to Version 4.0 format.  (BAB)
  !   900328  Added TYPE section.  (WRB)
  !   900510  Convert XERRWV calls to XERMSG calls, cvt GOTOs to
  !           IF-THEN-ELSE.  (RWC)
  !   910722  Updated AUTHOR section.  (ALS)
  USE service, ONLY : XERMSG, D1MACH
  !
  INTEGER Idid, Info(15), Init, Ipar(*), Iquit, Iv(10), Ivc, k, Kgi, Kle4, &
    Kold, Kord, Kprev, Ksteps, l, ltol, natolp, Neq, nrtolp, Ns
  REAL(8) :: a, absdel, Alpha(12), Atol(*), Beta(12), del, &
    Delsgn, dt, Eps, Fouru, G(13), Gi(11), H, ha, Hold, P(*), &
    Phi(Neq,16), Psi(12), Rpar(*), Rtol(*), Sig(13), T, Told, Tout, Tstop, &
    Twou, u, V(12), W(12), Wt(*), X, Xold, Y(*), Yp(*), Ypout(*), Yy(*)
  LOGICAL Stiff, crash, Start, Phase1, Nornd, Intout
  CHARACTER(8) :: xern1
  CHARACTER(16) :: xern3, xern4
  !
  EXTERNAL :: DF
  !
  !.......................................................................
  !
  !  THE EXPENSE OF SOLVING THE PROBLEM IS MONITORED BY COUNTING THE
  !  NUMBER OF  STEPS ATTEMPTED. WHEN THIS EXCEEDS  MAXNUM, THE COUNTER
  !  IS RESET TO ZERO AND THE USER IS INFORMED ABOUT POSSIBLE EXCESSIVE
  !  WORK.
  !
  INTEGER, PARAMETER :: maxnum = 500
  !
  !.......................................................................
  !
  !* FIRST EXECUTABLE STATEMENT  DDES
  IF ( Info(1)==0 ) THEN
    !
    ! ON THE FIRST CALL, PERFORM INITIALIZATION --
    !        DEFINE THE MACHINE UNIT ROUNDOFF QUANTITY  U  BY CALLING THE
    !        FUNCTION ROUTINE  D1MACH. THE USER MUST MAKE SURE THAT THE
    !        VALUES SET IN D1MACH ARE RELEVANT TO THE COMPUTER BEING USED.
    !
    u = D1MACH(4)
    !                       -- SET ASSOCIATED MACHINE DEPENDENT PARAMETERS
    Twou = 2.D0*u
    Fouru = 4.D0*u
    !                       -- SET TERMINATION FLAG
    Iquit = 0
    !                       -- SET INITIALIZATION INDICATOR
    Init = 0
    !                       -- SET COUNTER FOR ATTEMPTED STEPS
    Ksteps = 0
    !                       -- SET INDICATOR FOR INTERMEDIATE-OUTPUT
    Intout = .FALSE.
    !                       -- SET INDICATOR FOR STIFFNESS DETECTION
    Stiff = .FALSE.
    !                       -- SET STEP COUNTER FOR STIFFNESS DETECTION
    Kle4 = 0
    !                       -- SET INDICATORS FOR STEPS CODE
    Start = .TRUE.
    Phase1 = .TRUE.
    Nornd = .TRUE.
    !                       -- RESET INFO(1) FOR SUBSEQUENT CALLS
    Info(1) = 1
  END IF
  !
  !.......................................................................
  !
  !      CHECK VALIDITY OF INPUT PARAMETERS ON EACH ENTRY
  !
  IF ( Info(1)/=0.AND.Info(1)/=1 ) THEN
    WRITE (xern1,'(I8)') Info(1)
    CALL XERMSG('SLATEC','DDES','IN DDEABM, INFO(1) MUST BE SET TO 0 FOR THE&
      & START OF A NEW PROBLEM, AND MUST BE SET TO 1 FOLLOWING AN INTERRUPTED TASK.&
      & YOU ARE ATTEMPTING TO CONTINUE THE INTEGRATION ILLEGALLY BY CALLING&
      & THE CODE WITH INFO(1) = '//xern1,3,1)
    Idid = -33
  END IF
  !
  IF ( Info(2)/=0.AND.Info(2)/=1 ) THEN
    WRITE (xern1,'(I8)') Info(2)
    CALL XERMSG('SLATEC','DDES','IN DDEABM, INFO(2) MUST BE 0 OR 1 INDICATING&
      & SCALAR AND VECTOR ERROR TOLERANCES, RESPECTIVELY.&
      & YOU HAVE CALLED THE CODE WITH INFO(2) = '//xern1,4,1)
    Idid = -33
  END IF
  !
  IF ( Info(3)/=0.AND.Info(3)/=1 ) THEN
    WRITE (xern1,'(I8)') Info(3)
    CALL XERMSG('SLATEC','DDES','IN DDEABM, INFO(3) MUST BE 0 OR 1 INDICATING&
      & THE INTERVAL OR INTERMEDIATE-OUTPUT MODE OF INTEGRATION, RESPECTIVELY.&
      & YOU HAVE CALLED THE CODE WITH  INFO(3) = '//xern1,5,1)
    Idid = -33
  END IF
  !
  IF ( Info(4)/=0.AND.Info(4)/=1 ) THEN
    WRITE (xern1,'(I8)') Info(4)
    CALL XERMSG('SLATEC','DDES','IN DDEABM, INFO(4) MUST BE 0 OR 1 INDICATING&
      & WHETHER OR NOT THE INTEGRATION INTERVAL IS TO BE RESTRICTED BY A POINT TSTOP.&
      & YOU HAVE CALLED THE CODE WITH INFO(4) = '//xern1,14,1)
    Idid = -33
  END IF
  !
  IF ( Neq<1 ) THEN
    WRITE (xern1,'(I8)') Neq
    CALL XERMSG('SLATEC','DDES','IN DDEABM,  THE NUMBER OF EQUATIONS NEQ&
      & MUST BE A POSITIVE INTEGER.  YOU HAVE CALLED THE CODE WITH  NEQ = '//xern1,6,1)
    Idid = -33
  END IF
  !
  nrtolp = 0
  natolp = 0
  DO k = 1, Neq
    IF ( nrtolp==0.AND.Rtol(k)<0.D0 ) THEN
      WRITE (xern1,'(I8)') k
      WRITE (xern3,'(1PE15.6)') Rtol(k)
      CALL XERMSG('SLATEC','DDES','IN DDEABM, THE RELATIVE ERROR TOLERANCES RTOL&
        & MUST BE NON-NEGATIVE.  YOU HAVE CALLED THE CODE WITH  RTOL('//xern1//') = '&
        //xern3//'.  IN THE CASE OF VECTOR ERROR TOLERANCES, NO FURTHER&
        & CHECKING OF RTOL COMPONENTS IS DONE.',7,1)
      Idid = -33
      nrtolp = 1
    END IF
    !
    IF ( natolp==0.AND.Atol(k)<0.D0 ) THEN
      WRITE (xern1,'(I8)') k
      WRITE (xern3,'(1PE15.6)') Atol(k)
      CALL XERMSG('SLATEC','DDES','IN DDEABM, THE ABSOLUTE ERROR TOLERANCES ATOL&
        & MUST BE NON-NEGATIVE.  YOU HAVE CALLED THE CODE WITH  ATOL('//xern1//') = '&
        //xern3//'.  IN THE CASE OF VECTOR ERROR TOLERANCES, NO FURTHER CHECKING&
        & OF ATOL COMPONENTS IS DONE.',8,1)
      Idid = -33
      natolp = 1
    END IF
    !
    IF ( Info(2)==0 ) EXIT
    IF ( natolp>0.AND.nrtolp>0 ) EXIT
  END DO
  !
  IF ( Info(4)==1 ) THEN
    IF ( SIGN(1.D0,Tout-T)/=SIGN(1.D0,Tstop-T).OR.ABS(Tout-T)>ABS(Tstop-T) ) THEN
      WRITE (xern3,'(1PE15.6)') Tout
      WRITE (xern4,'(1PE15.6)') Tstop
      CALL XERMSG('SLATEC','DDES','IN DDEABM, YOU HAVE CALLED THE CODE WITH  TOUT = '&
        //xern3//' BUT YOU HAVE ALSO TOLD THE CODE (INFO(4) = 1) NOT TO&
        & INTEGRATE PAST THE POINT TSTOP = '//xern4//' THESE INSTRUCTIONS CONFLICT.',14,1)
      Idid = -33
    END IF
  END IF
  !
  !     CHECK SOME CONTINUATION POSSIBILITIES
  !
  IF ( Init/=0 ) THEN
    IF ( T==Tout ) THEN
      WRITE (xern3,'(1PE15.6)') T
      CALL XERMSG('SLATEC','DDES','IN DDEABM, YOU HAVE CALLED THE CODE WITH  T = TOUT = '//xern3//&
        '$$THIS IS NOT ALLOWED ON CONTINUATION CALLS.',9,1)
      Idid = -33
    END IF
    !
    IF ( T/=Told ) THEN
      WRITE (xern3,'(1PE15.6)') Told
      WRITE (xern4,'(1PE15.6)') T
      CALL XERMSG('SLATEC','DDES','IN DDEABM, YOU HAVE CHANGED THE VALUE OF T FROM '//xern3//' TO '//xern4//&
        '  THIS IS NOT ALLOWED ON CONTINUATION CALLS.',10,1)
      Idid = -33
    END IF
    !
    IF ( Init/=1 ) THEN
      IF ( Delsgn*(Tout-T)<0.D0 ) THEN
        WRITE (xern3,'(1PE15.6)') Tout
        CALL XERMSG('SLATEC','DDES','IN DDEABM, BY CALLING THE CODE WITH TOUT = '//xern3//&
          ' YOU ARE ATTEMPTING TO CHANGE THE DIRECTION OF INTEGRATION.$$THIS IS NOT ALLOWED WITHOUT RESTARTING.',11,1)
        Idid = -33
      END IF
    END IF
  END IF
  !
  !     INVALID INPUT DETECTED
  !
  IF ( Idid==(-33) ) THEN
    IF ( Iquit/=(-33) ) THEN
      Iquit = -33
      Info(1) = -1
    ELSE
      CALL XERMSG('SLATEC','DDES','IN DDEABM, INVALID INPUT WAS DETECTED ON&
        & SUCCESSIVE ENTRIES. IT IS IMPOSSIBLE TO PROCEED BECAUSE YOU HAVE NOT&
        & CORRECTED THE PROBLEM, SO EXECUTION IS BEING TERMINATED.',12,2)
    END IF
    RETURN
  END IF
  !
  !.......................................................................
  !
  !     RTOL = ATOL = 0. IS ALLOWED AS VALID INPUT AND INTERPRETED AS
  !     ASKING FOR THE MOST ACCURATE SOLUTION POSSIBLE. IN THIS CASE,
  !     THE RELATIVE ERROR TOLERANCE RTOL IS RESET TO THE SMALLEST VALUE
  !     FOURU WHICH IS LIKELY TO BE REASONABLE FOR THIS METHOD AND MACHINE
  !
  DO k = 1, Neq
    IF ( Rtol(k)+Atol(k)<=0.D0 ) THEN
      Rtol(k) = Fouru
      Idid = -2
    END IF
    IF ( Info(2)==0 ) EXIT
  END DO
  !
  IF ( Idid/=(-2) ) THEN
    !
    !     BRANCH ON STATUS OF INITIALIZATION INDICATOR
    !            INIT=0 MEANS INITIAL DERIVATIVES AND NOMINAL STEP SIZE
    !                   AND DIRECTION NOT YET SET
    !            INIT=1 MEANS NOMINAL STEP SIZE AND DIRECTION NOT YET SET
    !            INIT=2 MEANS NO FURTHER INITIALIZATION REQUIRED
    !
    IF ( Init==0 ) THEN
      !
      !.......................................................................
      !
      !     MORE INITIALIZATION --
      !                         -- EVALUATE INITIAL DERIVATIVES
      !
      Init = 1
      a = T
      CALL DF(a,Y,Yp,Rpar,Ipar)
      IF ( T==Tout ) THEN
        Idid = 2
        DO l = 1, Neq
          Ypout(l) = Yp(l)
        END DO
        Told = T
        RETURN
      END IF
    ELSEIF ( Init/=1 ) THEN
      GOTO 100
    END IF
    !
    !                         -- SET INDEPENDENT AND DEPENDENT VARIABLES
    !                                              X AND YY(*) FOR STEPS
    !                         -- SET SIGN OF INTEGRATION DIRECTION
    !                         -- INITIALIZE THE STEP SIZE
    !
    Init = 2
    X = T
    DO l = 1, Neq
      Yy(l) = Y(l)
    END DO
    Delsgn = SIGN(1.0D0,Tout-T)
    H = SIGN(MAX(Fouru*ABS(X),ABS(Tout-X)),Tout-X)
  ELSE
    !                       RTOL=ATOL=0 ON INPUT, SO RTOL IS CHANGED TO A
    !                                                SMALL POSITIVE VALUE
    Info(1) = -1
    RETURN
  END IF
  !
  !.......................................................................
  !
  !   ON EACH CALL SET INFORMATION WHICH DETERMINES THE ALLOWED INTERVAL
  !   OF INTEGRATION BEFORE RETURNING WITH AN ANSWER AT TOUT
  !
  100  del = Tout - T
  absdel = ABS(del)
  !
  !.......................................................................
  !
  !   IF ALREADY PAST OUTPUT POINT, INTERPOLATE AND RETURN
  !
  DO WHILE ( ABS(X-T)<absdel )
    !
    !   IF CANNOT GO PAST TSTOP AND SUFFICIENTLY CLOSE,
    !   EXTRAPOLATE AND RETURN
    !
    IF ( Info(4)==1 ) THEN
      IF ( ABS(Tstop-X)<Fouru*ABS(X) ) THEN
        dt = Tout - X
        DO l = 1, Neq
          Y(l) = Yy(l) + dt*Yp(l)
        END DO
        CALL DF(Tout,Y,Ypout,Rpar,Ipar)
        Idid = 3
        T = Tout
        Told = T
        RETURN
      END IF
    END IF
    !
    IF ( .NOT.(Info(3)==0.OR..NOT.Intout) ) THEN
      !
      !   INTERMEDIATE-OUTPUT MODE
      !
      Idid = 1
      DO l = 1, Neq
        Y(l) = Yy(l)
        Ypout(l) = Yp(l)
      END DO
      T = X
      Told = T
      Intout = .FALSE.
      RETURN
      !
      !.......................................................................
      !
      !     MONITOR NUMBER OF STEPS ATTEMPTED
      !
    ELSEIF ( Ksteps<=maxnum ) THEN
      !
      !.......................................................................
      !
      !   LIMIT STEP SIZE, SET WEIGHT VECTOR AND TAKE A STEP
      !
      ha = ABS(H)
      IF ( Info(4)==1 ) ha = MIN(ha,ABS(Tstop-X))
      H = SIGN(ha,H)
      Eps = 1.0D0
      ltol = 1
      DO l = 1, Neq
        IF ( Info(2)==1 ) ltol = l
        Wt(l) = Rtol(ltol)*ABS(Yy(l)) + Atol(ltol)
        IF ( Wt(l)<=0.0D0 ) GOTO 120
      END DO
      !
      CALL DSTEPS(DF,Neq,Yy,X,H,Eps,Wt,Start,Hold,Kord,Kold,crash,Phi,P,Yp,&
        Psi,Alpha,Beta,Sig,V,W,G,Phase1,Ns,Nornd,Ksteps,Twou,&
        Fouru,Xold,Kprev,Ivc,Iv,Kgi,Gi,Rpar,Ipar)
      !
      !.......................................................................
      !
      IF ( .NOT.crash ) THEN
        !
        !   (STIFFNESS TEST) COUNT NUMBER OF CONSECUTIVE STEPS TAKEN WITH THE
        !   ORDER OF THE METHOD BEING LESS OR EQUAL TO FOUR
        !
        Kle4 = Kle4 + 1
        IF ( Kold>4 ) Kle4 = 0
        IF ( Kle4>=50 ) Stiff = .TRUE.
        Intout = .TRUE.
        CYCLE
      ELSE
        !
        !                       TOLERANCES TOO SMALL
        Idid = -2
        Rtol(1) = Eps*Rtol(1)
        Atol(1) = Eps*Atol(1)
        IF ( Info(2)/=0 ) THEN
          DO l = 2, Neq
            Rtol(l) = Eps*Rtol(l)
            Atol(l) = Eps*Atol(l)
          END DO
        END IF
        GOTO 200
      END IF
      !
      !                       RELATIVE ERROR CRITERION INAPPROPRIATE
      120  Idid = -3
      DO l = 1, Neq
        Y(l) = Yy(l)
        Ypout(l) = Yp(l)
      END DO
      T = X
      Told = T
      Info(1) = -1
      Intout = .FALSE.
      RETURN
    ELSE
      !
      !                       A SIGNIFICANT AMOUNT OF WORK HAS BEEN EXPENDED
      Idid = -1
      Ksteps = 0
      IF ( Stiff ) THEN
        !
        !                       PROBLEM APPEARS TO BE STIFF
        Idid = -4
        Stiff = .FALSE.
        Kle4 = 0
      END IF
      !
      DO l = 1, Neq
        Y(l) = Yy(l)
        Ypout(l) = Yp(l)
      END DO
      T = X
      Told = T
      Info(1) = -1
      Intout = .FALSE.
      RETURN
    END IF
  END DO
  CALL DINTP(X,Yy,Tout,Y,Ypout,Neq,Kold,Phi,Ivc,Iv,Kgi,Gi,Alpha,G,W,Xold,P)
  Idid = 3
  IF ( X==Tout ) THEN
    Idid = 2
    Intout = .FALSE.
  END IF
  T = Tout
  Told = T
  RETURN
  200 CONTINUE
  DO l = 1, Neq
    Y(l) = Yy(l)
    Ypout(l) = Yp(l)
  END DO
  T = X
  Told = T
  Info(1) = -1
  Intout = .FALSE.
  RETURN
END SUBROUTINE DDES
