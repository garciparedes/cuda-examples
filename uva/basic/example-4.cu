/*
*
* Name: Exercise 4
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
#define ELEMENTS 5



__global__ void  kernel_A (int *array){
    array[ threadIdx.x ] = threadIdx.x;

    if (ELEMENTS % 2 == 1 && threadIdx.x == (ELEMENTS / 2)){
        array[ threadIdx.x ] = array[ threadIdx.x ];
    } else if (threadIdx.x < ((ELEMENTS / 2))){
        array[ threadIdx.x ] = array[ threadIdx.x + 1]*100 + array[ threadIdx.x ];
    } else{
        array[ threadIdx.x ] = array[ threadIdx.x - 1]*100 - array[ threadIdx.x ];
    }

}	//kernel_A




int main()
{

    cudaError_t error;

	/*Indicamos la GPU (DEVICE) que vamos a utilizar*/
    if( (error = cudaSetDevice(currentGPU)) != cudaSuccess){
        printf("cuda-error-1: %s\n", cudaGetErrorString( error ) );
        exit(-1);
    }
	/* Variables*/
	int *arrayHost;
	int *arrayDevice;

	/* Reservas de memoria HOST y DEVICE*/
	arrayHost = (int*) malloc(sizeof(int) * ELEMENTS);
    if( (error = cudaMalloc( (void**) &arrayDevice, sizeof(int) * (int) ELEMENTS))
        != cudaSuccess){

        printf("cuda-error-2: %s\n", cudaGetErrorString( error ) );
        exit(-1);
    }
	/* Inicialización e impresión inicial*/
	printf("Array inicialiado:");
	for(int i=0; i<ELEMENTS; i++){
		arrayHost[i]=0;
		printf(" %d ",arrayHost[i]);
	}
	printf("\n");

	/* Transferencia a memoria Device*/
    if( (error = cudaMemcpy(arrayDevice,arrayHost, sizeof(int)* ELEMENTS,cudaMemcpyHostToDevice))
        != cudaSuccess){

        printf("cuda-error-3: %s\n", cudaGetErrorString( error ) );
        exit(-1);
    }

	/* Lanzamiento del kernel*/
	kernel_A<<<1,ELEMENTS>>>(arrayDevice);

    if( (error = cudaGetLastError()) != cudaSuccess){
        printf("cuda-error-4: %s\n", cudaGetErrorString( error ) );
        exit(-1);
    }
	/* Transferencia a memoria Host*/
    if( (error = cudaMemcpy(arrayHost,arrayDevice, sizeof(int)*ELEMENTS,cudaMemcpyDeviceToHost))
        != cudaSuccess){

        printf("cuda-error-5: %s\n", cudaGetErrorString( error ) );
        exit(-1);
    }

	/* Inicialización e impresión inicial*/
	printf("Array despues del kernel:");
	for(int i=0; i<ELEMENTS; i++){
		printf(" %d ",arrayHost[i]);
	}
	printf("\n");

	/*Liberamos memoria del DEVICE*/

    if( (error = cudaFree(arrayDevice)) != cudaSuccess){
        printf("cuda-error-6: %s\n", cudaGetErrorString( error ) );
        exit(-1);
    }
	/*Liberamos los hilos del DEVICE*/
    if( (error = cudaDeviceReset()) != cudaSuccess){
        printf("cuda-error-7: %s\n", cudaGetErrorString( error ) );
        exit(-1);
    }

} //main
