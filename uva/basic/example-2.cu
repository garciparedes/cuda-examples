/*
*
* Name: Exercise 2 - Main
* Subject: Parallel Computing (Degree on Computer Engineering)
* Institution: University of Valladolid
* @author: Gonzalez Escribano, Arturo
* @author: García Prado, Sergio (@garciparedes)
* @version: 1.1
*/

#include <stdio.h>
#include <stdlib.h>
#include <cuda.h>
#include "kernel.cu"

/* Definición de constantes */
#define currentGPU 0		//El número más alto suele indicar la salida de video



int main()
{

	/*Indicamos la GPU (DEVICE) que vamos a utilizar*/
	cudaSetDevice(currentGPU);

	/*Declaración del shape de los bloques y del Grid*/
		/*Primer Kernel*/
		dim3 bloqShapeGpuFunc1(3,2);	//bloques (de hilos): 3 columnas 2 filas;
		dim3 gridShapeGpuFunc1(2,3);	//grid (de bloques): 2 columnas 3 filas;

		/*Segundo Kernel*/
		dim3 bloqShapeGpuFunc2(256,2);	  //bloques (de hilos): 256 columnas 2 filas;
		dim3 gridShapeGpuFunc2(10,25);    //grid (de bloques): 10 columnas 25 filas;

	/*Funciones del DEVICE*/
		printf("Lanzamos el primer kernel...\n");

        /***********************************************************************
        *
        *   ANSWER_2_3:
        *
        *   (3*2) * (3*2) = 36 threads
        *
        ***********************************************************************/

        /*Primer Kernel*/
		gpuFunc1<<<gridShapeGpuFunc1, bloqShapeGpuFunc1>>>();

		printf("\n Lanzamos el segundo kernel...\n");

        /***********************************************************************
        *
        *   ANSWER_2_3:
        *
        *   (10*25) * (256*2) = 128000 threads
        *
        ***********************************************************************/

        /*Segundo Kernel*/
		gpuFunc2<<<gridShapeGpuFunc2, bloqShapeGpuFunc2>>>();

	/*Liberamos recursos del DEVICE*/
	cudaDeviceReset();

} //Fin main
