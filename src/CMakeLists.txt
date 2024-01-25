add_library(slatec slatec.f90)
target_link_libraries(slatec service special_functions optimization nonlin_eq linear interpolation integ_trans
                      diff_integ diff_integ_eq data_handling approximation)
