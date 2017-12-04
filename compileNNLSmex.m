function compileNNLSmex()

MY_LFLAGS = '';
MY_OPTIM_FLAGS = '-O3';
MKLROOT = '/opt/intel/compilers_and_libraries_2018.1.163/linux/mkl';
SRC = ['main.c'];
MKL_LFLAGS = ['-Wl,--start-group ' MKLROOT '/lib/intel64/libmkl_intel_lp64.a ' MKLROOT '/lib/intel64/libmkl_core.a ' MKLROOT '/lib/intel64/libmkl_gnu_thread.a -Wl,--end-group -ldl -lpthread -lm'];
mex(['COPTIMFLAGS="' MY_OPTIM_FLAGS '"'], ['CFLAGS=" -fopenmp -m64 -I' MKLROOT '/include -fPIC"'], ['CLIBS="' MY_LFLAGS ' -fopenmp ' MKL_LFLAGS '"'], SRC);
copyfile main.mexa64 NNLS.mexa64
