//c, c++
#include <chrono>
#include <iostream>

//VCL
#include <vectorclass.h>

//root
#include <TRandom3.h>

int main() {
  //
  const unsigned int mTime = 100000;
  const unsigned int nTime = 100;
  const unsigned int n = 8*nTime;
  float xx[n];
  float yy[n];
  float zz[n];
  TRandom3 *rnd = new TRandom3(1234567890);
  //
  double xx_mean  = 3.0;
  double xx_sigma = 0.001;
  double yy_mean  = 2.0;
  double yy_sigma = 0.001;
  //
  for(unsigned int i = 0; i<n; i++){
    xx[i] = (float)rnd->Gaus( xx_mean, xx_sigma);
    yy[i] = (float)rnd->Gaus( yy_mean, yy_sigma);
  }
  //
  Vec8f x,y,z;
  //
  auto start = std::chrono::steady_clock::now();
  for(unsigned int i = 0; i<mTime; i++){
    for(unsigned int j = 0; j<nTime; j++){
      x.load(xx+8*j);
      y.load(yy+8*j);
      z = x*y;
      z.store(zz+8*j);
    }
  }
  //
  auto end = std::chrono::steady_clock::now();
  std::cout << "Elapsed time in microseconds : " 
	    << std::chrono::duration_cast<std::chrono::microseconds>(end - start).count()
	    << " us" << std::endl;
  //
  float sum = 0;
  for(unsigned int j = 0; j<n; j++){
    sum += zz[j];
  }
  //
  std::cout<<sum<<std::endl;
  //
  return 0;
}
