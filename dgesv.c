#include <time.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <openblas/lapacke.h>
//#include <mkl_lapacke.h>



double *generate_matrix(int size)
{
  int i;
  double *matrix = (double *) malloc(sizeof(double) * size * size);



 srand(1);

  for (i = 0; i < size * size; i++) {
    matrix[i] = rand() % 100;
  }



 return matrix;
}



int is_nearly_equal(double x, double y)
{
  const double epsilon = 1e-5 /* some small number */;
  return abs(x - y) <= epsilon * abs(x);
  // see Knuth section 4.2.2 pages 217-218
}



int check_result(double *bref, double *b, int size)
{
  int i;

  for(i = 0; i < size*size; i++) {
    if (!is_nearly_equal(bref[i], b[i]))
      return 0;
  }



 return 1;
}



int my_dgesv(int n, int nrhs, double* a, int lda, int* ipiv, double* b, int ldb, double x, double y, double* bref, int size)
{



 //Replace next line to use your own DGESV implementation
// LAPACKE_dgesv(LAPACK_ROW_MAJOR, n, nrhs, a, lda, ipiv, b, ldb);
is_nearly_equal(x,y);
check_result(bref, b, size);




}
void main(int argc, char *argv[])
{
  int size = atoi(argv[1]);



 double *a, *aref;
  double *b, *bref;
  double x;
  double y;




  a = generate_matrix(size);
  aref = generate_matrix(size);
  b = generate_matrix(size);
  bref = generate_matrix(size);



 // Using LAPACK dgesv OpenBLAS implementation to solve the system
  int n = size, nrhs = size, lda = size, ldb = size, info;
  int *ipiv = (int *) malloc(sizeof(int) * size);



 clock_t tStart = clock();
info = LAPACKE_dgesv(LAPACK_ROW_MAJOR, n, nrhs, aref, lda, ipiv, bref, ldb);
printf("Time taken by OpenBLAS LAPACK: %.2fs\n", (double) (clock() - tStart) / CLOCKS_PER_SEC);



 int *ipiv2 = (int *) malloc(sizeof(int) * size);



 tStart = clock();
  my_dgesv(n, nrhs, a, lda, ipiv2, b, ldb, x, y, bref, size);
  printf("Time taken by my implementation: %.2fs\n", (double) (clock() - tStart) / CLOCKS_PER_SEC);



 if (check_result(bref, b, size) == 1)
    printf("Result is ok!\n");
  else
    printf("Result is wrong!\n");
}
