#!/bin/sh
#SBATCH --mem-per-cpu=2G
#SBATCH -t 00:30:00 # execution time hh:mm:ss *OB*

# Parameter: N (matrix size: NxN)
PARAM_SMALL=1024
PARAM_MEDIUM=2048
PARAM_LARGE=4096

#export OMP_NUM_THREADS=6

echo GCC Benchmarking

GCC_TARGETS="dgesv0_gcc dgesv1_gcc dgesv2_gcc dgesv3_gcc dgesvfast_gcc dgesvipo_gcc dgesvpgo_gcc dges
vvector_gcc"

gcc --version

module load openblas
module load intel imkl

make cleanall
make all


#Small Test
echo " ";
echo "----SMALL TESTS-----";
for exe  in ${GCC_TARGETS}; do
  echo "**********";
  echo ${exe};
  echo "**********";
  time ./$exe ${PARAM_SMALL}
done

#Medium Test
echo " ";
echo "----MEDIUM TESTS----";
for exe in ${GCC_TARGETS}; do
  echo "**********";
  echo ${exe};
  echo "**********";
  time ./$exe ${PARAM_MEDIUM}
done

#Large Test
echo " ";
echo "----LARGE TESTS-----";
for exe in ${GCC_TARGETS}; do
   echo "**********";
   echo ${exe};
   echo "**********";
   time ./$exe ${PARAM_LARGE}
done

echo ICC Benchmarking

ICC_TARGETS="dgesv0_icc dgesv1_icc dgesv2_icc dgesv3_icc dgesvfast_icc dgesvipo_icc dgesvpgo_icc dges
vvector_icc"

icc --version

#Small Test
echo " ";
echo "----SMALL TESTS-----";
for exe  in ${ICC_TARGETS}; do
  echo "**********";
  echo ${exe};
  echo "**********";
  time ./$exe ${PARAM_SMALL}
done

#Medium Test
echo " ";
echo "----MEDIUM TESTS----";
for exe in ${ICC_TARGETS}; do
  echo "**********";
  echo ${exe};
  echo "**********";
  time ./$exe ${PARAM_MEDIUM}
done

#Large Test
echo " ";
echo "----LARGE TESTS-----";
for exe in ${ICC_TARGETS}; do
   echo "**********";
   echo ${exe};
   echo "**********";
   time ./$exe ${PARAM_LARGE}
done
