/*
*
* Name: Exercise 3
* Subject: Parallel Computing (Degree on Computer Engineering)
* Institution: University of Valladolid
* @author: Gonzalez Escribano, Arturo
* @version: 1.0
*/

#include <stdio.h>
#include <stdlib.h>
#include <cuda.h>


/*Definición de constantes*/
#define currentGPU 0		//El número más alto suele indicar la salida de video



int main()
{

	/*Consultamos el número de GPUs*/
	int deviceCount;
	cudaGetDeviceCount(&deviceCount);
	printf("El sistema tiene %d GPUs\n",deviceCount);

	/***********************************************************************
	*
	*   ANSWER_3_5:
	*
	*   GeForce GTX TITAN X: 	1024 1024 64 threads per block
	*   GeForce GTX TITAN Black:1024 1024 64 blocks per dim
	*
	***********************************************************************/


	/*Consultamos las características de las GPUs*/
	int device;
	for (device = 0; device < deviceCount; device++) {
		cudaDeviceProp deviceProp;
		cudaGetDeviceProperties(&deviceProp, device);
		printf("Device %d:\n",device);
		printf("\t\t\t Name: %s\n",deviceProp.name);
		printf("\t\t\t GPU architecture: %d.%d\n",deviceProp.major, deviceProp.minor);
		printf("\t\t\t multiProcessorCount: %d\n",deviceProp.multiProcessorCount);
		printf("\t\t\t totalGlobalMem: %.0f\n",(float) deviceProp.totalGlobalMem);
		printf("\t\t\t maxThreadsPerBlock: %d\n", deviceProp.maxThreadsPerBlock);
		printf("\t\t\t maxThreadsDim: %d %d %d\n", deviceProp.maxThreadsDim[0],
			deviceProp.maxThreadsDim[1],deviceProp.maxThreadsDim[2]);
		printf("\n\n");
	}
} //main
