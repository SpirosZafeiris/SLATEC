!** LSAME
LOGICAL FUNCTION LSAME(Ca,Cb)
  !>
  !  Test two characters to determine if they are the same
  !            letter, except for case.
  !***
  ! **Library:**   SLATEC
  !***
  ! **Category:**  R, N3
  !***
  ! **Type:**      LOGICAL (LSAME-L)
  !***
  ! **Keywords:**  CHARACTER COMPARISON, LEVEL 2 BLAS, LEVEL 3 BLAS
  !***
  ! **Author:**  Hanson, R., (SNLA)
  !           Du Croz, J., (NAG)
  !***
  ! **Description:**
  !
  !  LSAME  tests if CA is the same letter as CB regardless of case.
  !  CB is assumed to be an upper case letter. LSAME returns .TRUE. if
  !  CA is either the same as CB or the equivalent lower case letter.
  !
  !  N.B. This version of the code is correct for both ASCII and EBCDIC
  !       systems.  Installers must modify the routine for other
  !       character-codes.
  !
  !       For CDC systems using 6-12 bit representations, the system-
  !       specific code in comments must be activated.
  !
  !  Parameters
  !  ==========
  !
  !  CA     - CHARACTER*1
  !  CB     - CHARACTER*1
  !           On entry, CA and CB specify characters to be compared.
  !           Unchanged on exit.
  !
  !***
  ! **References:**  (NONE)
  !***
  ! **Routines called:**  (NONE)

  !* REVISION HISTORY  (YYMMDD)
  !   860720  DATE WRITTEN
  !   910606  Modified to meet SLATEC prologue standards.  Only comment
  !           lines were modified.  (BKS)
  !   910607  Modified to handle ASCII and EBCDIC codes.  (WRB)
  !   930201  Tests for equality and equivalence combined.  (RWC and WRB)

  !     .. Scalar Arguments ..
  CHARACTER :: Ca, Cb
  !     .. Intrinsic Functions ..
  INTRINSIC ICHAR
  !     .. Save statement ..
  INTEGER, PARAMETER :: ioff = ICHAR('a') - ICHAR('A')
  !* FIRST EXECUTABLE STATEMENT  LSAME
  !
  !     Test if the characters are equal or equivalent.
  !
  LSAME = (Ca==Cb) .OR. (ICHAR(Ca)-ioff==ICHAR(Cb))
  !
  !
  !  The following comments contain code for CDC systems using 6-12 bit
  !  representations.
  !
  !     .. Parameters ..
  !     INTEGER                ICIRFX
  !     PARAMETER            ( ICIRFX=62 )
  !     .. Scalar Arguments ..
  !     CHARACTER ::            CB
  !     .. Array Arguments ..
  !     CHARACTER ::            CA(*)
  !     .. Local Scalars ..
  !     INTEGER                IVAL
  !     .. Intrinsic Functions ..
  !     INTRINSIC              ICHAR, CHAR
  !     .. Executable Statements ..
  !     INTRINSIC              ICHAR, CHAR
  !
  !     See if the first character in string CA equals string CB.
  !
  !     LSAME = CA(1) .EQ. CB .AND. CA(1) .NE. CHAR(ICIRFX)
  !
  !     IF (LSAME) RETURN
  !
  !     The characters are not identical. Now check them for equivalence.
  !     Look for the 'escape' character, circumflex, followed by the
  !     letter.
  !
  !     IVAL = ICHAR(CA(2))
  !     IF (IVAL.GE.ICHAR('A') .AND. IVAL.LE.ICHAR('Z')) THEN
  !        LSAME = CA(1) .EQ. CHAR(ICIRFX) .AND. CA(2) .EQ. CB
  !     END IF
  !
  !     RETURN
  !
  !     End of LSAME.
  !
END FUNCTION LSAME
