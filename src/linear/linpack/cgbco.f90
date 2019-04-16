!** CGBCO
SUBROUTINE CGBCO(Abd,Lda,N,Ml,Mu,Ipvt,Rcond,Z)
  !>
  !***
  !  Factor a band matrix by Gaussian elimination and
  !            estimate the condition number of the matrix.
  !***
  ! **Library:**   SLATEC (LINPACK)
  !***
  ! **Category:**  D2C2
  !***
  ! **Type:**      COMPLEX (SGBCO-S, DGBCO-D, CGBCO-C)
  !***
  ! **Keywords:**  BANDED, CONDITION NUMBER, LINEAR ALGEBRA, LINPACK,
  !             MATRIX FACTORIZATION
  !***
  ! **Author:**  Moler, C. B., (U. of New Mexico)
  !***
  ! **Description:**
  !
  !     CGBCO factors a complex band matrix by Gaussian
  !     elimination and estimates the condition of the matrix.
  !
  !     If  RCOND  is not needed, CGBFA is slightly faster.
  !     To solve  A*X = B, follow CGBCO by CGBSL.
  !     To compute  INVERSE(A)*C, follow CGBCO by CGBSL.
  !     To compute  DETERMINANT(A), follow CGBCO by CGBDI.
  !
  !     On Entry
  !
  !        ABD     COMPLEX(LDA, N)
  !                contains the matrix in band storage.  The columns
  !                of the matrix are stored in the columns of  ABD  and
  !                the diagonals of the matrix are stored in rows
  !                ML+1 through 2*ML+MU+1 of  ABD .
  !                See the comments below for details.
  !
  !        LDA     INTEGER
  !                the leading dimension of the array  ABD .
  !                LDA must be .GE. 2*ML + MU + 1 .
  !
  !        N       INTEGER
  !                the order of the original matrix.
  !
  !        ML      INTEGER
  !                number of diagonals below the main diagonal.
  !                0 .LE. ML .LT. N .
  !
  !        MU      INTEGER
  !                number of diagonals above the main diagonal.
  !                0 .LE. MU .LT. N .
  !                More efficient if  ML .LE. MU .
  !
  !     On Return
  !
  !        ABD     an upper triangular matrix in band storage and
  !                the multipliers which were used to obtain it.
  !                The factorization can be written  A = L*U  where
  !                L  is a product of permutation and unit lower
  !                triangular matrices and  U  is upper triangular.
  !
  !        IPVT    INTEGER(N)
  !                an integer vector of pivot indices.
  !
  !        RCOND   REAL
  !                an estimate of the reciprocal condition of  A .
  !                For the system  A*X = B, relative perturbations
  !                in  A  And  B  of size  EPSILON  may cause
  !                relative perturbations in  X  of size  EPSILON/RCOND .
  !                If  RCOND  is so small that the logical expression
  !                           1.0 + RCOND .EQ. 1.0
  !                is true, then  A  may be singular to working
  !                precision.  In particular,  RCOND  is zero  if
  !                exact singularity is detected or the estimate
  !                underflows.
  !
  !        Z       COMPLEX(N)
  !                a work vector whose contents are usually unimportant.
  !                If  A  is close to a singular matrix, then  Z  is
  !                an approximate null vector in the sense that
  !                NORM(A*Z) = RCOND*NORM(A)*NORM(Z) .
  !
  !     Band Storage
  !
  !           if  A  is a band matrix, the following program segment
  !           will set up the input.
  !
  !                   ML = (band width below the diagonal)
  !                   MU = (band width above the diagonal)
  !                   M = ML + MU + 1
  !                   DO 20 J = 1, N
  !                      I1 = MAX(1, J-MU)
  !                      I2 = MIN(N, J+Ml)
  !                      DO 10 I = I1, I2
  !                         K = I - J + M
  !                         ABD(K,J) = A(I,J)
  !                10    CONTINUE
  !                20 CONTINUE
  !
  !           This uses rows  ML+1  through  2*ML+MU+1  of  ABD .
  !           In addition, the first  ML  rows in  ABD  are used for
  !           elements generated during the triangularization.
  !           The total number of rows needed in  ABD  is  2*ML+MU+1 .
  !           The  ML+MU by ML+MU  upper left triangle and the
  !           ML by ML  lower right triangle are not referenced.
  !
  !     Example:  If the original matrix is
  !
  !           11 12 13  0  0  0
  !           21 22 23 24  0  0
  !            0 32 33 34 35  0
  !            0  0 43 44 45 46
  !            0  0  0 54 55 56
  !            0  0  0  0 65 66
  !
  !      then  N = 6, ML = 1, MU = 2, LDA .GE. 5  and ABD should contain
  !
  !            *  *  *  +  +  + , * = not used
  !            *  * 13 24 35 46 , + = used for pivoting
  !            * 12 23 34 45 56
  !           11 22 33 44 55 66
  !           21 32 43 54 65  *
  !
  !***
  ! **References:**  J. J. Dongarra, J. R. Bunch, C. B. Moler, and G. W.
  !                 Stewart, LINPACK Users' Guide, SIAM, 1979.
  !***
  ! **Routines called:**  CAXPY, CDOTC, CGBFA, CSSCAL, SCASUM

  !* REVISION HISTORY  (YYMMDD)
  !   780814  DATE WRITTEN
  !   890531  Changed all specific intrinsics to generic.  (WRB)
  !   890831  Modified array declarations.  (WRB)
  !   890831  REVISION DATE from Version 3.2
  !   891214  Prologue converted to Version 4.0 format.  (BAB)
  !   900326  Removed duplicate information from DESCRIPTION section.
  !           (WRB)
  !   920501  Reformatted the REFERENCES section.  (WRB)

  INTEGER Lda, N, Ml, Mu, Ipvt(*)
  COMPLEX Abd(Lda,*), Z(*)
  REAL Rcond
  !
  COMPLEX ek, t, wk, wkm
  REAL anorm, s, sm, ynorm
  INTEGER is, info, j, ju, k, kb, kp1, l, la, lm, lz, m, mm
  !
  !     COMPUTE 1-NORM OF A
  !
  !* FIRST EXECUTABLE STATEMENT  CGBCO
  anorm = 0.0E0
  l = Ml + 1
  is = l + Mu
  DO j = 1, N
    anorm = MAX(anorm,SCASUM(l,Abd(is,j),1))
    IF ( is>Ml+1 ) is = is - 1
    IF ( j<=Mu ) l = l + 1
    IF ( j>=N-Ml ) l = l - 1
  END DO
  !
  !     FACTOR
  !
  CALL CGBFA(Abd,Lda,N,Ml,Mu,Ipvt,info)
  !
  !     RCOND = 1/(NORM(A)*(ESTIMATE OF NORM(INVERSE(A)))) .
  !     ESTIMATE = NORM(Z)/NORM(Y) WHERE  A*Z = Y  AND  CTRANS(A)*Y = E .
  !     CTRANS(A)  IS THE CONJUGATE TRANSPOSE OF A .
  !     THE COMPONENTS OF  E  ARE CHOSEN TO CAUSE MAXIMUM LOCAL
  !     GROWTH IN THE ELEMENTS OF W  WHERE  CTRANS(U)*W = E .
  !     THE VECTORS ARE FREQUENTLY RESCALED TO AVOID OVERFLOW.
  !
  !     SOLVE CTRANS(U)*W = E
  !
  ek = (1.0E0,0.0E0)
  DO j = 1, N
    Z(j) = (0.0E0,0.0E0)
  END DO
  m = Ml + Mu + 1
  ju = 0
  DO k = 1, N
    IF ( CABS1(Z(k))/=0.0E0 ) ek = CSIGN1(ek,-Z(k))
    IF ( CABS1(ek-Z(k))>CABS1(Abd(m,k)) ) THEN
      s = CABS1(Abd(m,k))/CABS1(ek-Z(k))
      CALL CSSCAL(N,s,Z,1)
      ek = CMPLX(s,0.0E0)*ek
    END IF
    wk = ek - Z(k)
    wkm = -ek - Z(k)
    s = CABS1(wk)
    sm = CABS1(wkm)
    IF ( CABS1(Abd(m,k))==0.0E0 ) THEN
      wk = (1.0E0,0.0E0)
      wkm = (1.0E0,0.0E0)
    ELSE
      wk = wk/CONJG(Abd(m,k))
      wkm = wkm/CONJG(Abd(m,k))
    END IF
    kp1 = k + 1
    ju = MIN(MAX(ju,Mu+Ipvt(k)),N)
    mm = m
    IF ( kp1<=ju ) THEN
      DO j = kp1, ju
        mm = mm - 1
        sm = sm + CABS1(Z(j)+wkm*CONJG(Abd(mm,j)))
        Z(j) = Z(j) + wk*CONJG(Abd(mm,j))
        s = s + CABS1(Z(j))
      END DO
      IF ( s<sm ) THEN
        t = wkm - wk
        wk = wkm
        mm = m
        DO j = kp1, ju
          mm = mm - 1
          Z(j) = Z(j) + t*CONJG(Abd(mm,j))
        END DO
      END IF
    END IF
    Z(k) = wk
  END DO
  s = 1.0E0/SCASUM(N,Z,1)
  CALL CSSCAL(N,s,Z,1)
  !
  !     SOLVE CTRANS(L)*Y = W
  !
  DO kb = 1, N
    k = N + 1 - kb
    lm = MIN(Ml,N-k)
    IF ( k<N ) Z(k) = Z(k) + CDOTC(lm,Abd(m+1,k),1,Z(k+1),1)
    IF ( CABS1(Z(k))>1.0E0 ) THEN
      s = 1.0E0/CABS1(Z(k))
      CALL CSSCAL(N,s,Z,1)
    END IF
    l = Ipvt(k)
    t = Z(l)
    Z(l) = Z(k)
    Z(k) = t
  END DO
  s = 1.0E0/SCASUM(N,Z,1)
  CALL CSSCAL(N,s,Z,1)
  !
  ynorm = 1.0E0
  !
  !     SOLVE L*V = Y
  !
  DO k = 1, N
    l = Ipvt(k)
    t = Z(l)
    Z(l) = Z(k)
    Z(k) = t
    lm = MIN(Ml,N-k)
    IF ( k<N ) CALL CAXPY(lm,t,Abd(m+1,k),1,Z(k+1),1)
    IF ( CABS1(Z(k))>1.0E0 ) THEN
      s = 1.0E0/CABS1(Z(k))
      CALL CSSCAL(N,s,Z,1)
      ynorm = s*ynorm
    END IF
  END DO
  s = 1.0E0/SCASUM(N,Z,1)
  CALL CSSCAL(N,s,Z,1)
  ynorm = s*ynorm
  !
  !     SOLVE  U*Z = W
  !
  DO kb = 1, N
    k = N + 1 - kb
    IF ( CABS1(Z(k))>CABS1(Abd(m,k)) ) THEN
      s = CABS1(Abd(m,k))/CABS1(Z(k))
      CALL CSSCAL(N,s,Z,1)
      ynorm = s*ynorm
    END IF
    IF ( CABS1(Abd(m,k))/=0.0E0 ) Z(k) = Z(k)/Abd(m,k)
    IF ( CABS1(Abd(m,k))==0.0E0 ) Z(k) = (1.0E0,0.0E0)
    lm = MIN(k,m) - 1
    la = m - lm
    lz = k - lm
    t = -Z(k)
    CALL CAXPY(lm,t,Abd(la,k),1,Z(lz),1)
  END DO
  !     MAKE ZNORM = 1.0
  s = 1.0E0/SCASUM(N,Z,1)
  CALL CSSCAL(N,s,Z,1)
  ynorm = s*ynorm
  !
  IF ( anorm/=0.0E0 ) Rcond = ynorm/anorm
  IF ( anorm==0.0E0 ) Rcond = 0.0E0
END SUBROUTINE CGBCO
