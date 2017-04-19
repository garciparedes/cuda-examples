/*
*
* Name: Exercise 5
* Subject: Parallel Computing (Degree on Computer Engineering)
* Institution: University of Valladolid
* @author: Gonzalez Escribano, Arturo
* @author: García Prado, Sergio (@garciparedes)
* @version: 1.1
*/

#include <stdio.h>
#include <stdlib.h>
#include <cuda.h>




/*Definición de constantes*/
#define currentGPU 0		//El número más alto suele indicar la salida de video
#define ELEMENTS 24



__global__ void  kernel_A (int *array){

    int global_id = threadIdx.x + threadIdx.y * blockDim.x +
        blockIdx.x * blockDim.x * blockDim.y +
        blockIdx.y * blockDim.x * blockDim.y * gridDim.x;

	array[ global_id ]= global_id +1 ;

}	//kernel_A

__global__ void  kernel_B (int *array){

    int global_id = threadIdx.x + threadIdx.y * blockDim.x +
        blockIdx.x * blockDim.x * blockDim.y +
        blockIdx.y * blockDim.x * blockDim.y * gridDim.x;

	array[ global_id ]= array[ global_id ] +1 ;

}	//kernel_B



int main()
{

	/*Indicamos la GPU (DEVICE) que vamos a utilizar*/
	cudaSetDevice(currentGPU);

    /*Declaración del shape de los bloques y del Grid*/
    dim3 bloqShapeGpu(4,2);
    dim3 gridShapeGpu(3,1);

	/* Variables*/
	int *arrayHost;
	int *arrayDevice;

	/* Reservas de memoria HOST y DEVICE*/
	arrayHost = (int*) malloc(sizeof(int) * ELEMENTS);
	cudaMalloc( (void**) &arrayDevice, sizeof(int) * (int) ELEMENTS);

	/* Inicialización e impresión inicial*/
	printf("\n\nArray inicialiado:");
	for(int i=0; i<ELEMENTS; i++){
		arrayHost[i]=1;
		printf(" %d ",arrayHost[i]);
	}
	printf("\n\n");

	/* Transferencia a memoria Device*/
	cudaMemcpy(arrayDevice,arrayHost, sizeof(int) * ELEMENTS,cudaMemcpyHostToDevice);

	/* Lanzamiento del primer kernel*/
	kernel_A<<<gridShapeGpu, bloqShapeGpu>>>(arrayDevice);

	cudaDeviceSynchronize();

	/* Lanzamiento del segundo kernel*/
	kernel_B<<<gridShapeGpu, bloqShapeGpu>>>(arrayDevice);

	/* Transferencia a memoria Host*/
	cudaMemcpy(arrayHost,arrayDevice, sizeof(int) * ELEMENTS,cudaMemcpyDeviceToHost);


	/* Impresión */
	printf("Array despues del segundo kernel:");
	for(int i=0; i<ELEMENTS; i++){
		printf(" %d ",arrayHost[i]);
	}
	printf("\n\n");

	/*Liberamos memoria del DEVICE*/
	cudaFree(arrayDevice);

	/*Liberamos los hilos del DEVICE*/
	cudaDeviceReset();

} //main
