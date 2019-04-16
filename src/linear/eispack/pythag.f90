!** PYTHAG
REAL FUNCTION PYTHAG(A,B)
  !>
  !***
  !  Compute the complex square root of a complex number without
  !            destructive overflow or underflow.
  !***
  ! **Library:**   SLATEC
  !***
  ! **Type:**      SINGLE PRECISION (PYTHAG-S)
  !***
  ! **Author:**  (UNKNOWN)
  !***
  ! **Description:**
  !
  !     Finds sqrt(A**2+B**2) without overflow or destructive underflow
  !
  !***
  ! **See also:**  EISDOC
  !***
  ! **Routines called:**  (NONE)

  !* REVISION HISTORY  (YYMMDD)
  !   811101  DATE WRITTEN
  !   890531  Changed all specific intrinsics to generic.  (WRB)
  !   891214  Prologue converted to Version 4.0 format.  (BAB)
  !   900402  Added TYPE section.  (WRB)

  REAL A, B
  !
  REAL p, q, r, s, t
  !* FIRST EXECUTABLE STATEMENT  PYTHAG
  p = MAX(ABS(A),ABS(B))
  q = MIN(ABS(A),ABS(B))
  IF ( q==0.0E0 ) THEN
    PYTHAG = p
  ELSE
    DO
      r = (q/p)**2
      t = 4.0E0 + r
      IF ( t==4.0E0 ) THEN
        PYTHAG = p
        EXIT
      ELSE
        s = r/t
        p = p + 2.0E0*p*s
        q = q*s
      END IF
    END DO
  END IF
END FUNCTION PYTHAG
