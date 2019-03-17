!DECK H12
SUBROUTINE H12(Mode,Lpivot,L1,M,U,Iue,Up,C,Ice,Icv,Ncv)
  IMPLICIT NONE
  !***BEGIN PROLOGUE  H12
  !***SUBSIDIARY
  !***PURPOSE  Subsidiary to HFTI, LSEI and WNNLS
  !***LIBRARY   SLATEC
  !***TYPE      SINGLE PRECISION (H12-S, DH12-D)
  !***AUTHOR  (UNKNOWN)
  !***DESCRIPTION
  !
  !     C.L.Lawson and R.J.Hanson, Jet Propulsion Laboratory, 1973 Jun 12
  !     to appear in 'Solving Least Squares Problems', Prentice-Hall, 1974
  !
  !     Construction and/or application of a single
  !     Householder transformation..     Q = I + U*(U**T)/B
  !
  !     MODE    = 1 or 2   to select algorithm  H1  or  H2 .
  !     LPIVOT is the index of the pivot element.
  !     L1,M   If L1 .LE. M   the transformation will be constructed to
  !            zero elements indexed from L1 through M.   If L1 GT. M
  !            THE SUBROUTINE DOES AN IDENTITY TRANSFORMATION.
  !     U(),IUE,UP    On entry to H1 U() contains the pivot vector.
  !                   IUE is the storage increment between elements.
  !                                       On exit from H1 U() and UP
  !                   contain quantities defining the vector U of the
  !                   Householder transformation.   On entry to H2 U()
  !                   and UP should contain quantities previously computed
  !                   by H1.  These will not be modified by H2.
  !     C()    On entry to H1 or H2 C() contains a matrix which will be
  !            regarded as a set of vectors to which the Householder
  !            transformation is to be applied.  On exit C() contains the
  !            set of transformed vectors.
  !     ICE    Storage increment between elements of vectors in C().
  !     ICV    Storage increment between vectors in C().
  !     NCV    Number of vectors in C() to be transformed. If NCV .LE. 0
  !            no operations will be done on C().
  !
  !***SEE ALSO  HFTI, LSEI, WNNLS
  !***ROUTINES CALLED  SAXPY, SDOT, SSWAP
  !***REVISION HISTORY  (YYMMDD)
  !   790101  DATE WRITTEN
  !   890531  Changed all specific intrinsics to generic.  (WRB)
  !   890831  Modified array declarations.  (WRB)
  !   891214  Prologue converted to Version 4.0 format.  (BAB)
  !   900328  Added TYPE section.  (WRB)
  !***END PROLOGUE  H12
  REAL b, C, cl, clinv, one, SDOT, sm, U, ul1m1, Up
  INTEGER i, i2, i3, i4, Ice, Icv, incr, Iue, j, kl1, kl2, klp, &
    L1, l1m1, Lpivot, M, mml1p2, Mode, Ncv
  DIMENSION U(Iue,*), C(*)
  !***FIRST EXECUTABLE STATEMENT  H12
  one = 1.
  !
  IF ( 0>=Lpivot.OR.Lpivot>=L1.OR.L1>M ) RETURN
  cl = ABS(U(1,Lpivot))
  IF ( Mode/=2 ) THEN
    !                            ****** CONSTRUCT THE TRANSFORMATION. ******
    DO j = L1, M
      cl = MAX(ABS(U(1,j)),cl)
    ENDDO
    IF ( cl<=0 ) GOTO 100
    clinv = one/cl
    sm = (U(1,Lpivot)*clinv)**2
    DO j = L1, M
      sm = sm + (U(1,j)*clinv)**2
    ENDDO
    cl = cl*SQRT(sm)
    IF ( U(1,Lpivot)>0 ) cl = -cl
    Up = U(1,Lpivot) - cl
    U(1,Lpivot) = cl
    !            ****** APPLY THE TRANSFORMATION  I+U*(U**T)/B  TO C. ******
    !
  ELSEIF ( cl<=0 ) THEN
    GOTO 100
  ENDIF
  IF ( Ncv<=0 ) RETURN
  b = Up*U(1,Lpivot)
  !                       B  MUST BE NONPOSITIVE HERE.  IF B = 0., RETURN.
  !
  IF ( b<0 ) THEN
    b = one/b
    mml1p2 = M - L1 + 2
    IF ( mml1p2>20 ) THEN
      l1m1 = L1 - 1
      kl1 = 1 + (l1m1-1)*Ice
      kl2 = kl1
      klp = 1 + (Lpivot-1)*Ice
      ul1m1 = U(1,l1m1)
      U(1,l1m1) = Up
      IF ( Lpivot/=l1m1 ) CALL SSWAP(Ncv,C(kl1),Icv,C(klp),Icv)
      DO j = 1, Ncv
        sm = SDOT(mml1p2,U(1,l1m1),Iue,C(kl1),Ice)
        sm = sm*b
        CALL SAXPY(mml1p2,sm,U(1,l1m1),Iue,C(kl1),Ice)
        kl1 = kl1 + Icv
      ENDDO
      U(1,l1m1) = ul1m1
      IF ( Lpivot==l1m1 ) RETURN
      kl1 = kl2
      CALL SSWAP(Ncv,C(kl1),Icv,C(klp),Icv)
      RETURN
    ELSE
      i2 = 1 - Icv + Ice*(Lpivot-1)
      incr = Ice*(L1-Lpivot)
      DO j = 1, Ncv
        i2 = i2 + Icv
        i3 = i2 + incr
        i4 = i3
        sm = C(i2)*Up
        DO i = L1, M
          sm = sm + C(i3)*U(1,i)
          i3 = i3 + Ice
        ENDDO
        IF ( sm/=0 ) THEN
          sm = sm*b
          C(i2) = C(i2) + sm*Up
          DO i = L1, M
            C(i4) = C(i4) + sm*U(1,i)
            i4 = i4 + Ice
          ENDDO
        ENDIF
      ENDDO
    ENDIF
  ENDIF
  100  RETURN
  END SUBROUTINE H12
