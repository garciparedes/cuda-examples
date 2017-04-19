/*
*
* Name: Exercise 2 - Kernels
* Subject: Parallel Computing (Degree on Computer Engineering)
* Institution: University of Valladolid
* @author: Gonzalez Escribano, Arturo
* @author: García Prado, Sergio (@garciparedes)
* @version: 1.1
*/

/* ********************************************************************
 *
 * **************************   Kernels   ***************************
 *
 * ****************************************************************** */


/*Primer kernel*/
__global__ void gpuFunc1()
{
        /***********************************************************************
        *
        *   ANSWER_2_5:
        *
        *   (Code Below)
        *
        ***********************************************************************/
        int global_id = threadIdx.x + threadIdx.y * blockDim.x +
            blockIdx.x * blockDim.x * blockDim.y +
            blockIdx.y * blockDim.x * blockDim.y * gridDim.x;

        printf("\t Soy el hilo %d %d del bloque %d %d con id %d\n",
            threadIdx.x,threadIdx.y,blockIdx.x,blockIdx.y, global_id);

} // gpuFunc1


/************************************************************************/


/*Segundo kernel*/
__global__ void gpuFunc2()
{
        /***********************************************************************
        *
        *   ANSWER_2_4:
        *
        *   int global_id = threadIdx.x + threadIdx.y * blockDim.x +
        *       blockIdx.x * blockDim.x * blockDim.y +
        *       blockIdx.y * blockDim.x * blockDim.y * gridDim.x;
        *
        ***********************************************************************/

        /***********************************************************************
        *
        *   ANSWER_2_6:
        *
        *   (Code Below)
        *
        ***********************************************************************/

        int global_id = threadIdx.x + threadIdx.y * blockDim.x +
            blockIdx.x * blockDim.x * blockDim.y +
            blockIdx.y * blockDim.x * blockDim.y * gridDim.x;

        if (global_id == 55555){
        	printf("\t El shape del bloque de hilos es: %d columnas y  %d filas\n", blockDim.x,blockDim.y);
	        printf("\t El shape del Grid es: %d columnas  y %d filas\n", gridDim.x,gridDim.y);
	} // if

} // gpuFunc2
