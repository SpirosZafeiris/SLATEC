!*==DCHK53.f90  processed by SPAG 6.72Dc at 10:52 on  6 Feb 2019
!DECK DCHK53
      SUBROUTINE DCHK53(Sname,Eps,Thresh,Nout,Kprint,Fatal,Nidim,Idim,Nalf,Alf,
     &                  Nbet,Bet,Nmax,Ab,Aa,As,Bb,Bs,C,Cc,Cs,Ct,G,W)
      IMPLICIT NONE
!*--DCHK536
!***BEGIN PROLOGUE  DCHK53
!***SUBSIDIARY
!***PURPOSE  Test DSYR2K.
!***LIBRARY   SLATEC (BLAS)
!***KEYWORDS  BLAS, QUICK CHECK SERVICE ROUTINE
!***AUTHOR  Dongarra, J. J., (ANL)
!           Duff, I., (AERE)
!           Du Croz, J., (NAG)
!           Hammarling, S., (NAG)
!***DESCRIPTION
!
!  Quick check for DSYR2K.
!
!  Auxiliary routine for test program for Level 3 Blas.
!***REFERENCES  (NONE)
!***ROUTINES CALLED  DMAKE3, DMMCH, DSYR2K, LDE, LDERES, NUMXER
!***REVISION HISTORY  (YYMMDD)
!   890208  DATE WRITTEN
!   910619  Modified to meet SLATEC code and prologue standards. (BKS)
!***END PROLOGUE  DCHK53
!     .. Parameters ..
      DOUBLE PRECISION ZERO
      PARAMETER (ZERO=0.0D0)
!     .. Scalar Arguments ..
      LOGICAL Fatal
      DOUBLE PRECISION Eps , Thresh
      INTEGER Kprint , Nalf , Nbet , Nidim , Nmax , Nout
      CHARACTER(6) :: Sname
!     .. Array Arguments ..
      DOUBLE PRECISION Aa(Nmax*Nmax) , Ab(2*Nmax*Nmax) , Alf(Nalf) ,
     &                 As(Nmax*Nmax) , Bb(Nmax*Nmax) , Bet(Nbet) , Bs(Nmax*Nmax)
     &                 , C(Nmax,Nmax) , Cc(Nmax*Nmax) , Cs(Nmax*Nmax) , Ct(Nmax)
     &                 , G(Nmax) , W(2*Nmax)
      INTEGER Idim(Nidim)
!     .. Local Scalars ..
      DOUBLE PRECISION alpha , als , beta , bets , err , errmax
      INTEGER i , ia , ib , ict , icu , ik , in , j , jc , jj , jjab , k , ks ,
     &        laa , lbb , lcc , lda , ldas , ldb , ldbs , ldc , ldcs , lj , ma ,
     &        n , na , nargs , nc , nerr , ns
      LOGICAL ftl , null , reset , tran , upper
      CHARACTER :: trans , transs , uplo , uplos
      CHARACTER(2) :: ichu
      CHARACTER(3) :: icht
!     .. Local Arrays ..
      LOGICAL isame(13)
!     .. External Functions ..
      INTEGER NUMXER
      LOGICAL LDE , LDERES
      EXTERNAL LDE , LDERES , NUMXER
!     .. External Subroutines ..
      EXTERNAL DSYR2K , DMAKE3 , DMMCH
!     .. Intrinsic Functions ..
      INTRINSIC ABS , MAX , MIN
!     .. Data statements ..
      DATA ichu/'UL'/ , icht/'NTC'/
!***FIRST EXECUTABLE STATEMENT  DCHK53
      nargs = 12
      nc = 0
      reset = .TRUE.
      errmax = ZERO
!
      DO in = 1 , Nidim
        n = Idim(in)
!        Set LDC to 1 more than minimum value if room.
        ldc = n
        IF ( ldc<Nmax ) ldc = ldc + 1
!        Skip tests if not enough room.
        IF ( ldc<=Nmax ) THEN
          lcc = ldc*n
          null = n<=0
!
          DO ik = 1 , Nidim
            k = Idim(ik)
!
            DO ict = 1 , 3
              trans = icht(ict:ict)
              tran = trans=='T' .OR. trans=='C'
              IF ( tran ) THEN
                ma = k
                na = n
              ELSE
                ma = n
                na = k
              ENDIF
!              Set LDA to 1 more than minimum value if room.
              lda = ma
              IF ( lda<Nmax ) lda = lda + 1
!              Skip tests if not enough room.
              IF ( lda<=Nmax ) THEN
                laa = lda*na
!
!              Generate the matrix A.
!
                IF ( tran ) THEN
                  CALL DMAKE3('GE',' ',' ',ma,na,Ab,2*Nmax,Aa,lda,reset,ZERO)
                ELSE
                  CALL DMAKE3('GE',' ',' ',ma,na,Ab,Nmax,Aa,lda,reset,ZERO)
                ENDIF
!
!              Generate the matrix B.
!
                ldb = lda
                lbb = laa
                IF ( tran ) THEN
                  CALL DMAKE3('GE',' ',' ',ma,na,Ab(k+1),2*Nmax,Bb,ldb,reset,
     &                        ZERO)
                ELSE
                  CALL DMAKE3('GE',' ',' ',ma,na,Ab(k*Nmax+1),Nmax,Bb,ldb,reset,
     &                        ZERO)
                ENDIF
!
                DO icu = 1 , 2
                  uplo = ichu(icu:icu)
                  upper = uplo=='U'
!
                  DO ia = 1 , Nalf
                    alpha = Alf(ia)
!
                    DO ib = 1 , Nbet
                      beta = Bet(ib)
!
!                       Generate the matrix C.
!
                      CALL DMAKE3('SY',uplo,' ',n,n,C,Nmax,Cc,ldc,reset,ZERO)
!
                      nc = nc + 1
!
!                       Save every datum before calling the subroutine.
!
                      uplos = uplo
                      transs = trans
                      ns = n
                      ks = k
                      als = alpha
                      DO i = 1 , laa
                        As(i) = Aa(i)
                      ENDDO
                      ldas = lda
                      DO i = 1 , lbb
                        Bs(i) = Bb(i)
                      ENDDO
                      ldbs = ldb
                      bets = beta
                      DO i = 1 , lcc
                        Cs(i) = Cc(i)
                      ENDDO
                      ldcs = ldc
!
!                       Call the subroutine.
!
                      CALL DSYR2K(uplo,trans,n,k,alpha,Aa,lda,Bb,ldb,beta,Cc,
     &                            ldc)
!
!                       Check if error-exit was taken incorrectly.
!
                      IF ( NUMXER(nerr)/=0 ) THEN
                        IF ( Kprint>=2 ) WRITE (Nout,FMT=99006)
                        Fatal = .TRUE.
                      ENDIF
!
!                       See what data changed inside subroutines.
!
                      isame(1) = uplos==uplo
                      isame(2) = transs==trans
                      isame(3) = ns==n
                      isame(4) = ks==k
                      isame(5) = als==alpha
                      isame(6) = LDE(As,Aa,laa)
                      isame(7) = ldas==lda
                      isame(8) = LDE(Bs,Bb,lbb)
                      isame(9) = ldbs==ldb
                      isame(10) = bets==beta
                      IF ( null ) THEN
                        isame(11) = LDE(Cs,Cc,lcc)
                      ELSE
                        isame(11) = LDERES('SY',uplo,n,n,Cs,Cc,ldc)
                      ENDIF
                      isame(12) = ldcs==ldc
!
!                       If data was incorrectly changed, report and
!                       return.
!
                      DO i = 1 , nargs
                        IF ( .NOT.isame(i) ) THEN
                          Fatal = .TRUE.
                          IF ( Kprint>=2 ) WRITE (Nout,FMT=99002) i
                        ENDIF
                      ENDDO
!
                      ftl = .FALSE.
                      IF ( .NOT.null ) THEN
!
!                          Check the result column by column.
!
                        jjab = 1
                        jc = 1
                        DO j = 1 , n
                          IF ( upper ) THEN
                            jj = 1
                            lj = j
                          ELSE
                            jj = j
                            lj = n - j + 1
                          ENDIF
                          IF ( tran ) THEN
                            DO i = 1 , k
                              W(i) = Ab((j-1)*2*Nmax+k+i)
                              W(k+i) = Ab((j-1)*2*Nmax+i)
                            ENDDO
                            CALL DMMCH('T','N',lj,1,2*k,alpha,Ab(jjab),2*Nmax,W,
     &                                 2*Nmax,beta,C(jj,j),Nmax,Ct,G,Cc(jc),ldc,
     &                                 Eps,err,ftl,Nout,.TRUE.,Kprint)
                          ELSE
                            DO i = 1 , k
                              W(i) = Ab((k+i-1)*Nmax+j)
                              W(k+i) = Ab((i-1)*Nmax+j)
                            ENDDO
                            CALL DMMCH('N','N',lj,1,2*k,alpha,Ab(jj),Nmax,W,
     &                                 2*Nmax,beta,C(jj,j),Nmax,Ct,G,Cc(jc),ldc,
     &                                 Eps,err,ftl,Nout,.TRUE.,Kprint)
                          ENDIF
                          IF ( upper ) THEN
                            jc = jc + ldc
                          ELSE
                            jc = jc + ldc + 1
                            IF ( tran ) jjab = jjab + 2*Nmax
                          ENDIF
                          errmax = MAX(errmax,err)
                        ENDDO
                      ENDIF
                      IF ( ftl ) THEN
                        Fatal = .TRUE.
                        IF ( Kprint>=3 ) THEN
                          WRITE (Nout,FMT=99004) Sname
                          WRITE (Nout,FMT=99005) nc , Sname , uplo , trans , n ,
     &                           k , alpha , lda , ldb , beta , ldc
                        ENDIF
                      ENDIF
!
                    ENDDO
!
                  ENDDO
!
                ENDDO
              ENDIF
!
            ENDDO
!
          ENDDO
        ENDIF
!
      ENDDO
!
!     Report result.
!
      IF ( .NOT.Fatal ) THEN
        IF ( Kprint>=3 ) THEN
          IF ( errmax<Thresh ) THEN
            WRITE (Nout,FMT=99001) Sname , nc
          ELSE
            WRITE (Nout,FMT=99003) Sname , nc , errmax
          ENDIF
        ENDIF
      ENDIF
      RETURN
!
99001 FORMAT (' ',A6,' PASSED THE COMPUTATIONAL TESTS (',I6,' CALL','S)')
99002 FORMAT (' ******* FATAL ERROR - PARAMETER NUMBER ',I2,' WAS CH',
     &        'ANGED INCORRECTLY *******')
99003 FORMAT (' ',A6,' COMPLETED THE COMPUTATIONAL TESTS (',I6,' C','ALLS)',
     &        /' ******* BUT WITH MAXIMUM TEST RATIO',F8.2,' - SUSPECT *******')
99004 FORMAT (' ******* ',A6,' FAILED ON CALL NUMBER:')
99005 FORMAT (1X,I6,': ',A6,'(',2('''',A1,''','),2(I3,','),F4.1,', A,',I3,
     &        ', B,',I3,',',F4.1,', C,',I3,')   ',' .')
99006 FORMAT (' ******* FATAL ERROR - ERROR-EXIT TAKEN ON VALID CALL *',
     &        '******')
!
!     End of DCHK53.
!
      END SUBROUTINE DCHK53
