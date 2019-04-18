!** INDXA
SUBROUTINE INDXA(I,Ir,Idxa,Na)
  !>
  !***
  !  Subsidiary to BLKTRI
  !***
  ! **Library:**   SLATEC
  !***
  ! **Type:**      INTEGER (INDXA-I)
  !***
  ! **Author:**  (UNKNOWN)
  !***
  ! **See also:**  BLKTRI
  !***
  ! **Routines called:**  (NONE)
  !***
  ! COMMON BLOCKS    CBLKT

  !* REVISION HISTORY  (YYMMDD)
  !   801001  DATE WRITTEN
  !   891214  Prologue converted to Version 4.0 format.  (BAB)
  !   900402  Added TYPE section.  (WRB)
  USE CBLKT, ONLY : NM
  INTEGER I, Idxa, Ir, Na
  !* FIRST EXECUTABLE STATEMENT  INDXA
  Na = 2**Ir
  Idxa = I - Na + 1
  IF ( I>NM ) Na = 0
END SUBROUTINE INDXA
