ROOTCFLAGS  = $(shell $(ROOTSYS)/bin/root-config --cflags)
ROOTLIBS    = $(shell $(ROOTSYS)/bin/root-config --libs)
ROOTGLIBS   = $(shell $(ROOTSYS)/bin/root-config --glibs)
ROOTLDFLAGS = $(shell $(ROOTSYS)/bin/root-config --ldflags)

CXX = g++

CXXFLAGS  = -I./
CXXFLAGS += $(ROOTCFLAGS)
CXXFLAGS += $(ROOTLIBS)
CXXFLAGS += $(ROOTGLIBS)
CXXFLAGS += $(ROOTLDFLAGS)

all: array_simdVCL1 array

#g++ -IVCL -O3 -Wall -std=c++17 -fPIC -mavx array_simd.cpp -o array_simd -I./ -pthread -m64 -I/home/burmist/root_v6.14.00/root-6.14.00-install/include -L/home/burmist/root_v6.14.00/root-6.14.00-install/lib -lCore -lImt -lRIO -lNet -lHist -lGraf -lGraf3d -lGpad -lROOTDataFrame -lROOTVecOps -lTree -lTreePlayer -lRint -lPostscript -lMatrix -lPhysics -lMathCore -lThread -lMultiProc -pthread -lm -ldl -rdynamic -L/home/burmist/root_v6.14.00/root-6.14.00-install/lib -lGui -lCore -lImt -lRIO -lNet -lHist -lGraf -lGraf3d -lGpad -lROOTDataFrame -lROOTVecOps -lTree -lTreePlayer -lRint -lPostscript -lMatrix -lPhysics -lMathCore -lThread -lMultiProc -pthread -lm -ldl -rdynamic -m64

array: array.cpp
	$(CXX) -O3 -fabi-version=0 $< -o $@ $(CXXFLAGS) -O3

array_simdVCL1: array_simd.cpp
	$(CXX) -IVCL1 -O3 -mavx -fabi-version=0 $< -o $@ $(CXXFLAGS) -O3

#array_simdVCL2: array_simd.cpp
#	$(CXX) -IVCL2 -O3 -Wall -std=c++17 -fPIC -mavx $< -o $@ $(CXXFLAGS)

.PHONY: printLD
printLD:
	$(info export LD_LIBRARY_PATH=$${LD_LIBRARY_PATH}:.)

clean:
	rm -rf array array_simdVCL1 array_simdVCL2 *~
