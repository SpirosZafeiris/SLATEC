!** CBESH
SUBROUTINE CBESH(Z,Fnu,Kode,M,N,Cy,Nz,Ierr)
  IMPLICIT NONE
  !>
  !***
  !  Compute a sequence of the Hankel functions H(m,a,z)
  !            for superscript m=1 or 2, real nonnegative orders a=b,
  !            b+1,... where b>0, and nonzero complex argument z.  A
  !            scaling option is available to help avoid overflow.
  !***
  ! **Library:**   SLATEC
  !***
  ! **Category:**  C10A4
  !***
  ! **Type:**      COMPLEX (CBESH-C, ZBESH-C)
  !***
  ! **Keywords:**  BESSEL FUNCTIONS OF COMPLEX ARGUMENT,
  !             BESSEL FUNCTIONS OF THE THIRD KIND, H BESSEL FUNCTIONS,
  !             HANKEL FUNCTIONS
  !***
  ! **Author:**  Amos, D. E., (SNL)
  !***
  ! **Description:**
  !
  !         On KODE=1, CBESH computes an N member sequence of complex
  !         Hankel (Bessel) functions CY(L)=H(M,FNU+L-1,Z) for super-
  !         script M=1 or 2, real nonnegative orders FNU+L-1, L=1,...,
  !         N, and complex nonzero Z in the cut plane -pi<arg(Z)<=pi.
  !         On KODE=2, CBESH returns the scaled functions
  !
  !            CY(L) = H(M,FNU+L-1,Z)*exp(-(3-2*M)*Z*i),  i**2=-1
  !
  !         which removes the exponential behavior in both the upper
  !         and lower half planes.  Definitions and notation are found
  !         in the NBS Handbook of Mathematical Functions (Ref. 1).
  !
  !         Input
  !           Z      - Nonzero argument of type COMPLEX
  !           FNU    - Initial order of type REAL, FNU>=0
  !           KODE   - A parameter to indicate the scaling option
  !                    KODE=1  returns
  !                            CY(L)=H(M,FNU+L-1,Z), L=1,...,N
  !                        =2  returns
  !                            CY(L)=H(M,FNU+L-1,Z)*exp(-(3-2M)*Z*i),
  !                            L=1,...,N
  !           M      - Superscript of Hankel function, M=1 or 2
  !           N      - Number of terms in the sequence, N>=1
  !
  !         Output
  !           CY     - Result vector of type COMPLEX
  !           NZ     - Number of underflows set to zero
  !                    NZ=0    Normal return
  !                    NZ>0    CY(L)=0 for NZ values of L (if M=1 and
  !                            Im(Z)>0 or if M=2 and Im(Z)<0, then
  !                            CY(L)=0 for L=1,...,NZ; in the com-
  !                            plementary half planes, the underflows
  !                            may not be in an uninterrupted sequence)
  !           IERR   - Error flag
  !                    IERR=0  Normal return     - COMPUTATION COMPLETED
  !                    IERR=1  Input error       - NO COMPUTATION
  !                    IERR=2  Overflow          - NO COMPUTATION
  !                            (abs(Z) too small and/or FNU+N-1
  !                            too large)
  !                    IERR=3  Precision warning - COMPUTATION COMPLETED
  !                            (Result has half precision or less
  !                            because abs(Z) or FNU+N-1 is large)
  !                    IERR=4  Precision error   - NO COMPUTATION
  !                            (Result has no precision because
  !                            abs(Z) or FNU+N-1 is too large)
  !                    IERR=5  Algorithmic error - NO COMPUTATION
  !                            (Termination condition not met)
  !
  !- Long Description:
  !
  !         The computation is carried out by the formula
  !
  !            H(m,a,z) = (1/t)*exp(-a*t)*K(a,z*exp(-t))
  !                   t = (3-2*m)*i*pi/2
  !
  !         where the K Bessel function is computed as described in the
  !         prologue to CBESK.
  !
  !         Exponential decay of H(m,a,z) occurs in the upper half z
  !         plane for m=1 and the lower half z plane for m=2.  Exponential
  !         growth occurs in the complementary half planes.  Scaling
  !         by exp(-(3-2*m)*z*i) removes the exponential behavior in the
  !         whole z plane as z goes to infinity.
  !
  !         For negative orders, the formula
  !
  !            H(m,-a,z) = H(m,a,z)*exp((3-2*m)*a*pi*i)
  !
  !         can be used.
  !
  !         In most complex variable computation, one must evaluate ele-
  !         mentary functions.  When the magnitude of Z or FNU+N-1 is
  !         large, losses of significance by argument reduction occur.
  !         Consequently, if either one exceeds U1=SQRT(0.5/UR), then
  !         losses exceeding half precision are likely and an error flag
  !         IERR=3 is triggered where UR=R1MACH(4)=UNIT ROUNDOFF.  Also,
  !         if either is larger than U2=0.5/UR, then all significance is
  !         lost and IERR=4.  In order to use the INT function, arguments
  !         must be further restricted not to exceed the largest machine
  !         integer, U3=I1MACH(9).  Thus, the magnitude of Z and FNU+N-1
  !         is restricted by MIN(U2,U3).  In IEEE arithmetic, U1,U2, and
  !         U3 approximate 2.0E+3, 4.2E+6, 2.1E+9 in single precision
  !         and 4.7E+7, 2.3E+15 and 2.1E+9 in double precision.  This
  !         makes U2 limiting in single precision and U3 limiting in
  !         double precision.  This means that one can expect to retain,
  !         in the worst cases on IEEE machines, no digits in single pre-
  !         cision and only 6 digits in double precision.  Similar con-
  !         siderations hold for other machines.
  !
  !         The approximate relative error in the magnitude of a complex
  !         Bessel function can be expressed as P*10**S where P=MAX(UNIT
  !         ROUNDOFF,1.0E-18) is the nominal precision and 10**S repre-
  !         sents the increase in error due to argument reduction in the
  !         elementary functions.  Here, S=MAX(1,ABS(LOG10(ABS(Z))),
  !         ABS(LOG10(FNU))) approximately (i.e., S=MAX(1,ABS(EXPONENT OF
  !         ABS(Z),ABS(EXPONENT OF FNU)) ).  However, the phase angle may
  !         have only absolute accuracy.  This is most likely to occur
  !         when one component (in magnitude) is larger than the other by
  !         several orders of magnitude.  If one component is 10**K larger
  !         than the other, then one can expect only MAX(ABS(LOG10(P))-K,
  !         0) significant digits; or, stated another way, when K exceeds
  !         the exponent of P, no significant digits remain in the smaller
  !         component.  However, the phase angle retains absolute accuracy
  !         because, in complex arithmetic with precision P, the smaller
  !         component will not (as a rule) decrease below P times the
  !         magnitude of the larger component.  In these extreme cases,
  !         the principal phase angle is on the order of +P, -P, PI/2-P,
  !         or -PI/2+P.
  !
  !***
  ! **References:**  1. M. Abramowitz and I. A. Stegun, Handbook of Mathe-
  !                 matical Functions, National Bureau of Standards
  !                 Applied Mathematics Series 55, U. S. Department
  !                 of Commerce, Tenth Printing (1972) or later.
  !               2. D. E. Amos, Computation of Bessel Functions of
  !                 Complex Argument, Report SAND83-0086, Sandia National
  !                 Laboratories, Albuquerque, NM, May 1983.
  !               3. D. E. Amos, Computation of Bessel Functions of
  !                 Complex Argument and Large Order, Report SAND83-0643,
  !                 Sandia National Laboratories, Albuquerque, NM, May
  !                 1983.
  !               4. D. E. Amos, A Subroutine Package for Bessel Functions
  !                 of a Complex Argument and Nonnegative Order, Report
  !                 SAND85-1018, Sandia National Laboratory, Albuquerque,
  !                 NM, May 1985.
  !               5. D. E. Amos, A portable package for Bessel functions
  !                 of a complex argument and nonnegative order, ACM
  !                 Transactions on Mathematical Software, 12 (September
  !                 1986), pp. 265-273.
  !
  !***
  ! **Routines called:**  CACON, CBKNU, CBUNK, CUOIK, I1MACH, R1MACH

  !* REVISION HISTORY  (YYMMDD)
  !   830501  DATE WRITTEN
  !   890801  REVISION DATE from Version 3.2
  !   910415  Prologue converted to Version 4.0 format.  (BAB)
  !   920128  Category corrected.  (WRB)
  !   920811  Prologue revised.  (DWL)
  
  !
  INTEGER i, Ierr, inu, inuh, ir, k, Kode, k1, k2, M, mm, mr, &
    N, nn, nuf, nw, Nz, I1MACH
  COMPLEX Cy(N), Z, zn, zt, csgn
  REAL aa, alim, aln, arg, az, cpn, dig, elim, fmm, fn, Fnu, &
    fnul, hpi, rhpi, rl, r1m5, sgn, spn, tol, ufl, xn, xx, &
    yn, yy, R1MACH, bb, ascle, rtol, atol
  !
  DATA hpi/1.57079632679489662E0/
  !
  !* FIRST EXECUTABLE STATEMENT  CBESH
  Nz = 0
  xx = REAL(Z)
  yy = AIMAG(Z)
  Ierr = 0
  IF ( xx==0.0E0.AND.yy==0.0E0 ) Ierr = 1
  IF ( Fnu<0.0E0 ) Ierr = 1
  IF ( M<1.OR.M>2 ) Ierr = 1
  IF ( Kode<1.OR.Kode>2 ) Ierr = 1
  IF ( N<1 ) Ierr = 1
  IF ( Ierr/=0 ) RETURN
  nn = N
  !-----------------------------------------------------------------------
  !     SET PARAMETERS RELATED TO MACHINE CONSTANTS.
  !     TOL IS THE APPROXIMATE UNIT ROUNDOFF LIMITED TO 1.0E-18.
  !     ELIM IS THE APPROXIMATE EXPONENTIAL OVER- AND UNDERFLOW LIMIT.
  !     EXP(-ELIM).LT.EXP(-ALIM)=EXP(-ELIM)/TOL    AND
  !     EXP(ELIM).GT.EXP(ALIM)=EXP(ELIM)*TOL       ARE INTERVALS NEAR
  !     UNDERFLOW AND OVERFLOW LIMITS WHERE SCALED ARITHMETIC IS DONE.
  !     RL IS THE LOWER BOUNDARY OF THE ASYMPTOTIC EXPANSION FOR LARGE Z.
  !     DIG = NUMBER OF BASE 10 DIGITS IN TOL = 10**(-DIG).
  !     FNUL IS THE LOWER BOUNDARY OF THE ASYMPTOTIC SERIES FOR LARGE FNU
  !-----------------------------------------------------------------------
  tol = MAX(R1MACH(4),1.0E-18)
  k1 = I1MACH(12)
  k2 = I1MACH(13)
  r1m5 = R1MACH(5)
  k = MIN(ABS(k1),ABS(k2))
  elim = 2.303E0*(k*r1m5-3.0E0)
  k1 = I1MACH(11) - 1
  aa = r1m5*k1
  dig = MIN(aa,18.0E0)
  aa = aa*2.303E0
  alim = elim + MAX(-aa,-41.45E0)
  fnul = 10.0E0 + 6.0E0*(dig-3.0E0)
  rl = 1.2E0*dig + 3.0E0
  fn = Fnu + (nn-1)
  mm = 3 - M - M
  fmm = mm
  zn = Z*CMPLX(0.0E0,-fmm)
  xn = REAL(zn)
  yn = AIMAG(zn)
  az = ABS(Z)
  !-----------------------------------------------------------------------
  !     TEST FOR RANGE
  !-----------------------------------------------------------------------
  aa = 0.5E0/tol
  bb = I1MACH(9)*0.5E0
  aa = MIN(aa,bb)
  IF ( az>aa ) GOTO 300
  IF ( fn>aa ) GOTO 300
  aa = SQRT(aa)
  IF ( az>aa ) Ierr = 3
  IF ( fn>aa ) Ierr = 3
  !-----------------------------------------------------------------------
  !     OVERFLOW TEST ON THE LAST MEMBER OF THE SEQUENCE
  !-----------------------------------------------------------------------
  ufl = R1MACH(1)*1.0E+3
  IF ( az>=ufl ) THEN
    IF ( Fnu>fnul ) THEN
      !-----------------------------------------------------------------------
      !     UNIFORM ASYMPTOTIC EXPANSIONS FOR FNU.GT.FNUL
      !-----------------------------------------------------------------------
      mr = 0
      IF ( .NOT.((xn>=0.0E0).AND.(xn/=0.0E0.OR.yn>=0.0E0.OR.M/=2)) ) THEN
        mr = -mm
        IF ( xn==0.0E0.AND.yn<0.0E0 ) zn = -zn
      ENDIF
      CALL CBUNK(zn,Fnu,Kode,mr,nn,Cy,nw,tol,elim,alim)
      IF ( nw<0 ) GOTO 200
      Nz = Nz + nw
    ELSE
      IF ( fn>1.0E0 ) THEN
        IF ( fn>2.0E0 ) THEN
          CALL CUOIK(zn,Fnu,Kode,2,nn,Cy,nuf,tol,elim,alim)
          IF ( nuf<0 ) GOTO 100
          Nz = Nz + nuf
          nn = nn - nuf
          !-----------------------------------------------------------------------
          !     HERE NN=N OR NN=0 SINCE NUF=0,NN, OR -1 ON RETURN FROM CUOIK
          !     IF NUF=NN, THEN CY(I)=CZERO FOR ALL I
          !-----------------------------------------------------------------------
          IF ( nn==0 ) THEN
            IF ( xn<0.0E0 ) GOTO 100
            RETURN
          ENDIF
        ELSEIF ( az<=tol ) THEN
          arg = 0.5E0*az
          aln = -fn*ALOG(arg)
          IF ( aln>elim ) GOTO 100
        ENDIF
      ENDIF
      IF ( (xn<0.0E0).OR.(xn==0.0E0.AND.yn<0.0E0.AND.M==2) ) THEN
        !-----------------------------------------------------------------------
        !     LEFT HALF PLANE COMPUTATION
        !-----------------------------------------------------------------------
        mr = -mm
        CALL CACON(zn,Fnu,Kode,mr,nn,Cy,nw,rl,fnul,tol,elim,alim)
        IF ( nw<0 ) GOTO 200
        Nz = nw
      ELSE
        !-----------------------------------------------------------------------
        !     RIGHT HALF PLANE COMPUTATION, XN.GE.0. .AND. (XN.NE.0. .OR.
        !     YN.GE.0. .OR. M=1)
        !-----------------------------------------------------------------------
        CALL CBKNU(zn,Fnu,Kode,nn,Cy,Nz,tol,elim,alim)
      ENDIF
    ENDIF
    !-----------------------------------------------------------------------
    !     H(M,FNU,Z) = -FMM*(I/HPI)*(ZT**FNU)*K(FNU,-Z*ZT)
    !
    !     ZT=EXP(-FMM*HPI*I) = CMPLX(0.0,-FMM), FMM=3-2*M, M=1,2
    !-----------------------------------------------------------------------
    sgn = SIGN(hpi,-fmm)
    !-----------------------------------------------------------------------
    !     CALCULATE EXP(FNU*HPI*I) TO MINIMIZE LOSSES OF SIGNIFICANCE
    !     WHEN FNU IS LARGE
    !-----------------------------------------------------------------------
    inu = INT( Fnu )
    inuh = inu/2
    ir = inu - 2*inuh
    arg = (Fnu-(inu-ir))*sgn
    rhpi = 1.0E0/sgn
    cpn = rhpi*COS(arg)
    spn = rhpi*SIN(arg)
    !     ZN = CMPLX(-SPN,CPN)
    csgn = CMPLX(-spn,cpn)
    !     IF (MOD(INUH,2).EQ.1) ZN = -ZN
    IF ( MOD(inuh,2)==1 ) csgn = -csgn
    zt = CMPLX(0.0E0,-fmm)
    rtol = 1.0E0/tol
    ascle = ufl*rtol
    DO i = 1, nn
      !       CY(I) = CY(I)*ZN
      !       ZN = ZN*ZT
      zn = Cy(i)
      aa = REAL(zn)
      bb = AIMAG(zn)
      atol = 1.0E0
      IF ( MAX(ABS(aa),ABS(bb))<=ascle ) THEN
        zn = zn*CMPLX(rtol,0.0E0)
        atol = tol
      ENDIF
      zn = zn*csgn
      Cy(i) = zn*CMPLX(atol,0.0E0)
      csgn = csgn*zt
    ENDDO
    RETURN
  ENDIF
  100  Ierr = 2
  Nz = 0
  RETURN
  200 CONTINUE
  IF ( nw==(-1) ) GOTO 100
  Nz = 0
  Ierr = 5
  RETURN
  300  Nz = 0
  Ierr = 4
END SUBROUTINE CBESH
