#include <stdio.h>
#include <stdlib.h>
#include <cuda.h>

__global__ void gpuFunc()
{
	printf("\n********************************************************\n");
	printf("*                 SOY LA GPU: \"Hello World\"          *\n");
	printf("********************************************************\n\n");

} // gpuFunc


/* Definicion de constantes */
#define currentGPU 0


int main()
{

	/* Indicamos la GPU (DEVICE) que vamos a utilizar */
	cudaSetDevice(currentGPU);

	/* *******************************************
	 * Lanzamos la función del DEVICE (el Kernel)
	 *  1º parámetro: número de bloques (de hilos)
	 *  2º parámetro: número de hilos por bloque
	 * ***************************************** */
	gpuFunc<<<1, 1>>>();

	/* Liberar recursos del DEVICE */
	cudaDeviceReset();

} // Fin main
