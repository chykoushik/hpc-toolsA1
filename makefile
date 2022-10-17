TARGETS = dgesv0_gcc dgesv1_gcc dgesv2_gcc dgesv3_gcc dgesvfast_gcc dgesvfprofile_gcc dgesvvector_gcc dgesv0_icc dgesv1_icc dgesv2_icc dgesv3_icc dgesvfast_icc

CC = gcc

reportflags.gcc = -fopt-info-optall-optimized
reportflags.icc = -qopt-report-phase=vec

CFLAGS = $(reportflags.$(CC)) -Wall -Wextra

all: $(TARGETS)


dgesv0_gcc: dgesv.c
            $(CC) -lopenblas -lm -O0 -march=native -o dgesv0_gcc dgesv.c
dgesv1_gcc: dgesv.c
            $(CC) -lopenblas -lm -O1 -march=native  -o dgesv1_gcc dgesv.c
dgesv2_gcc: dgesv.c
            $(CC) -lopenblas -lm -O2 -march=native -o dgesv2_gcc dgesv.c
dgesv3_gcc: dgesv.c
            $(CC) -lopenblas -lm -O3 -march=native -o dgesv3_gcc dgesv.c
dgesvfast_gcc: dgesv.c
           $(CC) -lopenblas -lm -Ofast -march=native -o dgesvfast_gcc dgesv.c
dgesvfprofile_gcc: dgesv.c
            $(CC) -lopenblas -lm -Ofast -fipa-pta -fprofile-generate -march=native -o dgesvfprofile_gcc dgesv.c
dgesvvector_gcc: dgesv.c
            $(CC) -lopenblas -lm -ftree-loop-vectorize -O3 -fopt-info-vec -o dgesvvector_gcc dgesv.c

dgesv0_icc: dgesv.c
            icc dgesv.c  -mkl -O0 -xHost -o dgesv0_icc
dgesv1_icc: dgesv.c
            icc dgesv.c  -mkl -O1 -xHost -o dgesv1_icc
dgesv2_icc: dgesv.c
            icc dgesv.c  -mkl -O2 -xHost -o dgesv2_icc
dgesv3_icc: dgesv.c
            icc dgesv.c  -mkl -O3 -xHost -o dgesv3_icc
dgesvfast_icc: dgesv.c
            icc dgesv.c  -mkl -Ofast -xHost -o dgesvfast_icc

cleanall: 
        rm -f $(TARGETS)
