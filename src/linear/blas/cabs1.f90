
REAL(SP) FUNCTION CABS1(zdum)
  COMPLEX(SP), INTENT(IN) :: zdum

  CABS1 = ABS(REAL(zdum)) + ABS(AIMAG(zdum))

END FUNCTION CABS1
