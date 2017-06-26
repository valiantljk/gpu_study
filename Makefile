#source config.sh

all: simple_cpu simple_gpu

simple_cpu: simple_cpu.cpp
	g++ -o simple_cpu simple_cpu.cpp

simple_gpu: simple_gpu.cu
	nvcc -o simple_gpu simple_gpu.cu

clean:
	rm simple_gpu simple_cpu
