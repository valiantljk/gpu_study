/* from: https://devblogs.nvidia.com/parallelforall/even-easier-introduction-cuda/
 * Jialin Liu
 * Simple starting cpp cuda program
 * Jun 24 2017, Saturday, 2:09pm
 * Compile and test on Maeve, a 3GPU single node at NERSC, LBNL, CA. 
*/


#include<iostream>
#include<math.h>
using namespace std;

//functions to add the elements of two arrays

void add (int n, float *x, float * y){
  for (int i=0;i<n;i++){
      y[i] = x[i] + y[i];
  }
}

int main(void)
{
  int N= 1<<20; //1 million elements
  float * x= new float[N];
  float * y= new float[N];
  clock_t t;
  // initialize x and y arrays on the host
  for (int i=0; i<N; i++){
   x[i] =1.5f;
   y[i] =2.3f;
  }
  
  // run kernel on 1M elements on the CPU
  t = clock();
  add(N, x, y);
  t = clock() -t;
//  cout<<format("%f seconds")%((float)t/CLOCKS_PER_SEC)<<endl;
  cout <<(float)t/CLOCKS_PER_SEC<<" seconds"<<endl;
  float maxError = 0.0f;
  for (int i =0;i <N;i ++)
   maxError =fmax(maxError, fabs(y[i]-3.8f));
  cout <<"Max error: "<<maxError <<endl;

  delete [] x;
  delete [] y;

  return 0;
}
