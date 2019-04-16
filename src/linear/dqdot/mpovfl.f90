!** MPOVFL
SUBROUTINE MPOVFL(X)
  USE MPCOM
  !>
  !***
  !  Subsidiary to DQDOTA and DQDOTI
  !***
  ! **Library:**   SLATEC
  !***
  ! **Type:**      ALL (MPOVFL-A)
  !***
  ! **Author:**  (UNKNOWN)
  !***
  ! **Description:**
  !
  !  Called on multiple-precision overflow, i.e. when the
  !  exponent of 'mp' number X would exceed M.  At present execution is
  !  terminated with an error message after calling MPMAXR(X), but it
  !  would be possible to return, possibly updating a counter and
  !  terminating execution after a preset number of overflows.  Action
  !  could easily be determined by a flag in labelled common.
  !
  !  The argument X(*) is an INTEGER array of size 30.  See the comments
  !  in the routine MPBLAS for the reason for this choice.
  !
  !***
  ! **See also:**  DQDOTA, DQDOTI, MPBLAS
  !***
  ! **Routines called:**  MPCHK, MPERR, MPMAXR
  !***
  ! COMMON BLOCKS    MPCOM

  !* REVISION HISTORY  (YYMMDD)
  !   791001  DATE WRITTEN
  !   ??????  Modified for use with BLAS.  Blank COMMON changed to named
  !           COMMON.  R given dimension 12.
  !   890831  Modified array declarations.  (WRB)
  !   891214  Prologue converted to Version 4.0 format.  (BAB)
  !   900402  Added TYPE section.  (WRB)
  !   930124  Increased Array size in MPCON for SUN -r8.  (RWC)

  INTEGER X(*)
  !* FIRST EXECUTABLE STATEMENT  MPOVFL
  CALL MPCHK(1,4)
  ! SET X TO LARGEST POSSIBLE POSITIVE NUMBER
  CALL MPMAXR(X)
  WRITE (LUN,99001)
  99001 FORMAT (' *** CALL TO MPOVFL, MP OVERFLOW OCCURRED ***')
  ! TERMINATE EXECUTION BY CALLING MPERR
  CALL MPERR
END SUBROUTINE MPOVFL
