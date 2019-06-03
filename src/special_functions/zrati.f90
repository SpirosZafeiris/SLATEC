!** ZRATI
SUBROUTINE ZRATI(Zr,Zi,Fnu,N,Cyr,Cyi,Tol)
  !>
  !  Subsidiary to ZBESH, ZBESI and ZBESK
  !***
  ! **Library:**   SLATEC
  !***
  ! **Type:**      ALL (CRATI-A, ZRATI-A)
  !***
  ! **Author:**  Amos, D. E., (SNL)
  !***
  ! **Description:**
  !
  !     ZRATI COMPUTES RATIOS OF I BESSEL FUNCTIONS BY BACKWARD
  !     RECURRENCE.  THE STARTING INDEX IS DETERMINED BY FORWARD
  !     RECURRENCE AS DESCRIBED IN J. RES. OF NAT. BUR. OF STANDARDS-B,
  !     MATHEMATICAL SCIENCES, VOL 77B, P111-114, SEPTEMBER, 1973,
  !     BESSEL FUNCTIONS I AND J OF COMPLEX ARGUMENT AND INTEGER ORDER,
  !     BY D. J. SOOKNE.
  !
  !***
  ! **See also:**  ZBESH, ZBESI, ZBESK
  !***
  ! **Routines called:**  ZABS, ZDIV

  !* REVISION HISTORY  (YYMMDD)
  !   830501  DATE WRITTEN
  !   910415  Prologue converted to Version 4.0 format.  (BAB)

  INTEGER i, id, idnu, inu, itime, k, kk, magz, N
  REAL(DP) :: ak, amagz, ap1, ap2, arg, az, cdfnui, cdfnur, Cyi(N), Cyr(N), dfnu, &
    fdnu, flam, Fnu, fnup, pti, ptr, p1i, p1r, p2i, p2r, rak, rap1, rho, rzi, &
    rzr, test, test1, Tol, tti, ttr, t1i, t1r, Zi, Zr
  REAL(DP), PARAMETER :: czeror = 0.0D0, czeroi = 0.0D0, coner = 1.0D0, conei = 0.0D0, &
    rt2 = 1.41421356237309505D0
  !* FIRST EXECUTABLE STATEMENT  ZRATI
  az = ZABS(Zr,Zi)
  inu = INT( Fnu )
  idnu = inu + N - 1
  magz = INT( az )
  amagz = magz + 1
  fdnu = idnu
  fnup = MAX(amagz,fdnu)
  id = idnu - magz - 1
  itime = 1
  k = 1
  ptr = 1.0D0/az
  rzr = ptr*(Zr+Zr)*ptr
  rzi = -ptr*(Zi+Zi)*ptr
  t1r = rzr*fnup
  t1i = rzi*fnup
  p2r = -t1r
  p2i = -t1i
  p1r = coner
  p1i = conei
  t1r = t1r + rzr
  t1i = t1i + rzi
  IF ( id>0 ) id = 0
  ap2 = ZABS(p2r,p2i)
  ap1 = ZABS(p1r,p1i)
  !-----------------------------------------------------------------------
  !     THE OVERFLOW TEST ON K(FNU+I-1,Z) BEFORE THE CALL TO CBKNU
  !     GUARANTEES THAT P2 IS ON SCALE. SCALE TEST1 AND ALL SUBSEQUENT
  !     P2 VALUES BY AP1 TO ENSURE THAT AN OVERFLOW DOES NOT OCCUR
  !     PREMATURELY.
  !-----------------------------------------------------------------------
  arg = (ap2+ap2)/(ap1*Tol)
  test1 = SQRT(arg)
  test = test1
  rap1 = 1.0D0/ap1
  p1r = p1r*rap1
  p1i = p1i*rap1
  p2r = p2r*rap1
  p2i = p2i*rap1
  ap2 = ap2*rap1
  DO
    k = k + 1
    ap1 = ap2
    ptr = p2r
    pti = p2i
    p2r = p1r - (t1r*ptr-t1i*pti)
    p2i = p1i - (t1r*pti+t1i*ptr)
    p1r = ptr
    p1i = pti
    t1r = t1r + rzr
    t1i = t1i + rzi
    ap2 = ZABS(p2r,p2i)
    IF ( ap1>test ) THEN
      IF ( itime==2 ) THEN
        kk = k + 1 - id
        ak = kk
        t1r = ak
        t1i = czeroi
        dfnu = Fnu + (N-1)
        p1r = 1.0D0/ap2
        p1i = czeroi
        p2r = czeror
        p2i = czeroi
        DO i = 1, kk
          ptr = p1r
          pti = p1i
          rap1 = dfnu + t1r
          ttr = rzr*rap1
          tti = rzi*rap1
          p1r = (ptr*ttr-pti*tti) + p2r
          p1i = (ptr*tti+pti*ttr) + p2i
          p2r = ptr
          p2i = pti
          t1r = t1r - coner
        END DO
        IF ( p1r==czeror.AND.p1i==czeroi ) THEN
          p1r = Tol
          p1i = Tol
        END IF
        CALL ZDIV(p2r,p2i,p1r,p1i,Cyr(N),Cyi(N))
        IF ( N==1 ) RETURN
        k = N - 1
        ak = k
        t1r = ak
        t1i = czeroi
        cdfnur = Fnu*rzr
        cdfnui = Fnu*rzi
        DO i = 2, N
          ptr = cdfnur + (t1r*rzr-t1i*rzi) + Cyr(k+1)
          pti = cdfnui + (t1r*rzi+t1i*rzr) + Cyi(k+1)
          ak = ZABS(ptr,pti)
          IF ( ak==czeror ) THEN
            ptr = Tol
            pti = Tol
            ak = Tol*rt2
          END IF
          rak = coner/ak
          Cyr(k) = rak*ptr*rak
          Cyi(k) = -rak*pti*rak
          t1r = t1r - coner
          k = k - 1
        END DO
        EXIT
      ELSE
        ak = ZABS(t1r,t1i)*0.5D0
        flam = ak + SQRT(ak*ak-1.0D0)
        rho = MIN(ap2/ap1,flam)
        test = test1*SQRT(rho/(rho*rho-1.0D0))
        itime = 2
      END IF
    END IF
  END DO
END SUBROUTINE ZRATI
