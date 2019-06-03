include"dqdot/mpcom.f90"
include"slap/sslblk.f90"
include"slap/dslblk.f90"

MODULE linear
  USE service, ONLY : SP, DP
  IMPLICIT NONE

CONTAINS
  include"blas/cabs1.f90"
  include"blas/caxpy.f90"
  include"blas/ccopy.f90"
  include"blas/cdcdot.f90"
  include"blas/cdotc.f90"
  include"blas/cdotu.f90"
  include"blas/cgbmv.f90"
  include"blas/cgemm.f90"
  include"blas/cgemv.f90"
  include"blas/cgerc.f90"
  include"blas/cgeru.f90"
  include"blas/chbmv.f90"
  include"blas/chemm.f90"
  include"blas/chemv.f90"
  include"blas/cher.f90"
  include"blas/cher2.f90"
  include"blas/cher2k.f90"
  include"blas/cherk.f90"
  include"blas/chpmv.f90"
  include"blas/chpr.f90"
  include"blas/chpr2.f90"
  include"blas/crotg.f90"
  include"blas/cscal.f90"
  include"blas/csign.f90"
  include"blas/csign1.f90"
  include"blas/csrot.f90"
  include"blas/csscal.f90"
  include"blas/cswap.f90"
  include"blas/csymm.f90"
  include"blas/csyr2k.f90"
  include"blas/csyrk.f90"
  include"blas/ctbmv.f90"
  include"blas/ctbsv.f90"
  include"blas/ctpmv.f90"
  include"blas/ctpsv.f90"
  include"blas/ctrmm.f90"
  include"blas/ctrmv.f90"
  include"blas/ctrsm.f90"
  include"blas/ctrsv.f90"
  include"blas/dasum.f90"
  include"blas/daxpy.f90"
  include"blas/dcdot.f90"
  include"blas/dcopy.f90"
  include"blas/dcopym.f90"
  include"blas/ddot.f90"
  include"blas/dgbmv.f90"
  include"blas/dgemm.f90"
  include"blas/dgemv.f90"
  include"blas/dger.f90"
  include"blas/dnrm2.f90"
  include"blas/drot.f90"
  include"blas/drotg.f90"
  include"blas/drotm.f90"
  include"blas/drotmg.f90"
  include"blas/dsbmv.f90"
  include"blas/dscal.f90"
  include"blas/dsdot.f90"
  include"blas/dspmv.f90"
  include"blas/dspr.f90"
  include"blas/dspr2.f90"
  include"blas/dswap.f90"
  include"blas/dsymm.f90"
  include"blas/dsymv.f90"
  include"blas/dsyr.f90"
  include"blas/dsyr2.f90"
  include"blas/dsyr2k.f90"
  include"blas/dsyrk.f90"
  include"blas/dtbmv.f90"
  include"blas/dtbsv.f90"
  include"blas/dtpmv.f90"
  include"blas/dtpsv.f90"
  include"blas/dtrmm.f90"
  include"blas/dtrmv.f90"
  include"blas/dtrsm.f90"
  include"blas/dtrsv.f90"
  include"blas/icamax.f90"
  include"blas/icopy.f90"
  include"blas/idamax.f90"
  include"blas/isamax.f90"
  include"blas/iswap.f90"
  include"blas/lsame.f90"
  include"blas/sasum.f90"
  include"blas/saxpy.f90"
  include"blas/scasum.f90"
  include"blas/scnrm2.f90"
  include"blas/scopy.f90"
  include"blas/scopym.f90"
  include"blas/sdot.f90"
  include"blas/sdsdot.f90"
  include"blas/sgbmv.f90"
  include"blas/sgemm.f90"
  include"blas/sgemv.f90"
  include"blas/sger.f90"
  include"blas/snrm2.f90"
  include"blas/srot.f90"
  include"blas/srotg.f90"
  include"blas/srotm.f90"
  include"blas/srotmg.f90"
  include"blas/ssbmv.f90"
  include"blas/sscal.f90"
  include"blas/sspmv.f90"
  include"blas/sspr.f90"
  include"blas/sspr2.f90"
  include"blas/sswap.f90"
  include"blas/ssymm.f90"
  include"blas/ssymv.f90"
  include"blas/ssyr.f90"
  include"blas/ssyr2.f90"
  include"blas/ssyr2k.f90"
  include"blas/ssyrk.f90"
  include"blas/stbmv.f90"
  include"blas/stbsv.f90"
  include"blas/stpmv.f90"
  include"blas/stpsv.f90"
  include"blas/strmm.f90"
  include"blas/strmv.f90"
  include"blas/strsm.f90"
  include"blas/strsv.f90"
  include"bndacc.f90"
  include"bndsol.f90"
  include"cgeev.f90"
  include"cgefs.f90"
  include"cgeir.f90"
  include"chiev.f90"
  include"cnbco.f90"
  include"cnbdi.f90"
  include"cnbfa.f90"
  include"cnbfs.f90"
  include"cnbir.f90"
  include"cnbsl.f90"
  include"cpofs.f90"
  include"cpoir.f90"
  include"dbndac.f90"
  include"dbndsl.f90"
  include"dgefs.f90"
  include"dglss.f90"
  include"dh12.f90"
  include"dhfti.f90"
  include"dllsia.f90"
  include"dnbco.f90"
  include"dnbdi.f90"
  include"dnbfa.f90"
  include"dnbfs.f90"
  include"dnbsl.f90"
  include"dpofs.f90"
  include"dqdot/dqdota.f90"
  include"dqdot/dqdoti.f90"
  include"dqdot/mpadd.f90"
  include"dqdot/mpadd2.f90"
  include"dqdot/mpadd3.f90"
  include"dqdot/mpblas.f90"
  include"dqdot/mpcdm.f90"
  include"dqdot/mpchk.f90"
  include"dqdot/mpcmd.f90"
  include"dqdot/mpdivi.f90"
  include"dqdot/mperr.f90"
  include"dqdot/mpmaxr.f90"
  include"dqdot/mpmlp.f90"
  include"dqdot/mpmul.f90"
  include"dqdot/mpmul2.f90"
  include"dqdot/mpmuli.f90"
  include"dqdot/mpnzr.f90"
  include"dqdot/mpovfl.f90"
  include"dqdot/mpstr.f90"
  include"dqdot/mpunfl.f90"
  include"du11ls.f90"
  include"du11us.f90"
  include"du12ls.f90"
  include"du12us.f90"
  include"dulsia.f90"
  include"eispack/bakvec.f90"
  include"eispack/balanc.f90"
  include"eispack/balbak.f90"
  include"eispack/bandr.f90"
  include"eispack/bandv.f90"
  include"eispack/bisect.f90"
  include"eispack/bqr.f90"
  include"eispack/cbabk2.f90"
  include"eispack/cbal.f90"
  include"eispack/cdiv.f90"
  include"eispack/cg.f90"
  include"eispack/ch.f90"
  include"eispack/cinvit.f90"
  include"eispack/combak.f90"
  include"eispack/comhes.f90"
  include"eispack/comlr.f90"
  include"eispack/comlr2.f90"
  include"eispack/comqr.f90"
  include"eispack/comqr2.f90"
  include"eispack/cortb.f90"
  include"eispack/corth.f90"
  include"eispack/csroot.f90"
  include"eispack/eisdoc.f90"
  include"eispack/elmbak.f90"
  include"eispack/elmhes.f90"
  include"eispack/eltran.f90"
  include"eispack/figi.f90"
  include"eispack/figi2.f90"
  include"eispack/hqr.f90"
  include"eispack/hqr2.f90"
  include"eispack/htrib3.f90"
  include"eispack/htribk.f90"
  include"eispack/htrid3.f90"
  include"eispack/htridi.f90"
  include"eispack/imtql1.f90"
  include"eispack/imtql2.f90"
  include"eispack/imtqlv.f90"
  include"eispack/invit.f90"
  include"eispack/minfit.f90"
  include"eispack/ortbak.f90"
  include"eispack/orthes.f90"
  include"eispack/ortran.f90"
  include"eispack/pythag.f90"
  include"eispack/qzhes.f90"
  include"eispack/qzit.f90"
  include"eispack/qzval.f90"
  include"eispack/qzvec.f90"
  include"eispack/ratqr.f90"
  include"eispack/rebak.f90"
  include"eispack/rebakb.f90"
  include"eispack/reduc.f90"
  include"eispack/reduc2.f90"
  include"eispack/rg.f90"
  include"eispack/rgg.f90"
  include"eispack/rs.f90"
  include"eispack/rsb.f90"
  include"eispack/rsg.f90"
  include"eispack/rsgab.f90"
  include"eispack/rsgba.f90"
  include"eispack/rsp.f90"
  include"eispack/rst.f90"
  include"eispack/rt.f90"
  include"eispack/sspev.f90"
  include"eispack/tinvit.f90"
  include"eispack/tql1.f90"
  include"eispack/tql2.f90"
  include"eispack/tqlrat.f90"
  include"eispack/trbak1.f90"
  include"eispack/trbak3.f90"
  include"eispack/tred1.f90"
  include"eispack/tred2.f90"
  include"eispack/tred3.f90"
  include"eispack/tridib.f90"
  include"eispack/tsturm.f90"
  include"h12.f90"
  include"hfti.f90"
  include"linpack/cchdc.f90"
  include"linpack/cchdd.f90"
  include"linpack/cchex.f90"
  include"linpack/cchud.f90"
  include"linpack/cgbco.f90"
  include"linpack/cgbdi.f90"
  include"linpack/cgbfa.f90"
  include"linpack/cgbsl.f90"
  include"linpack/cgeco.f90"
  include"linpack/cgedi.f90"
  include"linpack/cgefa.f90"
  include"linpack/cgesl.f90"
  include"linpack/cgtsl.f90"
  include"linpack/chico.f90"
  include"linpack/chidi.f90"
  include"linpack/chifa.f90"
  include"linpack/chisl.f90"
  include"linpack/chpco.f90"
  include"linpack/chpdi.f90"
  include"linpack/chpfa.f90"
  include"linpack/chpsl.f90"
  include"linpack/cpbco.f90"
  include"linpack/cpbdi.f90"
  include"linpack/cpbfa.f90"
  include"linpack/cpbsl.f90"
  include"linpack/cpoco.f90"
  include"linpack/cpodi.f90"
  include"linpack/cpofa.f90"
  include"linpack/cposl.f90"
  include"linpack/cppco.f90"
  include"linpack/cppdi.f90"
  include"linpack/cppfa.f90"
  include"linpack/cppsl.f90"
  include"linpack/cptsl.f90"
  include"linpack/cqrdc.f90"
  include"linpack/cqrsl.f90"
  include"linpack/csico.f90"
  include"linpack/csidi.f90"
  include"linpack/csifa.f90"
  include"linpack/csisl.f90"
  include"linpack/cspco.f90"
  include"linpack/cspdi.f90"
  include"linpack/cspfa.f90"
  include"linpack/cspsl.f90"
  include"linpack/csvdc.f90"
  include"linpack/ctrco.f90"
  include"linpack/ctrdi.f90"
  include"linpack/ctrsl.f90"
  include"linpack/dchdc.f90"
  include"linpack/dchdd.f90"
  include"linpack/dchex.f90"
  include"linpack/dchud.f90"
  include"linpack/dgbco.f90"
  include"linpack/dgbdi.f90"
  include"linpack/dgbfa.f90"
  include"linpack/dgbsl.f90"
  include"linpack/dgeco.f90"
  include"linpack/dgedi.f90"
  include"linpack/dgefa.f90"
  include"linpack/dgesl.f90"
  include"linpack/dgtsl.f90"
  include"linpack/dpbco.f90"
  include"linpack/dpbdi.f90"
  include"linpack/dpbfa.f90"
  include"linpack/dpbsl.f90"
  include"linpack/dpoco.f90"
  include"linpack/dpodi.f90"
  include"linpack/dpofa.f90"
  include"linpack/dposl.f90"
  include"linpack/dppco.f90"
  include"linpack/dppdi.f90"
  include"linpack/dppfa.f90"
  include"linpack/dppsl.f90"
  include"linpack/dptsl.f90"
  include"linpack/dqrdc.f90"
  include"linpack/dqrsl.f90"
  include"linpack/dsico.f90"
  include"linpack/dsidi.f90"
  include"linpack/dsifa.f90"
  include"linpack/dsisl.f90"
  include"linpack/dspco.f90"
  include"linpack/dspdi.f90"
  include"linpack/dspfa.f90"
  include"linpack/dspsl.f90"
  include"linpack/dsvdc.f90"
  include"linpack/dtrco.f90"
  include"linpack/dtrdi.f90"
  include"linpack/dtrsl.f90"
  include"linpack/schdc.f90"
  include"linpack/schdd.f90"
  include"linpack/schex.f90"
  include"linpack/schud.f90"
  include"linpack/sgbco.f90"
  include"linpack/sgbdi.f90"
  include"linpack/sgbfa.f90"
  include"linpack/sgbsl.f90"
  include"linpack/sgeco.f90"
  include"linpack/sgedi.f90"
  include"linpack/sgefa.f90"
  include"linpack/sgesl.f90"
  include"linpack/sgtsl.f90"
  include"linpack/spbco.f90"
  include"linpack/spbdi.f90"
  include"linpack/spbfa.f90"
  include"linpack/spbsl.f90"
  include"linpack/spoco.f90"
  include"linpack/spodi.f90"
  include"linpack/spofa.f90"
  include"linpack/sposl.f90"
  include"linpack/sppco.f90"
  include"linpack/sppdi.f90"
  include"linpack/sppfa.f90"
  include"linpack/sppsl.f90"
  include"linpack/sptsl.f90"
  include"linpack/sqrdc.f90"
  include"linpack/sqrsl.f90"
  include"linpack/ssico.f90"
  include"linpack/ssidi.f90"
  include"linpack/ssifa.f90"
  include"linpack/ssisl.f90"
  include"linpack/sspco.f90"
  include"linpack/sspdi.f90"
  include"linpack/sspfa.f90"
  include"linpack/sspsl.f90"
  include"linpack/ssvdc.f90"
  include"linpack/strco.f90"
  include"linpack/strdi.f90"
  include"linpack/strsl.f90"
  include"llsia.f90"
  include"sgeev.f90"
  include"sgefs.f90"
  include"sgeir.f90"
  include"sglss.f90"
  include"slap/dbcg.f90"
  include"slap/dbhin.f90"
  include"slap/dcg.f90"
  include"slap/dcgn.f90"
  include"slap/dcgs.f90"
  include"slap/dchkw.f90"
  include"slap/dcpplt.f90"
  include"slap/dgmres.f90"
  include"slap/dhels.f90"
  include"slap/dheqr.f90"
  include"slap/dir.f90"
  include"slap/dllti2.f90"
  include"slap/dlpdoc.f90"
  include"slap/domn.f90"
  include"slap/dorth.f90"
  include"slap/dpigmr.f90"
  include"slap/drlcal.f90"
  include"slap/ds2lt.f90"
  include"slap/ds2y.f90"
  include"slap/dsd2s.f90"
  include"slap/dsdbcg.f90"
  include"slap/dsdcg.f90"
  include"slap/dsdcgn.f90"
  include"slap/dsdcgs.f90"
  include"slap/dsdgmr.f90"
  include"slap/dsdi.f90"
  include"slap/dsdomn.f90"
  include"slap/dsds.f90"
  include"slap/dsdscl.f90"
  include"slap/dsgs.f90"
  include"slap/dsiccg.f90"
  include"slap/dsics.f90"
  include"slap/dsilur.f90"
  include"slap/dsilus.f90"
  include"slap/dsjac.f90"
  include"slap/dsli.f90"
  include"slap/dsli2.f90"
  include"slap/dsllti.f90"
  include"slap/dslubc.f90"
  include"slap/dslucn.f90"
  include"slap/dslucs.f90"
  include"slap/dslugm.f90"
  include"slap/dslui.f90"
  include"slap/dslui2.f90"
  include"slap/dslui4.f90"
  include"slap/dsluom.f90"
  include"slap/dsluti.f90"
  include"slap/dsmmi2.f90"
  include"slap/dsmmti.f90"
  include"slap/dsmtv.f90"
  include"slap/dsmv.f90"
  include"slap/dtin.f90"
  include"slap/dtout.f90"
  include"slap/dxlcal.f90"
  include"slap/isdbcg.f90"
  include"slap/isdcg.f90"
  include"slap/isdcgn.f90"
  include"slap/isdcgs.f90"
  include"slap/isdgmr.f90"
  include"slap/isdir.f90"
  include"slap/isdomn.f90"
  include"slap/issbcg.f90"
  include"slap/isscg.f90"
  include"slap/isscgn.f90"
  include"slap/isscgs.f90"
  include"slap/issgmr.f90"
  include"slap/issir.f90"
  include"slap/issomn.f90"
  include"slap/qs2i1d.f90"
  include"slap/qs2i1r.f90"
  include"slap/sbcg.f90"
  include"slap/sbhin.f90"
  include"slap/scg.f90"
  include"slap/scgn.f90"
  include"slap/scgs.f90"
  include"slap/schkw.f90"
  include"slap/scpplt.f90"
  include"slap/sgmres.f90"
  include"slap/shels.f90"
  include"slap/sheqr.f90"
  include"slap/sir.f90"
  include"slap/sllti2.f90"
  include"slap/slpdoc.f90"
  include"slap/somn.f90"
  include"slap/sorth.f90"
  include"slap/spigmr.f90"
  include"slap/srlcal.f90"
  include"slap/ss2lt.f90"
  include"slap/ss2y.f90"
  include"slap/ssd2s.f90"
  include"slap/ssdbcg.f90"
  include"slap/ssdcg.f90"
  include"slap/ssdcgn.f90"
  include"slap/ssdcgs.f90"
  include"slap/ssdgmr.f90"
  include"slap/ssdi.f90"
  include"slap/ssdomn.f90"
  include"slap/ssds.f90"
  include"slap/ssdscl.f90"
  include"slap/ssgs.f90"
  include"slap/ssiccg.f90"
  include"slap/ssics.f90"
  include"slap/ssilur.f90"
  include"slap/ssilus.f90"
  include"slap/ssjac.f90"
  include"slap/ssli.f90"
  include"slap/ssli2.f90"
  include"slap/ssllti.f90"
  include"slap/sslubc.f90"
  include"slap/sslucn.f90"
  include"slap/sslucs.f90"
  include"slap/sslugm.f90"
  include"slap/sslui.f90"
  include"slap/sslui2.f90"
  include"slap/sslui4.f90"
  include"slap/ssluom.f90"
  include"slap/ssluti.f90"
  include"slap/ssmmi2.f90"
  include"slap/ssmmti.f90"
  include"slap/ssmtv.f90"
  include"slap/ssmv.f90"
  include"slap/stin.f90"
  include"slap/stout.f90"
  include"slap/sxlcal.f90"
  include"snbco.f90"
  include"snbdi.f90"
  include"snbfa.f90"
  include"snbfs.f90"
  include"snbir.f90"
  include"snbsl.f90"
  include"spofs.f90"
  include"spoir.f90"
  include"ssiev.f90"
  include"svd.f90"
  include"u11ls.f90"
  include"u11us.f90"
  include"u12ls.f90"
  include"u12us.f90"
  include"ulsia.f90"
END MODULE linear