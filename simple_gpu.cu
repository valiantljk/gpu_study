/* from: https://devblogs.nvidia.com/parallelforall/even-easier-introduction-cuda/
 * Jialin Liu
 * Simple starting cpp cuda program
 * Jun 24 2017, Saturday, 2:09pm
 * Compile and test on Maeve, a 3GPU single node at NERSC, LBNL, CA. 
*/


#include<iostream>
#include<math.h>
using namespace std;

//CUDA kernel functions to add the elements of two arrays
__global__
void add (int n, float *x, float * y){
  for (int i=0;i<n;i++){
      y[i] = x[i] + y[i];
  }
}

int main(void)
{
  int N= 1<<20; //1 million elements
  //float * x= new float[N];
  //float * y= new float[N];
  float *x, *y;
  cudaMallocManaged(&x, N*sizeof(float));
  cudaMallocManaged(&y, N*sizeof(float));
  clock_t t;
  //Initialize x and y arrays on the host
  for (int i=0; i<N; i++){
   x[i] =1.5f;
   y[i] =2.3f;
  }
  
  //run kernel on 1M elements on the CPU
  t = clock();
  //add(N, x, y);
  add<<<1, 1>>>(N, x, y);
  t = clock() -t;
  //cout<<format("%f seconds")%((float)t/CLOCKS_PER_SEC)<<endl;
  cout <<(float)t/CLOCKS_PER_SEC<<" seconds"<<endl;
  //Wait for GPU to finish before accessing on host
  cudaDeviceSynchronize();
  float maxError = 0.0f;
  for (int i =0;i <N;i ++)
   maxError =fmax(maxError, fabs(y[i]-3.8f));
  cout <<"Max error: "<<maxError <<endl;

  //delete [] x;
  //delete [] y;
  cudaFree(x);
  cudaFree(y);
  return 0;
}
