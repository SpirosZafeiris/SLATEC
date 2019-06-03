!** DDASLV
SUBROUTINE DDASLV(Neq,Delta,Wm,Iwm)
  !>
  !  Linear system solver for DDASSL.
  !***
  ! **Library:**   SLATEC (DASSL)
  !***
  ! **Type:**      DOUBLE PRECISION (SDASLV-S, DDASLV-D)
  !***
  ! **Author:**  Petzold, Linda R., (LLNL)
  !***
  ! **Description:**
  !-----------------------------------------------------------------------
  !     THIS ROUTINE MANAGES THE SOLUTION OF THE LINEAR
  !     SYSTEM ARISING IN THE NEWTON ITERATION.
  !     MATRICES AND REAL TEMPORARY STORAGE AND
  !     REAL INFORMATION ARE STORED IN THE ARRAY WM.
  !     INTEGER MATRIX INFORMATION IS STORED IN
  !     THE ARRAY IWM.
  !     FOR A DENSE MATRIX, THE LINPACK ROUTINE
  !     DGESL IS CALLED.
  !     FOR A BANDED MATRIX,THE LINPACK ROUTINE
  !     DGBSL IS CALLED.
  !-----------------------------------------------------------------------
  !***
  ! **Routines called:**  DGBSL, DGESL

  !* REVISION HISTORY  (YYMMDD)
  !   830315  DATE WRITTEN
  !   901009  Finished conversion to SLATEC 4.0 format (F.N.Fritsch)
  !   901019  Merged changes made by C. Ulrich with SLATEC 4.0 format.
  !   901026  Added explicit declarations for all variables and minor
  !           cosmetic changes to prologue.  (FNF)
  USE linear, ONLY : DGBSL, DGESL
  !
  INTEGER :: Neq, Iwm(:)
  REAL(DP) :: Delta(Neq), Wm(Neq)
  !
  INTEGER :: meband, mtype
  INTEGER, PARAMETER :: NPD = 1
  INTEGER, PARAMETER :: LML = 1
  INTEGER, PARAMETER :: LMU = 2
  INTEGER, PARAMETER :: LMTYPE = 4
  INTEGER, PARAMETER :: LIPVT = 21
  !
  !* FIRST EXECUTABLE STATEMENT  DDASLV
  mtype = Iwm(LMTYPE)
  SELECT CASE (mtype)
    CASE (3)
      !
      !     DUMMY SECTION FOR MTYPE=3
      RETURN
    CASE (4,5)
      !
      !     BANDED MATRIX
      meband = 2*Iwm(LML) + Iwm(LMU) + 1
      CALL DGBSL(Wm(NPD),meband,Neq,Iwm(LML),Iwm(LMU),Iwm(LIPVT:),Delta,0)
      RETURN
    CASE DEFAULT
  END SELECT
  !
  !     DENSE MATRIX
  CALL DGESL(Wm(NPD),Neq,Neq,Iwm(LIPVT:),Delta,0)
  RETURN
  !------END OF SUBROUTINE DDASLV------
  RETURN
END SUBROUTINE DDASLV
