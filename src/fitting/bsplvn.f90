!** BSPLVN
SUBROUTINE BSPLVN(T,Jhigh,Index,X,Ileft,Vnikx)
  IMPLICIT NONE
  !>
  !***
  !  Subsidiary to FC
  !***
  ! **Library:**   SLATEC
  !***
  ! **Type:**      SINGLE PRECISION (BSPLVN-S, DFSPVN-D)
  !***
  ! **Author:**  (UNKNOWN)
  !***
  ! **Description:**
  !
  ! Calculates the value of all possibly nonzero B-splines at *X* of
  !  order MAX(JHIGH,(J+1)(INDEX-1)) on *T*.
  !
  !***
  ! **See also:**  FC
  !***
  ! **Routines called:**  (NONE)

  !* REVISION HISTORY  (YYMMDD)
  !   780801  DATE WRITTEN
  !   891214  Prologue converted to Version 4.0 format.  (BAB)
  !   900328  Added TYPE section.  (WRB)

  REAL T(*), vm, vmprev, Vnikx(*), X
  INTEGER Ileft, imjp1, Index, ipj, Jhigh, jp1, jp1ml, l
  INTEGER :: j = 1
  REAL :: deltam(20) = 0., deltap(20) = 0.
  !* FIRST EXECUTABLE STATEMENT  BSPLVN
  IF ( Index/=2 ) THEN
    j = 1
    Vnikx(1) = 1.
    IF ( j>=Jhigh ) RETURN
  ENDIF
  DO
    !
    ipj = Ileft + j
    deltap(j) = T(ipj) - X
    imjp1 = Ileft - j + 1
    deltam(j) = X - T(imjp1)
    vmprev = 0.
    jp1 = j + 1
    DO l = 1, j
      jp1ml = jp1 - l
      vm = Vnikx(l)/(deltap(l)+deltam(jp1ml))
      Vnikx(l) = vm*deltap(l) + vmprev
      vmprev = vm*deltam(jp1ml)
    ENDDO
    Vnikx(jp1) = vmprev
    j = jp1
    IF ( j>=Jhigh ) EXIT
  ENDDO
  !
  RETURN
END SUBROUTINE BSPLVN
