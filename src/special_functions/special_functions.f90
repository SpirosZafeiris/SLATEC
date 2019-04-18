include"xblk.f90"
include"dxblk.f90"

MODULE special_functions
  IMPLICIT NONE

CONTAINS
  include"ai.f90"
  include"aie.f90"
  include"albeta.f90"
  include"algams.f90"
  include"ali.f90"
  include"alnrel.f90"
  include"asyik.f90"
  include"asyjy.f90"
  include"bdiff.f90"
  include"besi.f90"
  include"besi0.f90"
  include"besi0e.f90"
  include"besi1.f90"
  include"besi1e.f90"
  include"besj.f90"
  include"besk.f90"
  include"besk0.f90"
  include"besk0e.f90"
  include"besk1.f90"
  include"besk1e.f90"
  include"beskes.f90"
  include"besknu.f90"
  include"besks.f90"
  include"besy.f90"
  include"besynu.f90"
  include"beta.f90"
  include"betai.f90"
  include"bi.f90"
  include"bie.f90"
  include"binom.f90"
  include"bkias.f90"
  include"bkisr.f90"
  include"bskin.f90"
  include"c0lgmc.f90"
  include"c9lgmc.f90"
  include"c9ln2r.f90"
  include"cacai.f90"
  include"cacon.f90"
  include"cairy.f90"
  include"carg.f90"
  include"casyi.f90"
  include"catan2.f90"
  include"cbesh.f90"
  include"cbesi.f90"
  include"cbesj.f90"
  include"cbesk.f90"
  include"cbesy.f90"
  include"cbeta.f90"
  include"cbinu.f90"
  include"cbiry.f90"
  include"cbknu.f90"
  include"cbrt.f90"
  include"cbuni.f90"
  include"cbunk.f90"
  include"ccbrt.f90"
  include"ccot.f90"
  include"cexprl.f90"
  include"cgamma.f90"
  include"cgamr.f90"
  include"chu.f90"
  include"ckscl.f90"
  include"clbeta.f90"
  include"clngam.f90"
  include"clnrel.f90"
  include"clog10.f90"
  include"cmlri.f90"
  include"cosdg.f90"
  include"cot.f90"
  include"cpsi.f90"
  include"crati.f90"
  include"cs1s2.f90"
  include"cseri.f90"
  include"csevl.f90"
  include"cshch.f90"
  include"cuchk.f90"
  include"cunhj.f90"
  include"cuni1.f90"
  include"cuni2.f90"
  include"cunik.f90"
  include"cunk1.f90"
  include"cunk2.f90"
  include"cuoik.f90"
  include"cwrsk.f90"
  include"d9aimp.f90"
  include"d9atn1.f90"
  include"d9b0mp.f90"
  include"d9b1mp.f90"
  include"d9chu.f90"
  include"d9gmic.f90"
  include"d9gmit.f90"
  include"d9knus.f90"
  include"d9lgic.f90"
  include"d9lgit.f90"
  include"d9lgmc.f90"
  include"d9ln2r.f90"
  include"d9pak.f90"
  include"d9upak.f90"
  include"dai.f90"
  include"daie.f90"
  include"dasyik.f90"
  include"dasyjy.f90"
  include"daws.f90"
  include"dbdiff.f90"
  include"dbesi.f90"
  include"dbesi0.f90"
  include"dbesi1.f90"
  include"dbesj.f90"
  include"dbesk.f90"
  include"dbesk0.f90"
  include"dbesk1.f90"
  include"dbesks.f90"
  include"dbesy.f90"
  include"dbeta.f90"
  include"dbetai.f90"
  include"dbi.f90"
  include"dbie.f90"
  include"dbinom.f90"
  include"dbkias.f90"
  include"dbkisr.f90"
  include"dbsi0e.f90"
  include"dbsi1e.f90"
  include"dbsk0e.f90"
  include"dbsk1e.f90"
  include"dbskes.f90"
  include"dbskin.f90"
  include"dbsknu.f90"
  include"dbsynu.f90"
  include"dcbrt.f90"
  include"dchu.f90"
  include"dcosdg.f90"
  include"dcot.f90"
  include"dcsevl.f90"
  include"ddaws.f90"
  include"de1.f90"
  include"dei.f90"
  include"dexint.f90"
  include"dexprl.f90"
  include"dfac.f90"
  include"dgami.f90"
  include"dgamic.f90"
  include"dgamit.f90"
  include"dgamlm.f90"
  include"dgamln.f90"
  include"dgamr.f90"
  include"dgamrn.f90"
  include"dhkseq.f90"
  include"djairy.f90"
  include"dlbeta.f90"
  include"dlgams.f90"
  include"dli.f90"
  include"dlnrel.f90"
  include"dpoch.f90"
  include"dpoch1.f90"
  include"dpsi.f90"
  include"dpsifn.f90"
  include"dpsixn.f90"
  include"drc.f90"
  include"drc3jj.f90"
  include"drc3jm.f90"
  include"drc6j.f90"
  include"drd.f90"
  include"drf.f90"
  include"drj.f90"
  include"dsindg.f90"
  include"dspenc.f90"
  include"dxadd.f90"
  include"dxadj.f90"
  include"dxc210.f90"
  include"dxcon.f90"
  include"dxlegf.f90"
  include"dxnrmp.f90"
  include"dxpmu.f90"
  include"dxpmup.f90"
  include"dxpnrm.f90"
  include"dxpqnu.f90"
  include"dxpsi.f90"
  include"dxqmu.f90"
  include"dxqnu.f90"
  include"dxred.f90"
  include"dxset.f90"
  include"dyairy.f90"
  include"e1.f90"
  include"ei.f90"
  include"exint.f90"
  include"exprel.f90"
  include"fac.f90"
  include"fundoc.f90"
  include"gami.f90"
  include"gamic.f90"
  include"gamit.f90"
  include"gamlim.f90"
  include"gamln.f90"
  include"gamr.f90"
  include"gamrn.f90"
  include"hkseq.f90"
  include"initds.f90"
  include"inits.f90"
  include"jairy.f90"
  include"poch.f90"
  include"poch1.f90"
  include"psi.f90"
  include"psifn.f90"
  include"psixn.f90"
  include"r9aimp.f90"
  include"r9atn1.f90"
  include"r9chu.f90"
  include"r9gmic.f90"
  include"r9gmit.f90"
  include"r9knus.f90"
  include"r9lgic.f90"
  include"r9lgit.f90"
  include"r9lgmc.f90"
  include"r9ln2r.f90"
  include"r9pak.f90"
  include"r9upak.f90"
  include"rand.f90"
  include"rc.f90"
  include"rc3jj.f90"
  include"rc3jm.f90"
  include"rc6j.f90"
  include"rd.f90"
  include"rf.f90"
  include"rgauss.f90"
  include"rj.f90"
  include"runif.f90"
  include"sindg.f90"
  include"spenc.f90"
  include"xadd.f90"
  include"xadj.f90"
  include"xc210.f90"
  include"xcon.f90"
  include"xlegf.f90"
  include"xnrmp.f90"
  include"xpmu.f90"
  include"xpmup.f90"
  include"xpnrm.f90"
  include"xpqnu.f90"
  include"xpsi.f90"
  include"xqmu.f90"
  include"xqnu.f90"
  include"xred.f90"
  include"xset.f90"
  include"yairy.f90"
  include"zabs.f90"
  include"zacai.f90"
  include"zacon.f90"
  include"zairy.f90"
  include"zasyi.f90"
  include"zbesh.f90"
  include"zbesi.f90"
  include"zbesj.f90"
  include"zbesk.f90"
  include"zbesy.f90"
  include"zbinu.f90"
  include"zbiry.f90"
  include"zbknu.f90"
  include"zbuni.f90"
  include"zbunk.f90"
  include"zdiv.f90"
  include"zexp.f90"
  include"zkscl.f90"
  include"zlog.f90"
  include"zmlri.f90"
  include"zmlt.f90"
  include"zrati.f90"
  include"zs1s2.f90"
  include"zseri.f90"
  include"zshch.f90"
  include"zsqrt.f90"
  include"zuchk.f90"
  include"zunhj.f90"
  include"zuni1.f90"
  include"zuni2.f90"
  include"zunik.f90"
  include"zunk1.f90"
  include"zunk2.f90"
  include"zuoik.f90"
  include"zwrsk.f90"
END MODULE special_functions