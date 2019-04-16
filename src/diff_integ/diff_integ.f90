MODULE diff_integ
  use service
  use linear
  use interpolation
  IMPLICIT NONE

CONTAINS
  include"avint.f90"
  include"davint.f90"
  include"dgaus8.f90"
  include"dpfqad.f90"
  include"dqnc79.f90"
  include"gaus8.f90"
  include"pfqad.f90"
  include"qnc79.f90"
  include"quadpack/dqag.f90"
  include"quadpack/dqage.f90"
  include"quadpack/dqagi.f90"
  include"quadpack/dqagie.f90"
  include"quadpack/dqagp.f90"
  include"quadpack/dqagpe.f90"
  include"quadpack/dqags.f90"
  include"quadpack/dqagse.f90"
  include"quadpack/dqawc.f90"
  include"quadpack/dqawce.f90"
  include"quadpack/dqawf.f90"
  include"quadpack/dqawfe.f90"
  include"quadpack/dqawo.f90"
  include"quadpack/dqawoe.f90"
  include"quadpack/dqaws.f90"
  include"quadpack/dqawse.f90"
  include"quadpack/dqc25c.f90"
  include"quadpack/dqc25f.f90"
  include"quadpack/dqc25s.f90"
  include"quadpack/dqcheb.f90"
  include"quadpack/dqelg.f90"
  include"quadpack/dqk15.f90"
  include"quadpack/dqk15i.f90"
  include"quadpack/dqk15w.f90"
  include"quadpack/dqk21.f90"
  include"quadpack/dqk31.f90"
  include"quadpack/dqk41.f90"
  include"quadpack/dqk51.f90"
  include"quadpack/dqk61.f90"
  include"quadpack/dqmomo.f90"
  include"quadpack/dqng.f90"
  include"quadpack/dqpsrt.f90"
  include"quadpack/dqwgtc.f90"
  include"quadpack/dqwgtf.f90"
  include"quadpack/dqwgts.f90"
  include"quadpack/qag.f90"
  include"quadpack/qage.f90"
  include"quadpack/qagi.f90"
  include"quadpack/qagie.f90"
  include"quadpack/qagp.f90"
  include"quadpack/qagpe.f90"
  include"quadpack/qags.f90"
  include"quadpack/qagse.f90"
  include"quadpack/qawc.f90"
  include"quadpack/qawce.f90"
  include"quadpack/qawf.f90"
  include"quadpack/qawfe.f90"
  include"quadpack/qawo.f90"
  include"quadpack/qawoe.f90"
  include"quadpack/qaws.f90"
  include"quadpack/qawse.f90"
  include"quadpack/qc25c.f90"
  include"quadpack/qc25f.f90"
  include"quadpack/qc25s.f90"
  include"quadpack/qcheb.f90"
  include"quadpack/qelg.f90"
  include"quadpack/qk15.f90"
  include"quadpack/qk15i.f90"
  include"quadpack/qk15w.f90"
  include"quadpack/qk21.f90"
  include"quadpack/qk31.f90"
  include"quadpack/qk41.f90"
  include"quadpack/qk51.f90"
  include"quadpack/qk61.f90"
  include"quadpack/qmomo.f90"
  include"quadpack/qng.f90"
  include"quadpack/qpdoc.f90"
  include"quadpack/qpsrt.f90"
  include"quadpack/qwgtc.f90"
  include"quadpack/qwgtf.f90"
  include"quadpack/qwgts.f90"
END MODULE diff_integ