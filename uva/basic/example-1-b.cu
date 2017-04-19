/*
*
* Name: Exercise 1-b
* Subject: Parallel Computing (Degree on Computer Engineering)
* Institution: University of Valladolid
* @author: Gonzalez Escribano, Arturo
* @author: García Prado, Sergio (@garciparedes)
* @version: 1.1.1
*/

#include <stdio.h>
#include <stdlib.h>
#include <cuda.h>

__global__ void gpuFunc()
{
	printf("\n********************************************************\n");
	printf("*                 SOY LA GPU: \"Hello World\"            *\n");
	printf("********************************************************\n\n");

} // gpuFunc


/* Definicion de constantes */
#define currentGPU 7


int main()
{
	cudaError_t error;

	/* Indicamos la GPU (DEVICE) que vamos a utilizar */
	if( (error = cudaSetDevice(currentGPU)) != cudaSuccess){
	      printf("cuda-error: %s\n", cudaGetErrorString( error ) );
	}

	/* *******************************************
	 * Lanzamos la función del DEVICE (el Kernel)
	 *  1º parámetro: número de bloques (de hilos)
	 *  2º parámetro: número de hilos por bloque
	 * ***************************************** */
	gpuFunc<<<1, 1>>>();

	/* Liberar recursos del DEVICE */
	cudaDeviceReset();

} // Fin main
