MODULE interpolation
  IMPLICIT NONE

CONTAINS
  include"bspline/bfqad.f90"
  include"bspline/bint4.f90"
  include"bspline/bintk.f90"
  include"bspline/bnfac.f90"
  include"bspline/bnslv.f90"
  include"bspline/bsgq8.f90"
  include"bspline/bspdoc.f90"
  include"bspline/bspdr.f90"
  include"bspline/bspev.f90"
  include"bspline/bsppp.f90"
  include"bspline/bspvd.f90"
  include"bspline/bspvn.f90"
  include"bspline/bsqad.f90"
  include"bspline/bvalu.f90"
  include"bspline/dbfqad.f90"
  include"bspline/dbint4.f90"
  include"bspline/dbintk.f90"
  include"bspline/dbnfac.f90"
  include"bspline/dbnslv.f90"
  include"bspline/dbsgq8.f90"
  include"bspline/dbspdr.f90"
  include"bspline/dbspev.f90"
  include"bspline/dbsppp.f90"
  include"bspline/dbspvd.f90"
  include"bspline/dbspvn.f90"
  include"bspline/dbsqad.f90"
  include"bspline/dbvalu.f90"
  include"bspline/dintrv.f90"
  include"bspline/dppgq8.f90"
  include"bspline/dppqad.f90"
  include"bspline/dppval.f90"
  include"bspline/intrv.f90"
  include"bspline/ppgq8.f90"
  include"bspline/ppqad.f90"
  include"bspline/ppval.f90"
  include"dplint.f90"
  include"dpolcf.f90"
  include"dpolvl.f90"
  include"pchip/chfcm.f90"
  include"pchip/chfdv.f90"
  include"pchip/chfev.f90"
  include"pchip/chfie.f90"
  include"pchip/dchfcm.f90"
  include"pchip/dchfdv.f90"
  include"pchip/dchfev.f90"
  include"pchip/dchfie.f90"
  include"pchip/dpchbs.f90"
  include"pchip/dpchce.f90"
  include"pchip/dpchci.f90"
  include"pchip/dpchcm.f90"
  include"pchip/dpchcs.f90"
  include"pchip/dpchdf.f90"
  include"pchip/dpchfd.f90"
  include"pchip/dpchfe.f90"
  include"pchip/dpchia.f90"
  include"pchip/dpchic.f90"
  include"pchip/dpchid.f90"
  include"pchip/dpchim.f90"
  include"pchip/dpchkt.f90"
  include"pchip/dpchsp.f90"
  include"pchip/dpchst.f90"
  include"pchip/dpchsw.f90"
  include"pchip/pchbs.f90"
  include"pchip/pchce.f90"
  include"pchip/pchci.f90"
  include"pchip/pchcm.f90"
  include"pchip/pchcs.f90"
  include"pchip/pchdf.f90"
  include"pchip/pchdoc.f90"
  include"pchip/pchfd.f90"
  include"pchip/pchfe.f90"
  include"pchip/pchia.f90"
  include"pchip/pchic.f90"
  include"pchip/pchid.f90"
  include"pchip/pchim.f90"
  include"pchip/pchkt.f90"
  include"pchip/pchsp.f90"
  include"pchip/pchst.f90"
  include"pchip/pchsw.f90"
  include"polcof.f90"
  include"polint.f90"
  include"polyvl.f90"
END MODULE interpolation