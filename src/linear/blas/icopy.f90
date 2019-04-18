!** ICOPY
SUBROUTINE ICOPY(N,Ix,Incx,Iy,Incy)
  !>
  !  Copy a vector.
  !***
  ! **Library:**   SLATEC (BLAS)
  !***
  ! **Category:**  D1A5
  !***
  ! **Type:**      INTEGER (ICOPY-S, DCOPY-D, CCOPY-C, ICOPY-I)
  !***
  ! **Keywords:**  BLAS, COPY, LINEAR ALGEBRA, VECTOR
  !***
  ! **Author:**  Boland, W. Robert, (LANL)
  !           Clemens, Reginald, (PLK)
  !***
  ! **Description:**
  !
  !                B L A S  Subprogram
  !    Description of Parameters
  !
  !     --Input--
  !        N  number of elements in input vector(s)
  !       IX  integer vector with N elements
  !     INCX  storage spacing between elements of IX
  !       IY  integer vector with N elements
  !     INCY  storage spacing between elements of IY
  !
  !     --Output--
  !       IY  copy of vector IX (unchanged if N .LE. 0)
  !
  !     Copy integer IX to integer IY.
  !     For I = 0 to N-1, copy  IX(LX+I*INCX) to IY(LY+I*INCY),
  !     where LX = 1 if INCX .GE. 0, else LX = 1+(1-N)*INCX, and LY is
  !     defined in a similar way using INCY.
  !
  !***
  ! **References:**  C. L. Lawson, R. J. Hanson, D. R. Kincaid and F. T.
  !                 Krogh, Basic linear algebra subprograms for Fortran
  !                 usage, Algorithm No. 539, Transactions on Mathematical
  !                 Software 5, 3 (September 1979), pp. 308-323.
  !***
  ! **Routines called:**  (NONE)

  !* REVISION HISTORY  (YYMMDD)
  !   930201  DATE WRITTEN

  INTEGER i, iix, iiy, Incx, Incy, m, mp1, N, ns
  INTEGER Ix(*), Iy(*)
  !* FIRST EXECUTABLE STATEMENT  ICOPY
  IF ( N<=0 ) RETURN
  IF ( Incx==Incy ) THEN
    IF ( Incx<1 ) THEN
    ELSEIF ( Incx==1 ) THEN
      !
      !     Code for both increments equal to 1.
      !
      !     Clean-up loop so remaining vector length is a multiple of 7.
      !
      m = MOD(N,7)
      IF ( m/=0 ) THEN
        DO i = 1, m
          Iy(i) = Ix(i)
        END DO
        IF ( N<7 ) RETURN
      END IF
      GOTO 100
    ELSE
      !
      !     Code for equal, positive, non-unit increments.
      !
      ns = N*Incx
      DO i = 1, ns, Incx
        Iy(i) = Ix(i)
      END DO
      RETURN
    END IF
  END IF
  !
  !     Code for unequal or nonpositive increments.
  !
  iix = 1
  iiy = 1
  IF ( Incx<0 ) iix = (-N+1)*Incx + 1
  IF ( Incy<0 ) iiy = (-N+1)*Incy + 1
  DO i = 1, N
    Iy(iiy) = Ix(iix)
    iix = iix + Incx
    iiy = iiy + Incy
  END DO
  RETURN
  100  mp1 = m + 1
  DO i = mp1, N, 7
    Iy(i) = Ix(i)
    Iy(i+1) = Ix(i+1)
    Iy(i+2) = Ix(i+2)
    Iy(i+3) = Ix(i+3)
    Iy(i+4) = Ix(i+4)
    Iy(i+5) = Ix(i+5)
    Iy(i+6) = Ix(i+6)
  END DO
  RETURN
END SUBROUTINE ICOPY
