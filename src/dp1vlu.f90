!*==DP1VLU.f90  processed by SPAG 6.72Dc at 11:01 on  6 Feb 2019
!DECK DP1VLU
      SUBROUTINE DP1VLU(L,Nder,X,Yfit,Yp,A)
!***BEGIN PROLOGUE  DP1VLU
!***PURPOSE  Use the coefficients generated by DPOLFT to evaluate the
!            polynomial fit of degree L, along with the first NDER of
!            its derivatives, at a specified point.
!***LIBRARY   SLATEC
!***CATEGORY  K6
!***TYPE      DOUBLE PRECISION (PVALUE-S, DP1VLU-D)
!***KEYWORDS  CURVE FITTING, LEAST SQUARES, POLYNOMIAL APPROXIMATION
!***AUTHOR  Shampine, L. F., (SNLA)
!           Davenport, S. M., (SNLA)
!***DESCRIPTION
!
!     Abstract
!
!     The subroutine  DP1VLU  uses the coefficients generated by  DPOLFT
!     to evaluate the polynomial fit of degree  L , along with the first
!     NDER  of its derivatives, at a specified point.  Computationally
!     stable recurrence relations are used to perform this task.
!
!     The parameters for  DP1VLU  are
!
!     Input -- ALL TYPE REAL variables are DOUBLE PRECISION
!         L -      the degree of polynomial to be evaluated.  L  may be
!                  any non-negative integer which is less than or equal
!                  to  NDEG , the highest degree polynomial provided
!                  by  DPOLFT .
!         NDER -   the number of derivatives to be evaluated.  NDER
!                  may be 0 or any positive value.  If NDER is less
!                  than 0, it will be treated as 0.
!         X -      the argument at which the polynomial and its
!                  derivatives are to be evaluated.
!         A -      work and output array containing values from last
!                  call to  DPOLFT .
!
!     Output -- ALL TYPE REAL variables are DOUBLE PRECISION
!         YFIT -   value of the fitting polynomial of degree  L  at  X
!         YP -     array containing the first through  NDER  derivatives
!                  of the polynomial of degree  L .  YP  must be
!                  dimensioned at least  NDER  in the calling program.
!
!***REFERENCES  L. F. Shampine, S. M. Davenport and R. E. Huddleston,
!                 Curve fitting by polynomials in one variable, Report
!                 SLA-74-0270, Sandia Laboratories, June 1974.
!***ROUTINES CALLED  XERMSG
!***REVISION HISTORY  (YYMMDD)
!   740601  DATE WRITTEN
!   890531  Changed all specific intrinsics to generic.  (WRB)
!   890911  Removed unnecessary intrinsics.  (WRB)
!   891006  Cosmetic changes to prologue.  (WRB)
!   891006  REVISION DATE from Version 3.2
!   891214  Prologue converted to Version 4.0 format.  (BAB)
!   900315  CALLs to XERROR changed to CALLs to XERMSG.  (THJ)
!   900510  Convert XERRWV calls to XERMSG calls.  (RWC)
!   920501  Reformatted the REFERENCES section.  (WRB)
!***END PROLOGUE  DP1VLU
      IMPLICIT NONE
!*--DP1VLU60
      INTEGER i , ic , ilo , in , inp1 , iup , k1 , k1i , k2 , k3 , k3p1 ,
     &        k3pn , k4 , k4p1 , k4pn , kc , L , lm1 , lp1 , maxord , n , Nder ,
     &        ndo , ndp1 , nord
      DOUBLE PRECISION A(*) , cc , dif , val , X , Yfit , Yp(*)
      CHARACTER(8) :: xern1 , xern2
!***FIRST EXECUTABLE STATEMENT  DP1VLU
      IF ( L<0 ) THEN
!
        CALL XERMSG('SLATEC','DP1VLU',
     &              'INVALID INPUT PARAMETER.  ORDER OF POLYNOMIAL EVALUATION '
     &              //'REQUESTED IS NEGATIVE.',2,2)
        GOTO 99999
      ELSE
        ndo = MAX(Nder,0)
        ndo = MIN(ndo,L)
        maxord = A(1) + 0.5D0
        k1 = maxord + 1
        k2 = k1 + maxord
        k3 = k2 + maxord + 2
        nord = A(k3) + 0.5D0
        IF ( L<=nord ) THEN
          k4 = k3 + L + 1
          IF ( Nder>=1 ) THEN
            DO i = 1 , Nder
              Yp(i) = 0.0D0
            ENDDO
          ENDIF
          IF ( L>=2 ) THEN
!
! L IS GREATER THAN 1
!
            ndp1 = ndo + 1
            k3p1 = k3 + 1
            k4p1 = k4 + 1
            lp1 = L + 1
            lm1 = L - 1
            ilo = k3 + 3
            iup = k4 + ndp1
            DO i = ilo , iup
              A(i) = 0.0D0
            ENDDO
            dif = X - A(lp1)
            kc = k2 + lp1
            A(k4p1) = A(kc)
            A(k3p1) = A(kc-1) + dif*A(k4p1)
            A(k3+2) = A(k4p1)
!
! EVALUATE RECURRENCE RELATIONS FOR FUNCTION VALUE AND DERIVATIVES
!
            DO i = 1 , lm1
              in = L - i
              inp1 = in + 1
              k1i = k1 + inp1
              ic = k2 + in
              dif = X - A(inp1)
              val = A(ic) + dif*A(k3p1) - A(k1i)*A(k4p1)
              IF ( ndo>0 ) THEN
                DO n = 1 , ndo
                  k3pn = k3p1 + n
                  k4pn = k4p1 + n
                  Yp(n) = dif*A(k3pn) + n*A(k3pn-1) - A(k1i)*A(k4pn)
                ENDDO
!
! SAVE VALUES NEEDED FOR NEXT EVALUATION OF RECURRENCE RELATIONS
!
                DO n = 1 , ndo
                  k3pn = k3p1 + n
                  k4pn = k4p1 + n
                  A(k4pn) = A(k3pn)
                  A(k3pn) = Yp(n)
                ENDDO
              ENDIF
              A(k4p1) = A(k3p1)
              A(k3p1) = val
            ENDDO
          ELSEIF ( L==1 ) THEN
!
! L IS 1
!
            cc = A(k2+2)
            val = A(k2+1) + (X-A(2))*cc
            IF ( Nder>=1 ) Yp(1) = cc
          ELSE
!
! L IS 0
!
            val = A(k2+1)
          ENDIF
!
! NORMAL RETURN OR ABORT DUE TO ERROR
!
          Yfit = val
          RETURN
        ENDIF
      ENDIF
!
      WRITE (xern1,'(I8)') L
      WRITE (xern2,'(I8)') nord
      CALL XERMSG('SLATEC','DP1VLU','THE ORDER OF POLYNOMIAL EVALUATION, L = '//
     &            xern1//' REQUESTED EXCEEDS THE HIGHEST ORDER FIT, NORD = '//
     &            xern2//', COMPUTED BY DPOLFT -- EXECUTION TERMINATED.',8,2)
      RETURN
99999 END SUBROUTINE DP1VLU
