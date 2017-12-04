all: NNLS_TEST NNLS_MEX

#COMPILER = icc
COMPILER = gcc

MATLAB_VER = R2017b
MATLAB_PATH =  /data/applications/MATLAB/$(MATLAB_VER)
MATLAB_INCLUDE = -I $(MATLAB_PATH)/extern/include
MATLAB_LIBS = -L $(MATLAB_PATH)/bin/glnxa64 -lmx -lmex
MATLAB_STUFF = $(MATLAB_INCLUDE) $(MATLAB_LIBS)

 

MKL_PATH = /opt/intel/mkl
MKL_INCLUDES = -I $(MKL_PATH)/include

#For icc
#MKL_LIBS = -L$(MKL_PATH)/lib/em64t -lmkl_solver_lp64 -Wl,--start-group -lmkl_intel_lp64 -lmkl_intel_thread -lmkl_lapack -lmkl_core -lmkl_mc3 -lmkl_def -Wl,--end-group

#For gcc
MKL_LIBS = -L$(MKL_PATH)/lib/intel64 -Wl,--start-group -lmkl_intel_lp64 -lmkl_intel_thread -lmkl_lapack95_lp64 -lmkl_core -lmkl_mc3 -lmkl_def -Wl,--end-group -liomp5 

MKL_STUFF = $(MKL_INCLUDES) $(MKL_LIBS)

#For gcc
OMP_FLAGS =  -fopenmp -lpthread 

#For icc
#OMP_FLAGS =  -openmp -lpthread -openmp-report2

OTHER_FLAGS = -O3 -fpic

RPATH = -Wl,-rpath,/opt/intel/compilers_and_libraries_2018.1.163/linux/compiler/lib/intel64_lin/:$(MKL_PATH)/intel64/:$(MKL_PATH)/intel64/lib:$(MATLAB_PATH)/bin/glnxa64:$(MATLAB_PATH)/extern/lib/glnxa64:$(MATLAB_PATH)/sys/os/glnxa64

NNLS_TEST: main.c
	$(COMPILER) $(MATLAB_STUFF) $(OMP_FLAGS) $(MKL_STUFF) $(RPATH) $(OTHER_FLAGS) -lm  main.c  -o runNNLS

NNLS_MEX: main.c
	$(COMPILER) $(MATLAB_STUFF) $(OMP_FLAGS) $(MKL_STUFF) $(RPATH) $(OTHER_FLAGS)  main.c -shared -o matlab/NNLS.mexa64

clean:
	 rm -rf *o runNNLS matlab/NNLS.mexa64
